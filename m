Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA11690
	for <selinux@tycho.nsa.gov>; Sun, 23 Feb 2003 19:01:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA08605
	for <selinux@tycho.nsa.gov>; Sun, 23 Feb 2003 23:58:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA08601
	for <selinux@tycho.nsa.gov>; Sun, 23 Feb 2003 23:58:07 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A842B9253C
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 11:00:54 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0B56C8D6
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 01:00:42 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: char signedness
Date: Mon, 24 Feb 2003 01:00:40 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oCWW+UCiu7AAPAq"
Message-Id: <200302240100.40208.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_oCWW+UCiu7AAPAq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a patch for selinux-small that makes it work correctly on 
platforms where the "char" type is unsigned.

This affects ARM, PPC, and S/390.  Also the code will not perform correctly on 
platforms with signed char (such as i386) in the case of character 255.

This closes bug #182170 in the Debian BTS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_oCWW+UCiu7AAPAq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sign.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sign.diff"

diff -ruN selinux-orig/libsecure/test/msgget_s.c selinux-small-2003011510/libsecure/test/msgget_s.c
--- selinux-orig/libsecure/test/msgget_s.c	2001-07-18 22:38:06.000000000 +0200
+++ selinux-small-2003011510/libsecure/test/msgget_s.c	2003-02-24 00:12:46.000000000 +0100
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
Binary files selinux-orig/libsecure/test/msgsnd_s and selinux-small-2003011510/libsecure/test/msgsnd_s differ
diff -ruN selinux-orig/libsecure/test/msgsnd_s.c selinux-small-2003011510/libsecure/test/msgsnd_s.c
--- selinux-orig/libsecure/test/msgsnd_s.c	2001-07-18 22:38:06.000000000 +0200
+++ selinux-small-2003011510/libsecure/test/msgsnd_s.c	2003-02-24 00:13:39.000000000 +0100
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
Binary files selinux-orig/libsecure/test/semget_s and selinux-small-2003011510/libsecure/test/semget_s differ
diff -ruN selinux-orig/libsecure/test/semget_s.c selinux-small-2003011510/libsecure/test/semget_s.c
--- selinux-orig/libsecure/test/semget_s.c	2001-07-18 22:38:06.000000000 +0200
+++ selinux-small-2003011510/libsecure/test/semget_s.c	2003-02-24 00:14:38.000000000 +0100
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
Binary files selinux-orig/libsecure/test/shmget_s and selinux-small-2003011510/libsecure/test/shmget_s differ
diff -ruN selinux-orig/libsecure/test/shmget_s.c selinux-small-2003011510/libsecure/test/shmget_s.c
--- selinux-orig/libsecure/test/shmget_s.c	2001-07-18 22:38:06.000000000 +0200
+++ selinux-small-2003011510/libsecure/test/shmget_s.c	2003-02-24 00:13:51.000000000 +0100
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

--Boundary-00=_oCWW+UCiu7AAPAq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
