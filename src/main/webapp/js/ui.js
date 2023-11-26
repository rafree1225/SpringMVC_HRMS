(function (window, document) {

    var layout   = document.getElementById('layout'),
        menu     = document.getElementById('menu'),
        menuLink = document.getElementById('menuLink');

    function toggleClass(element, className) {
        var classes = element.className.split(/\s+/),
            length = classes.length,
            i = 0;

        for (; i < length; i++) {
            if (classes[i] === className) {
                classes.splice(i, 1);
                break;
            }
        }
        // The className is not found
        if (length === classes.length) {
            classes.push(className);
        }

        element.className = classes.join(' ');
    }

    function toggleAll(e) {
        var active = 'active';

        e.preventDefault();
        toggleClass(layout, active);
        toggleClass(menu, active);
        toggleClass(menuLink, active);
    }
    
    
    
    function handleEvent(e) {
        if (e.target.id === menuLink.id) {
            return toggleAll(e);
        }

        // 檢查點擊的是哪個項目，然後執行相應的操作
        if (e.target.id === 'deptLink') {
            // 執行部門相關操作
            console.log('點擊了部門');
        } else if (e.target.id === 'clubLink') {
            // 執行社團相關操作
            console.log('點擊了社團');
        } else if (e.target.id === 'empLink') {
            // 執行員工相關操作
            console.log('點擊了員工');
        }

        if (menu.className.indexOf('active') !== -1) {
            return toggleAll(e);
        }
    }
    
    document.addEventListener('click', handleEvent);

}(this, this.document));