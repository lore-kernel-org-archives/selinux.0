Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K9IlrT002476
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 05:18:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K9I34v028067
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 09:18:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 304C861AF7
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 19:18:43 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 31672-10 for <selinux@tycho.nsa.gov>;
	Fri, 20 Aug 2004 19:18:42 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B8C8C61AF6
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 19:18:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 42249B57DB
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 19:18:41 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: restorecon
Date: Fri, 20 Aug 2004 19:18:40 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wHcJBTnsLQJza91"
Message-Id: <200408201918.40233.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_wHcJBTnsLQJza91
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In 1.16 there is a new check in restorecon:
+  if (S_ISLNK(st.st_mode)) {
+    fprintf(stderr,"Warning! %s refers to a symbolic link, not expanding 
path.\
n", filename);
+  } else {
+    char *p;
+    p = realpath(filename, path);
+    if (!p) {
+      fprintf(stderr,"realpath(%s) failed %s\n", filename, strerror(errno));
+      return 1;
+    }
+    filename = p;
+  }

Is this really what we want?

In the case of the target not being a sym-link realpath() will expand 
sym-links in the middle of the path.  But if the target is a sym-link then 
restorecon will not expand the sym-links in the path and may do things that 
are not expected or desired (/usr/lib/X11 is one example).

I've attached a patch for policycoreutils to fix this.  In the case of the 
target being a sym-link it calls realpath() on the parent directory.

To test this create a sym-link /etc/foo pointing to /lib and then try 
relabelling /etc/foo/X where X is a sym-link.

Of course this shouldn't be an issue if the machine is in enforcing mode as 
restorecon_t can only get read access to lnk_file class through the following 
rules:

(163702) allow  restorecon_t  lib_t : lnk_file  { read getattr lock ioctl }; 
(163708) allow  restorecon_t  ld_so_t : lnk_file  { read getattr lock ioctl }; 
(163712) allow  restorecon_t  shlib_t : lnk_file  { read getattr lock ioctl }; 
(163734) allow  restorecon_t  proc_t : lnk_file  read ; 
(163756) allow  restorecon_t  policy_config_t : lnk_file  { getattr read }; 
(163786) allow  restorecon_t  selinux_config_t : lnk_file  { getattr read }; 
(163795) allow  restorecon_t  file_context_t : lnk_file  { getattr read }; 

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_wHcJBTnsLQJza91
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pol.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pol.diff"

diff -ru policycoreutils-1.16.orig/restorecon/restorecon.c policycoreutils-1.16/restorecon/restorecon.c
--- policycoreutils-1.16.orig/restorecon/restorecon.c	2004-07-29 05:43:42.000000000 +1000
+++ policycoreutils-1.16/restorecon/restorecon.c	2004-08-20 19:00:30.000000000 +1000
@@ -63,6 +63,23 @@
   }
   if (S_ISLNK(st.st_mode)) {
     fprintf(stderr,"Warning! %s refers to a symbolic link, not expanding path.\n", filename);
+    char *p = NULL, *file_sep;
+    char *tmp_path = strdup(filename);
+    file_sep = strrchr(tmp_path, '/');
+    if(file_sep)
+    {
+      *file_sep = 0;
+      file_sep++;
+      p = realpath(tmp_path, path);
+    }
+    if (!p || strlen(path) + strlen(file_sep) + 1 > PATH_MAX) {
+      fprintf(stderr,"realpath(%s) failed %s\n", filename, strerror(errno));
+      free(tmp_path);
+      return 1;
+    }
+    sprintf(p + strlen(p), "/%s", file_sep);
+    filename = p;
+    free(tmp_path);
   } else {
     char *p;
     p = realpath(filename, path);

--Boundary-00=_wHcJBTnsLQJza91--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
