package com.lab.jpa.controller;

import com.lab.jpa.entities.Club;
import com.lab.jpa.entities.Department;
import com.lab.jpa.repository.CompanyDao;
import com.lab.jpa.validation.ClubValidation;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/club")
public class ClubController {
    
    @Autowired
    private CompanyDao dao;
    
    @Autowired
    private ClubValidation validation;
    
    @GetMapping(value = {"/", // 查詢全部資料用
                         "/{id}", // 根據 id 查詢單筆使用 (給修改連結用)
                         "/{delete}/{id}"}) // 根據 id 查詢單筆使用 (給刪除連結用)
    public String read(Model model,
                       @PathVariable Optional<Integer> id,
                       @PathVariable Optional<String> delete) {
        
        String _method = "POST";
        
        List club_list = dao.queryAllClubs();
        
        Club club = new Club();
        
         if(id.isPresent()) {
            
            _method = "PUT";
            club = dao.getClub(id.get());
            
            // 根據路徑參數是否有 delete 字樣
            if(delete.isPresent() && delete.get().equalsIgnoreCase("delete")) {
                _method = "DELETE";
            }
        }
         
        model.addAttribute("_method", _method);
        model.addAttribute("club_list", club_list);
        model.addAttribute("club", club);
   
        return "club_page";
    }
    
    
     @PostMapping(value = {"/"})
    public String create(@ModelAttribute("club") Club club, 
            BindingResult result, Model model) {

        //數據驗證 
        validation.validate(club, result);
        
        if (result.hasErrors()) {
            model.addAttribute("_method", "POST");
            model.addAttribute("club_list", dao.queryAllClubs());
            model.addAttribute("club", club);
            return "club_page";
        }
        
        dao.saveClub(club);
        return "redirect: ./";//重導至mvc/club/( 因為redirect → 使用GET方法 )
    }
    
     @PutMapping(value = {"/"})
    public String update(@ModelAttribute("club") Club club) {
        dao.updateClub(club);
        return "redirect: ./";
    }
    
    @DeleteMapping(value = {"/"})
    public String delete(@ModelAttribute("club") Club club) {
        dao.deleteDept(club.getId());
        return "redirect: ./";
    }
}


