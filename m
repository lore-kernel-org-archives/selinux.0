Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mEF85Lhw"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1808191
	for <selinux@vger.kernel.org>; Wed, 13 Dec 2023 08:14:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so827866366b.1
        for <selinux@vger.kernel.org>; Wed, 13 Dec 2023 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702484056; x=1703088856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKJklPt5dvwQzkUiIfAJUiT7Y+bLT341krw0xZUEn1I=;
        b=mEF85LhwFgRnVHCVT5UJctLN0+Dch5NVPoNXgDiBnYQl5VpO4agiRtDHxtEk4i3+7+
         6iueJtLrV/Y44kas26J+1xxh2TQO/cnhJJbrFA5YMsYI9TZGsKx3lu/5mHCHlUp1Xo/L
         ruJ5NuVAcQjLgA/z3IpG3rQPER+FWtUIPTjCbTGaeqbfLZsZTgQaRLaQJX9BhKdihsvN
         Z7wuaot8GEC4hnGgaRC1QE0m9y+JS4iAU981Hh1jPD+BRWxIF6OR+I3jUoImLm8PeclJ
         ixJPG2k9VAXEJKrT1X5ncXKw7mZ3PMzVq/LHcp3dlPiRMVIl2ubj8DoVoro3ENhuuEFD
         yl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484056; x=1703088856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKJklPt5dvwQzkUiIfAJUiT7Y+bLT341krw0xZUEn1I=;
        b=CRNMUeE1vVjxrZ73WoLQ8R5QrXMtDGuxz7E6r53QNTco8cLRXyvdP0cZKnZVXe9CUW
         5xrMcYcNB7ArHlgPQXfVUg1pnaKYLNLqo44mzYkisRgha74nVfnPMzN3Ymcbz6kF5ei6
         2F1DdWqUB5/7OsoUqYnDs0pdgyfuLfHSMjhVJ2bh6fupG2WwdZM5REBpqZo3g7y54+lo
         BwfIq23Oq65+CEZyM1o9sXCZdew8Sm1OK2ooPnDmdT48C7DEl82H2eAxjHNmCh5P37Fw
         B4Qxf40xTLxgt55FVlgJwFYGS/wYTYuudm7Av5YiNojmFguy15r9I6VyTUExO5fGmGVK
         CKTg==
X-Gm-Message-State: AOJu0YwhToxxtmnvYanKg0tvqNPZjIMx/ObC30ShKN7Vxepu/f6r2k1N
	cg7DM0pqqBgF3q9avhvoJzcjnck6h8ZlR4JG
X-Google-Smtp-Source: AGHT+IHXw/ybVlZESHJGwBe/66uhpo3y47BDlkC1habwpoxNnDNqDGx7dO19gh6+wUc9V7mn2vDHag==
X-Received: by 2002:a17:906:51c2:b0:a23:45c:5ca with SMTP id v2-20020a17090651c200b00a23045c05camr419089ejk.0.1702484055871;
        Wed, 13 Dec 2023 08:14:15 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-078-050-014-136.78.50.pool.telefonica.de. [78.50.14.136])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a1e026ac542sm8139203ejc.10.2023.12.13.08.14.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:14:15 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [UTIL-LINUX PATCH] sulogin: relabel terminal according to SELinux policy
Date: Wed, 13 Dec 2023 17:14:12 +0100
Message-ID: <20231213161412.23022-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The common SELinux practice is to have a distinct label for terminals in
use by logged in users.  This allows to differentiate access on the
associated terminal (e.g. user_tty_device_t) vs foreign ones (e.g.
tty_device_t or sysadm_tty_device_t).  Therefore the application
performing the user login and setting up the associated terminal should
label that terminal according to the loaded SELinux policy.  Commonly
this is done by pam_selinux(7).  Since sulogin(8) does not use pam(7)
perform the necessary steps manually.

