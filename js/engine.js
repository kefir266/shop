/**
 * Created by dmitrij on 11.11.2016.
 */

function sendBuy(id){
    var itemId = id;

    $.ajax({
        type: "POST",
        url: "controler/buy.php",
        data: {id:itemId}
    }).done(function( result )
    {
        $("#cart").html( result );
    });
}


$("button.btn-cart").on("click", function() {
     sendBuy(this.id);

})