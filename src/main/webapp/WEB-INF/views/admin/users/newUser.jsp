<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp"%>



<c:import url="/WEB-INF/views/admin/users/registriFormUser.jsp">
	<c:param name="user" value="${user}" />
   	
	
</c:import> 

<script type="text/javascript">
    $(document).ready(function () {
        $(".form-register").validate(
                {
                    rules: {
                        name: {
                            required: true,
                            minlength: 3,
                            remote :  {
                                url: "<spring:url value='/admin/users/is-available' />",
                                type: "get",
                                data : {
                                    username: function(){
                                        return $("#name").val();
                                    }
                                }
                            }
                        },
                        email: {
                            required: true,
                            email: true
                        },
                        password: {
                            required: true,
                            minlength: 5
                        },
                        password_again: {
                            required: true,
                            minlength: 5,
                            equalTo: "#password"
                        }
                    },
                    highlight: function(element) {
                        $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                    },
                    unhighlight: function(element) {
                        $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
                    },
                    messages: {
                        name: {
                            remote: "Urzytkownik o takim loginie już istnieje w bazie!"
                        }
                    }
                }
        )
    });
</script>