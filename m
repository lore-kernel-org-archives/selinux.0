Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i55GEwrT026408
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 12:14:58 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i55GEt22027407
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 12:14:55 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 5 Jun 2004 16:14:56 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWdAb-0000pn-4S
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 15:33:17 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BWdmI-0001pE-4O
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 16:12:14 +0000
Date: Sat, 5 Jun 2004 16:12:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [patch]
Message-ID: <20040605161213.GA5998@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

patch to exim4 to get it to change its name when it execve's on:

- transport (-MC)
- smtp in
- alias (-bi)
- initial daemon startup

you have to start exim4 in /etc/init.d/exim4 as exim4-daemon not
exim4.

you'll need to symlink exim4 to exim4-MC, exim4-bi and exim4-in
for "non-selinux" and other testing purposes.

i don't know if it's possible to create domain auto transitions
on a symlink, but if it _was_ then the policy files could,
i imagine, have file_contexts for exim4_mc_exec_t etc just on
the symlinks.

*shrug*.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=g

diff -ru orig/exim-4.34/src/exim.c exim4-4.34/src/exim.c
--- orig/exim-4.34/src/exim.c	2004-05-10 12:31:20.000000000 +0000
+++ exim4-4.34/src/exim.c	2004-06-01 17:22:35.000000000 +0000
@@ -3002,6 +3002,12 @@
     DEBUG(D_exec) debug_printf("exec %.256s %.256s\n", argv[0],
       (argv[1] == NULL)? US"" : argv[1]);
 
+    /* for SE/Linux to write a tiny program to change security domain
+     * specifically to deal with -bi, we change the name to exim-bi.
+     * non-SELinux systems can symbolic link exim-bi to exim.
+     */
+    argv[0] = string_sprintf("%s-bi", argv[0]);
+
     execv(CS argv[0], (char *const *)argv);
     fprintf(stderr, "exim: exec failed: %s\n", strerror(errno));
     exit(EXIT_FAILURE);
diff -ru orig/exim-4.34/src/smtp_in.c exim4-4.34/src/smtp_in.c
--- orig/exim-4.34/src/smtp_in.c	2004-05-10 12:31:20.000000000 +0000
+++ exim4-4.34/src/smtp_in.c	2004-06-01 17:22:35.000000000 +0000
@@ -3372,6 +3372,14 @@
 
       if (!smtp_etrn_serialize || (pid = fork()) == 0)
         {
+	 /* change the name of the daemon to exec to an exim-in instead
+	  * this is so that SE/Linux can create a tiny program that
+	  * sets up a separate security domain for incoming SMTP,
+	  * and of course non-SE/Linux systems can symbolic link exim-in
+	  * to exim.
+	  */
+	 argv[0] = string_sprintf("%s-in", argv[0]);
+
         DEBUG(D_exec) debug_print_argv(argv);
         exim_nullstd();                   /* Ensure std{in,out,err} exist */
         execv(CS argv[0], (char *const *)argv);
Only in exim4-4.34/src: tags
diff -ru orig/exim-4.34/src/transport.c exim4-4.34/src/transport.c
--- orig/exim-4.34/src/transport.c	2004-05-10 12:31:20.000000000 +0000
+++ exim4-4.34/src/transport.c	2004-06-01 17:14:29.000000000 +0000
@@ -1585,6 +1585,12 @@
     close(socket_fd);
     }
 
+  /* for SE/Linux systems we run a tiny program that changes security
+   * domain to deal with transports (exim-MC).
+   * non-SELinux systems can always symbolic link exim-MC to exim
+   */
+  argv[0] = string_sprintf("%s-MC", argv[0]);
+
   DEBUG(D_exec) debug_print_argv(argv);
   exim_nullstd();                          /* Ensure std{out,err} exist */
   execv(CS argv[0], (char *const *)argv);
diff -ru orig/exim-4.34/src/exim.c exim4-4.34/src/exim.c
--- orig/exim-4.34/src/exim.c	2004-05-10 12:31:20.000000000 +0000
+++ exim4-4.34/src/exim.c	2004-06-01 17:22:35.000000000 +0000
@@ -3002,6 +3002,12 @@
     DEBUG(D_exec) debug_printf("exec %.256s %.256s\n", argv[0],
       (argv[1] == NULL)? US"" : argv[1]);
 
+    /* for SE/Linux to write a tiny program to change security domain
+     * specifically to deal with -bi, we change the name to exim-bi.
+     * non-SELinux systems can symbolic link exim-bi to exim.
+     */
+    argv[0] = string_sprintf("%s-bi", argv[0]);
+
     execv(CS argv[0], (char *const *)argv);
     fprintf(stderr, "exim: exec failed: %s\n", strerror(errno));
     exit(EXIT_FAILURE);
diff -ru orig/exim-4.34/src/smtp_in.c exim4-4.34/src/smtp_in.c
--- orig/exim-4.34/src/smtp_in.c	2004-05-10 12:31:20.000000000 +0000
+++ exim4-4.34/src/smtp_in.c	2004-06-01 17:22:35.000000000 +0000
@@ -3372,6 +3372,14 @@
 
       if (!smtp_etrn_serialize || (pid = fork()) == 0)
         {
+	 /* change the name of the daemon to exec to an exim-in instead
+	  * this is so that SE/Linux can create a tiny program that
+	  * sets up a separate security domain for incoming SMTP,
+	  * and of course non-SE/Linux systems can symbolic link exim-in
+	  * to exim.
+	  */
+	 argv[0] = string_sprintf("%s-in", argv[0]);
+
         DEBUG(D_exec) debug_print_argv(argv);
         exim_nullstd();                   /* Ensure std{in,out,err} exist */
         execv(CS argv[0], (char *const *)argv);
Only in exim4-4.34/src: tags
diff -ru orig/exim-4.34/src/transport.c exim4-4.34/src/transport.c
--- orig/exim-4.34/src/transport.c	2004-05-10 12:31:20.000000000 +0000
+++ exim4-4.34/src/transport.c	2004-06-01 17:14:29.000000000 +0000
@@ -1585,6 +1585,12 @@
     close(socket_fd);
     }
 
+  /* for SE/Linux systems we run a tiny program that changes security
+   * domain to deal with transports (exim-MC).
+   * non-SELinux systems can always symbolic link exim-MC to exim
+   */
+  argv[0] = string_sprintf("%s-MC", argv[0]);
+
   DEBUG(D_exec) debug_print_argv(argv);
   exim_nullstd();                          /* Ensure std{out,err} exist */
   execv(CS argv[0], (char *const *)argv);
Only in exim4-4.34/: unpack-configs-stamp

--yrj/dFKFPuw6o+aM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