Fixes: https://github.com/util-linux/util-linux/issues/1578

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Upstream pull-request: https://github.com/util-linux/util-linux/pull/2650
---
 login-utils/sulogin-consoles.c |   4 +
 login-utils/sulogin-consoles.h |   4 +
 login-utils/sulogin.c          | 156 +++++++++++++++++++++++++++++----
 3 files changed, 146 insertions(+), 18 deletions(-)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 9ae525556..0dca949f4 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -341,6 +341,10 @@ int append_console(struct list_head *consoles, const char * const name)
 	tail->id = last ? last->id + 1 : 0;
 	tail->pid = -1;
 	memset(&tail->tio, 0, sizeof(tail->tio));
+#ifdef HAVE_LIBSELINUX
+	tail->reset_tty_context = NULL;
+	tail->user_tty_context = NULL;
+#endif
 
 	return 0;
 }
diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-consoles.h
index 12032c997..608c4f84f 100644
--- a/login-utils/sulogin-consoles.h
+++ b/login-utils/sulogin-consoles.h
@@ -44,6 +44,10 @@ struct console {
 	pid_t pid;
 	struct chardata cp;
 	struct termios tio;
+#ifdef HAVE_LIBSELINUX
+	char *reset_tty_context;
+	char *user_tty_context;
+#endif
 };
 
 extern int detect_consoles(const char *device, int fallback,
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 019f35092..2682c30fb 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -99,6 +99,81 @@ static int locked_account_password(const char * const passwd)
 	return 0;
 }
 
+#ifdef HAVE_LIBSELINUX
+/*
+ * Cached check whether SELinux is enabled.
+ */
+static int is_selinux_enabled_cached(void)
+{
+	static int cache = -1;
+
+	if (cache == -1)
+		cache = is_selinux_enabled();
+
+	return cache;
+}
+
+/* Computed SELinux login context. */
+static char *login_context;
+
+/*
+ * Compute SELinux login context.
+ */
+static void compute_login_context(void)
+{
+	char *seuser = NULL;
+	char *level = NULL;
+
+	if (is_selinux_enabled_cached() == 0)
+		goto cleanup;
+
+	if (getseuserbyname("root", &seuser, &level) == -1) {
+		warnx(_("failed to compute seuser"));
+		goto cleanup;
+	}
+
+	if (get_default_context_with_level(seuser, level, NULL, &login_context) == -1) {
+		warnx(_("failed to compute default context"));
+		goto cleanup;
+	}
+
+cleanup:
+	free(seuser);
+	free(level);
+}
+
+/*
+ * Compute SELinux terminal context.
+ */
+static void tcinit_selinux(struct console *con)
+{
+	security_class_t tclass;
+
+	if (!login_context)
+		return;
+
+	if (fgetfilecon(con->fd, &con->reset_tty_context) == -1) {
+		warn(_("failed to get context of terminal %s"), con->tty);
+		return;
+	}
+
+	tclass = string_to_security_class("chr_file");
+	if (tclass == 0) {
+		warnx(_("security class chr_file not available"));
+		freecon(con->reset_tty_context);
+		con->reset_tty_context = NULL;
+		return;
+	}
+
+	if (security_compute_relabel(login_context, con->reset_tty_context, tclass, &con->user_tty_context) == -1) {
+		warnx(_("failed to compute relabel context of terminal"));
+		freecon(con->reset_tty_context);
+		con->reset_tty_context = NULL;
+		return;
+	}
+}
+#endif
+
 /*
  * Fix the tty modes and set reasonable defaults.
  */
@@ -132,6 +207,10 @@ static void tcinit(struct console *con)
 	errno = 0;
 #endif
 
+#ifdef HAVE_LIBSELINUX
+	tcinit_selinux(con);
+#endif
+
 #ifdef TIOCGSERIAL
 	if (ioctl(fd, TIOCGSERIAL,  &serinfo) >= 0)
 		con->flags |= CON_SERIAL;
