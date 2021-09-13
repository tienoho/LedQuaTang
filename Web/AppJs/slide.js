﻿var pageIndex = 1;
var slide = function () {
    return {
        init: function () {
            slide.loadData(); 
        },
        loadData: function (pageindex) {
            var self = this;
            $("#loading").show();
            AjaxService.POST("/Admin/slide/ListData", {page:pageIndex}, function (res) {
                $("#gridData").html(res.viewContent);
                if (res.totalPages > 1) {
                    $('#paginationholder').html('');
                    $('#paginationholder').html('<ul id="pagination" class="pagination-sm"></ul>');
                    $('#pagination').twbsPagination({
                        startPage: self.pageIndex,
                        totalPages: res.totalPages,
                        visiblePages: 5,
                        onPageClick: function (event, page) {
                            self.pageIndex = page;
                            slide.loadData(self.pageIndex);
                        }
                    });
                }
                self.FirstLoad = false;
                $("#loading").hide();
            });
        },
       
        loadfrmAdd: function () {
            modal.Render("/Admin/slide/Add", "Thêm mới ảnh slide", "modal-lg");
        },
        onAddSuccess: function (res) {
            if (res.IsSuccess == true) {
                alertmsg.success(res.Messenger);
                slide.loadData(this.pageIndex);
                modal.hide();
            } else {
                alertmsg.error(res.Messenger);
            }
            $("#loading").hide();
        },
        loadfrmedit: function (id) {
            modal.Render("/Admin/slide/Edit/" + id, "Cập nhật ảnh slide", "modal-lg");
        },
        onEditSuccess: function (res) {
            if (res.IsSuccess == true) {
                alertmsg.success(res.Messenger);
                slide.loadData(this.pageIndex);
                modal.hide();
            } else {
                alertmsg.error(res.Messenger);
            }
            $("#loading").hide();
        },
        active: function (id) {
            $("#loading").show();
            var self = this;
            swal({
                title: "Thay đổi trạng thái?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Có",
                cancelButtonText: "không",
            }, function (isConfirm) {
                if (isConfirm) {
                    AjaxService.POST("/Admin/slide/ChangeStatus", { id: id }, function (res) {
                        self.pageIndex = 1;
                        self.loadData(self.pageIndex);
                        alertmsg.success(res.Messenger);
                    });
                }
                $("#loading").hide();
            });
        },
        ondelete: function (id) {
            $("#loading").show();
            var self = this;
            swal({
                title: "Bạn có chắc chắn không?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Có",
                cancelButtonText: "không",
            }, function (isConfirm) {
                if (isConfirm) {
                    AjaxService.POST("/Admin/slide/Delete", { id: id }, function (res) {
                        self.pageIndex = 1;
                        self.loadData(self.pageIndex);
                        alertmsg.success(res.Messenger);
                    });
                }
                $("#loading").hide();
            });
        },
        onmultidelete: function () {
            var self = this;
            if ($("table tbody").find("input[type=checkbox]:checked").length == 0) {
                alertmsg.error("Bạn cần chọn ít nhất một ảnh cần xóa");
            } else {
                $("#loading").show();
                swal({
                    title: "Bạn có chắc chắn không?",
                    text: "",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Có",
                    cancelButtonText: "không",
                }, function (isConfirm) {
                    if (isConfirm) {
                        AjaxService.POST("/Admin/slide/DeleteAll", { lstid: $("#hdfID").val() }, function (res) {
                            self.pageIndex = 1;
                            self.loadData(self.pageIndex);
                            alertmsg.success(res.Messenger);
                        });
                    }
                    $("#loading").hide();
                });
            }
        },
        onupdateposittion: function () {
        var self = this;
        $("#loading").show();
        var arrValue = [];
        $("table tbody tr").each(function () {
            var id = $(this).find(".item_ID").val();
            var ordering = $(this).find(".width50").val();
            var str = id + ":" + ordering;
            arrValue.push(str);
        });
        var strValue = arrValue.join("|");
        AjaxService.POST("/Admin/slide/UpdatePosition", { value: strValue }, function (res) {
            if (res.IsSuccess == true) {
                alertmsg.success(res.Messenger);
                $("#gridData").html(res.ViewContent);
            } else {
                alertmsg.error(res.Messenger);
            }
            slide.loadData(self.pageIndex);
            $("#loading").hide();
        });
        },
        initcheckall: function () {
            var countall = $(".chkelement").length;
            var countchecked = 0;
            $(".chkelement").each(function () {
                if ($(this).find($("input[type=checkbox]")).is(':checked')) {
                    countchecked++;
                }
            });
            if (countall == countchecked) {
                $("#basicForm #chkall").prop('checked', true);
            } else {
                $("#basicForm #chkall").prop('checked', false);
            }
            $("#basicForm #chkall").click(function () {
                if ($(this).is(':checked')) {
                    $(".chkelement").each(function () {
                        $(this).find($("input[type=checkbox]")).prop('checked', true);
                    });
                } else {
                    $(".chkelement").each(function () {
                        $(this).find($("input[type=checkbox]")).prop('checked', false);
                    });
                }
            });
            $(".chkelement").click(function () {
                countchecked = 0;
                $(".chkelement").each(function () {
                    if ($(this).find($("input[type=checkbox]")).is(':checked')) {
                        countchecked++;
                    }
                });
                if (countall == countchecked) {
                    $("#basicForm #chkall").prop('checked', true);
                } else {
                    $("#basicForm #chkall").prop('checked', false);
                }
            });
        },
        initcheckall2: function () {
            var countall = $(".chkelement2").length;
            var countchecked = 0;
            $(".chkelement2").each(function () {
                if ($(this).find($("input[type=checkbox]")).is(':checked')) {
                    countchecked++;
                }
            });
            if (countall == countchecked) {
                $("#basicForm #chkall2").prop('checked', true);
            } else {
                $("#basicForm #chkall2").prop('checked', false);
            }
            $("#basicForm #chkall2").click(function () {
                if ($(this).is(':checked')) {
                    $(".chkelement2").each(function () {
                        $(this).find($("input[type=checkbox]")).prop('checked', true);
                    });
                } else {
                    $(".chkelement2").each(function () {
                        $(this).find($("input[type=checkbox]")).prop('checked', false);
                    });
                }
            });
            $(".chkelement2").click(function () {
                countchecked = 0;
                $(".chkelement2").each(function () {
                    if ($(this).find($("input[type=checkbox]")).is(':checked')) {
                        countchecked++;
                    }
                });
                if (countall == countchecked) {
                    $("#basicForm #chkall2").prop('checked', true);
                } else {
                    $("#basicForm #chkall2").prop('checked', false);
                }
            });
        }
    };
}();
$(function () { slide.init(); });


