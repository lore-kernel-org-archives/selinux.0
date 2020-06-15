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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8BC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3006F20739
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K64x6mrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgFOPHu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgFOPHu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 11:07:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94194C061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 08:07:49 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t21so11762254edr.12
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gmw0Lo4oPqvfDE4AhTBxRM2egtHbgvJY6n1PBJCmLqM=;
        b=K64x6mrnnfkztaUt0EvbFAajHa+pxYArLp90A7WxrIiz5ztS62OKt6hUb74NZfk0eh
         aTRhuP5yXDHysEp6s8JJtwT/HdWd3MIApF6eNrclKUpHx82MgUHLXh/agC4YeSQgCHmy
         YSOej9Gh2iFyhJLwolUjGEtRMnx2myzLRMUbpQ0K65Psu4+ToVhbHRMagB+cYpl81bgI
         +4UFAQ2wMXfxEHP9a6455qGq59lvvSRPKP8CfMYVLxAYe/Aoa12eeCdVOzGROZnJbHcT
         +X1JPJZB/0F2lsZ6tEdiu+7aULFTDaAZOiJeCNsIPgkFa13jUEXGY2EcM517Y321rFES
         i67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmw0Lo4oPqvfDE4AhTBxRM2egtHbgvJY6n1PBJCmLqM=;
        b=L/2rKfBANVkVJ7aanX/3WtsvEv+TTesn4HppYa3UFs7Kyzc8rNi7unbNpL3g4P4BLu
         54X5/u/D74dYrE9Pl1D+0TN6LC5T6u/qNBssXr5gMJOUW0ie8o1p/1qLQFj9MJ9ScQoN
         SWyISoGHnox2F7u2XClKAzG5o61OEumc9MZAT/hJpHFiiJ3dAPVu3xN5mdyU4NQz4Fzg
         5rNII8qrC41bY7DlosQENVM6zWLrusbsr6z4f8w7UwGH1rZnSjmzSlBzOQNKjNdmuQIB
         KAgswhS1zTq55rPO6cbbopmjzZw+W3L2hN8QffWFyKHcNH05FxU9rJFzqdFObW+XJkFo
         D90Q==
X-Gm-Message-State: AOAM532O02phTKBbUMguSpNI1YBhf16Q8aM3BrdgpNoqz+ROJTgf27dk
        GIXc51e4fgbgMGW8SWaDqlFQKMOz
X-Google-Smtp-Source: ABdhPJzbXZighQ32DTaCImuXh97C2kwJ1QskQ6FwiTlJWtFbRrlh3had6FuB2JPKtFktpXTsY9HhAA==
X-Received: by 2002:aa7:c752:: with SMTP id c18mr23642389eds.55.1592233667832;
        Mon, 15 Jun 2020 08:07:47 -0700 (PDT)
Received: from debianHome.localdomain (x4d0683cf.dyn.telefonica.de. [77.6.131.207])
        by smtp.gmail.com with ESMTPSA id g20sm8990200ejk.16.2020.06.15.08.07.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:07:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v6 3/3] sepolgen-ifgen: refactor default policy path retrieval
Date:   Mon, 15 Jun 2020 17:07:41 +0200
Message-Id: <20200615150741.18526-1-cgzones@googlemail.com>
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
v6: fix -lselinux usage
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
index 15db5490..76bf4e37 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -19,7 +19,7 @@ endif
 all: audit2why sepolgen-ifgen-attr-helper
 
 sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA) -lselinux
 
 audit2why:
 	ln -sf audit2allow audit2why
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

