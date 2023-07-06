Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B099EB64DC
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjGFOyC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjGFOxv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:53:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E41FC3
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:53:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so1076799a12.3
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688655221; x=1691247221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Znw4JNVSOA3c26jFrdRp3OH3MKu3SeGIe6sFOaQ4pks=;
        b=NmiNdTQuPlnqkclCn34dWhAwZ+A4sAsZw8oESqaNrJIEKqPJkmBmAEtsoLTWn4FZIr
         mIRKNAb8EoGf7WQmJ4KDI6QEJZFvlmP9CXLgnUwY3KGOk2WCmGOc9mse6QzMyxw/idIq
         92/nbQfTHSY3QYF5cnPhLTyiUePM9U0sbj5qH3D8V0U3aDZiDR1IHr/jXHx+TKmLFM7v
         IY2LV6spKYCEpW0lCahHy7U9TnJaV0zqHXfI5g/UFyKmHl7D4cVXHLMw5HOFzQlaXemo
         SM8uYxc6BPdoFKMgPgMo+2tZws+sraDeMDeLKg66LjiYJS5tS0Kh4oSgeWjf4L5WIRng
         HyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655221; x=1691247221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Znw4JNVSOA3c26jFrdRp3OH3MKu3SeGIe6sFOaQ4pks=;
        b=YaBxUqKLUF3yDrRBjV7Z6yKemkjaHzU/Vf2o8e1u4Kl9Hw7jWyQAA+pbuBOuo7qT53
         DlNQCmlR8GY6S0NPGFbzn2Qu3OuLmp/wpzD9tjy43JQldaW1qSXTQhKLn/FrgHG1u7tX
         BaUISDTokbt5xocQP21PBxRbNYM1gP1Vi5Pbyyn4QQvS0bQXx0xgNq6rv/c1Y9bxXA56
         rpu9AIrXH/dADZ/Jgae7DFVTJpLhoIDOPXHyBtcQCUAqsfqw2xKxx/UK/53beKS1Eunc
         4PC3bibpp4H/CFQcm//EjMK95hCRzzchk4NPmGYfOu2U9SMUonsUln6ZwHbNMVq37zmA
         imsw==
X-Gm-Message-State: ABy/qLbSUaxQzY2pkN6e7iAFTCAahLeX8CrDWGrRgMeaQNTOvDCHLrY7
        vWYqFKEsFpoUyvWyI2AJi8SrRCn/9Si65aY7
X-Google-Smtp-Source: APBJJlHayJJfsOldV47YNHyZ5d0LZwWuOW5n/MCv3xvOi0lQ/O/7fD2ByPHs+n/wxi5VnVMRGo14nw==
X-Received: by 2002:a17:906:6149:b0:992:61c5:dab0 with SMTP id p9-20020a170906614900b0099261c5dab0mr1606169ejl.62.1688655221487;
        Thu, 06 Jul 2023 07:53:41 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id va25-20020a17090711d900b00992e265495csm905659ejb.212.2023.07.06.07.53.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:53:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/4] semodule_unpackage: update
Date:   Thu,  6 Jul 2023 16:53:35 +0200
Message-Id: <20230706145335.71452-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706145335.71452-1-cgzones@googlemail.com>
References: <20230706145335.71452-1-cgzones@googlemail.com>
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
v2:
address comments from Jim
  * drop exit() calls
  * reduce to one final return statement
  * drop global variable progname
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../semodule_package/semodule_unpackage.c     | 129 +++++++++++-------
 1 file changed, 77 insertions(+), 52 deletions(-)

diff --git a/semodule-utils/semodule_package/semodule_unpackage.c b/semodule-utils/semodule_package/semodule_unpackage.c
index b8c4fbce..d5b84068 100644
--- a/semodule-utils/semodule_package/semodule_unpackage.c
+++ b/semodule-utils/semodule_package/semodule_unpackage.c
@@ -11,46 +11,23 @@
 #include <fcntl.h>
 #include <errno.h>
 
