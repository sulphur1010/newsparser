// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//
//
//= require turbolinks
//= require_tree .
//=require jquery_ujs

function sliderinit() {
		    $(document).ready(function(){
		        $('#layerslider').layerSlider({
		            skinsPath : 'layerskins/',
		            skin : 'fullwidth',
		            thumbnailNavigation : 'hover',
		            hoverPrevNext : true,
		            responsive : true,
		            responsiveUnder : 960,
		            sublayerContainer : 960
		        });
		    });     
        }
$(document).ready(sliderinit);
$(document).bind("page:load",sliderinit);




_.templateSettings = {
     interpolate: /\{\{\=(.+?)\}\}/g ,
     evaluate: /\{\{(.+?)\}\}/g

};

function initMultiselect(){
	$(".select").selectpicker()

}
$(document).ready(initMultiselect);
$(document).bind("page:load",initMultiselect);

