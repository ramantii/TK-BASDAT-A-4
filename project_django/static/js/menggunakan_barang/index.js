const getBarang = () => {
  const namaTokoh = $("#select-nama-tokoh").val();
  const url = "/pemain/menggunakan-barang/get-barang";
  const csrftoken = $("[name=csrfmiddlewaretoken]").val();
  const data = { namaTokoh };

  $.ajax({
    type: 'POST',
    url: url,
    headers: { "X-CSRFToken": csrftoken },
    data,
    success: function (response) {
      $("#select-barang").empty();
      $("#select-barang").append(`<option value="">Pilih Barang</option>`);
      response.data.map((res)=>$("#select-barang").append(`<option value="${res.id_koleksi}">${res.id_koleksi}</option>`))
    },
    error: function (response) {
      console.log(response)
    }
  })
}

$(document).ready(function() {
  getBarang();
});