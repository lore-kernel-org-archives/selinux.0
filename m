Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RIitcT004793
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 13:44:55 -0500
Received: from cadmus.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RIijgc018964
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 18:44:51 GMT
Received: from cadmus.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by cadmus.columbia.tresys.com (8.14.1/8.14.1) with ESMTP id m1RIhv1X004383
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 13:43:57 -0500
Received: (from tmiller@localhost)
	by cadmus.columbia.tresys.com (8.14.1/8.14.1/Submit) id m1RIhvvc004382
	for selinux@tycho.nsa.gov; Wed, 27 Feb 2008 13:43:57 -0500
Date: Wed, 27 Feb 2008 13:43:57 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200802271843.m1RIhvvc004382@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: avoid -Werror for parser-generated sources
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've been bitten repeatedly by changes in lex and yacc resulting in
new compiler warnings.  Now that we build with -Werror this can result
in broken builds.  Since we have little control over what lex and yacc
generate, just filter out -Werror when compiling their .c files.

 checkpolicy/Makefile     |    4 ++--
 libsemanage/src/Makefile |   12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

Index: trunk/libsemanage/src/Makefile
===================================================================
--- trunk/libsemanage/src/Makefile	(revision 2811)
+++ trunk/libsemanage/src/Makefile	(working copy)
@@ -71,6 +71,18 @@
 %.lo:  %.c
 	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
+conf-parse.o:  conf-parse.c
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
+
+conf-parse.lo:  conf-parse.c
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
+
+conf-scan.o:  conf-scan.c
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
+
+conf-scan.lo:  conf-scan.c
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
+
 $(SWIGCOUT): $(SWIGIF)
 	$(SWIG) $^
 
Index: trunk/checkpolicy/Makefile
===================================================================
--- trunk/checkpolicy/Makefile	(revision 2811)
+++ trunk/checkpolicy/Makefile	(working copy)
@@ -33,10 +33,10 @@
 	$(CC) $(CFLAGS) -o $@ -c $<
 
 y.tab.o: y.tab.c
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
 
 lex.yy.o: lex.yy.c
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
 
 y.tab.c: policy_parse.y
 	$(YACC) -d policy_parse.y

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
