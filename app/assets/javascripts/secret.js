function secret(){
  var spock = document.getElementById("spock");
  
  spock.addEventListener('click', function(){
    var wrapper = document.getElementById('wrapper')
    var div = document.createElement('div');
    div.className = 'secret';
    wrapper.appendChild(div);
    div.classList.add('reveal');
    div.addEventListener('webkitAnimationEnd', function(){
      div.classList.remove('reveal');
    });
  });
}

window.addEventListener('turbolinks:load', secret);