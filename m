Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E00C47080
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiDEVl3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383127AbiDEPOk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 11:14:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB30C17584D
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 06:26:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so26688872ejd.5
        for <selinux@vger.kernel.org>; Tue, 05 Apr 2022 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GEzap0/9F5oXhEiX19oOnrbM44NUaH+4hANHPd1nDm0=;
        b=KAOoge+Ggkr4+qyfER7sKOGc9Lioljo9BSMg/JrcV2qqKVvzjzV0H2uKi7SgkwfqQb
         6c1IqHQvBwXhFLmb/S3a4WEycN72mVxY9ikwYixsmrpQPuVt9IJnkEd5xLHM+VjmU9ir
         8a9XaLQnZCW87U9dDmR6+xMqOqRyxfC2Ro7JOsKkH3OAmzCk+uaNofgyOvSrpWS6vFa9
         HUIShUg5aqR/KG0aErUOzm9eRHy0j1GLnvhn+j7LuXuIkg8t6jFe6hBYaFHFM6oVuU3p
         7HnacA/TjcKBfksDd8lsVEM6v/o8UY2OhDMme+Ofo390EWCyUf04YOe9ulv0TgYKrM8E
         vn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEzap0/9F5oXhEiX19oOnrbM44NUaH+4hANHPd1nDm0=;
        b=i+PkHl1Z8/nWMPuArrSoxtBGiBB38bpNhhfshWNLgMighex0utRVTH7o7M03Sz5CEl
         o1lPKZkM+GSj+qhIl5TYMTMTLg9uYpcHHzARFFyhbMQAv2qEOQs41RJGAPOB8b5p6Xld
         Eyn60TwZNSe9VsdJH5s3hIBIKgPTbPzDr18mBYbVMs1u82UmIlllXga09bV5K3gThtxb
         Ga2uE1rrwee22fGIYijN5sKajcAXy/O6EDHzonZTmpJVBfRYYK33ORaG45EuB9QgH3jS
         vXuIx9mdBouXe3T+3r0YFtpmGPBpDn6wt8UEADiH/qUjI1s5NReDnbJCwrm+EUGpopsC
         pxbg==
X-Gm-Message-State: AOAM530qLzdPHVcO2SLvKcplRDIB/b1bfhuwzDxNZUZhG6WD9P4aJzx4
        yrpDoI/O1feWjgAeq+oksg2zjaCgNIE=
X-Google-Smtp-Source: ABdhPJxL3X5TNZwldWm4bdj3/DsYCB3xLBnoj8aDau2Sa4OE8zy1/+ZN08DlDHOIK7NQPtJalLI7Mg==
X-Received: by 2002:a17:907:7f8d:b0:6da:b3d6:a427 with SMTP id qk13-20020a1709077f8d00b006dab3d6a427mr3444310ejc.509.1649165197027;
        Tue, 05 Apr 2022 06:26:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-134-094.77.8.pool.telefonica.de. [77.8.134.94])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709062a9a00b006e7ee7ad20bsm2769901eje.149.2022.04.05.06.26.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:26:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux/utils: check for valid contexts to improve error causes
Date:   Tue,  5 Apr 2022 15:26:30 +0200
Message-Id: <20220405132630.47946-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331144653.31178-1-cgzones@googlemail.com>
References: <20220331144653.31178-1-cgzones@googlemail.com>
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
v2:
   check new context in validatetrans
---
 libselinux/utils/compute_av.c      | 10 ++++++++++
 libselinux/utils/compute_create.c  | 12 +++++++++++-
 libselinux/utils/compute_member.c  | 12 +++++++++++-
 libselinux/utils/compute_relabel.c | 10 ++++++++++
 libselinux/utils/getdefaultcon.c   |  5 +++++
 libselinux/utils/selinuxexeccon.c  |  6 +++++-
 libselinux/utils/validatetrans.c   | 15 +++++++++++++++
 7 files changed, 67 insertions(+), 3 deletions(-)

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
index 1db33e66..9d642a93 100644
--- a/libselinux/utils/validatetrans.c
+++ b/libselinux/utils/validatetrans.c
@@ -17,12 +17,27 @@ int main(int argc, char **argv)
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
 		exit(2);
 	}
 
+	if (security_check_context(argv[4])) {
+		fprintf(stderr, "%s:  invalid new context '%s'\n", argv[0], argv[4]);
+		exit(6);
+	}
+
 	ret = security_validatetrans(argv[1], argv[2], tclass, argv[4]);
 	printf("security_validatetrans returned %d errno: %s\n", ret, strerror(errno));
 
-- 
2.35.1

