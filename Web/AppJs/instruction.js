var instruction = function () {
    return {
        init: function () {
            $(".keyEnter").keypress(function (e) {
                if (e.which == 13) // Enter key = keycode 13
                {
                    instruction.loadData(1);
                    return false;
                }
            });
            instruction.loadData();
        },
        loadData: function () {
            $("#loading").show();
            AjaxService.POST("/Admin/Instruction/ListData",null, function (res) {
                $("#gridData").html(res.viewContent);
                $("#loading").hide();
            });
        },  
        loadfrmDetail: function (id) {
            modal.Render("/Admin/Instruction/Detail/" + id, "Chi tiết hướng dẫn", "modal-lg");
        },
        loadfrmAdd: function () {
            modal.Render("/Admin/Instruction/Add", "Thêm mới tiêu đề hướng dẫn", "modal-lg");
        },
        loadfrmedit: function (id) {
            modal.Render("/Admin/Instruction/Edit/" + id, "Cập nhật tiêu đề hướng dẫn", "modal-lg");
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
                    AjaxService.POST("/Admin/Instruction/Delete", { id: id }, function (res) {
                        self.pageIndex = 1;
                        self.loadData(self.pageIndex);
                        alertmsg.success(res.Messenger);
                    });
                }
                $("#loading").hide();
            });
        },
        onAddSuccess: function (res) {
            if (res.IsSuccess == true) {
                alertmsg.success(res.Messenger);
                window.location.href="/Admin/Instruction"
            } else {
                alertmsg.error(res.Messenger);
            }
            $("#loading").hide();
        },
        onEditSuccess: function (res) {
            if (res.IsSuccess == true) {
                alertmsg.success(res.Messenger);
                window.location.href = "/Admin/Instruction"
            } else {
                alertmsg.error(res.Messenger);
            }
            $("#loading").hide();
        }
    };
}();
$(function () {
    instruction.init();
});
