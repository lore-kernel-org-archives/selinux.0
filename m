Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D9BC433F5
	for <selinux@archiver.kernel.org>; Thu,  5 May 2022 17:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382881AbiEERs2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 May 2022 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382999AbiEERsW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 May 2022 13:48:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB05A5DBC6
        for <selinux@vger.kernel.org>; Thu,  5 May 2022 10:44:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so10090366ejj.10
        for <selinux@vger.kernel.org>; Thu, 05 May 2022 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TzkXzIZETindeCuoF706N8O6IRK3dbzskcF1WdVaf4=;
        b=K0Rly0qAqMxLTn4cbzWzDkgflokBcZgSywfrMXXa3yDFv84+8C9Jlc7MRXqbD6YsZP
         QSVueq6OyJxq0PKh+38U6B+duHCQqcVTErD2wkKnjq3zBGNkdDbw6N3CILePVNRU9KSI
         xrqeNZszVjrkZG+fgc9FbS99J+eEVGyezsMHiTc051QvWEOfRW56vtfjzG6H1jna36ba
         t9gnsuFUaA3DehXmqHMEwy/MTk30drBVfRqYVmRLUd80PBEsc4K4HkawDNHgVl2XN4tn
         /KjWDZo10u+BJIUAiqafp/L3PkU7J5DGlfXkeMXEeL8tmUroIDfYoGYBggX03JPqT+sI
         6NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TzkXzIZETindeCuoF706N8O6IRK3dbzskcF1WdVaf4=;
        b=bMTUg/IM/3LNgjNHzFOldyFYnEFslfmAx/8smfjwCOm4ND+5TyqogTQXJJF2Kc2zWR
         bI1DwPjazMt7f/Ysd06eAMNNAp1aZf7Nf73trP6oDrMkYrFhxIaYtYzYOdUyjiR+EUOl
         HTmItpFTAmJt1saQODvdL8cL95vA4rl92LzQKiC+TRoEjkvCGKvIQ3gXzecdyraiOw3y
         u4eD8XZV9yVJumtROwBMMPDbTMuW/enfb8WJCrajfNNkrjf83EkkPOBmNHVb12fFfELA
         G0HuBhiF5okrViPj8MDDczORVBE1U2l9MrzYN88S8xSJcONndPQVeq7Dis8meRKUyI2k
         NeSw==
X-Gm-Message-State: AOAM531nY0UWsm2kpELShjeqXDTKCC0A8D0fFH1ZP3K2ff4n4eGuVgUv
        LVDq0wNYtv/7QkS3kWvPyLWTkQKaaOg=
X-Google-Smtp-Source: ABdhPJzqKoO0dJ7EQd2QUkLYXWyaaTANPke3J99SkbpaKSSxy/HQI0Go4kCe53nDhRm0QqidQnMApg==
X-Received: by 2002:a17:907:7e88:b0:6f4:99be:a333 with SMTP id qb8-20020a1709077e8800b006f499bea333mr13660706ejc.719.1651772645312;
        Thu, 05 May 2022 10:44:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-152-226.77.1.pool.telefonica.de. [77.1.152.226])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214da6sm999417ejc.12.2022.05.05.10.44.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:44:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux/utils: print errno on failure
Date:   Thu,  5 May 2022 19:44:01 +0200
Message-Id: <20220505174401.24442-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Print error description on failure after functions known to set errno.

Also mention the library function name in getenforce, policyvers and
setenforce instead of the program name twice.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/compute_av.c                              | 3 ++-
 libselinux/utils/compute_create.c                          | 5 +++--
 libselinux/utils/compute_member.c                          | 5 +++--
 libselinux/utils/compute_relabel.c                         | 5 +++--
 libselinux/utils/getconlist.c                              | 2 +-
 libselinux/utils/getdefaultcon.c                           | 2 +-
 libselinux/utils/getenforce.c                              | 4 +++-
 libselinux/utils/getfilecon.c                              | 6 ++++--
 libselinux/utils/getpidcon.c                               | 4 +++-
 libselinux/utils/policyvers.c                              | 4 +++-
 libselinux/utils/selabel_digest.c                          | 2 +-
 libselinux/utils/selabel_get_digests_all_partial_matches.c | 3 ++-
 libselinux/utils/selabel_lookup.c                          | 3 ++-
 libselinux/utils/selabel_lookup_best_match.c               | 3 ++-
 libselinux/utils/selabel_partial_match.c                   | 3 ++-
 libselinux/utils/setenforce.c                              | 3 ++-
 libselinux/utils/setfilecon.c                              | 6 ++++--
 17 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.c
index ef08338f..cca407d6 100644
--- a/libselinux/utils/compute_av.c
+++ b/libselinux/utils/compute_av.c
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <selinux/selinux.h>
 
