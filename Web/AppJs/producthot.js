 var Product = function () {
    return {
        init: function () {
            Product.loadData(1);
        },
        loadData: function (pageIndex) {
            var self = this;
            $.get("/Product/ProductAll", {pageIndex: pageIndex}, function (res) {
                $('#loadData').html(res.viewContent);
                if (res.totalPages > 0) {
                    $('#paginationholder').html('<ul id="pagination" class="pagination-sm"></ul>');
                    $('#pagination').twbsPagination({
                        startPage: self.pageIndex,
                        totalPages: res.totalPages,
                        visiblePages: 5,
                        onPageClick: function (event, page) {
                            self.pageIndex = page;
                            Product.loadData(self.pageIndex);
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
    Product.init();
})