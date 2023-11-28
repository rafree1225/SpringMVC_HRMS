package com.lab.jpa.controller;

import com.lab.jpa.entities.Club;
import com.lab.jpa.entities.Department;
import com.lab.jpa.entities.Employee;
import com.lab.jpa.repository.CompanyDao;
import com.lab.jpa.validation.EmpValidation;
import java.awt.print.Pageable;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import org.hibernate.annotations.Sort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/emp")
public class EmpController {

    @Autowired
    private CompanyDao dao;

    @Autowired
    private EmpValidation validation;

    @GetMapping(value = {"/", // 查詢全部資料用
        "/{id}", // 根據 id 查詢單筆使用 (給修改連結用)
        "/{delete}/{id}"})// 根據 id 查詢單筆使用 (給刪除連結用)
    public String read(Model model,
            @PathVariable Optional<Integer> id,
            @PathVariable Optional<String> delete) {

        String _method = "POST";

        List emp_list = dao.queryAllEmps();

        List dept_list = dao.queryAllDepts();

        List club_list = dao.queryAllClubs();

        Employee emp = new Employee();

        if (id.isPresent()) {

            _method = "PUT";
            emp = dao.getEmp(id.get());

            // 根據路徑參數是否有 delete 字樣
            if (delete.isPresent() && delete.get().equalsIgnoreCase("delete")) {
                _method = "DELETE";
            }
        }

        model.addAttribute("_method", _method);
        model.addAttribute("emp_list", emp_list);
        model.addAttribute("dept_list", dept_list);
        model.addAttribute("club_list", club_list);
        model.addAttribute("emp", emp);

        return "emp_page";
    }

    @PostMapping(value = {"/"})
    public String create(@ModelAttribute("emp") Employee emp,
            BindingResult result,
            Model model,
            @RequestParam Optional<int[]> clubIds) {

        //數據驗證
        validation.validate(emp, result);

        if (result.hasErrors()) {
            model.addAttribute("_method", "POST");
            model.addAttribute("emp_list", dao.queryAllEmps());
            model.addAttribute("dept_list", dao.queryAllDepts());
            model.addAttribute("club_list", dao.queryAllClubs());
            model.addAttribute("emp", emp);

            return "emp_page";

        }

        if (clubIds.isPresent()) {

            for (Integer id : clubIds.get()) {
                Club club = dao.getClub(id);
                emp.getClubs().add(club);
            }
        }
        dao.saveEmp(emp);
        return "redirect: ./";

    }

    @PutMapping(value = {"/"})
    public String update(@ModelAttribute("emp") Employee emp,
            @RequestParam Optional<int[]> clubIds) {

        // 清除舊的社團關聯
        emp.getClubs().clear();

        // 根據提交的社團ID添加新的社團關聯
        if (clubIds.isPresent()) {
            for (Integer id : clubIds.get()) {
                Club club = dao.getClub(id);
                emp.getClubs().add(club);
            }
        }

        // 更新員工資訊
        dao.updateEmp(emp);
        return "redirect: ./";
    }

    @DeleteMapping(value = {"/"})
    public String delete(@ModelAttribute("emp") Employee emp) {
        dao.deleteEmp(emp.getId());
        return "redirect: ./";
    }

}
