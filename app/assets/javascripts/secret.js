function secret(){
  var spock = document.getElementById("spock");
  
  spock.addEventListener('click', function(){
    var div = document.getElementById('secret')
    div.classList.add('reveal');
    div.addEventListener('webkitAnimationEnd', function(){
      div.classList.remove('reveal');
    });
  });
}

window.addEventListener('turbolinks:load', secret);