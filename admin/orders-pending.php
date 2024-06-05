<html lang="en">
<?php
session_start();
require_once("../database/connection.php");
require_once("function/admin-function.php");
require("function/check-login.php");
include("head.html");


check_login_user_universal($link);
if (!check_login_user_universal($link)) {
    header("Location: index");
    exit;
} else {
    $verifiedUID = $_SESSION['admin_id'];
}


?>


</head>
<style> 
@media only screen and (max-width: 767px) {
    #approve_cancel {
        margin-top: 10px;
    }
}
</style>
<body>



    <div class="container-scroller">
        <!-- partial:partials/_sidebar.html -->
        <?php include("sidebar.php"); ?>
        <!-- partial -->
        <div class="container-fluid page-body-wrapper">
            <!-- partial:partials/_navbar.html -->
            <?php include("navbar.php") ?>
            <!-- partial -->
            <div class="main-panel">

                <div class="content-wrapper">



                    <div class="row">

                        <div class="col-lg-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Pending Transaction</h4>
                                    
                                    <div class="table-responsive">
                                        <table id="productTable" class="table">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Txn</th>
                                                    <th>User</th>
                                                    <th>To pay</th>
                                                    <th>Date Ordered</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php


                                                // Fetch orders
                                                $query = "SELECT * FROM orders WHERE order_status = 'Pending'";
                                                $result = mysqli_query($link, $query);

                                                while ($row = mysqli_fetch_assoc($result)) {
                                                    
                                                    $userid = $row['userid'];

                                                    // Fetch username
                                                    $usernameQuery = "SELECT username FROM users WHERE userid = ?";
                                                    $stmtUsername = $link->prepare($usernameQuery);
                                                    $stmtUsername->bind_param("i", $userid);
                                                    $stmtUsername->execute();
                                                    $resultUsername = $stmtUsername->get_result();
                                                    $username = $resultUsername->fetch_assoc()['username'];
                                                    $stmtUsername->close();

                                                    $status = $row['order_status'];

                                                    $order_id = $row['order_id'];
                                                    $transaction_number = $row['transaction_number'];

                                                    

                                                    $createdAt = date('d M Y', strtotime($row['created_at']));

                                                    // check if the order is pending for cancellation
                                                    $queryCheckCancellation = "SELECT status FROM cancellation_request WHERE order_id = ?";
                                                    $stmtqueryCheckCancellation = $link->prepare($queryCheckCancellation);

                                                  
                                                    $stmtqueryCheckCancellation->bind_param("i", $order_id); 
                                                
                                                    $stmtqueryCheckCancellation->execute();
                                                
                                                    // Fetch the result
                                                    $stmtqueryCheckCancellation->bind_result($cancel_order);
                                                    $stmtqueryCheckCancellation->fetch();
                                                    if (!isset($cancel_order)) {
                                                        $cancel_order = 3;
                                                    }

                                                    echo $cancel_order;

                                                    if ($status === 'Pending' && $cancel_order === 0) {
                                                        $status = '<label class="badge badge-danger">Cancellation</label>';
                                                    } else if ($status === 'Pending') {
                                                        $status = '<label class="badge badge-warning">Pending</label>';
                                                    }




                                                    echo "<tr>
                                                        <td>{$row['order_id']}</td>
                                                        <td>{$row['transaction_number']}</td>
                                                        <td>{$username}</td>
                                                        <td style='color: green;'>₱" . number_format($row['total_amount'], 2, '.', ',') . "</td>
                                                        <td>{$createdAt}</td>
                                                        <td>{$status}</td>
                                                        <td>
                                                            <button type='button' data-txn='{$row['transaction_number']}' class='view-order btn btn-primary btn-md'><i class='fas fa-shopping-cart'></i></button>
                                                            <button type='button' data-userid='{$row['userid']}' class='view-user btn btn-info btn-md'><i class='fas fa-user'></i></button>
                                                            <button type='button' data-userid='{$row['userid']}' class='email-user btn btn-success btn-md'><i class='fas fa-envelope'></i></button>
                                                            <button type='button' data-order_id='{$row['order_id']}' class='proof-payment btn btn-info btn-md'><i class='fas fa-file-invoice-dollar'></i></button>
                                                        </td>
                                                    </tr>";
                                                    $stmtqueryCheckCancellation->close();
                                                }

                                                mysqli_close($link);
                                                ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
                <!-- content-wrapper ends -->
                <!-- partial:partials/_footer.html -->
                <?php include("footer.html") ?>
                <!-- partial -->
            </div>
            <!-- main-panel ends -->
        </div>
        <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->


    <?php include("assets/injectables.html"); ?>
