const menuNav = document.getElementById('menu');
const overlay = document.getElementById('overlay');

function openMenu() {
  menuNav.classList.remove('hidden');
}

function closeMenu() {
  menuNav.classList.add('hidden');
}
