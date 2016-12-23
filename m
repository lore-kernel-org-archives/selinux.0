Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBNFJpsu016875
 for <selinux@tycho.nsa.gov>; Fri, 23 Dec 2016 10:19:51 -0500
Message-ID: <1482506386.10020.10.camel@trentalancia.net>
Subject: [PATCH 2/2] libsemanage: fix optimized compile errors
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Fri, 23 Dec 2016 16:19:46 +0100
In-Reply-To: <1482506214.10020.8.camel@trentalancia.net>
References: <1482506214.10020.8.camel@trentalancia.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix compile errors when using the "-O -Werror" flags on gcc6.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 src/direct_api.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -pru libsemanage-2.6-orig/src/direct_api.c libsemanage-2.6/src/direct_api.c
--- libsemanage-2.6-orig/src/direct_api.c	2016-10-14 17:31:26.000000000 +0200
+++ libsemanage-2.6/src/direct_api.c	2016-12-23 15:22:50.101297993 +0100
@@ -955,8 +955,8 @@ static int semanage_compile_module(seman
 	ssize_t bzip_status;
 	int status = 0;
 	int compressed;
-	size_t cil_data_len;
-	size_t err_data_len;
+	size_t cil_data_len = 0;
+	size_t err_data_len = 0;
 
 	if (!strcasecmp(modinfo->lang_ext, "cil")) {
 		goto cleanup;
