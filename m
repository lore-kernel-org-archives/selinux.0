Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5237140E2F
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590218; cv=none; b=LuTVqTDOjZ/+FK9ZLJdkJZv9d4zldlfL/iTp7Oj6XBFFsKhEmqu/6+v1NqU2Dwfc3Z5tST3dBzZrgt2Cbz5FVLH3DJ6jN1Urf4cEbBjOl2Z4frCFeBrTvnf42UkKf6RqTGkyfBQCmlCTD1KesMp8KivQy2mfGEDH96iYmtIfroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590218; c=relaxed/simple;
	bh=HUd58OTFjetFwo0db0m2MmfIp97j4CJ6GIkYF4//ltk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZAdhzDpsSVrEESIZTV0lh9QloE8sm5wTttkTCKa7bx2/LLpLep+UZOnw52TvGJTp5KkdlwpDzmJjNEtyI06uBNdZpawxGOuYhnTEuVhoMptnSYlI5thQxfcvopv05/KlXLV3T7uN+HWMJGijIjss8h9VehbRtSVanVCnxFrrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=n4h63Fvy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="n4h63Fvy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712590214;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tI5+TpBGK9ryj8tye9rRgbCaozdatcrQ/H9Fw66/6sk=;
	b=n4h63FvyKomuJe84hdiwXQtM2pgBriOZZcBb9Tj2nPGeZmaly6ddXMlIeePJzohKNKyxkz
	Ah8jKrPrhnWyegA/3GnnC3NUXoUFi+P9AgoaGW2E4cl/HbWQwYsGmgID44A+BsBHcTgx29
	Dn2W1XhQX4VjxGwbk7Os8xguZ3IVM7a0ZuA4SV/88GjuPtMysJ2YbLbHlQ9f5mq76BmE0s
	XA9eXegeqHxWtPFQZH8+D/phiA9b1QiNg0i3UBBIPTS2edpM7JfEFNMbGh0WpgdG6GiSZP
	fzHNrpiVUHrkNxx5EMNi4XheUrpFVBpg4FJuc23ZwvQmr7tG1BZ2/u2VuDk7ZQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 3/3] newrole: use ROWHAMMER resistant values
Date: Mon,  8 Apr 2024 17:30:06 +0200
Message-ID: <20240408153006.69840-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240408153006.69840-1-cgoettsche@seltendoof.de>
References: <20240408153006.69840-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use values for success and failure that are more resistant to bit flips,
to harden against potential ROWHAMMER attacks.
Inspired by [1].

[1]: https://github.com/sudo-project/sudo/commit/7873f8334c8d31031f8cfa83bd97ac6029309e4f
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 35 +++++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 59a5caa3..618c4101 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -89,6 +89,9 @@
 #define PACKAGE "policycoreutils"	/* the name of this package lang translation */
 #endif
 
+#define ALLOW 0x52a2925
+#define DENY  0xad5d6da
+
 #define TRUE 1
 #define FALSE 0
 
@@ -174,8 +177,8 @@ static const char *service_name = "newrole";
  * out:    nothing
  * return: value   condition
  *         -----   ---------
- *           1     PAM thinks that the user authenticated themselves properly
- *           0     otherwise
+ *         ALLOW   PAM thinks that the user authenticated themselves properly
+ *         DENY    otherwise
  *
  * This function uses PAM to authenticate the user running this
  * program.  This is the only function in this program that makes PAM
@@ -184,7 +187,7 @@ static const char *service_name = "newrole";
 static int authenticate_via_pam(const char *ttyn, pam_handle_t * pam_handle)
 {
 
-	int result = 0;		/* set to 0 (not authenticated) by default */
+	int result = DENY;	/* set to DENY (not authenticated) by default */
 	int pam_rc;		/* pam return code */
 	const char *tty_name;
 
@@ -210,7 +213,7 @@ static int authenticate_via_pam(const char *ttyn, pam_handle_t * pam_handle)
 	/* Ask PAM to verify acct_mgmt */
 	pam_rc = pam_acct_mgmt(pam_handle, 0);
 	if (pam_rc == PAM_SUCCESS) {
-		result = 1;	/* user authenticated OK! */
+		result = ALLOW;	/* user authenticated OK! */
 	}
 
       out:
@@ -348,12 +351,12 @@ static int streq_constant(const char *userinput, const char *secret)
 	s_len = strlen(secret);
 
 	if (u_len != s_len)
-		return 0;
+		return DENY;
 
 	for (i = 0; i < u_len; i++)
 		ret |= x[i] ^ y[i];
 
-	return ret == 0;
+	return ret == 0 ? ALLOW : DENY;
 }
 
 /* authenticate_via_shadow_passwd()
@@ -362,9 +365,9 @@ static int streq_constant(const char *userinput, const char *secret)
  * out:    nothing
  * return: value   condition
  *         -----   ---------
- *           1     user authenticated themselves properly according to the
+ *         ALLOW   user authenticated themselves properly according to the
  *                 shadow passwd file.
- *           0     otherwise
+ *         DENY    otherwise
  *
  * This function uses the shadow passwd file to thenticate the user running
  * this program.
@@ -382,14 +385,14 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	if (!(p_shadow_line)) {
 		fprintf(stderr, _("Cannot find your entry in the shadow "
 				  "passwd file.\n"));
-		return 0;
+		return DENY;
 	}
 
 	/* Ask user to input unencrypted password */
 	if (!(unencrypted_password_s = getpass(PASSWORD_PROMPT))) {
 		fprintf(stderr, _("getpass cannot open /dev/tty\n"));
 		memzero(p_shadow_line->sp_pwdp, strlen(p_shadow_line->sp_pwdp));
-		return 0;
+		return DENY;
 	}
 
 	/* Use crypt() to encrypt user's input password. */
@@ -400,7 +403,7 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	if (errno || !encrypted_password_s) {
 		fprintf(stderr, _("Cannot encrypt password.\n"));
 		memzero(p_shadow_line->sp_pwdp, strlen(p_shadow_line->sp_pwdp));
-		return 0;
+		return DENY;
 	}
 
 	ret = streq_constant(encrypted_password_s, p_shadow_line->sp_pwdp);
@@ -416,7 +419,7 @@ static int authenticate_via_shadow_passwd(const char *uname)
  */
 static int verify_shell(const char *shell_name)
 {
-	int found = 0;
+	int found = DENY;
 	const char *buf;
 
 	if (!(shell_name && shell_name[0]))
@@ -429,7 +432,7 @@ static int verify_shell(const char *shell_name)
 
 		/* check the shell skipping newline char */
 		if (!strcmp(shell_name, buf)) {
-			found = 1;
+			found = ALLOW;
 			break;
 		}
 	}
@@ -479,7 +482,7 @@ static int extract_pw_data(struct passwd *pw_copy)
 		goto out_free;
 	}
 
-	if (verify_shell(pw->pw_shell) == 0) {
+	if (verify_shell(pw->pw_shell) != ALLOW) {
 		fprintf(stderr, _("Error!  Shell is not valid.\n"));
 		goto out_free;
 	}
@@ -1182,9 +1185,9 @@ int main(int argc, char *argv[])
 		goto err_free;
 	}
 
-	if (!authenticate_via_pam(ttyn, pam_handle))
+	if (authenticate_via_pam(ttyn, pam_handle) != ALLOW)
 #else
-	if (!authenticate_via_shadow_passwd(pw.pw_name))
+	if (authenticate_via_shadow_passwd(pw.pw_name) != ALLOW)
 #endif
 	{
 		fprintf(stderr, _("newrole: incorrect password for %s\n"),
-- 
2.43.0

