Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA04140
	for <selinux@tycho.nsa.gov>; Sun, 8 Sep 2002 16:33:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA04454
	for <selinux@tycho.nsa.gov>; Sun, 8 Sep 2002 20:31:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA04450 for <selinux@tycho.nsa.gov>; Sun, 8 Sep 2002 20:31:19 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8AD6192479
	for <selinux@tycho.nsa.gov>; Mon,  9 Sep 2002 06:33:00 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B163042EB
	for <selinux@tycho.nsa.gov>; Sun,  8 Sep 2002 22:32:51 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: spasswd
Date: Sun, 8 Sep 2002 22:18:19 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_J2Z43KTBZBBDBUT7NP5R"
Message-Id: <200209082218.19913.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_J2Z43KTBZBBDBUT7NP5R
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached a patch for the spasswd program.  This fixes a bug in my code 
that was included in the CVS (and is now in the release version).

To demonstrate the bug run "spasswd", "sadminpasswd" etc and then press ^C or 
^\ to kill it.  It'll kill the wrapper but leave the child process running in 
the background, then when the shell and the child process start fighting over 
the standard input it goes into an infinite loop (and in the case of 
"spasswd" the user running it may not have permission to clean it up).

The patch makes the wrapper handle the signals that can be handled and then 
deliver them to the child process, and it makes the wait() operation handle 
the interruption.

I've tested this code reasonably thoroughly and am quite confidant in it's 
ability to work correctly.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_J2Z43KTBZBBDBUT7NP5R
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spasswd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="spasswd.diff"

--- selinux-small-2002082308.orig/utils/spasswd/spasswd.c
+++ selinux-small-2002082308/utils/spasswd/spasswd.c
@@ -9,6 +9,7 @@
 #include <syslog.h>
 #include <string.h>
 #include <fs_secure.h>
+#include <errno.h>
 
 #ifndef PASSWD
 #define PASSWD "/usr/bin/passwd"
@@ -39,6 +40,13 @@
 
 #define SZ 255
 
+pid_t child;
+
+void sig_handler(int sig, siginfo_t *siginf, void *unused)
+{
+  kill(child, siginf->si_signo);
+}
+
 
 int main(int argc, char **argv) 
 {
@@ -55,6 +63,7 @@
   int status;
   char **passwd_argv;
   int i;
+  struct sigaction sa;
 
   passwd_argv = malloc( (argc + 1) * sizeof(char *) );
   if(!passwd_argv)
@@ -136,8 +145,20 @@
 
   openlog(p, LOG_CONS, LOG_AUTH);
 
-  ret = fork();
-  switch(ret)
+  sa.sa_sigaction = &sig_handler;
+  sa.sa_flags = SA_SIGINFO;
+  if(sigaction(SIGHUP, &sa, NULL)
+    || sigaction(SIGINT, &sa, NULL)
+    || sigaction(SIGQUIT, &sa, NULL)
+    || sigaction(SIGPIPE, &sa, NULL)
+    || sigaction(SIGTERM, &sa, NULL))
+  {
+    fprintf(stderr, "Can't handle signals.");
+    return 1;
+  }
+
+  child = fork();
+  switch(child)
   {
   case 0:  /* child */
     execv(PASSWD, passwd_argv);
@@ -147,15 +168,17 @@
     perror(argv[0]);
     exit(1);
   }
-  if(wait(&status) != ret)
+  while( (ret = wait(&status)) == -1 && errno == EINTR)
+    ;
+  if(ret != child)
   {
-    fprintf(stderr, "Error waiting for child.\n");
+    fprintf(stderr, "Error %d waiting for child.\n", errno);
     ret = 1;
   }
   else
   {
     if(!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-      fprintf(stderr, "Child had an error.\n");
+      fprintf(stderr, "Child returned an error.\n");
     else
       ret = 0;
   }

--------------Boundary-00=_J2Z43KTBZBBDBUT7NP5R--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
