Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2DC433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65672083E
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AifdZc5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgFKNxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKNxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 09:53:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE21C03E96F
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:53:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so6512075ejd.13
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U6dioI+Qu+x3G3TWLScB71dR0s7M+3ZrjD97afSg0Hg=;
        b=AifdZc5TIRrrq6djEmckRItZb4AXw3XtpVW92Hrc3ROYFdmrclQYugUSULWRr695JS
         enzWVpuGxuEKeeVHV8x2hs5ZiE0cmVTX+M04yCm3U1+qhLz7h4DFVREJlzZqFImUJgba
         awAZFyH7bDk84noypbSjJJyHgslqzW+cqkCGBn3IBuYgM9rPYXXia/D6o6p6OfEt8rn2
         BQoRHndxXf6B4SH4KIsAQmP/Nj1KEGWgVaZVXrqazmcuBBmgpd/lJneZPrTo6wI8h9E/
         VDrQqrx0kC1n9PD5FSbOENrkh6+Tp2JAAtd2IzwB4SXSP7rx7afv4C7fuBXgitvj9BJT
         T7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6dioI+Qu+x3G3TWLScB71dR0s7M+3ZrjD97afSg0Hg=;
        b=gnEESNM7f7VPfh8jSGXh0RxQkjrdONSInkxVlY2rJxL9Thdtb2db2X9gbrcKmKsgRm
         xShW/tbYxpAgi9WgYyIX0O8j5LsxN0+6m6URTO6Ie6p1t70udA98rxGWJOJ++AHwPED6
         ycqlAk0Vxd4FHro3bxl3dg//GUbZI6vKwJ0oDg1dCFzqBZZZ55tLsIPsxWyTxm500Sel
         cF+A5h9zUfWVXjFY510LZ5z1IS8Z/oe0m3B568cpLGJx5qDtJxSeUt/IbYgZbBhVsaCt
         vbUuQx1gmfNpphQR98j0muSgGil0BGySQL5S1GQGgMziQrReLa55F86msXtIoo8QbPzU
         /CDA==
X-Gm-Message-State: AOAM533uZFwHIitdopg3Y+GairfcEmCQxsY67CHuLn3wkqbmscKB0aX2
        fh+H+yEoITEax00zkjNstv4xYtif
X-Google-Smtp-Source: ABdhPJyVTv1uiaQhT7bIAmPMkGJqO8vIDqB8bZiuGY2MfUvrizW82ESqkvYVdLonGtsuSM254mJyOA==
X-Received: by 2002:a17:906:1149:: with SMTP id i9mr8878403eja.100.1591883599647;
        Thu, 11 Jun 2020 06:53:19 -0700 (PDT)
Received: from debianHome.localdomain (x4d03eb01.dyn.telefonica.de. [77.3.235.1])
        by smtp.gmail.com with ESMTPSA id bd19sm1575005edb.2.2020.06.11.06.53.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 06:53:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v4 3/3] sepolgen-ifgen: refactor default policy path retrieval
Date:   Thu, 11 Jun 2020 15:53:03 +0200
Message-Id: <20200611135303.19538-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611135303.19538-1-cgzones@googlemail.com>
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200611135303.19538-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On a SELinux disabled system the python call
`selinux.security_policyvers()` will fail.

Move the logic to find a binary policy from the python script
`sepolgen-ifgen` to the C-helper `sepolgen-ifgen-attr-helper`.
Change the helper command line interface to accept an optional policy
path as second argument.  If not given try the current loaded policy
(`selinux_current_policy_path`) and if running on a SELinux disabled
system iterate over the default store path appending policy versions
starting at the maximum supported policy version
(`sepol_policy_kern_vers_max`).

This changes the helper command line interface from:
    sepolgen-ifgen-attr-helper policy_file out_file
to
    sepolgen-ifgen-attr-helper out_file [policy_file]
and adds a linkage to libselinux.

Export LIBSELINUXA like LIBSEPOLA in the root Makefile

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v4: Improve the behavior on no explicit policy path given:
    - Reorder helper's command line interface
    - Use loaded policy on SELinux enabled systems
v3: Move the iteration logic from sepolgen-ifgen to 
    sepolgen-ifgen-attr-helper and use sepol_policy_kern_vers_max()
    instead of selinux.security_policyvers(), to work on SELinux
    disabled systems

 Makefile                                      |  2 +
 python/audit2allow/Makefile                   |  5 ++-
 python/audit2allow/sepolgen-ifgen             | 28 ++----------
 .../audit2allow/sepolgen-ifgen-attr-helper.c  | 43 +++++++++++++++++--
 4 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 298cd2b7..caf4cd3c 100644
--- a/Makefile
+++ b/Makefile
@@ -23,12 +23,14 @@ endif
 ifneq ($(DESTDIR),)
 	LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 	LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+	LIBSELINUXA ?= $(LIBDIR)/libselinux.a
 
 	CFLAGS += -I$(DESTDIR)$(PREFIX)/include
 	LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
 	export CFLAGS
 	export LDFLAGS
 	export LIBSEPOLA
