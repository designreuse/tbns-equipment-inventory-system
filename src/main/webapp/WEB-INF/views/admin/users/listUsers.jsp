<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('.nav-tabs a:first').tab('show'); // Select first tab
		$('.triggerRemove').click(function(e) {
			e.preventDefault();
			$("#modalRemove .removeBtn").attr("href", $(this).attr("href"));
			$("#modalRemove").modal();
		})
		$(".alert-success").alert();		
		window.setTimeout(function() {
		    $(".alert-success").fadeTo(500, 0).slideUp(1000, function(){
		        $(this).remove(); 
		    });
		}, 4000);
	});
</script>

<div class="row">
	<div class="col-xs-12">
	<c:if test="${not empty msg}">
				<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert"
							aria-hidden="true">×</button>
						<h4>
							<i class="icon fa fa-check"></i> Sukces!
						</h4>
						${msg}
					</div>
				</c:if>
		<div class="box">			
			<div class="box-header">
				<h3 class="box-title">Lista urzytkowników</h3>
				<div class="box-tools">
					<!-- <a href="<spring:url value="/register"/>" class="btn btn-primary btn-sm"> Dodaj urzytkownika </a>   -->
					<!-- <a href="<spring:url value="/register"/>" class="btn btn-default btn-sm"> Dodaj urzytkownika </a>	 -->
					<div class="input-group" style="width: 150px;">
						<div class="search-query-sf"></div>
						<input type="text" name="table_search"
							class="form-control input-sm pull-right" id="system-search" name="q"  placeholder="Search" required>
						<div class="input-group-btn">															
							<button class="btn btn-sm btn-default">
								<i class="fa fa-search"></i>
							</button>
						
						
						</div>
					</div>
				</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body table-responsive no-padding">
				<table class="table table-hover table-list-search">
					<security:authentication property="principal.username"
						var="logged_username" />
					<tr>
						<th>ID</th>
						<th>Login</th>
						<th>Status</th>
						<th>Imię</th>
						<th>Nazwisko</th>
						<th>E-mail</th>
						<th>Data utworzenia</th>
						<th>Data aktualizacji</th>
						<th>Opcje</th>
					</tr>
					<c:forEach items="${users}" var="user">
						<tr>
							<td>${user.id}</td>
							<td><a href="<spring:url value="/admin/users/${user.id}"/>">
									${user.name} </a></td>
							<td>
							<c:choose>
							<c:when test="${user.status == true}"><span class="label label-success ">   Aktywny  </span></c:when>
    						<c:otherwise><span class="label label-danger">Nieaktywny</span></c:otherwise>
					        </c:choose>
					     	</td>
							<td>${user.first_name}</td>
							<td>${user.last_name}</td>
							<td>${user.email}</td>
							<td>${user.dateCreate}</td>
							<td>${user.dateUpdate}</td> 
							<td>							
									<a href="<spring:url value="/admin/users/edit/${user.id}"/>" 
									class="btn btn-xs btn-info"> Szczegóły </a>
								
							 	
							 		<a <c:if test="${user.name.equals(logged_username)}"> disabled="true" </c:if>
									href="<spring:url value="/admin/users/remove/${user.id}"/>"
								class="btn btn-xs btn-danger triggerRemove"> Usuń </a>
															 								    			
					    	</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="modalRemove" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Zamknij</span>
				</button>
				<h4 class="modal-title">Usuwanie</h4>
			</div>
			<div class="modal-body">Czy jesteś pewien że chcesz usunąć tego
				urzytkownika?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<a href="" class="btn btn-danger removeBtn">Usuń</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    var activeSystemClass = $('.list-group-item.active');

    //something is entered in search form
    $('#system-search').keyup( function() {
       var that = this;
        // affect all table rows on in systems table
        var tableBody = $('.table-list-search tbody');
        var tableRowsClass = $('.table-list-search tbody tr');
        $('.search-sf').remove();
        tableRowsClass.each( function(i, val) {
        
            //Lower text for case insensitive
            var rowText = $(val).text().toLowerCase();
            var inputText = $(that).val().toLowerCase();
            if(inputText != '')
            {
                $('.search-query-sf').remove();
                tableBody.prepend('<tr class="search-query-sf"><td class="text-muted" colspan="6"><div class="alert alert-info"><strong>Szukana fraza: "'
                    + $(that).val()
                    + '"</strong></div></td></tr>');
            }
            else
            {
                $('.search-query-sf').remove();
            }

            if( rowText.indexOf( inputText ) == -1 )
            {
                //hide rows
                tableRowsClass.eq(i).hide();
                
            }
            else
            {
                $('.search-sf').remove();
                tableRowsClass.eq(i).show();
            }
        });
        //all tr elements are hidden
        if(tableRowsClass.children(':visible').length == 0)
        {
            tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6"><div class="alert alert-danger"><strong>Nie znaleziono szukanej frazy!</strong></div></td></tr>');
        }
    });
});
</script>
