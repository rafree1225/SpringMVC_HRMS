package com.lab.jpa.repository;

import com.lab.jpa.entities.Club;
import com.lab.jpa.entities.Department;
import com.lab.jpa.entities.Employee;
import com.lab.jpa.entities.Salary;
import java.util.List;
import javax.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public class CompanyDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session session = null;

    private Session getSession() {
        session = sessionFactory.getCurrentSession();
        return session;
    }

    // 查詢所有部門
    public List queryAllDepts() {
        List list = getSession().createQuery("from Department d").list();
        return list;
    }

    // 查詢單筆部門
    public Department getDept(Integer id) {
        Department dept = (Department) getSession().get(Department.class, id);
        return dept;
    }

    // 新增部門
    public void saveDept(Department dept) {
        getSession().saveOrUpdate(dept);
    }

    // 修改部門
    public void updateDept(Department dept) {
        getSession().merge(dept);
    }

    // 刪除部門
    public void deleteDept(Integer id) {
        Department dept = (Department) getSession().get(Department.class, id);
        getSession().delete(dept);
    }

    // 查詢所有社團
    public List queryAllClubs() {
        List list = getSession().createQuery("from Club c").list();
        return list;
    }

    // 查詢單筆社團
    public Club getClub(Integer id) {
        Club club = (Club) getSession().get(Club.class, id);
        return club;
    }

    // 新增社團
    public void saveClub(Club club) {
        getSession().saveOrUpdate(club);
    }

    // 修改社團
    public void updateClub(Club club) {
        getSession().merge(club);
    }

    // 刪除社團
    public void deleteClub(Integer id) {
        Club club = (Club) getSession().get(Club.class, id);
        getSession().delete(club);
    }

    // 查詢所有員工
    public List queryAllEmps() {
        List list = getSession().createQuery("FROM Employee e").list();
        return list;
    }

    // 查詢單筆員工
    public Employee getEmp(Integer id) {
        Employee emp = (Employee) getSession().get(Employee.class, id);
        return emp;
    }

    // 新增員工
   public void saveEmp(Employee emp) {
    if (emp.getSalary() != null && emp.getSalary().getId() == null) {
        getSession().save(emp.getSalary());
    }
    getSession().saveOrUpdate(emp);
}


    // 修改員工
    public void updateEmp(Employee emp) {
        getSession().merge(emp);
    }

    // 刪除員工
    public void deleteEmp(Integer id) {
        Employee emp = (Employee) getSession().get(Employee.class, id);
        getSession().delete(emp);
    }
    
    
    // 查詢所有薪水
    public List queryAllSalaries() {
        List list = getSession().createQuery("from Salaries s").list();
        return list;
    }
    
    
    // 查詢單筆薪水
    public Salary getSalary(Integer id) {
        Salary salary = (Salary) getSession().get(Salary.class, id);
        return salary;
    }
    

    // 新增薪水
    public void saveSalary(Salary salary) {
        getSession().saveOrUpdate(salary);
    }
    
    

}
