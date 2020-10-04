Return-Path: <SRS0=7KID=DL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE327C4363C
	for <selinux@archiver.kernel.org>; Sun,  4 Oct 2020 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639F520735
	for <selinux@archiver.kernel.org>; Sun,  4 Oct 2020 14:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJDOMY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 4 Oct 2020 10:12:24 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48634 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDOMX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 4 Oct 2020 10:12:23 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2020 10:12:22 EDT
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6FACB564819
        for <selinux@vger.kernel.org>; Sun,  4 Oct 2020 16:03:58 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libselinux: convert matchpathcon to selabel_lookup()
Date:   Sun,  4 Oct 2020 16:03:39 +0200
Message-Id: <20201004140339.1896260-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Oct  4 16:03:59 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Function matchpathcon() is deprecated in favor of selabel_lookup() but
program "matchpathcon" is much easier to use than "selabel_loopkup" to
find the file context which would be applied to some files and
directories.

More precisely:

    matchpathcon /path/to/my/file

is easier to type and remember than:

    selabel_lookup -b file -k /path/to/my/file

It also allows performing multiple context searches in one command,
where selabel_lookup cannot use multiple -k options.

Migrate matchpathcon to the preferred API.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/Makefile       |  2 -
 libselinux/utils/matchpathcon.c | 87 ++++++++++++++-------------------
 2 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index aa2d3e1b144f..b018a08acbe0 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -56,8 +56,6 @@ sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
 
 sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
-matchpathcon: CFLAGS += -Wno-deprecated-declarations
-
 all: $(TARGETS)
 
 install: all
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index cc018d213f4c..a07e160dee71 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -1,15 +1,14 @@
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <getopt.h>
 #include <errno.h>
-#include <string.h>
+#include <getopt.h>
 #include <limits.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+#include <selinux/label.h>
 #include <selinux/selinux.h>
-#include <limits.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
 
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
@@ -19,15 +18,21 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 	exit(1);
 }
 
-static int printmatchpathcon(const char *path, int header, int mode)
+static int printmatchpathcon(struct selabel_handle *hnd, const char *path, int header, int mode, int notrans)
 {
-	char *buf;
-	int rc = matchpathcon(path, mode, &buf);
+	char *buf = NULL;
+	int rc;
+
+	if (notrans) {
+		rc = selabel_lookup_raw(hnd, &buf, path, mode);
+	} else {
+		rc = selabel_lookup(hnd, &buf, path, mode);
+	}
 	if (rc < 0) {
 		if (errno == ENOENT) {
 			buf = strdup("<<none>>");
 		} else {
-			fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
+			fprintf(stderr, "selabel_lookup(%s) failed: %s\n", path,
 				strerror(errno));
 			return 1;
 		}
@@ -66,15 +71,14 @@ static mode_t string_to_mode(char *s)
 
 int main(int argc, char **argv)
 {
-	int i, init = 0, force_mode = 0;
+	int i, force_mode = 0;
 	int header = 1, opt;
 	int verify = 0;
 	int notrans = 0;
 	int error = 0;
 	int quiet = 0;
-
-	fprintf(stderr,
-		"Deprecated, use selabel_lookup\n");
+	struct selabel_handle *hnd;
+	struct selinux_opt options[SELABEL_NOPT] = {};
 
 	if (argc < 2)
 		usage(argv[0]);
@@ -96,23 +100,10 @@ int main(int argc, char **argv)
 			break;
 		case 'N':
 			notrans = 1;
-			set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 			break;
 		case 'f':
-			if (init) {
-				fprintf(stderr,
-					"%s:  -f and -p are exclusive\n",
-					argv[0]);
-				exit(1);
-			}
-			init = 1;
-			if (matchpathcon_init(optarg)) {
-				fprintf(stderr,
-					"Error while processing %s:  %s\n",
-					optarg,
-					errno ? strerror(errno) : "invalid");
-				exit(1);
-			}
+			options[SELABEL_OPT_PATH].type = SELABEL_OPT_PATH;
+			options[SELABEL_OPT_PATH].value = optarg;
 			break;
 		case 'P':
 			if (selinux_set_policy_root(optarg) < 0 ) {
@@ -124,20 +115,11 @@ int main(int argc, char **argv)
 			}
 			break;
 		case 'p':
-			if (init) {
-				fprintf(stderr,
-					"%s:  -f and -p are exclusive\n",
-					argv[0]);
-				exit(1);
-			}
-			init = 1;
-			if (matchpathcon_init_prefix(NULL, optarg)) {
-				fprintf(stderr,
-					"Error while processing %s:  %s\n",
-					optarg,
-					errno ? strerror(errno) : "invalid");
-				exit(1);
-			}
+			// This option has been deprecated since libselinux 2.5 (2016):
+			// https://github.com/SELinuxProject/selinux/commit/26e05da0fc2d0a4bd274320968a88f8acbb3b6a6
+			fprintf(stderr, "Warning: using %s -p is deprecated\n", argv[0]);
+			options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
+			options[SELABEL_OPT_SUBSET].value = optarg;
 			break;
 		case 'q':
 			quiet = 1;
@@ -146,6 +128,13 @@ int main(int argc, char **argv)
 			usage(argv[0]);
 		}
 	}
+	hnd = selabel_open(SELABEL_CTX_FILE, options, SELABEL_NOPT);
+	if (!hnd) {
+		fprintf(stderr,
+			"Error while opening file contexts database: %s\n",
+			strerror(errno));
+		return -1;
+	}
 	for (i = optind; i < argc; i++) {
 		int rc, mode = 0;
 		struct stat buf;
@@ -185,19 +174,19 @@ int main(int argc, char **argv)
 				if (rc >= 0) {
 					printf("%s has context %s, should be ",
 					       path, con);
-					printmatchpathcon(path, 0, mode);
+					printmatchpathcon(hnd, path, 0, mode, notrans);
 					freecon(con);
 				} else {
 					printf
 					    ("actual context unknown: %s, should be ",
 					     strerror(errno));
-					printmatchpathcon(path, 0, mode);
+					printmatchpathcon(hnd, path, 0, mode, notrans);
 				}
 			}
 		} else {
-			error |= printmatchpathcon(path, header, mode);
+			error |= printmatchpathcon(hnd, path, header, mode, notrans);
 		}
 	}
-	matchpathcon_fini();
+	selabel_close(hnd);
 	return error;
 }
-- 
2.28.0

