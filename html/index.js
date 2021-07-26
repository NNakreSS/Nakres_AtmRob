$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://Nakres_AtmRob/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://Nakres_AtmRob/exit', JSON.stringify({}));
        return
    })
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://Nakres_AtmRob/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("http://Nakres_AtmRob/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        if (inputValue == "SUT-HOLEZ"){
        $.post('http://Nakres_AtmRob/code', JSON.stringify({
            password: inputValue,
        }));
        return;
        } 
            else {
            $.post("http://Nakres_AtmRob/error", JSON.stringify({
                    error: "Incorrect password"
                }))
                return
            }

})
})