@@ -785,7 +864,7 @@ out:
 /*
  * Password was OK, execute a shell.
  */
-static void sushell(struct passwd *pwd)
+static void sushell(struct passwd *pwd, struct console *con)
 {
 	char shell[PATH_MAX];
 	char home[PATH_MAX];
@@ -842,22 +921,21 @@ static void sushell(struct passwd *pwd)
 	mask_signal(SIGHUP, SIG_DFL, NULL);
 
 #ifdef HAVE_LIBSELINUX
-	if (is_selinux_enabled() > 0) {
-		char *scon = NULL;
-		char *seuser = NULL;
-		char *level = NULL;
-
-		if (getseuserbyname("root", &seuser, &level) == 0) {
-			if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
-				if (setexeccon(scon) != 0)
-					warnx(_("setexeccon failed"));
-				freecon(scon);
-			}
+	if (is_selinux_enabled_cached() == 1) {
+		if (con->user_tty_context) {
+			if (fsetfilecon(con->fd, con->user_tty_context) == -1)
+				warn(_("failed to set context to %s for terminal %s"), con->user_tty_context, con->tty);
+		}
+
+		if (login_context) {
+			if (setexeccon(login_context) == -1)
+				warn(_("failed to set exec context to %s"), login_context);
 		}
-		free(seuser);
-		free(level);
 	}
+#else
+	(void)con;
 #endif
+
 	execl(su_shell, shell, (char *)NULL);
 	warn(_("failed to execute %s"), su_shell);
 
@@ -866,6 +944,30 @@ static void sushell(struct passwd *pwd)
 	warn(_("failed to execute %s"), "/bin/sh");
 }
 
+#ifdef HAVE_LIBSELINUX
+static void tcreset_selinux(struct list_head *consoles) {
+	struct list_head *ptr;
+	struct console *con;
+
+	if (is_selinux_enabled_cached() == 0)
+		return;
+
+	list_for_each(ptr, consoles) {
+		con = list_entry(ptr, struct console, entry);
+
+		if (con->fd < 0)
+			continue;
+		if (!con->reset_tty_context)
+			continue;
+		if (fsetfilecon(con->fd, con->reset_tty_context) == -1)
+			warn(_("failed to reset context to %s for terminal %s"), con->reset_tty_context, con->tty);
+
+		freecon(con->reset_tty_context);
+		con->reset_tty_context = NULL;
+	}
+}
+#endif
+
 static void usage(void)
 {
 	FILE *out = stdout;
@@ -1015,6 +1117,10 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+#ifdef HAVE_LIBSELINUX
+	compute_login_context();
+#endif
+
 	/*
 	 * Ask for the password on the consoles.
 	 */
@@ -1034,9 +1140,18 @@ int main(int argc, char **argv)
 	}
 	ptr = (&consoles)->next;
 
-	if (ptr->next == &consoles) {
-		con = list_entry(ptr, struct console, entry);
-		goto nofork;
+#ifdef HAVE_LIBSELINUX
+	/*
+	 * Always fork with SELinux enabled, so the parent can restore the
+	 * terminal context afterwards.
+	 */
+	if (is_selinux_enabled_cached() == 0)
+#endif
+	{
+		if (ptr->next == &consoles) {
+			con = list_entry(ptr, struct console, entry);
+			goto nofork;
+		}
 	}
 
 
@@ -1087,7 +1202,7 @@ int main(int argc, char **argv)
 #endif
 				if (doshell) {
 					/* sushell() unmask signals */
-					sushell(pwd);
+					sushell(pwd, con);
 
 					mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
 					mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
@@ -1193,5 +1308,10 @@ int main(int argc, char **argv)
 	} while (1);
 
 	mask_signal(SIGCHLD, SIG_DFL, NULL);
+
+#ifdef HAVE_LIBSELINUX
+	tcreset_selinux(&consoles);
+#endif
+
 	return EXIT_SUCCESS;
 }
-- 
2.43.0

