Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D76C433EF
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiCaOst (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiCaOss (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:48:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2486F21FC64
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:47:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b15so28466410edn.4
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qlcg3DY7lauRAl2+ODnl91XkXEWGqzXxiuDrwfV5B20=;
        b=mHAZGnQ/EZw4ZLOjNB0khRpvD4zSI7RNaZk9khaWkVv15u3GeKzNtuCpkBjm9bi22B
         wXgoTXdPCT2U3JPhfZgSsCuJkc16PajYU76P/PANju2nuPETbLbAikHeWfne3LEgfEHL
         Me/u4+GRI1dmMx5yyjioDhiOrrc2HCCq1ZBSRnYNI272nz/I5Mh1Hsgqh2DxgKSSy0zp
         z3QpCBAXIT3aXirEswv+ewmfkMc7WFYIPkrpkWVr6hkJD6ILcSRao31EMGm2zMDmEi9N
         migbD283vQUlUro2gRGByKNWdQJyNOPfWRXsd0fxa3ZJ8rGUz0M0EwWR2/rctRfFs6iV
         4jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qlcg3DY7lauRAl2+ODnl91XkXEWGqzXxiuDrwfV5B20=;
        b=sfKYmfSignnRPWqWLM0kAgmD2RrGV/Fs73sNNmYlnEG594dgEOnHqxTsOwiu/fi/D+
         fdFsodcJHZpqb2/s4fLW4rA9ThXsKCMGUQImbTm3lwieq7YrGQtRYlZZQT+NtjiF1ata
         aP28d609KGNIFQ3ucX3J3UUtqFz3jqJtwvYamsyLAklp/vkiiMF0X0VaO+MMnI4gsYB4
         ADHuM4KfPFzieFqXGQdAe5XApM5zshGrvidsI5FJCkBXRmy5xvnLvD5OkjIgFFa815oL
         czZGt9694FfpTV+DEGkoo7fRZuPyy5eeQq+FoYz5Z8F2svsIj6OQKIT12+5/YuYu5UXv
         Szng==
X-Gm-Message-State: AOAM5303C0rRwtDsLEXMwQjHG3dOFLI+m8PT4R8LpDx7D1ufm5ajAQSk
        NWhupilRLWz2f9XfHCwK23PcLzrUoDc=
X-Google-Smtp-Source: ABdhPJziLAzmkF+zwtNO+TS58eK0Vj9UxttYh8NK+NLP6l11n+O07hNqL8eCG0K9VsdHsEjoO0SDeg==
X-Received: by 2002:a05:6402:438b:b0:41b:5212:1de1 with SMTP id o11-20020a056402438b00b0041b52121de1mr15763278edc.384.1648738018567;
        Thu, 31 Mar 2022 07:46:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id pk9-20020a170906d7a900b006e05b7ce40csm9408275ejb.221.2022.03.31.07.46.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:46:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux/utils: check for valid contexts to improve error causes
Date:   Thu, 31 Mar 2022 16:46:53 +0200
Message-Id: <20220331144653.31178-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return more detailed error messages when the supplied contexts are
invalid.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/compute_av.c      | 10 ++++++++++
 libselinux/utils/compute_create.c  | 12 +++++++++++-
 libselinux/utils/compute_member.c  | 12 +++++++++++-
 libselinux/utils/compute_relabel.c | 10 ++++++++++
 libselinux/utils/getdefaultcon.c   |  5 +++++
 libselinux/utils/selinuxexeccon.c  |  6 +++++-
 libselinux/utils/validatetrans.c   | 10 ++++++++++
 7 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.c
index df4a77e8..ef08338f 100644
--- a/libselinux/utils/compute_av.c
+++ b/libselinux/utils/compute_av.c
@@ -17,6 +17,16 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (security_check_context(argv[1])) {
+		fprintf(stderr, "%s:  invalid source context '%s'\n", argv[0], argv[1]);
+		exit(4);
+	}
+
+	if (security_check_context(argv[2])) {
+		fprintf(stderr, "%s:  invalid target context '%s'\n", argv[0], argv[2]);
+		exit(5);
+	}
+
 	tclass = string_to_security_class(argv[3]);
 	if (!tclass) {
 		fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute_create.c
index 449ccd90..63029c19 100644
--- a/libselinux/utils/compute_create.c
+++ b/libselinux/utils/compute_create.c
@@ -17,9 +17,19 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (security_check_context(argv[1])) {
+		fprintf(stderr, "%s:  invalid source context '%s'\n", argv[0], argv[1]);
+		exit(4);
+	}
+
+	if (security_check_context(argv[2])) {
+		fprintf(stderr, "%s:  invalid target context '%s'\n", argv[0], argv[2]);
+		exit(5);
+	}
+
 	tclass = string_to_security_class(argv[3]);
 	if (!tclass) {
-		fprintf(stderr, "Invalid class '%s'\n", argv[3]);
+		fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
 		exit(2);
 	}
 
diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compute_member.c
index c6dad19e..1ef47c25 100644
--- a/libselinux/utils/compute_member.c
+++ b/libselinux/utils/compute_member.c
@@ -17,9 +17,19 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (security_check_context(argv[1])) {
+		fprintf(stderr, "%s:  invalid source context '%s'\n", argv[0], argv[1]);
+		exit(4);
+	}
+
+	if (security_check_context(argv[2])) {
+		fprintf(stderr, "%s:  invalid target context '%s'\n", argv[0], argv[2]);
+		exit(5);
+	}
+
 	tclass = string_to_security_class(argv[3]);
 	if (!tclass) {
-		fprintf(stderr, "Invalid class '%s'\n", argv[3]);
+		fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
 		exit(2);
 	}
 
diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/compute_relabel.c
index 85c760bc..f6a957da 100644
--- a/libselinux/utils/compute_relabel.c
+++ b/libselinux/utils/compute_relabel.c
@@ -17,6 +17,16 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (security_check_context(argv[1])) {
+		fprintf(stderr, "%s:  invalid source context '%s'\n", argv[0], argv[1]);
+		exit(4);
+	}
+
+	if (security_check_context(argv[2])) {
+		fprintf(stderr, "%s:  invalid target context '%s'\n", argv[0], argv[2]);
+		exit(5);
+	}
+
 	tclass = string_to_security_class(argv[3]);
 	if (!tclass) {
 		fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 957c1cb2..590e98d9 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -68,6 +68,11 @@ int main(int argc, char **argv)
 	} else
 		cur_context = argv[optind + 1];
 
+	if (security_check_context(cur_context)) {
+		fprintf(stderr, "%s:  invalid from context '%s'\n", argv[0], cur_context);
+		return 3;
+	}
+
 	if ((ret = getseuser(user, service, &seuser, &dlevel)) == 0) {
 		if (! level) level=dlevel;
 		if (role != NULL && role[0]) 
diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinuxexeccon.c
index b50e7886..66754b6a 100644
--- a/libselinux/utils/selinuxexeccon.c
+++ b/libselinux/utils/selinuxexeccon.c
@@ -16,7 +16,7 @@ static __attribute__ ((__noreturn__)) void usage(const char *name, const char *d
 	exit(rc);
 }
 
-static char * get_selinux_proc_context(const char *command, char * execcon) {
+static char * get_selinux_proc_context(const char *command, const char * execcon) {
 	char * fcon = NULL, *newcon = NULL;
 
 	int ret = getfilecon(command, &fcon);
@@ -43,6 +43,10 @@ int main(int argc, char **argv)
 		}
 	} else {
 		con = strdup(argv[2]);
+		if (security_check_context(con)) {
+			fprintf(stderr, "%s:  invalid from context '%s'\n", argv[0], con);
+			return -1;
+		}
 	}
 
 	proccon = get_selinux_proc_context(argv[1], con);
diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/validatetrans.c
index 1db33e66..9aa03e62 100644
--- a/libselinux/utils/validatetrans.c
+++ b/libselinux/utils/validatetrans.c
@@ -17,6 +17,16 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (security_check_context(argv[1])) {
+		fprintf(stderr, "%s:  invalid source context '%s'\n", argv[0], argv[1]);
+		exit(4);
+	}
+
+	if (security_check_context(argv[2])) {
+		fprintf(stderr, "%s:  invalid target context '%s'\n", argv[0], argv[2]);
+		exit(5);
+	}
+
 	tclass = string_to_security_class(argv[3]);
 	if (!tclass) {
 		fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
-- 
2.35.1

