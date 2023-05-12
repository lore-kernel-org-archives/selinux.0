Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D8C7EE25
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 11:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbjELLHl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELLHk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 07:07:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B2730DC
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso14779320a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683889657; x=1686481657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HayLvsHKcvOwnYP2GdxtAfynefSInfGAezvE5JgeD78=;
        b=VNwJRUCQE93qXuznfocS2kXFY+VA85Qz7mJPHGSFaZoBihq3dO0WMyIm/yZS1daPFM
         ygOw8ifxM5jLsxnZTmGYzh7wzGcJT0w1vEpKXKS1LDjWbn+MCPeCfEvxgBRUegBtBgqf
         rZNqyU6idBA7JjmhGet1Lmrh/sNHA5IsttOloLB/egrqKMCAtDfJH5iROd3yl5ebUeoH
         nSPdPNNC8qy8zM5wbaorPw6RvW+QmaEE5ZVNfay7/2A4lhdNN3iDeG4j88dBGwEEayo0
         ctdUsG7ar6ZJE4ZQ5JTS2/EBfMGaqU3xFqcgnYPWPBDxRi9njwYVYygX98cG2iMFkKAz
         Zk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683889657; x=1686481657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HayLvsHKcvOwnYP2GdxtAfynefSInfGAezvE5JgeD78=;
        b=SIdPGqbRaseeGbifx94lGfaTnMSgw7NPcess9in4lo7OAksfeK8Tdq0lhTyrba5W+g
         Vw035LtevKowYDO7c+suBD9M/qK1Pv0S1TPuq7W4s1VZj1aro+UvzQDS3jvMcCF+VIKq
         MoCivl2Wi9Hdv/KP2S3238SoJZOSIQvazTFRWShIBfLyjeqFVK5HaAuYxxUixBHgiUhv
         diz/fl9swiC9uvXnF8HQgM3D6A1GyLoXxxLSvLTlGy5sAAbK7NWPFfEHL5AZGQJC60uR
         P2RLLKGjtLrDNSMzPlXf9SUTL7aGN6IV9sYNORFmO6QmOQvRpou0P+hr3J1e/eKvoq+g
         aCSQ==
X-Gm-Message-State: AC+VfDwFPptujTe0GtKE84QXjMk/KgZ1T9gYWAr4YLFkBSD6tenDJoa2
        O/Z6RsZW1i4Qxkh400OvL7q1MMp6e7wqKQ==
X-Google-Smtp-Source: ACHHUZ4RFHPY6Ju1xvV9EdkyP63UDrvKo7BofPxquSMb/2WaMtT1i/+BDNkUXGb6pjOC0JHK/1JKLA==
X-Received: by 2002:a17:907:7d91:b0:969:e304:7a1d with SMTP id oz17-20020a1709077d9100b00969e3047a1dmr14119012ejc.50.1683889656812;
        Fri, 12 May 2023 04:07:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c7cb000000b0050bde945c00sm3812016eds.78.2023.05.12.04.07.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:07:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/4] semodule_unpackage: update
Date:   Fri, 12 May 2023 13:07:30 +0200
Message-Id: <20230512110730.78672-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512110730.78672-1-cgzones@googlemail.com>
References: <20230512110730.78672-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop unnecessary declarations.
Check closing file for incomplete write.
Rework resource cleanup, so that all files and allocated memory are
released in all branches, useful to minimize reports while debugging
libsepol under valgrind(8) or sanitizers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../semodule_package/semodule_unpackage.c     | 122 +++++++++++-------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/semodule-utils/semodule_package/semodule_unpackage.c b/semodule-utils/semodule_package/semodule_unpackage.c
index b8c4fbce..21c97953 100644
--- a/semodule-utils/semodule_package/semodule_unpackage.c
+++ b/semodule-utils/semodule_package/semodule_unpackage.c
@@ -11,8 +11,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
-char *progname = NULL;
-extern char *optarg;
+static const char *progname = NULL;
 
 static __attribute__((__noreturn__)) void usage(void)
 {
@@ -20,84 +19,113 @@ static __attribute__((__noreturn__)) void usage(void)
 	exit(1);
 }
 
