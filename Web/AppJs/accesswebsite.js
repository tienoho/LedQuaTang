var accesswebsite = function () {
    return {
        init: function () {
            this.pageIndex = 1;
            accesswebsite.loadData(this.pageIndex);
        },
        loadData: function (pageindex) {
            var self = this;
            AjaxService.GET("/Admin/AccessWebsite/ListData?page=" + pageindex, null, function (res) {
                $("#gridData").html(res.viewContent);
                if (res.totalPages > 1) {
                    $('#paginationholder').html('');
                    $('#paginationholder').html('<ul id="pagination" class="pagination-sm"></ul>');
                    $('#pagination').twbsPagination({
                        startPage: pageindex,
                        totalPages: res.totalPages,
                        visiblePages: 5,
                        onPageClick: function (event, page) {
                            accesswebsite.loadData(page);
                        }
                    });
                }
            });
        }
    }
}();
$(function () { accesswebsite.init(); });


