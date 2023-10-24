//= require jquery
//= require rails-ujs

// .card {
//   margin: 0 auto 60px;
//   max-width: 376px;
//   height: 370px;
// }
// .card-body p {
//   text-align: left;
// }
$(document).on('turbolinks:load', function() {
  $(function(){
    $('.js-accordion-title').on('click', function () {
      /*クリックでコンテンツを開閉*/
      $(this).next().slideToggle(200);
      /*矢印の向きを変更*/
      $(this).toggleClass('open', 200);
    });
  });
});