@@ -35,7 +36,7 @@ int main(int argc, char **argv)
 
 	ret = security_compute_av(argv[1], argv[2], tclass, 1, &avd);
 	if (ret < 0) {
-		fprintf(stderr, "%s:  security_compute_av failed\n", argv[0]);
+		fprintf(stderr, "%s:  security_compute_av failed:  %s\n", argv[0], strerror(errno));
 		exit(3);
 	}
 
diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute_create.c
index 63029c19..c6481f4b 100644
--- a/libselinux/utils/compute_create.c
+++ b/libselinux/utils/compute_create.c
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <selinux/selinux.h>
 
@@ -35,8 +36,8 @@ int main(int argc, char **argv)
 
 	ret = security_compute_create(argv[1], argv[2], tclass, &buf);
 	if (ret < 0) {
-		fprintf(stderr, "%s:  security_compute_create failed\n",
-			argv[0]);
+		fprintf(stderr, "%s:  security_compute_create failed:  %s\n",
+			argv[0], strerror(errno));
 		exit(3);
 	}
 
diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compute_member.c
index 1ef47c25..9fe790ee 100644
--- a/libselinux/utils/compute_member.c
+++ b/libselinux/utils/compute_member.c
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <selinux/selinux.h>
 
@@ -35,8 +36,8 @@ int main(int argc, char **argv)
 
 	ret = security_compute_member(argv[1], argv[2], tclass, &buf);
 	if (ret < 0) {
-		fprintf(stderr, "%s:  security_compute_member failed\n",
-			argv[0]);
+		fprintf(stderr, "%s:  security_compute_member failed:  %s\n",
+			argv[0], strerror(errno));
 		exit(3);
 	}
 
diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/compute_relabel.c
index f6a957da..bdd39d0f 100644
--- a/libselinux/utils/compute_relabel.c
+++ b/libselinux/utils/compute_relabel.c
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <selinux/selinux.h>
 
@@ -35,8 +36,8 @@ int main(int argc, char **argv)
 
 	ret = security_compute_relabel(argv[1], argv[2], tclass, &buf);
 	if (ret < 0) {
-		fprintf(stderr, "%s:  security_compute_relabel failed\n",
-			argv[0]);
+		fprintf(stderr, "%s:  security_compute_relabel failed:  %s\n",
+			argv[0], strerror(errno));
 		exit(3);
 	}
 
diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 0bb28469..92f6a793 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -55,7 +55,7 @@ int main(int argc, char **argv)
 	/* If a context wasn't passed, use the current context. */
 	if (((argc - optind) < 2)) {
 		if (getcon(&cur_context) < 0) {
-			fprintf(stderr, "Couldn't get current context.\n");
+			fprintf(stderr, "Couldn't get current context:  %s\n", strerror(errno));
 			free(level);
 			return 2;
 		}
diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 590e98d9..93102e5e 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -62,7 +62,7 @@ int main(int argc, char **argv)
 	/* If a context wasn't passed, use the current context. */
 	if (((argc - optind) < 2)) {
 		if (getcon(&cur_context) < 0) {
-			fprintf(stderr, "Couldn't get current context.\n");
+			fprintf(stderr, "Couldn't get current context:  %s\n", strerror(errno));
 			return 2;
 		}
 	} else
diff --git a/libselinux/utils/getenforce.c b/libselinux/utils/getenforce.c
index e5d19c54..aeeb79a8 100644
--- a/libselinux/utils/getenforce.c
+++ b/libselinux/utils/getenforce.c
@@ -1,6 +1,8 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 
 int main(int argc __attribute__ ((unused)),
@@ -16,7 +18,7 @@ int main(int argc __attribute__ ((unused)),
 	if (rc == 1) {
 		rc = security_getenforce();
 		if (rc < 0) {
-			fputs("getenforce:  getenforce() failed", stderr);
+			fprintf(stderr, "getenforce:  security_getenforce() failed:  %s\n", strerror(errno));
 			return 2;
 		}
 
diff --git a/libselinux/utils/getfilecon.c b/libselinux/utils/getfilecon.c
index 6266ae16..b823a1a1 100644
--- a/libselinux/utils/getfilecon.c
+++ b/libselinux/utils/getfilecon.c
@@ -1,6 +1,8 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 
 int main(int argc, char **argv)
@@ -16,8 +18,8 @@ int main(int argc, char **argv)
 	for (i = 1; i < argc; i++) {
 		rc = getfilecon(argv[i], &buf);
 		if (rc < 0) {
-			fprintf(stderr, "%s:  getfilecon(%s) failed\n", argv[0],
-				argv[i]);
+			fprintf(stderr, "%s:  getfilecon(%s) failed:  %s\n", argv[0],
+				argv[i], strerror(errno));
 			exit(2);
 		}
 		printf("%s\t%s\n", argv[i], buf);
diff --git a/libselinux/utils/getpidcon.c b/libselinux/utils/getpidcon.c
index ea6c274e..1a88fa6d 100644
--- a/libselinux/utils/getpidcon.c
+++ b/libselinux/utils/getpidcon.c
@@ -1,6 +1,8 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 
 int main(int argc, char **argv)
@@ -21,7 +23,7 @@ int main(int argc, char **argv)
 
 	rc = getpidcon(pid, &buf);
 	if (rc < 0) {
-		fprintf(stderr, "%s:  getpidcon() failed\n", argv[0]);
+		fprintf(stderr, "%s:  getpidcon() failed:  %s\n", argv[0], strerror(errno));
 		exit(3);
 	}
 
diff --git a/libselinux/utils/policyvers.c b/libselinux/utils/policyvers.c
index dd56f2c7..5230bcaf 100644
--- a/libselinux/utils/policyvers.c
+++ b/libselinux/utils/policyvers.c
@@ -1,6 +1,8 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 
 int main(int argc __attribute__ ((unused)), char **argv)
@@ -9,7 +11,7 @@ int main(int argc __attribute__ ((unused)), char **argv)
 
 	rc = security_policyvers();
 	if (rc < 0) {
-		fprintf(stderr, "%s:  policyvers() failed\n", argv[0]);
+		fprintf(stderr, "%s:  security_policyvers() failed:  %s\n", argv[0], strerror(errno));
 		exit(2);
 	}
 
diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 49408a0b..6a8313a2 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -34,7 +34,7 @@ static int run_check_digest(char *cmd, char *selabel_digest)
 
 	fp = popen(cmd, "r");
 	if (!fp) {
-		printf("Failed to run command line\n");
+		fprintf(stderr, "Failed to run command '%s':  %s\n", cmd, strerror(errno));
 		return -1;
 	}
 
diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
index e28833d2..c4e0f836 100644
--- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -77,7 +77,8 @@ int main(int argc, char **argv)
 	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
 	if (!hnd) {
 		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
-							     "handle.\n");
+							     "handle:  %s\n",
+							     strerror(errno));
 		return -1;
 	}
 
diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
index 1aef64de..112ffda1 100644
--- a/libselinux/utils/selabel_lookup.c
+++ b/libselinux/utils/selabel_lookup.c
@@ -91,7 +91,8 @@ int main(int argc, char **argv)
 	hnd = selabel_open(backend, selabel_option, 2);
 	if (!hnd) {
 		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
-							     "handle.\n");
+							     "handle:  %s\n",
+							     strerror(errno));
 		return -1;
 	}
 
diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/utils/selabel_lookup_best_match.c
index 2cddc6cd..a4af0679 100644
--- a/libselinux/utils/selabel_lookup_best_match.c
+++ b/libselinux/utils/selabel_lookup_best_match.c
@@ -117,7 +117,8 @@ int main(int argc, char **argv)
 	hnd = selabel_open(SELABEL_CTX_FILE, options, 2);
 	if (!hnd) {
 		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
-							     "handle.\n");
+							     "handle:  %s\n",
+							     strerror(errno));
 		rc = -1;
 		goto out;
 	}
diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/selabel_partial_match.c
index c5932cb1..7bbd5777 100644
--- a/libselinux/utils/selabel_partial_match.c
+++ b/libselinux/utils/selabel_partial_match.c
@@ -61,7 +61,8 @@ int main(int argc, char **argv)
 	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
 	if (!hnd) {
 		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
-							     "handle.\n");
+							     "handle:  %s\n",
+							     strerror(errno));
 		return -1;
 	}
 
diff --git a/libselinux/utils/setenforce.c b/libselinux/utils/setenforce.c
index 60a20a4b..67c13dca 100644
--- a/libselinux/utils/setenforce.c
+++ b/libselinux/utils/setenforce.c
@@ -4,6 +4,7 @@
 #include <ctype.h>
 #include <string.h>
 #include <strings.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
@@ -35,7 +36,7 @@ int main(int argc, char **argv)
 			usage(argv[0]);
 	}
 	if (rc < 0) {
-		fprintf(stderr, "%s:  setenforce() failed\n", argv[0]);
+		fprintf(stderr, "%s:  security_setenforce() failed:  %s\n", argv[0], strerror(errno));
 		return 2;
 	}
 	return 0;
diff --git a/libselinux/utils/setfilecon.c b/libselinux/utils/setfilecon.c
index 79af55de..a3fbc3ed 100644
--- a/libselinux/utils/setfilecon.c
+++ b/libselinux/utils/setfilecon.c
@@ -1,6 +1,8 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 #include <selinux/selinux.h>
 
 int main(int argc, char **argv)
@@ -15,8 +17,8 @@ int main(int argc, char **argv)
 	for (i = 2; i < argc; i++) {
 		rc = setfilecon(argv[i], argv[1]);
 		if (rc < 0) {
-			fprintf(stderr, "%s:  setfilecon(%s,%s) failed\n",
-				argv[0], argv[i], argv[1]);
+			fprintf(stderr, "%s:  setfilecon(%s,%s) failed:  %s\n",
+				argv[0], argv[i], argv[1], strerror(errno));
 			exit(2);
 		}
 	}
-- 
2.36.0

