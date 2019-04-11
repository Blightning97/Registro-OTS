<?php
namespace App\Model\Entity;

use Cake\ORM\Entity;

/**
 * ProCurso Entity
 *
 * @property string $PRO_CURSO
 * @property string $NOMBRE
 * @property \Cake\I18n\FrozenDate $FECHA_INICIO
 * @property \Cake\I18n\FrozenDate $FECHA_FINALIZACION
 * @property \Cake\I18n\FrozenDate $FECHA_LIMITE
 * @property int $CREDITOS
 * @property string $IDIOMA
 * @property string $LOCACION
 * @property string|null $ACTIVO
 * @property string|null $PRO_PROGRAMA
 * @property string|null $SEG_USUARIO
 * @property string|null $SOL_FORMULARIO
 */
class ProCurso extends Entity
{
    /**
     * Fields that can be mass assigned using newEntity() or patchEntity().
     *
     * Note that when '*' is set to true, this allows all unspecified fields to
     * be mass assigned. For security purposes, it is advised to set '*' to false
     * (or remove it), and explicitly make individual fields accessible as needed.
     *
     * @var array
     */
    protected $_accessible = [
        'NOMBRE' => true,
        'FECHA_INICIO' => true,
        'FECHA_FINALIZACION' => true,
        'FECHA_LIMITE' => true,
        'CREDITOS' => true,
        'IDIOMA' => true,
        'LOCACION' => true,
        'ACTIVO' => true,
        'PRO_PROGRAMA' => true,
        'SEG_USUARIO' => true,
        'SOL_FORMULARIO' => true
    ];
}