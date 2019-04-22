<?php
/**
 * Barra superior con el logo de la OET, el nombre del sistema y la información de sesión del usuario
 */
?>

<nav class="navbar navbar-fixed-top navbar-expand-xl justify-content-between" style="background-color:#659F31">
        <div class="navbar-nav">
	
            <?= $this->Html->image('Logos/eng/s/3.png', ['style' => 'height:50px'])?>
        
        </div>

  
        <div class="navbar-bar">
            <?php echo $this->Html->link( $actualUser['NOMBRE_USUARIO'],   array('controller' => 'usuario', 'action' => 'profileView'), [ 'class' => 'menuItem'] ); ?>

            
            <?php 
  
                if($actualUser){
                    echo $this->Html->link( "Log Out",   array('controller' => 'seguridad', 'action' => 'logout'), ['class' => 'menuItem'] );
                }else{
                    echo $this->Html->link( "Log In",   array('controller' => 'seguridad', 'action' => 'login'), [ 'id'=>'LogIn','class' => 'menuItem'] ); 
                }
            ?>
            <?php //echo $this->Html->link( "Cambiar a inglés",   array('controller' => 'idioma'), [ 'class' => 'menuItem'] ); ?>




    
            
        </div>

</nav>