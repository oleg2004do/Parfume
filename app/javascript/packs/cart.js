document.addEventListener("DOMContentLoaded", function () {
  const removeLinks = document.querySelectorAll(".btn-danger");

  removeLinks.forEach((link) => {
    link.addEventListener("ajax:success", function (event) {
      const cartItemId = event.target.closest("tr").id;
      document.getElementById(cartItemId).remove(); // Видаляємо товар з таблиці
    });
  });
});
