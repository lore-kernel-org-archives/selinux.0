Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i01G5aRb022736
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 11:05:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i01G4cxr006669
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 16:04:38 GMT
Received: from maja.beep.pl (smtp.sys.beep.pl [195.245.198.13])
	by jazzswing.ncsc.mil  with ESMTP id i01G4bYc006666
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 16:04:37 GMT
Received: from [195.245.198.2] (helo=gucio.beep.pl ident=exim)
	by maja.beep.pl with esmtp (TLSv1:EDH-RSA-DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ac5Bv-0001Vo-Ib
	for selinux@tycho.nsa.gov; Thu, 01 Jan 2004 16:56:55 +0100
Received: from [156.17.236.105] (helo=192.168.2.2 ident=arekm-m1)
	by gucio.beep.pl with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.30)
	id 1Ac5Jz-0006tU-NN
	for selinux@tycho.nsa.gov; Thu, 01 Jan 2004 17:05:15 +0100
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: selinux@tycho.nsa.gov
Subject: modification of vixie-cron patch to get crond working in permissive mode
Date: Thu, 1 Jan 2004 17:05:12 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4UE9/eDIblEchHw"
Message-Id: <200401011705.12427.arekm@pld-linux.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_4UE9/eDIblEchHw
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch should be applied after fedora core selinux patch for vixie-cron=
=20
(probably the same as on nsa.gov/selinux page).

It changes behaviour when running selinux in permissive mode. Until now whe=
n=20
there were no known context with which jobs should be executed then error=20
message was logged and crontab file was skipped. Now error message is logge=
d=20
but jobs are still run.

It's better to have working crond + bunch of log messages instead of not=20
usable crond.

Please apply + rediff new selinux patch.
=2D-=20
Arkadiusz Mi=B6kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

--Boundary-00=_4UE9/eDIblEchHw
Content-Type: application/octet-stream;
  name="vixie-cron-selinux-pld.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vixie-cron-selinux-pld.patch"

diff -urN vixie-cron-3.0.1.org/database.c vixie-cron-3.0.1/database.c
--- vixie-cron-3.0.1.org/database.c	2004-01-01 16:37:48.651341944 +0100
+++ vixie-cron-3.0.1/database.c	2004-01-01 16:58:42.478731208 +0100
@@ -350,8 +350,13 @@
 	  int retval=0;
 
 	  if (fgetfilecon(crontab_fd, &file_context) < OK) {
-	    log_it(fname, getpid(), "getfilecon FAILED", tabname);
-	    goto next_crontab;
+	    if (security_getenforce() > 0) {
+    		log_it(fname, getpid(), "getfilecon FAILED", tabname);
+    		goto next_crontab;
+	    } else {
+		log_it(fname, getpid(), "getfilecon FAILED but SELinux in permissive mode, continuing", tabname);
+		goto selinux_out;
+	    }
 	  }
 
 	  /*
@@ -362,9 +367,14 @@
 	   * permission check for this purpose.
 	   */
 	  if (get_default_context(fname, NULL, &user_context)) {
-	    log_it(fname, getpid(), "NO CONTEXT", tabname);
 	    freecon(file_context);
-	    goto next_crontab;
+	    if (security_getenforce() > 0) {
+		log_it(fname, getpid(), "NO CONTEXT", tabname);
+		goto next_crontab;
+	    } else {
+		log_it(fname, getpid(), "NO CONTEXT but SELinux in permissive mode, continuing", tabname);
+		goto selinux_out;
+	    }
 	  }
 	  retval = security_compute_av(user_context,
 				       file_context,
@@ -374,9 +384,15 @@
 	  freecon(user_context);
 	  freecon(file_context);
 	  if (retval || ((FILE__ENTRYPOINT & avd.allowed) != FILE__ENTRYPOINT)) {
-	    log_it(fname, getpid(), "ENTRYPOINT FAILED", tabname);
-	    goto next_crontab;
+	    if (security_getenforce() > 0) {
+    		log_it(fname, getpid(), "ENTRYPOINT FAILED", tabname);
+    		goto next_crontab;
+	    } else {
+		log_it(fname, getpid(), "ENTRYPOINT FAILED but SELinux in permissive mode, continuing", tabname);
+		goto selinux_out;
+	    }
 	  }
+selinux_out:
 	}
 #endif
 	u = load_user(crontab_fd, pw, fname);
diff -urN vixie-cron-3.0.1.org/do_command.c vixie-cron-3.0.1/do_command.c
--- vixie-cron-3.0.1.org/do_command.c	2004-01-01 16:37:48.707333432 +0100
+++ vixie-cron-3.0.1/do_command.c	2004-01-01 16:56:33.269374016 +0100
@@ -280,14 +280,21 @@
 			if (is_selinux_enabled()) {
 			  security_context_t scontext;
 			  if (get_default_context(u->name, NULL, &scontext)) {
-			    fprintf(stderr, "execle: couldn't get security context for user %s\n", u->name); 
-			    _exit(ERROR_EXIT);
+			    if (security_getenforce() > 0) {
+    				fprintf(stderr, "execle: couldn't get security context for user %s\n", u->name); 
+    				_exit(ERROR_EXIT);
+			    } else
+				fprintf(stderr, "execle: couldn't get security context for user %s but SELinux in permissive mode, continuing\n", u->name);
+			  } else {
+    			      if (setexeccon(scontext) < 0) {
+				  if (security_getenforce() > 0) {
+				      fprintf(stderr, "Could not set exec context to %s for user  %s\n", scontext,u->name);
+    				      _exit(ERROR_EXIT);
+				  } else
+				      fprintf(stderr, "Could not set exec context to %s for user  %s but SELinux in permissive mode, continuing\n", scontext,u->name);
+    			      }
+    			      freecon(scontext);
 			  }
-			  if (setexeccon(scontext) < 0) {
-			    fprintf(stderr, "Could not set exec context to %s for user  %s\n", scontext,u->name);
-			    _exit(ERROR_EXIT);
-			  }
-			  freecon(scontext);
 			}
 #endif
 			execle(shell, shell, "-c", e->cmd, (char *)0, e->envp);

--Boundary-00=_4UE9/eDIblEchHw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