-static int file_to_policy_file(const char *filename, struct sepol_policy_file **pf, const char *mode)
-{
-	FILE *f;
-
-	if (sepol_policy_file_create(pf)) {
-		fprintf(stderr, "%s:  Out of memory\n", progname);
-		return -1;
-	}
-
-	f = fopen(filename, mode);
-	if (!f) {
-		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, strerror(errno), filename);
-		return -1;
-	}
-	sepol_policy_file_set_fp(*pf, f);
-	return 0;
-}
-
 int main(int argc, char **argv)
 {
-	struct sepol_module_package *pkg;
-	struct sepol_policy_file *in, *out;
-	FILE *fp;
+	struct sepol_module_package *pkg = NULL;
+	struct sepol_policy_file *in = NULL, *out = NULL;
+	FILE *fp = NULL;
 	size_t len;
-	char *ppfile, *modfile, *fcfile = NULL, *fcdata;
+	const char *ppfile, *modfile, *fcfile = NULL, *fcdata;
+	int ret;
 
 	progname = argv[0];
 
-	if (argc < 3) {
+	if (argc < 3)
 		usage();
-		exit(1);
-	}
 
 	ppfile = argv[1];
 	modfile = argv[2];
 	if (argc >= 4)
 		fcfile = argv[3];
 
-	if (file_to_policy_file(ppfile, &in, "r"))
-		exit(1);
-
 	if (sepol_module_package_create(&pkg)) {
-                fprintf(stderr, "%s:  Out of memory\n", progname);
-                exit(1);
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto failure;
+	}
+
+	if (sepol_policy_file_create(&in)) {
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto failure;
 	}
 
+	fp = fopen(ppfile, "r");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, ppfile, strerror(errno));
+		goto failure;
+	}
+	sepol_policy_file_set_fp(in, fp);
+
 	if (sepol_module_package_read(pkg, in, 0) == -1) {
-                fprintf(stderr, "%s:  Error while reading policy module from %s\n",
+		fprintf(stderr, "%s:  Error while reading policy module from %s\n",
 			progname, ppfile);
-                exit(1);
+		goto failure;
 	}
 
-	if (file_to_policy_file(modfile, &out, "w"))
-		exit(1);
+	sepol_policy_file_free(in);
+	in = NULL;
+	fclose(fp);
+	fp = NULL;
 
-        if (sepol_policydb_write(sepol_module_package_get_policy(pkg), out)) {
-                fprintf(stderr, "%s:  Error while writing module to %s\n", progname, modfile);
-                exit(1);
-        }
+	if (sepol_policy_file_create(&out)) {
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto failure;
+	}
+
+	fp = fopen(modfile, "w");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, modfile, strerror(errno));
+		goto failure;
+	}
+	sepol_policy_file_set_fp(out, fp);
+
+	if (sepol_policydb_write(sepol_module_package_get_policy(pkg), out)) {
+		fprintf(stderr, "%s:  Error while writing module to %s\n", progname, modfile);
+		goto failure;
+	}
+
+	ret = fclose(fp);
+	fp = NULL;
+	if (ret) {
+		fprintf(stderr, "%s:  Error while closing file %s:  %s\n", progname, modfile, strerror(errno));
+		goto failure;
+	}
 
-	sepol_policy_file_free(in);
 	sepol_policy_file_free(out);
+	out = NULL;
 
 	len = sepol_module_package_get_file_contexts_len(pkg);
 	if (fcfile && len) {
 		fp = fopen(fcfile, "w");
 		if (!fp) {
-			fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, strerror(errno), fcfile);
-			exit(1);
+			fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, fcfile, strerror(errno));
+			goto failure;
 		}
 		fcdata = sepol_module_package_get_file_contexts(pkg);
 		if (fwrite(fcdata, 1, len, fp) != len) {
-			fprintf(stderr, "%s:  Could not write file %s:  %s\n", progname, strerror(errno), fcfile);
-			exit(1);
+			fprintf(stderr, "%s:  Could not write file %s:  %s\n", progname, fcfile, strerror(errno));
+			goto failure;
+		}
+
+		ret = fclose(fp);
+		fp = NULL;
+		if (ret) {
+			fprintf(stderr, "%s:  Could not close file %s:  %s\n", progname, fcfile, strerror(errno));
+			goto failure;
 		}
-		fclose(fp);
 	}
 
+	ret = EXIT_SUCCESS;
+
+cleanup:
+	if (fp)
+		fclose(fp);
+	sepol_policy_file_free(out);
 	sepol_module_package_free(pkg);
-	exit(0);
+	sepol_policy_file_free(in);
+
+	return ret;
+
+failure:
+	ret = EXIT_FAILURE;
+	goto cleanup;
 }
-- 
2.40.1

