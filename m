Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i01GmPRb022813
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 11:48:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i01GlRxr007962
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 16:47:27 GMT
Received: from maja.beep.pl (smtp.sys.beep.pl [195.245.198.13])
	by jazzswing.ncsc.mil  with ESMTP id i01GlQYc007959
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 16:47:26 GMT
Received: from [195.245.198.2] (helo=gucio.beep.pl ident=exim)
	by maja.beep.pl with esmtp (TLSv1:EDH-RSA-DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ac5rc-0003Na-Sq
	for selinux@tycho.nsa.gov; Thu, 01 Jan 2004 17:40:00 +0100
Received: from [156.17.236.105] (helo=192.168.2.2 ident=arekm-m1)
	by gucio.beep.pl with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.30)
	id 1Ac5zh-0001nE-Kv
	for selinux@tycho.nsa.gov; Thu, 01 Jan 2004 17:48:21 +0100
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: selinux@tycho.nsa.gov
Subject: Re: modification of vixie-cron patch to get crond working in permissive mode
Date: Thu, 1 Jan 2004 17:48:19 +0100
References: <200401011705.12427.arekm@pld-linux.org>
In-Reply-To: <200401011705.12427.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T9E9/oQFl6JfoIb"
Message-Id: <200401011748.19883.arekm@pld-linux.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_T9E9/oQFl6JfoIb
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 01 of January 2004 17:05, you wrote:
> This patch should be applied after fedora core selinux patch for vixie-cr=
on
> (probably the same as on nsa.gov/selinux page).
I've modified it a little to do not display error message to stderr when in=
=20
permissive mode (it would generate email message for each such job=20
execution).

=2D-=20
Arkadiusz Mi=B6kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

--Boundary-00=_T9E9/oQFl6JfoIb
Content-Type: application/octet-stream;
  name="vixie-cron-selinux-pld.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vixie-cron-selinux-pld.patch"

diff -urN vixie-cron-3.0.1.org/database.c vixie-cron-3.0.1/database.c
--- vixie-cron-3.0.1.org/database.c	2004-01-01 16:37:48.000000000 +0100
+++ vixie-cron-3.0.1/database.c	2004-01-01 16:58:42.000000000 +0100
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
--- vixie-cron-3.0.1.org/do_command.c	2004-01-01 16:37:48.000000000 +0100
+++ vixie-cron-3.0.1/do_command.c	2004-01-01 17:15:05.377307912 +0100
@@ -280,14 +280,19 @@
 			if (is_selinux_enabled()) {
 			  security_context_t scontext;
 			  if (get_default_context(u->name, NULL, &scontext)) {
-			    fprintf(stderr, "execle: couldn't get security context for user %s\n", u->name); 
-			    _exit(ERROR_EXIT);
+			    if (security_getenforce() > 0) {
+    				fprintf(stderr, "execle: couldn't get security context for user %s\n", u->name); 
+    				_exit(ERROR_EXIT);
+			    }
+			  } else {
+    			      if (setexeccon(scontext) < 0) {
+				  if (security_getenforce() > 0) {
+				      fprintf(stderr, "Could not set exec context to %s for user  %s\n", scontext,u->name);
+    				      _exit(ERROR_EXIT);
+				  }
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

--Boundary-00=_T9E9/oQFl6JfoIb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
