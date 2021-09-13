 var Category = function () {
    return {
        init: function () {
            Category.loadData(1);
        },
        loadData: function (pageIndex) {
            let linkseo = $('#linkseo').val();
            $.get("/Category/LoadData", {linkseo: linkseo, pageIndex: pageIndex}, function (res) {
                $('#loadData').html(res.viewContent);
                $('#titleCate').text(res.categoryName);
                $('#pathway').text(res.categoryName);
                if (res.totalPages > 1) {
                    $('#paginationholder').html('<ul id="pagination" class="pagination-sm"></ul>');
                    $('#pagination').twbsPagination({
                        startPage: self.pageIndex,
                        totalPages: res.totalPages,
                        visiblePages: 5,
                        onPageClick: function (event, page) {
                            self.pageIndex = page;
                            Category.loadData(self.pageIndex);
                        }
                    });
                } else {
                    $('#paginationholder').html('');
                }
            });
        } 
    }
}();
$(function () {
    Category.init();
})