function ComprarSuscripcion(id){
    Swal.fire({
      title:'Confirmar Suscripcion',
      icon: 'info',
      text:'¿Estas seguro?',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      cancelButtonText: 'Cancelar',
      confirmButtonText: 'Confirmar'
    }).then((result) => {
      if (result.isConfirmed) {
        swal.fire('Pago Realizado!','Gracias por la suscripcion','success').then(function(){
            window.location.href = "/addSuscripcion/"+id+"/";
        })
      }
    })
  }

  function AnularSuscripcion(id){
    Swal.fire({
      title:'Anular Suscripcion',
      icon: 'info',
      text:'¿Estas seguro?',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      cancelButtonText: 'Cancelar',
      confirmButtonText: 'Confirmar'
    }).then((result) => {
      if (result.isConfirmed) {
        swal.fire('Anulacion completada','','success').then(function(){
            window.location.href = "/deleteSuscripcion/"+id+"/";
        })
      }
    })
  }