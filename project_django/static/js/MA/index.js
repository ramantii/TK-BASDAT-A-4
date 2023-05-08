const getApparel = () => {
    const nama_tokoh = $("#select-nama-tokoh").val();
    const url = "/pemain/menggunakan-apparel/get-apparel";
    const csrftoken = $("[name=csrfmiddlewaretoken]").val();
    const data = { nama_tokoh };
  
    $.ajax({
      type: 'POST',
      url: url,
      headers: { "X-CSRFToken": csrftoken },
      data,
      success: function (response) {
        $("#select-apparel").empty()
        response.data.map((res)=>$("#select-apparel").append(`<option value="${res.id_koleksi}">${res.id_koleksi}</option>`))
      },
      error: function (response) {
        console.log(response)
      }
    })
  }
  
  $(document).ready(function() {
    getApparel();
  });