</body>

<script>
    $(function() {
        // Use event delegation for the click event
        $(document).on('click', '.view-order', function() {
            var txn = $(this).data('txn');
            $.ajax({
                url: 'function/order-list.php',
                type: 'post',
                data: {
                    txn: txn
                },
                success: function(response) {
                    $('.ordermodalbody').html(response);
                    $('#orderModal').modal('show');

                    $(document).on('click', '#close-btn', function() {
                        $('#orderModal').modal('hide');
                    });
                }
            });
        });
    });
</script>


<!-- Modal for cart list -->
<div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="ModalModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Cart</h5>
                <button type="button" class="close" id="close-btn" data-dismiss="modal">&times;</button>
            </div>
            <div class="ordermodalbody modal-body">

                <!-- Content will be loaded here from edit-temp-question.php -->
            </div>
        </div>
    </div>
</div>


<!-- proof of payment -->
<script>
    $(function() {
        // Use event delegation for the click event
        $(document).on('click', '.proof-payment', function() {
            var order_id = $(this).data('order_id');
            $.ajax({
                url: 'function/proof-payment.php',
                type: 'post',
                data: {
                    order_id: order_id
                },
                success: function(response) {
                    $('.proofPaymentModalBody').html(response);
                    $('#proofPaymentModal').modal('show');

                    $(document).on('click', '#close-btn', function() {
                        $('#proofPaymentModal').modal('hide');
                    });
                }
            });
        });
    });
</script>


<!-- Modal for proof of payment -->
<div class="modal fade" id="proofPaymentModal" tabindex="-1" role="dialog" aria-labelledby="ModalModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Proof Of Payment</h5>
                <button type="button" class="close" id="close-btn" data-dismiss="modal">&times;</button>
            </div>
            <div class="proofPaymentModalBody modal-body">

                <!-- Content will be loaded here from edit-temp-question.php -->
            </div>
        </div>
    </div>
</div>


<!-- datatable -->

<script src="https://cdn.datatables.net/2.0.7/js/dataTables.min.js"></script>
<script>
    $(document).ready(function() {
        $('#productTable').DataTable();
    });
</script>

<!-- tooltip for status -->
<script>
    $(document).ready(function() {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>


<!-- view user -->
<script>
    $(function() {
        // Use event delegation for the click event
        $(document).on('click', '.view-user', function() {
            var userid = $(this).data('userid');
            $.ajax({
                url: 'function/view-user.php',
                type: 'post',
                data: {
                    userid: userid
                },
                success: function(response) {
                    $('.viewUserModalBody').html(response);
                    $('#viewUserModal').modal('show');

                    $(document).on('click', '#close-btn', function() {
                        $('#viewUserModal').modal('hide');
                    });
                }
            });
        });
    });
</script>


<!-- Modal for proof of payment -->
<div class="modal fade" id="viewUserModal" tabindex="-1" role="dialog" aria-labelledby="ModalModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">User information</h5>
                <button type="button" class="close" id="close-btn" data-dismiss="modal">&times;</button>
            </div>
            <div class="viewUserModalBody modal-body">

                <!-- Content will be loaded here from edit-temp-question.php -->
            </div>
        </div>
    </div>
</div>






</html>