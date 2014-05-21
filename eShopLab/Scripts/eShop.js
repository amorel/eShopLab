jQuery.fn.exists = function () { return this.length > 0; }

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
                if (Dropzone.forElement("#mydropzone").files.length > 0) {
                    e.preventDefault();
                    e.stopPropagation();
                    myDropzone.processQueue();
                }
            });
            if ($("input[name='fileUrl']").exists())
                if ($("input[name='fileUrl']").val() != "") {
                    var fakeFile = {
                        name: "",
                        size: 2323 // in bytes,
                    };

                    myDropzone.emit("addedfile", fakeFile);
                    myDropzone.emit("thumbnail", fakeFile, location.protocol + '//' + location.host + $("input[name='fileUrl']").val());
                    myDropzone.files.push(fakeFile);
                }
        },
        complete: function () {
            window.location = "./";
        }
    });

    console.log("ready!");
});