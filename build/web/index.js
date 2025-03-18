$(".not-dqtab").each(function () {
    /* Khởi tạo ban đầu cho 2 kiểu tab */
    var $this1 = $(this);
    var $this2 = $(this);
    var datasection = $this1.closest('.not-dqtab').attr('data-section');
    $this1.find('.tabs-title li:first-child').addClass('current');
    $this1.find('.tab-content').first().addClass('current');
    var datasection2 = $this2.closest('.not-dqtab').attr('data-section-2');
    $this2.find('.tabs-title li:first-child').addClass('current');
    $this2.find('.tab-content').first().addClass('current');

    /* Kiểu 1 - có hiệu ứng load bằng AJAX */
    $this1.find(".tabtitle1 li").click(function () {
        var $this2 = $(this),
                tab_id = $this2.attr("data-tab");

        var etabs = $this2.closest(".e-tabs");
        etabs.find(".tabs-title li").removeClass("current");
        etabs.find(".tab-content").removeClass("current");
        $this2.addClass("current");
        etabs.find(".tab-content[data-tab='" + tab_id + "']").addClass("current");
        if (!$this2.hasClass("has-content")) {
            $this2.addClass("has-content");
            getContentTab("." + datasection + " .tab-content[data-tab='" + tab_id + "']");
        }
    });
    $this2.find(".tabtitle2 li").click(function () {
        var $this2 = $(this),
                tab_id = $this2.attr("data-tab");

        var etabs = $this2.closest(".e-tabs");
        etabs.find(".tabs-title li").removeClass("current");
        etabs.find(".tab-content").removeClass("current");
        $this2.addClass("current");
        etabs.find(".tab-content[data-tab='" + tab_id + "']").addClass("current");
        if (!$this2.hasClass("has-content")) {
            $this2.addClass("has-content");
            getContentTab("." + datasection + " .tab-content[data-tab='" + tab_id + "']");
        }
    });

});

// Hàm getContentTab sửa lại để không dùng url
function getContentTab(selector) {
    // Hiệu ứng loading
    var loading =
            '<div class="a-center"><img src="//bizweb.dktcdn.net/100/455/315/themes/894917/assets/rolling.svg?1723540086975" alt="loading"/></div>';
    // Hiển thị loading trước
    var contentDiv = $(selector).html();
    $(selector).html(loading);


    // Giả lập thời gian tải bằng setTimeout
    setTimeout(function () {
        // Hiển thị nội dung thực sự
        $(selector).html(contentDiv);
        if ($(selector).find('.swiper-container').length) {
            $(selector).find('.swiper-container').each(function () {
                var swiper = new Swiper(this, {
                    slidesPerView: 5,
                    spaceBetween: 20,
                    breakpoints: {
                        300: {slidesPerView: 2, spaceBetween: 20},
                        767: {slidesPerView: 2, spaceBetween: 20},
                        768: {slidesPerView: 2, spaceBetween: 20},
                        1024: {slidesPerView: 5, spaceBetween: 20}
                    }
                });
                swiper.update(); // Cập nhật Swiper để đảm bảo hiển thị đúng
            });
        }
    }, 500);
    dataType: "html";

}

// Ajax carousel
// Khởi tạo các Swiper khác nhau
function ajaxSwiper(selector) {
    $(selector + " .swipertab").each(function () {
        if (!this.swiperInstance) {
            this.swiperInstance = new Swiper(this, {
                slidesPerView: 5,
                spaceBetween: 20,
                breakpoints: {
                    300: {slidesPerView: 2, spaceBetween: 20},
                    767: {slidesPerView: 2, spaceBetween: 20},
                    768: {slidesPerView: 2, spaceBetween: 20},
                    1024: {slidesPerView: 5, spaceBetween: 20}
                }
            });
        }
    });
}

function ajaxSwiper2(selector) {
    $(selector + " .swipertab2").each(function () {
        if (!this.swiperInstance) {
            this.swiperInstance = new Swiper(this, {
                slidesPerView: 3,
                spaceBetween: 20,
                breakpoints: {
                    300: {slidesPerView: 2, spaceBetween: 20},
                    767: {slidesPerView: 2, spaceBetween: 20},
                    768: {slidesPerView: 2, spaceBetween: 20},
                    1024: {slidesPerView: 3, spaceBetween: 20}
                }
            });
        }
    });
}

// Khởi tạo Swiper khi trang đã tải
document.addEventListener("DOMContentLoaded", function () {
    var swiperCarousel =
            new Swiper(".swiper-carousel", {
                slidesPerView: 5,
                spaceBetween: 20,
                breakpoints: {
                    300: {slidesPerView: 2, spaceBetween: 20},
                    767: {slidesPerView: 2, spaceBetween: 20},
                    768: {slidesPerView: 3, spaceBetween: 20},
                    1024: {slidesPerView: 4, spaceBetween: 20},
                    1200: {slidesPerView: 5, spaceBetween: 20}
                }
            });


});

document.addEventListener("DOMContentLoaded", function () {
    var swiperCarousel = new Swiper(".swiper-carousel2", {
        slidesPerView: 3,
        spaceBetween: 20,
        breakpoints: {
            300: {slidesPerView: 2, spaceBetween: 20},
            767: {slidesPerView: 2, spaceBetween: 20},
            768: {slidesPerView: 2, spaceBetween: 20},
            1024: {slidesPerView: 3, spaceBetween: 20}
        }
    });
});

          