$(function () {
    var myDropzone = $("#mydropzone").dropzone({
        url: "/Uploads",
        previewsContainer: ".dropzone-previews",
        maxFiles: 1,
        autoProcessQueue: false,
        init: function () {
            this.on("addedfile", function (file) {
                var dz = Dropzone.forElement("#mydropzone");
                if (dz.files.length > 1) {
                    dz.removeFile(dz.files[0])
                }
            });
        }
    });

    console.log("ready!");
});