
function mensaje(){
    alert('Bienvenido a la Pagina');

}
function NoIniciado(){
  Swal.fire({
    icon: 'error',
    title: 'Error',
    text: 'Debes iniciar sesion primero',
  })

}
function deleteProducto(id){
    //alert(id)
    //console.log("ID: "+id);
    Swal.fire({
        title: 'Eliminar',
        text: 'Desea eliminar los datos?',
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonText:'Cancelar',
        cancelButtonColor: '#d33',
        confirmButtonText: 'success'
      }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire('Eliminado!','Producto Eliminado Correctamente','success').then(function() {
                window.location.href = "/delete/"+id+"/";
            })
          }
        })
    }
function eliminarCarro(id){
    //alert(id)
    //console.log("ID: "+id);
    Swal.fire({
        title: 'Eliminar',
        text: 'Desea eliminar los datos?',
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        cancelButtonText:'Cancelar',
        confirmButtonText: 'Confirmar'
      }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire('Eliminado!','Producto Eliminado Correctamente del Carrito','success').then(function() {
                window.location.href = "/eliminarCarro/"+id+"/";
            })
          }
        })
}

function Comprafinalizada(){
  Swal.fire({
      title: 'Compra Realizada',
      text: 'Su compra ha sido realizada exitosamente',
      icon: 'success',
      confirmButtonColor: '#3085d6',
      confirmButtonText: 'Confirmar'
    }).then(function() {
      window.location.href = "/Finalcompra/";
  })
}

function NoCarrito(){Swal.fire({
  icon: 'error',
  title: 'Error',
  text: 'No hay nada en el carrito',
})
}

function ActualizarCarrito() {
  Swal.fire({
      title: '¿Estás seguro?',
      text: '¿Deseas actualizar la cantidad del producto en el carrito?',
      icon: 'question',
      showCancelButton: true,
      confirmButtonText: 'Sí',
      cancelButtonText: 'Cancelar',
  }).then(function(result) {
      if (result.isConfirmed) {
          // Obtener el valor actualizado del campo de entrada
          var itemID = document.getElementById('form-actualizar-carrito').dataset.itemId;
          var cantidad = document.getElementById('cantidad-' + itemID).value;
          
          // Actualizar el elemento en la interfaz con el nuevo valor
          var cantidadElement = document.getElementById('cantidad-label-' + itemID);
          cantidadElement.textContent = 'Cantidad: ' + cantidad;
          
          // Enviar el formulario para actualizar el carrito
          document.getElementById('form-actualizar-carrito-' + itemID).submit();
      }
  });
}