-char *progname = NULL;
-extern char *optarg;
-
-static __attribute__((__noreturn__)) void usage(void)
+static void usage(const char *progname)
 {
 	printf("usage: %s ppfile modfile [fcfile]\n", progname);
-	exit(1);
-}
-
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
 }
 
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
-
-	progname = argv[0];
+	const char *ppfile, *modfile, *fcfile = NULL, *fcdata;
+	int ret;
 
 	if (argc < 3) {
-		usage();
-		exit(1);
+		usage(argv[0]);
+		return EXIT_FAILURE;
 	}
 
 	ppfile = argv[1];
@@ -58,46 +35,94 @@ int main(int argc, char **argv)
 	if (argc >= 4)
 		fcfile = argv[3];
 
-	if (file_to_policy_file(ppfile, &in, "r"))
-		exit(1);
-
 	if (sepol_module_package_create(&pkg)) {
-                fprintf(stderr, "%s:  Out of memory\n", progname);
-                exit(1);
+		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		goto failure;
 	}
 
-	if (sepol_module_package_read(pkg, in, 0) == -1) {
-                fprintf(stderr, "%s:  Error while reading policy module from %s\n",
-			progname, ppfile);
-                exit(1);
+	if (sepol_policy_file_create(&in)) {
+		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		goto failure;
 	}
 
-	if (file_to_policy_file(modfile, &out, "w"))
-		exit(1);
+	fp = fopen(ppfile, "r");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", argv[0], ppfile, strerror(errno));
+		goto failure;
+	}
+	sepol_policy_file_set_fp(in, fp);
 
-        if (sepol_policydb_write(sepol_module_package_get_policy(pkg), out)) {
-                fprintf(stderr, "%s:  Error while writing module to %s\n", progname, modfile);
-                exit(1);
-        }
+	if (sepol_module_package_read(pkg, in, 0) == -1) {
+		fprintf(stderr, "%s:  Error while reading policy module from %s\n",
+			argv[0], ppfile);
+		goto failure;
+	}
 
 	sepol_policy_file_free(in);
+	in = NULL;
+	fclose(fp);
+	fp = NULL;
+
+	if (sepol_policy_file_create(&out)) {
+		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		goto failure;
+	}
+
+	fp = fopen(modfile, "w");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", argv[0], modfile, strerror(errno));
+		goto failure;
+	}
+	sepol_policy_file_set_fp(out, fp);
+
+	if (sepol_policydb_write(sepol_module_package_get_policy(pkg), out)) {
+		fprintf(stderr, "%s:  Error while writing module to %s\n", argv[0], modfile);
+		goto failure;
+	}
+
+	ret = fclose(fp);
+	fp = NULL;
+	if (ret) {
+		fprintf(stderr, "%s:  Error while closing file %s:  %s\n", argv[0], modfile, strerror(errno));
+		goto failure;
+	}
+
 	sepol_policy_file_free(out);
+	out = NULL;
 
 	len = sepol_module_package_get_file_contexts_len(pkg);
 	if (fcfile && len) {
 		fp = fopen(fcfile, "w");
 		if (!fp) {
-			fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, strerror(errno), fcfile);
-			exit(1);
+			fprintf(stderr, "%s:  Could not open file %s:  %s\n", argv[0], fcfile, strerror(errno));
+			goto failure;
 		}
 		fcdata = sepol_module_package_get_file_contexts(pkg);
 		if (fwrite(fcdata, 1, len, fp) != len) {
-			fprintf(stderr, "%s:  Could not write file %s:  %s\n", progname, strerror(errno), fcfile);
-			exit(1);
+			fprintf(stderr, "%s:  Could not write file %s:  %s\n", argv[0], fcfile, strerror(errno));
+			goto failure;
+		}
+
+		ret = fclose(fp);
+		fp = NULL;
+		if (ret) {
+			fprintf(stderr, "%s:  Could not close file %s:  %s\n", argv[0], fcfile, strerror(errno));
+			goto failure;
 		}
-		fclose(fp);
 	}
 
+	ret = EXIT_SUCCESS;
+	goto cleanup;
+
+failure:
+	ret = EXIT_FAILURE;
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
 }
-- 
2.40.1

