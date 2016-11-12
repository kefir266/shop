/**
 * Created by dmitrij on 12.11.2016.
 */

function submitOrder(order){

    $.ajax({
        type: "POST",
        url: "controler/submitOrder.php",
        datatype:'json',
        data: {order:order},
        success: function(data){
            if(data){
                //console.log(data); // все полученные координаты, именно в том виде, который требовался ТС
            } else {
                // действия в случае, если координаты в БД отсутствуют
            }
        }

    }).done(function( result )
    {
        if (result == "1"){
            $("div.order-accept").remove();
            $("div.thank-you").css("visibility", "visible")
            $("#cart").html( "" );

        }
        return result;
    });
    //return "test";
}

$("button.submit-cart").on("click", function() {

    var goods = $("tr.row-cart");

    var order = [];

    for (i = 0; i < goods.length; i++){
        var row = goods[i];
        var td = $("td", row);
        var count = $("input", td[3]).val();
        order[i] = {
            'ind':i,
            'id':td[1].innerHTML,
            'title':td[2].innerHTML,
            'count': count,
            'price':td[4].innerHTML,
            'sum':td[5].innerHTML
        };

    }

    var result = submitOrder(order);
    //console.log(result);
    //var p = document.createElement('p'),
    //    txt = document.createTextNode(result);
    //
    //p.appendChild(txt);
    //document.body.appendChild(p);


});