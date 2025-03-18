/********************************************************
Search header
********************************************************/
$("body").click(function (event) {
  if (!$(event.target).closest(".collection-selector").length) {
    $(".list_search").css("display", "none");
  }
});
/* top search */

$(".search_text").click(function () {
  $(this).next().slideToggle(200);
  $(".list_search").show();
});

$(".list_search .search_item").on("click", function (e) {
  $(".list_search").hide();

  var optionSelected = $(this);

  var title = optionSelected.text();

  $(".search_text").text(title);

  $(".search-text").focus();
  optionSelected.addClass("active").siblings().removeClass("active");
});

$(".header_search form button").click(function (e) {
  e.preventDefault();
  var textmm = $(".search-text").val();
  if (textmm != "") {
    searchCollection();
    setSearchStorage(".header_search form");
  } else {
    alert("bạn chưa nhập nội dung tìm kiếm");
  }
});

$("#mb_search").click(function () {
  $(".mb_header_search").slideToggle("fast");
});

$(".fi-title.drop-down").click(function () {
  $(this).toggleClass("opentab");
});


function searchCollection() {
  var collectionId = $(".list_search .search_item.active").attr("data-coll-id");
  var vl = $(".header form input").val();
  var searchVal = $('.header_search input[type="search"]').val();
  var url = "./searchProduct?collId=" + collectionId + "&name=" + encodeURIComponent(searchVal); 
  window.location = url;
}
/*** Search Storage ****/

function setSearchStorage(form_id) {
  var seach_input = $(form_id).find(".search-text").val();
  var search_collection = $(form_id)
    .find(".list_search .search_item.active")
    .attr("data-coll-id");
  sessionStorage.setItem("search_input", seach_input);
  sessionStorage.setItem("search_collection", search_collection);
}
function getSearchStorage(form_id) {
  var search_input_st = ""; // sessionStorage.getItem('search_input');
  var search_collection_st = ""; // sessionStorage.getItem('search_collection');
  if (sessionStorage.search_input != "") {
    search_input_st = sessionStorage.search_input;
  }
  if (sessionStorage.search_collection != "") {
    search_collection_st = sessionStorage.search_collection;
  }
  $(form_id).find(".search-text").val(search_input_st);
  $(form_id)
    .find('.search_item[data-coll-id="' + search_collection_st + '"]')
    .addClass("active")
    .siblings()
    .removeClass("active");
  var search_key = $(form_id)
    .find('.search_item[data-coll-id="' + search_collection_st + '"]')
    .text();
  if (search_key != "") {
    var searchVal = $('.header_search input[type="search"]').val();
    $(form_id).find(".collection-selector .search_text").text(search_key);
    $(".search_item_name").text(searchVal + " thuộc danh mục " + search_key);
  }
}
function resetSearchStorage() {
  sessionStorage.removeItem("search_input");
  sessionStorage.removeItem("search_collection");
}
$(window).load(function () {
  getSearchStorage(".header_search form");
  resetSearchStorage();
});
