Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBNFHDaC016301
 for <selinux@tycho.nsa.gov>; Fri, 23 Dec 2016 10:17:14 -0500
Message-ID: <1482506214.10020.8.camel@trentalancia.net>
Subject: [PATCH 1/2] libselinux: fix optimized compile errors
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Fri, 23 Dec 2016 16:16:54 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix compile errors when using the "-O3 -Werror" flags on gcc6.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 src/fgetfilecon.c |    2 +-
 src/getfilecon.c  |    2 +-
 src/lgetfilecon.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -pru libselinux-2.6-orig/src/fgetfilecon.c libselinux-2.6/src/fgetfilecon.c
--- libselinux-2.6-orig/src/fgetfilecon.c	2016-10-14 17:31:26.000000000 +0200
+++ libselinux-2.6/src/fgetfilecon.c	2016-12-23 15:19:23.642205413 +0100
@@ -53,7 +53,7 @@ hidden_def(fgetfilecon_raw)
 
 int fgetfilecon(int fd, char ** context)
 {
-	char * rcontext;
+	char * rcontext = NULL;
 	int ret;
 
 	*context = NULL;
diff -pru libselinux-2.6-orig/src/getfilecon.c libselinux-2.6/src/getfilecon.c
--- libselinux-2.6-orig/src/getfilecon.c	2016-10-14 17:31:26.000000000 +0200
+++ libselinux-2.6/src/getfilecon.c	2016-12-23 15:19:39.849448184 +0100
@@ -54,7 +54,7 @@ hidden_def(getfilecon_raw)
 int getfilecon(const char *path, char ** context)
 {
 	int ret;
-	char * rcontext;
+	char * rcontext = NULL;
 
 	*context = NULL;
 
diff -pru libselinux-2.6-orig/src/lgetfilecon.c libselinux-2.6/src/lgetfilecon.c
--- libselinux-2.6-orig/src/lgetfilecon.c	2016-10-14 17:31:26.000000000 +0200
+++ libselinux-2.6/src/lgetfilecon.c	2016-12-23 15:19:52.489637524 +0100
@@ -54,7 +54,7 @@ hidden_def(lgetfilecon_raw)
 int lgetfilecon(const char *path, char ** context)
 {
 	int ret;
-	char * rcontext;
+	char * rcontext = NULL;
 
 	*context = NULL;
 
