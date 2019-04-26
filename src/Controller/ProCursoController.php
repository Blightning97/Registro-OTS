<?php
namespace App\Controller;

use App\Controller\AppController;
use App\Controller\ProProgramaController;
use Cake\Event\Event;
use Cake\Validation\Validator;
use Cake\Datasource\ConnectionManager;
/**
 * ProCurso Controller
 * @author Jason Zamora Trejos
 * @property \App\Model\Table\ProCursoTable $ProCurso
 *
 * @method \App\Model\Entity\ProCurso[]|\Cake\Datasource\ResultSetInterface paginate($object = null, array $settings = [])
 */
class ProCursoController extends AppController
{

    public function beforeFilter(Event $event)
    {
        parent::beforeFilter($event);
        $this->set('active_menu', 'MenubarCourses');
    }
    /**
     * Index method
     *
     * @return \Cake\Http\Response|void
     */
    public function index()
    {
        $proCurso = $this->paginate($this->ProCurso);
        $this->set(compact('proCurso'));
    }

    /**
     * View method
     *
     * @param string|null $id Pro Curso id.
     * @return \Cake\Http\Response|void
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function view($id = null)
    {
        $proCurso = $this->ProCurso->get($id, [
            'contain' => []
        ]);

        $this->set('proCurso', $proCurso);
    }

    /**
     * Add method
     *
     * @return \Cake\Http\Response|null Redirects on successful add, renders view otherwise.
     */
    public function add()
    {
        $proCurso = $this->ProCurso->newEntity();
        if ($this->request->is('post')) {
            $proCurso = $this->ProCurso->patchEntity($proCurso, $this->request->getData());
            $form_data = $this->request->getData();
            $proCurso['FECHA_LIMITE'] = date("Y-m-d", strtotime($form_data['FECHA_LIMITE']));
            $proCurso['FECHA_FINALIZACION'] = date("Y-m-d", strtotime($form_data['FECHA_FINALIZACION']));
            $proCurso['FECHA_INICIO'] = date("Y-m-d", strtotime($form_data['FECHA_INICIO']));
            debug($proCurso);
            $lc_code = $this->checkUniqueData($form_data['PRO_CURSO']);
            debug($lc_code);
            if($lc_code == "1")
            {
               $this->Flash->error(__('The course alredy exits in the system.'));
            }
            else
            {
               if ($this->ProCurso->save($proCurso)) {
                $this->Flash->success(__('The course has been saved.'));

                return $this->redirect(['action' => 'index']);
               }
               $this->Flash->error(__('The course could not be saved. Please, try again.'));
            }
        }
        $this->set(compact('proCurso'));
    }

    /**
     * Edit method
     *
     * @param string|null $id Pro Curso id.
     * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function edit($id = null)
    {
        $proCurso = $this->ProCurso->get($id, ['contain' => []]);
        $lc_oldID = $proCurso['PRO_CURSO'];
        $form_data = $this->request->getData();
        if ($this->request->is(['patch', 'post', 'put'])) {
            $proCurso = $this->ProCurso->patchEntity($proCurso, $this->request->getData());
            $form_data = $this->request->getData();
            $proCurso['FECHA_LIMITE'] = date("Y-m-d", strtotime($form_data['FECHA_LIMITE']));
            $proCurso['FECHA_FINALIZACION'] = date("Y-m-d", strtotime($form_data['FECHA_FINALIZACION']));
            $proCurso['FECHA_INICIO'] = date("Y-m-d", strtotime($form_data['FECHA_INICIO']));
            $lc_code = $this->checkUniqueData($proCurso["PRO_CURSO"]);
            if($lc_code == "1" && $proCurso['PRO_CURSO'] != $form_data['PRO_CURSO'])
            {
               $this->Flash->error(__('The course alredy exits in the system.'));
            }
            else 
            {
               $lo_connet = ConnectionManager::get('default');
               $lc_SiglaCurso = $proCurso["PRO_CURSO"];
               $lc_result = $lo_connet->execute("
               update pro_curso 
               set PRO_CURSO = '$lc_SiglaCurso' 
               where PRO_CURSO = '$lc_oldID'
               ");
               if ($this->ProCurso->save($proCurso)) 
               {
                  $this->Flash->success(__('The course has been saved.'));
   
                  return $this->redirect(['action' => 'index']);
               }
            }
            $this->Flash->error(__('The course could not be saved. Please, try again.'));
        }
        $this->set(compact('proCurso'));
    }

    /**
     * Delete method
     *
     * @param string|null $id Pro Curso id.
     * @return \Cake\Http\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function delete($id = null)
    {
        $this->request->allowMethod(['post', 'delete']);
        $proCurso = $this->ProCurso->get($id);
        if ($this->logicalDelete($id)) {
            $this->Flash->success(__('The course has been deleted.'));
        } else {
            $this->Flash->error(__('The course could not be deleted. Please, try again.'));
        }

        return $this->redirect(['action' => 'index']);
    }
     /**
     * @author Jason Zamora Trejos
     * Logically delete a course
     * 
     */
    public function logicalDelete($id)
    {
        $con = ConnectionManager::get('default');
        $result = $con->execute("update pro_curso set activo = '0' where PRO_CURSO = '$id'");
        return 1;
    }
    
    
    
    /**
     * @author Jason Zamora Trejos
     * If the course exists shows it.
     * 
     */
     public function checkUniqueData($lc_Id)
    {
        $lc_code = "0";
        $lo_connet = ConnectionManager::get('default');
        $lc_result = $lo_connet->execute("SELECT PRO_CURSO FROM pro_curso WHERE PRO_CURSO = '$lc_Id'");
        $lc_result = $lc_result->fetchAll('assoc');
        if(empty($lc_result) == 0)
        {
   
            if($lc_result[0]["PRO_CURSO"] == $lc_Id)
                $lc_code = "1";
            
        }
        return $lc_code;
    }

}
