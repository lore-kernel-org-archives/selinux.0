Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9JABKWt016096
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 06:11:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9JABJmR008183
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 10:11:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9JABIjp008180 for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 10:11:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: pam_selinux patch
Date: Sun, 19 Oct 2003 20:11:02 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2Mmk/vAs/FooYQV"
Message-Id: <200310192011.02774.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_2Mmk/vAs/FooYQV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch against Dan's latest package will prevent any device name 
starting with "NODEV" from being relabeled (scp uses the device name of 
"NODEVssh").  It will also refrain from trying to relabel a /dev/pts node 
back to it's original context.  We know that a /dev/pts node will be unlinked 
when both master and slave are closed so there is no need to relabel it at 
logout time.  This means that we can prevent sshd from arbitary relabel 
operations without getting anything logged.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_2Mmk/vAs/FooYQV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dan.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dan.diff"

diff -ruN p/Linux-PAM/modules/pam_selinux/pam_selinux.c pam-0.76/Linux-PAM/modules/pam_selinux/pam_selinux.c
--- p/Linux-PAM/modules/pam_selinux/pam_selinux.c	2003-10-19 19:47:49.000000000 +1000
+++ pam-0.76/Linux-PAM/modules/pam_selinux/pam_selinux.c	2003-10-19 19:40:32.000000000 +1000
@@ -191,18 +191,31 @@
   return NULL;
 }
 
-static void security_restorelabel_tty(char *tty,security_context_t context) {
+static void security_restorelabel_tty(const char *tty,security_context_t context) {
   char ttybuf[PATH_MAX];
+  const char *ptr;
+
   if (context==NULL)
     return;
   
-  snprintf(ttybuf,sizeof(ttybuf),"/dev/%s",tty);
-  if (setfilecon(ttybuf,context)) 
+  if(strncmp("/dev/", tty, 5))
+  {
+    snprintf(ttybuf,sizeof(ttybuf),"/dev/%s",tty);
+    ptr = ttybuf;
+  }
+  else
+    ptr = tty;
+
+  if(!strncmp(tty, "/dev/pts", 8))
+    return;
+
+  if (setfilecon(ptr, context)) 
     {
       syslog(LOG_NOTICE, _("Warning!  Could not relabel %s with %s, not relabeling.\n"), ttybuf,context);
     }
   return;
 }
+
 static security_context_t security_label_tty(char *tty, security_context_t usercon) {
   char ttybuf[PATH_MAX];
   int status=0;
@@ -348,7 +361,7 @@
       }
     }
   }
-  if(ttys && tty) {
+  if(ttys && tty && strncmp(tty, "NODEV", 5) ) {
     ttyn=strdup(tty);
     ttyn_context=security_label_tty(ttyn,user_context);
   }

--Boundary-00=_2Mmk/vAs/FooYQV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