+	export LIBSELINUXA
 endif
 
 all install relabel clean test indent:
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 15db5490..5400586c 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -15,10 +15,13 @@ CFLAGS ?= -Werror -Wall -W
 ifeq ($(LIBSEPOLA),)
         LDLIBS_LIBSEPOLA := -l:libsepol.a
 endif
+ifeq ($(LIBSELINUXA),)
+        LDLIBS_LIBSELINUXA := -l:libselinux.a
+endif
 
 all: audit2why sepolgen-ifgen-attr-helper
 
-sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
+sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA) $(LIBSELINUXA)
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 audit2why:
diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index 4a71cda4..b7a04c71 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -27,7 +27,6 @@
 
 
 import sys
-import os
 import tempfile
 import subprocess
 
@@ -65,37 +64,18 @@ def parse_options():
     return options
 
 
-def get_policy():
-    p = selinux.selinux_current_policy_path()
-    if p and os.path.exists(p):
-        return p
-    i = selinux.security_policyvers()
-    p = selinux.selinux_binary_policy_path() + "." + str(i)
-    while i > 0 and not os.path.exists(p):
-        i = i - 1
-        p = selinux.selinux_binary_policy_path() + "." + str(i)
-    if i > 0:
-        return p
-    return None
-
-
 def get_attrs(policy_path, attr_helper):
     try:
-        if not policy_path:
-            policy_path = get_policy()
-        if not policy_path:
-            sys.stderr.write("No installed policy to check\n")
-            return None
         outfile = tempfile.NamedTemporaryFile()
     except IOError as e:
         sys.stderr.write("could not open attribute output file\n")
         return None
-    except OSError:
-        # SELinux Disabled Machine
-        return None
 
     fd = open("/dev/null", "w")
-    ret = subprocess.Popen([attr_helper, policy_path, outfile.name], stdout=fd).wait()
+    if policy_path:
+        ret = subprocess.Popen([attr_helper, outfile.name, policy_path], stdout=fd).wait()
+    else:
+        ret = subprocess.Popen([attr_helper, outfile.name], stdout=fd).wait()
     fd.close()
     if ret != 0:
         sys.stderr.write("could not run attribute helper\n")
diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/audit2allow/sepolgen-ifgen-attr-helper.c
index 1ce37b0d..001ae80b 100644
--- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
+++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
@@ -26,6 +26,8 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/util.h>
 
+#include <selinux/selinux.h>
+
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -147,8 +149,41 @@ static policydb_t *load_policy(const char *filename)
 	policydb_t *policydb;
 	struct policy_file pf;
 	FILE *fp;
+	char pathname[PATH_MAX];
+	int suffix_ver;
 	int ret;
 
+	/* no explicit policy name given, try loaded policy on a SELinux enabled system */
+	if (!filename) {
+		filename = selinux_current_policy_path();
+	}
+
+	/* try bare default policy path */
+	if (!filename && access(selinux_binary_policy_path(), F_OK) == 0) {
+		filename = selinux_binary_policy_path();
+	}
+
+	/*
+	 * Fallback to default store paths with version suffixes,
+	 * starting from the maximum supported policy version.
+	 */
+	if (!filename) {
+		for (suffix_ver = sepol_policy_kern_vers_max(); suffix_ver > 0; suffix_ver--) {
+			snprintf(pathname, sizeof(pathname), "%s.%d", selinux_binary_policy_path(), suffix_ver);
+
+			if (access(pathname, F_OK) == 0) {
+				filename = pathname;
+				break;
+			}
+		}
+
+		if (!filename) {
+			fprintf(stderr, "Can't find any policy at '%s'\n",
+				selinux_binary_policy_path());
+			return NULL;
+		}
+	}
+
 	fp = fopen(filename, "r");
 	if (fp == NULL) {
 		fprintf(stderr, "Can't open '%s':  %s\n",
@@ -188,7 +223,7 @@ static policydb_t *load_policy(const char *filename)
 
 void usage(char *progname)
 {
-	printf("usage: %s policy_file out_file\n", progname);
+	printf("usage: %s out_file [policy_file]\n", progname);
 }
 
 int main(int argc, char **argv)
@@ -197,18 +232,18 @@ int main(int argc, char **argv)
 	struct callback_data cb_data;
 	FILE *fp;
 
-	if (argc != 3) {
+	if (argc != 2 && argc != 3) {
 		usage(argv[0]);
 		return -1;
 	}
 
 	/* Open the policy. */
-	p = load_policy(argv[1]);
+	p = load_policy(argv[2]);
 	if (p == NULL)
 		return -1;
 
 	/* Open the output policy. */
-	fp = fopen(argv[2], "w");
+	fp = fopen(argv[1], "w");
 	if (fp == NULL) {
 		fprintf(stderr, "error opening output file\n");
 		policydb_destroy(p);
-- 
2.27.0

