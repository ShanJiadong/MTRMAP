/*
 * Demo1:ѡȡһ��ͼƬ����Ԥ��
 */
$("#img_input").on("change", function(e) {

  var file = e.target.files[0]; //��ȡͼƬ��Դ

  // ֻѡ��ͼƬ�ļ�
  if (!file.type.match('image.*')) {
    return false;
  }

  var reader = new FileReader();

  reader.readAsDataURL(file); // ��ȡ�ļ�

  // ��Ⱦ�ļ�
  reader.onload = function(arg) {

    var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
    $(".preview_box").empty().append(img);
  }

  var form_data = new FormData();
  var file_data = $("#img_input").prop("files")[0];

  // ���ϴ������ݷ���form_data
  form_data.append("img", file_data);

  $.ajax({
    type: "POST", // �ϴ��ļ�Ҫ��POST
    url: "/images/equipment",
    dataType : "json",
    crossDomain: true, // ����õ�������Ҫ��̨����CORS
    processData: false,  // ע�⣺��Ҫ process data
    contentType: false,  // ע�⣺������ contentType
    data: form_data
  }).success(function(msg) {
    console.log(msg);
  }).fail(function(msg) {
    console.log(msg);
  });
});