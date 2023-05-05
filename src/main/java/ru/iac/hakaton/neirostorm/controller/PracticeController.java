package ru.iac.hakaton.neirostorm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import ru.iac.hakaton.neirostorm.model.Practice;
import ru.iac.hakaton.neirostorm.repository.PracticeRepository;
import ru.iac.hakaton.neirostorm.service.PracticeService;

import java.util.List;
import java.util.Optional;

@Controller
public class PracticeController {

    @Autowired
    private PracticeRepository practiceRepository;

    @Autowired
    private PracticeService practiceService;


    @GetMapping("/")
    public String getPractices(@RequestParam(value = "rating", required = false) String rating, Model model) {
        List<Practice> practices = practiceRepository.findAll();

        model.addAttribute("practices", practices);
        model.addAttribute("emptyList", practices.isEmpty());

        return "practices";
    }

    @GetMapping("/practice/{id}")
    public String showPractice(@PathVariable("id") Long id, Model model) {
        Optional<Practice> practiceOpt = practiceRepository.findById(id);

        if (practiceOpt.isEmpty()) {
            throw new IllegalArgumentException("Invalid practice id: " + id);
        }

        Practice practice = practiceOpt.get();

        model.addAttribute("practice", practice);

        return "practice";
    }

    @GetMapping("/practices")
    public String searchPractices(@RequestParam(value = "keyword", required = false) String keyword,
                                  @RequestParam(name = "topic", required = false) String topic, Model model) {

        List<Practice> practices = practiceService.searchPractices(keyword, topic);

        model.addAttribute("practices", practices);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedTopic", topic);
        return "practices";
    }
}
