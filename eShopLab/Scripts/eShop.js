$(function () {
    var myDropzone = $("#mydropzone").dropzone({
        previewsContainer: ".dropzone-previews",
        maxFiles: 1,
        addRemoveLinks: true,
        autoProcessQueue: false,
        acceptedFiles: "image/*",
        init: function () {
            this.on("addedfile", function (file) {
                var dz = Dropzone.forElement("#mydropzone");
                if (dz.files.length > 1) {
                    dz.removeFile(dz.files[0])
                }
            });

            var myDropzone = this;

            // First change the button to actually tell Dropzone to process the queue.
            this.element.querySelector("input[type=submit]").addEventListener("click", function (e) {
                // Make sure that the form isn't actually being sent.
                alert($("#mydropzone").dropzone.files.length);
                e.preventDefault();
                e.stopPropagation();
                myDropzone.processQueue();
            })
        }
    });
    console.log("ready!");
});