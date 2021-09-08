function secret(){
  const spock = document.getElementById("spock");
  
  spock.addEventListener('click', () => {
    const wrapper = document.getElementById('wrapper')
    const div = document.createElement('div');
    div.className = 'secret';
    wrapper.appendChild(div);
    div.classList.add('reveal');
    div.addEventListener('webkitAnimationEnd', () => {
      div.classList.remove('reveal');
    });
  });
}

window.addEventListener('turbolinks:load', secret);