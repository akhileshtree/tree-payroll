<style>
  .modal-content {width: 100%;}
  /* #bd-example-modal-lg{ padding-left: 0px; padding-right: 195px;}
  textarea.form-control{height: calc(1.5em + 1.25rem + 5px);} */
</style>
  <!-- Main content -->
<div class="main-content" id="panel">
   
    <!-- Header -->
  <div class="header bg-primary pb-6">
    <div class="container-fluid">
      <div class="header-body">
        <div class="row align-items-center py-4">
          <div class="col-lg-6 col-7">
            <h6 class="h2 text-white d-inline-block mb-0"><?= $this->escape($this->pageheader); ?></h6>
          </div>
          <div class="col-lg-6 col-5 text-right">
          <button type="button" class="btn btn-sm btn-neutral" data-toggle="modal" data-target="#bd-example-modal-lg">New</button>
        
          </div>
        </div>
      </div>
    </div>
  </div>
    <!-- Header -->

      <!-- Page content -->
  <div class="container-fluid mt--6">
      <!-- Add Employee Form Model -->
    <div class="modal fade" id="bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="card mb-4">
              <!-- Card header -->
            <div class="card-header">
                <h3 class="mb-0">Add Department's Form</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div><!-- Card header -->
              
              <!-- Card body -->
            <div class="card-body">
                <!-- Add Employee Form groups used in grid -->
              <form id="Form" class="needs-validation" novalidate>
                <div class="form-row">

                    <div class="col-md-5 mb-3">
                        <label class="form-control-label" for="departmentname">Department Name</label>
                        <input type="text" class="form-control" name="departmentname" id="departmentname" placeholder="Enter Department Name" required>     
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-control-label" for="departmentnote">Note</label>
                        <input type="text" class="form-control" name="departmentnote" id="departmentnote" placeholder="Enter Note" >
                    </div>
                  
                </div>
                <button class="btn btn-primary" type="submit">Submit form</button><!-- Submit Button -->
              </form>
                <!-- Add Employee Form groups used in grid -->
            </div>
              <!-- Card body -->
          </div>
        </div>
      </div>
    </div>
      <!-- Add Employee Form Model -->

      <!-- Employee table  -->
    <div class="row">
      <div class="col">
        <div class="card">
            <!-- Card header -->
          <div class="card-header">
            <h3 class="mb-0"><?= $this->escape($this->pageheader); ?> Table</h3>
          </div><!-- Card header -->

          <div class="table-responsive py-4">
            <table class="table table-flush" id="datatable-buttons">
                <!-- Table Header -->
              <thead class="thead-light">
                <tr>
                <th>Sno.</th>
                  <th>Department Name</th>
                  <th>Note </th>
                  <th>Status</th>
                  <!-- <th>Role</th> -->
                </tr>
              </thead>
                <!-- Table Header -->

                <!-- Table Body -->
              <tbody>
                  <?php foreach ($this->department as $i=>$res) { ?> 
                <tr>
                  <td><?= $i + 1;?></td>
                  <td><?=$this->escape($res['department_name']);?></td>
                  <td><?=$this->escape($res['note']);?></td>
                  <!-- <td><?=$this->escape($res['status']);?></td>  -->
                  <td><a class="btn-mini btn-success btn-flat" sts="<?php echo $res["status"]?>" id="<?php echo $res["depatment_id"] ?>"><i class="fa fa-align"></i></a></td>

                 <?php if ($res['status'] == 0) { ?>
                    <td><a class="btn-mini btn-success btn-flat" sts="<?php echo $res["status"]?>" id="<?php echo $res["depatment_id"] ?>"><i class="fa fa-align"></i></a></td>
                     <?php  } else { ?>
                      <td><a class="btn-mini btn-danger btn-flat" sts="<?php echo $res["status"] ?>" id="<?php echo $res["depatment_id"] ?>"><i class="fa fa-align"></i></a></td>
                      <?php  }  ?>
                </tr>               
                <?php } ?>          
              </tbody>
                <!-- Table Body -->              
            </table>
          </div>
        </div>
      </div>
    </div>
      <!-- End Employee table  -->
  </div>
      <!-- Page content -->
</div>
 
  <script src="./assets/js/argon.js?v=1.1.0"></script>
  <script type="text/javascript">

    $(document).ready(function () {

            /*  ********************  Submit Form Script *********************  */
        $('#Form').on('submit', function (e) {
            // Save the form data via an Ajax request
          e.preventDefault();
           $('button[type="submit"]').prop('disabled', true);       

          var $form = $(e.target);
            $.ajax({
                type: 'POST',
                url: '<?php echo $this->url(array('module'=>'default', 'controller' => 'department', 'action' => 'save'));?>',
                data: $form.serialize(),
                success: function(response){
                  var obj = $.parseJSON(response);
                  $('button[type="submit"]').prop('disabled', false);
                  if (obj.result) {
                    $('#bd-example-modal-lg').hide();
                    if(obj.result == "Records has been Inserted Successfully !!"){
                      if (confirm(obj.result)) {
                        window.location.reload();
                        } else {
                          window.location.reload();
                        }                    
                  }                 
                      
                  }
                  
                }
            });
        });
            /*  ********************  Submit Form Script *********************  */

      })
  </script>
 
