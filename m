Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3E4xoI4018823
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 00:59:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3E4u5Ov006218
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 04:56:05 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h3E4u3Y1006215
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 04:56:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: portability patch for char signedness
Date: Mon, 14 Apr 2003 14:59:54 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KBkm+nYcgJckk9O"
Message-Id: <200304141459.54596.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_KBkm+nYcgJckk9O
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch fixes some char signedness issues.  These are a problem on 
arm and SPARC.

BTW One of my friends is working on the SPARC port of SE Linux, hopefully 
he'll have something ready for inclusion in the next release of SE Linux.  I 
was planning to do the SPARC port myself, but I ran out of time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_KBkm+nYcgJckk9O
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ruN ./libsecure/test/msgget_s.c /tmp/selinux-small-2003011510/libsecure/test/msgget_s.c
--- ./libsecure/test/msgget_s.c	2001-07-19 06:38:06.000000000 +1000
+++ /tmp/selinux-small-2003011510/libsecure/test/msgget_s.c	2003-02-24 10:12:46.000000000 +1100
@@ -31,11 +31,11 @@
   key_t ipc_key;
   int ret;
   security_id_t sid = SECSID_NULL;
-  char c;
+  int c_int;
   int id;
 
-  while ( (c = getopt(argc, argv, "k:c:s:")) != EOF) {
-    switch (c) {
+  while ( (c_int = getopt(argc, argv, "k:c:s:")) != EOF) {
+    switch ((char)c_int) {
     case 'k':
       ipc_key = atoi(optarg);
       valid_ipc_key = 1;
diff -ruN ./libsecure/test/msgsnd_s.c /tmp/selinux-small-2003011510/libsecure/test/msgsnd_s.c
--- ./libsecure/test/msgsnd_s.c	2001-07-19 06:38:06.000000000 +1000
+++ /tmp/selinux-small-2003011510/libsecure/test/msgsnd_s.c	2003-02-24 10:13:39.000000000 +1100
@@ -42,10 +42,10 @@
   int valid_msg_sid = 0;
   char *word, *first_words;
   int ret;
-  char c;
+  int c_int;
 
-  while ( (c = getopt(argc, argv, "c:i:s:t:")) != EOF) {
-    switch (c) {
+  while ( (c_int = getopt(argc, argv, "c:i:s:t:")) != EOF) {
+    switch ((char)c_int) {
     case 's':
       if (valid_msg_sid) {
 	fprintf (stderr, "Only a sid or a context may be given, not both\n");
diff -ruN ./libsecure/test/semget_s.c /tmp/selinux-small-2003011510/libsecure/test/semget_s.c
--- ./libsecure/test/semget_s.c	2001-07-19 06:38:06.000000000 +1000
+++ /tmp/selinux-small-2003011510/libsecure/test/semget_s.c	2003-02-24 10:14:38.000000000 +1100
@@ -32,11 +32,11 @@
   key_t ipc_key;
   int ret;
   security_id_t sid;
-  char c;
+  int c_int;
   int id;
 
-  while ( (c = getopt(argc, argv, "k:c:s:n:")) != EOF) {
-    switch (c) {
+  while ( (c_int = getopt(argc, argv, "k:c:s:n:")) != EOF) {
+    switch ((char)c_int) {
     case 'k':
       ipc_key = atoi(optarg);
       valid_ipc_key = 1;
diff -ruN ./libsecure/test/shmget_s.c /tmp/selinux-small-2003011510/libsecure/test/shmget_s.c
--- ./libsecure/test/shmget_s.c	2001-07-19 06:38:06.000000000 +1000
+++ /tmp/selinux-small-2003011510/libsecure/test/shmget_s.c	2003-02-24 10:13:51.000000000 +1100
@@ -32,11 +32,11 @@
   key_t ipc_key;
   int err, ret;
   security_id_t sid = SECSID_NULL;
-  char c;
+  int c_int;
   int id;
 
-  while ( (c = getopt(argc, argv, "k:c:s:b:")) != EOF) {
-    switch (c) {
+  while ( (c_int = getopt(argc, argv, "k:c:s:b:")) != EOF) {
+    switch ((char)c_int) {
     case 'k':
       ipc_key = atoi(optarg);
       valid_ipc_key = 1;

--Boundary-00=_KBkm+nYcgJckk9O--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
