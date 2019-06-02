<?php
/**
 * @var \App\View\AppView $this
 * @var \App\Model\Entity\SolSolicitud $solSolicitud
 */
?>
<nav class="large-3 medium-4 columns" id="actions-sidebar">
    <ul class="side-nav">
        <li class="heading"><?= __('Actions') ?></li>
        <li><?= $this->Form->postLink(
                __('Delete'),
                ['action' => 'delete', $solSolicitud->SEG_USUARIO],
                ['confirm' => __('Are you sure you want to delete # {0}?', $solSolicitud->SEG_USUARIO)]
            )
        ?></li>
        <li><?= $this->Html->link(__('List Sol Solicitud'), ['action' => 'index']) ?></li>
    </ul>
</nav>
<div class="solSolicitud form large-9 medium-8 columns content">
    <?= $this->Form->create($solSolicitud) ?>
    <fieldset>
        <legend><?= __('Edit Sol Solicitud') ?></legend>
        <?php
            echo $this->Form->control('RESULTADO');
            echo $this->Form->control('ACTIVO');
        ?>
    </fieldset>
    <?= $this->Form->button(__('Submit')) ?>
    <?= $this->Form->end() ?>
</div>
