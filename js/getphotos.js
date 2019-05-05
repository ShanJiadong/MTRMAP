/*
 * Demo1:选取一张图片，并预览
 */
$("#img_input").on("change", function(e) {

  var file = e.target.files[0]; //获取图片资源

  // 只选择图片文件
  if (!file.type.match('image.*')) {
    return false;
  }

  var reader = new FileReader();

  reader.readAsDataURL(file); // 读取文件

  // 渲染文件
  reader.onload = function(arg) {

    var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
    $(".preview_box").empty().append(img);
  }

  var form_data = new FormData();
  var file_data = $("#img_input").prop("files")[0];

  // 把上传的数据放入form_data
  form_data.append("img", file_data);

  $.ajax({
    type: "POST", // 上传文件要用POST
    url: "/images/equipment",
    dataType : "json",
    crossDomain: true, // 如果用到跨域，需要后台开启CORS
    processData: false,  // 注意：不要 process data
    contentType: false,  // 注意：不设置 contentType
    data: form_data
  }).success(function(msg) {
    console.log(msg);
  }).fail(function(msg) {
    console.log(msg);
  });
});