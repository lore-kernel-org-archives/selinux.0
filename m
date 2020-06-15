Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A3C433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09A520644
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 14:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V4Mqz38K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgFOOUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgFOOUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 10:20:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3BAC061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 07:20:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id y6so6376987edi.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X4NZuj8l8MGRpEIYDryRdfaMRFb2s0Cf3n6HoCtgWBQ=;
        b=V4Mqz38KDHGzeKcY6xvv7Yg5mx3Zrmm25+339E2fDB+LWZwuhL5rOM5Zx7byPXzmuc
         jpgvG3T7THM7LmNxlr8UKyUOqThtNkcrtNsxaV7UVv9zD+CzJDb8hI7AOLjBxSJTjA7m
         B3rSb4cbm0ReqVR+c57yGZ2Xvk73p8qp6nVLdDbNvS5dGPFZVrEwC2p1HOY1Y4jvAOMk
         3xq9iP0ZWrF8qBUOIHyiraC7o6dna8JDZ/6/OL78DmzBH7vvYI6VD2hiQV2Zy3lDe0oM
         jTEeR627/6nO5z8/5iWKZggHHHMJn2RmXfbWDVSUvKG33pJ7MYDPgdgrl9PvCuhphp7N
         xNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4NZuj8l8MGRpEIYDryRdfaMRFb2s0Cf3n6HoCtgWBQ=;
        b=FBLvl5++hkMw6cAlBtIwY/qyrGnWR9ZngJ1SE1/9SbOoMPKn288MKYBdKHTl+z2+qu
         cRXsQ0/26t6vV9yNzAH80wTfYxJTepDIJkUBBTtzfsfmr811O1+PFgwISRLBqg6m8Sf/
         Gox3WBK8AeuXqvHrE+/lWzujI4CCurzsa/OX02wOcWtmAnzwl5HcDwkDVvPgVAryP8aM
         NnvwMZEUQ8s3Hs2DeJrN0uzcD6hryRkDxUSbtNUQDPd7Wf3cBKcUKMzvHz6gm8/DMnui
         Li7ylsOyiO229Sybge7EslUfqso0HTga1G7tT3S+9Fw+jTzJKN5VHojMuOdnyK5z+gIQ
         5nkQ==
X-Gm-Message-State: AOAM530VXy0IWVzH1hnUV+iefwhDEfv5sas1jFQlXcsYWqYuOYS5jyLb
        xW1gB2rYrO5JUfyypVcSNzqY286c
X-Google-Smtp-Source: ABdhPJz+3CnnvYL2GeE4q7o+e8/PC8FzzRLxQ41d28bB/0rBXGxEg5QvxYy/VuTQnr9XZlM+KgRrKA==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr25340179edv.40.1592230800951;
        Mon, 15 Jun 2020 07:20:00 -0700 (PDT)
Received: from debianHome.localdomain (x4d0683cf.dyn.telefonica.de. [77.6.131.207])
        by smtp.gmail.com with ESMTPSA id v2sm9203633eju.49.2020.06.15.07.20.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:20:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v5 3/3] sepolgen-ifgen: refactor default policy path retrieval
Date:   Mon, 15 Jun 2020 16:19:53 +0200
Message-Id: <20200615141953.11119-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611135303.19538-3-cgzones@googlemail.com>
References: <20200611135303.19538-3-cgzones@googlemail.com>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v5: - Do not check bare selinux_binary_policy_path()
    - Link helper dynamically with libselinux
v4: Improve the behavior on no explicit policy path given:
    - Reorder helper's command line interface
    - Use loaded policy on SELinux enabled systems
v3: Move the iteration logic from sepolgen-ifgen to
    sepolgen-ifgen-attr-helper and use sepol_policy_kern_vers_max()
    instead of selinux.security_policyvers(), to work on SELinux
    disabled systems

 python/audit2allow/Makefile                   |  2 +-
 python/audit2allow/sepolgen-ifgen             | 28 ++------------
 .../audit2allow/sepolgen-ifgen-attr-helper.c  | 38 +++++++++++++++++--
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 15db5490..025c282a 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -18,7 +18,7 @@ endif
 
 all: audit2why sepolgen-ifgen-attr-helper
 
-sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
+sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA) -lselinux
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
index 1ce37b0d..53f20818 100644
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
@@ -147,8 +149,36 @@ static policydb_t *load_policy(const char *filename)
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
@@ -188,7 +218,7 @@ static policydb_t *load_policy(const char *filename)
 
 void usage(char *progname)
 {
-	printf("usage: %s policy_file out_file\n", progname);
+	printf("usage: %s out_file [policy_file]\n", progname);
 }
 
 int main(int argc, char **argv)
@@ -197,18 +227,18 @@ int main(int argc, char **argv)
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

