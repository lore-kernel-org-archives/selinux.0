Return-Path: <SRS0=iV3B=7S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD55C433E1
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46907206F0
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T1JRkw1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFEOtX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgFEOtW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jun 2020 10:49:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3ABC08C5C3
        for <selinux@vger.kernel.org>; Fri,  5 Jun 2020 07:49:22 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so10407749eja.7
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2020 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eTjuuQiqvhQhhOMfjObuPenM0qBEpHYLeskr6IeBdDo=;
        b=T1JRkw1camx48HoqnjT8sct/V1pF8zif15sxAERreh89RW3wgJ5mB5G8PCwnvzmnUb
         UkCshy+PoW/iZLMURCUV6mr/LkhW9IkFNr9/eTLIwu7Hbr+CZDpOKwk95/cUd+ZqxAES
         vX0Z+8Cvseb5YCjikqC8QgP2v3pMnZ7/WPNI0XqsM5BmSeTCKKvwsAmAGlry6Rf1on9j
         d4cMXQsOrjgSzhUlYXuHoRroEL5bhybtw82cVQ3Dy2k5yvT+iYuvG+qQzyIGV3jB08CV
         C3Ji+Z2iZUvEVD+0gFEGuN5IgqBpIZ2x6KEIAt0kD05jraVpNg32qS3fZuQA78RioZ7v
         o9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTjuuQiqvhQhhOMfjObuPenM0qBEpHYLeskr6IeBdDo=;
        b=CDT3+6JGAeTxykZLcfnZqNKeUMtlZ41kXD+696r7UqTpKqtYJcNZwE28c8VLOhq1BU
         C8ZZ/B42P6vaCtQ25c2yP6ie0ZVadkIg0oC8Z82hFEg6vWAXFsbp9alwR1nibOfDHnfP
         ERnerjf3CFdITKSl3tmfO2Li/W+FyVV7hJJstcJy8mNPtPpSP0B9Ge7pw1l1bvsW3/0t
         f00oE2pBr3YIENka3Lw8RTytMoFBt/KIlzyiKEMhYL8737kXL/f77Ow9SNtvshrGUjc1
         q5BJskr0Dr60/8jvjw0vTjnHbxPjto7QU5Y0NOHrrkngb074OiQW9t80U1GZwYe4iioJ
         7Shg==
X-Gm-Message-State: AOAM533qRVBfcsFKVYNPEHfd+LKaN3++L3UAF9sBW1qdJ2kHv45WrXet
        5g8jwjZkaKwPYkDxyMTVMmEMFp6l
X-Google-Smtp-Source: ABdhPJxg/RbXyWb3+OFf85my0sLSHVt0qXYd447IXANCF32ofxfHVKJdE5dKXBTC+988toGktvvlgw==
X-Received: by 2002:a17:906:2b8f:: with SMTP id m15mr9597602ejg.156.1591368560771;
        Fri, 05 Jun 2020 07:49:20 -0700 (PDT)
Received: from debianHome.localdomain (x5f70b03c.dyn.telefonica.de. [95.112.176.60])
        by smtp.gmail.com with ESMTPSA id a9sm5060948edr.23.2020.06.05.07.49.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:49:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 3/3] sepolgen-ifgen: refactor default policy path retrieval
Date:   Fri,  5 Jun 2020 16:49:12 +0200
Message-Id: <20200605144912.22522-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605144912.22522-1-cgzones@googlemail.com>
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200605144912.22522-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On a SELinux disabled system the python call
`selinux.security_policyvers()` will fail.

Move the logic to find a binary policy by iterating over appended
version suffixes from the python script `sepolgen-ifgen` to the C
helper `sepolgen-ifgen-attr-helper` to make use of the libsepol
interface `sepol_policy_kern_vers_max()`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: Move the iteration logic from sepolgen-ifgen to 
    sepolgen-ifgen-attr-helper and use sepol_policy_kern_vers_max()
    instead of selinux.security_policyvers(), to work on SELinux
    disabled systems

 python/audit2allow/sepolgen-ifgen             | 26 ++-----------
 .../audit2allow/sepolgen-ifgen-attr-helper.c  | 39 ++++++++++++++++---
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index 4a71cda4..19c3ee30 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -27,7 +27,6 @@
 
 
 import sys
-import os
 import tempfile
 import subprocess
 
@@ -65,34 +64,15 @@ def parse_options():
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
+    if not policy_path:
+        policy_path = selinux.selinux_binary_policy_path()
+
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
     ret = subprocess.Popen([attr_helper, policy_path, outfile.name], stdout=fd).wait()
diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/audit2allow/sepolgen-ifgen-attr-helper.c
index 1ce37b0d..dab6fb15 100644
--- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
+++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
@@ -147,13 +147,42 @@ static policydb_t *load_policy(const char *filename)
 	policydb_t *policydb;
 	struct policy_file pf;
 	FILE *fp;
+	char pathname[PATH_MAX];
+	int suffix_ver;
 	int ret;
 
-	fp = fopen(filename, "r");
-	if (fp == NULL) {
-		fprintf(stderr, "Can't open '%s':  %s\n",
-			filename, strerror(errno));
-		return NULL;
+	/*
+	 * First use the pure given path.
+	 * If it does not exist use paths with version suffixes,
+	 * starting from the maximum supported policy version.
+	 */
+	if (access(filename, F_OK) == 0) {
+		fp = fopen(filename, "r");
+		if (fp == NULL) {
+			fprintf(stderr, "Can't open '%s':  %s\n",
+				filename, strerror(errno));
+			return NULL;
+		}
+	} else {
+		for (suffix_ver = sepol_policy_kern_vers_max(); suffix_ver > 0; suffix_ver--) {
+			snprintf(pathname, sizeof(pathname), "%s.%d", filename, suffix_ver);
+
+			if (access(pathname, F_OK) == 0)
+				break;
+		}
+
+		if (suffix_ver <= 0) {
+			fprintf(stderr, "Can't find any policy at '%s'\n",
+				filename);
+			return NULL;
+		}
+
+		fp = fopen(pathname, "r");
+		if (fp == NULL) {
+			fprintf(stderr, "Can't open '%s':  %s\n",
+				pathname, strerror(errno));
+			return NULL;
+		}
 	}
 
 	policy_file_init(&pf);
-- 
2.27.0

