<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .strength-bar { height: 4px; border-radius: 4px; margin-top: 6px; background: #e2e8f0; overflow: hidden; }
        .strength-fill { height: 100%; width: 0; transition: width .3s, background .3s; border-radius: 4px; }
        .strength-text { font-size: .78rem; color: #64748b; margin-top: 3px; }
        .input-ok { border-color: #22c55e !important; }
        .input-err { border-color: #ef4444 !important; }
        .field-msg { font-size: .78rem; margin-top: 3px; }
        .field-msg.ok { color: #22c55e; }
        .field-msg.err { color: #ef4444; }
    </style>
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box" style="max-width:500px;">
        <div style="text-align:center;margin-bottom:6px;">
            <a href="${pageContext.request.contextPath}/"
               style="color:#ff6b00;font-size:1.4rem;font-weight:900;text-decoration:none;">
                ShopNepal
            </a>
        </div>
        <h2>Create Account</h2>
        <p class="sub">Join ShopNepal today — it's free!</p>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register" id="regForm">

            <div class="form-group">
                <label>Full Name <span style="color:#ef4444;">*</span></label>
                <input type="text" name="fullName" id="fullName"
                       placeholder="e.g. Damaru Koirala"
                       value="${param.fullName != null ? param.fullName : ''}" required>
                <div class="field-msg" id="nameMsg"></div>
            </div>

            <div class="form-group">
                <label>Username <span style="color:#ef4444;">*</span></label>
                <input type="text" name="username" id="username"
                       placeholder="4-20 characters, letters/numbers only"
                       value="${param.username != null ? param.username : ''}" required>
                <div class="field-msg" id="userMsg"></div>
            </div>

            <div style="display:flex;gap:14px;">
                <div class="form-group" style="flex:1;">
                    <label>Email Address <span style="color:#ef4444;">*</span></label>
                    <input type="email" name="email" id="email"
                           placeholder="you@example.com"
                           value="${param.email != null ? param.email : ''}" required>
                    <div class="field-msg" id="emailMsg"></div>
                </div>
                <div class="form-group" style="flex:1;">
                    <label>Phone Number <span style="color:#ef4444;">*</span></label>
                    <input type="text" name="phone" id="phone"
                           placeholder="10 digit number"
                           value="${param.phone != null ? param.phone : ''}" required>
                    <div class="field-msg" id="phoneMsg"></div>
                </div>
            </div>

            <div class="form-group">
                <label>Password <span style="color:#ef4444;">*</span></label>
                <input type="password" name="password" id="password"
                       placeholder="Min 6 chars, 1 uppercase, 1 number" required>
                <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
                <div class="strength-text" id="strengthText">Enter a password</div>
            </div>

            <div class="form-group">
                <label>Confirm Password <span style="color:#ef4444;">*</span></label>
                <input type="password" name="confirmPassword" id="confirmPassword"
                       placeholder="Repeat your password" required>
                <div class="field-msg" id="confirmMsg"></div>
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="background:#ff6b00;margin-top:6px;">
                Create Account
            </button>
        </form>

        <div class="divider">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login here</a>
        </div>
        <div style="text-align:center;margin-top:8px;">
            <a href="${pageContext.request.contextPath}/"
               style="color:#64748b;font-size:.85rem;text-decoration:none;">
                ← Back to Home
            </a>
        </div>
    </div>
</div>

<script>
    // Real-time validation that keeps all values
    const fullName = document.getElementById('fullName');
    const username = document.getElementById('username');
    const email    = document.getElementById('email');
    const phone    = document.getElementById('phone');
    const password = document.getElementById('password');
    const confirm  = document.getElementById('confirmPassword');

    function setMsg(id, msg, isOk) {
        const el = document.getElementById(id);
        el.textContent = msg;
        el.className = 'field-msg ' + (isOk ? 'ok' : 'err');
    }

    fullName.addEventListener('input', function() {
        if (/^[a-zA-Z\s]{2,}$/.test(this.value.trim())) {
            this.className = 'input-ok';
            setMsg('nameMsg', '✓ Looks good', true);
        } else {
            this.className = 'input-err';
            setMsg('nameMsg', 'Only letters and spaces allowed', false);
        }
    });

    username.addEventListener('input', function() {
        if (/^[a-zA-Z0-9_]{4,20}$/.test(this.value.trim())) {
            this.className = 'input-ok';
            setMsg('userMsg', '✓ Valid username', true);
        } else {
            this.className = 'input-err';
            setMsg('userMsg', '4-20 chars, letters/numbers/underscore only', false);
        }
    });

    email.addEventListener('input', function() {
        if (/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(this.value.trim())) {
            this.className = 'input-ok';
            setMsg('emailMsg', '✓ Valid email', true);
        } else {
            this.className = 'input-err';
            setMsg('emailMsg', 'Enter a valid email address', false);
        }
    });

    phone.addEventListener('input', function() {
        if (/^[0-9]{10}$/.test(this.value.trim())) {
            this.className = 'input-ok';
            setMsg('phoneMsg', '✓ Valid phone', true);
        } else {
            this.className = 'input-err';
            setMsg('phoneMsg', 'Must be exactly 10 digits', false);
        }
    });

    password.addEventListener('input', function() {
        const v = this.value;
        let score = 0;
        if (v.length >= 6) score++;
        if (/[A-Z]/.test(v)) score++;
        if (/[0-9]/.test(v)) score++;
        if (/[^a-zA-Z0-9]/.test(v)) score++;

        const fill = document.getElementById('strengthFill');
        const text = document.getElementById('strengthText');
        const colors = ['#ef4444','#f59e0b','#22c55e','#15803d'];
        const labels = ['Weak','Fair','Strong','Very Strong'];
        fill.style.width = (score * 25) + '%';
        fill.style.background = colors[score - 1] || '#e2e8f0';
        text.textContent = score > 0 ? labels[score - 1] : 'Enter a password';

        checkConfirm();
    });

    confirm.addEventListener('input', checkConfirm);

    function checkConfirm() {
        if (confirm.value === '') return;
        if (confirm.value === password.value) {
            confirm.className = 'input-ok';
            setMsg('confirmMsg', '✓ Passwords match', true);
        } else {
            confirm.className = 'input-err';
            setMsg('confirmMsg', 'Passwords do not match', false);
        }
    }
</script>
</body>
</html>
