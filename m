Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC9EC433EF
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 17:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiD1RZt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbiD1RZr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 13:25:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD085BD39
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 10:22:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so10941847ejw.1
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lP7jSxzwJFxP7qTqUwyhijHQrQPoPLEBhpWzJn4tphg=;
        b=N3W6Bh1kPjAC22pn4+SCIIfBsRic8HrXISqs7l6quWXHKZZ2RdJHIKeHvQsrLl3roQ
         LdNMZYwlX0FovVQtxwaqj5aGBUl3H1OyxTpS5OQrGoGy6dYHd6ACQks1YEcpEWcuG+Hk
         B0ZKCKCcuCeu2Fv/Haq5Qzzxb9vKirRaJP1mqkj70dMmG3poBsLNsy/JSM/03LIb4ACv
         OVCMiNQbmVmHSrqfdmH4+GfICfPLBZ5UtJo55t/m4olsVI+YI+E32OirEfA1qE7CradO
         9qpbmqvuAaXCKNB6JQedl4D8Z4aOVHJrUwWwTM/yYD3iqoqzCSNqHwtwTgYlCs9sACUR
         5CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lP7jSxzwJFxP7qTqUwyhijHQrQPoPLEBhpWzJn4tphg=;
        b=6CCz64UA7Xe8P6H62HZJAZAHY/Y9fvvFl6NI5A/4JQFp/z2T2XjmgP8FHFuJm8fELV
         /WXqe38F7iH83ZAPehhQ6rNuKgoptEK2HpVrIGFfQIUzGVN+ERwujiFX1474BObSnpcb
         TxB/WTQQu7RE/uwHMsriBKll3UOrcY4yPpgeWK2BZpB3YByBnN0r/aOi987Pl5rFEKeR
         4Sbl6IVIRCknmGkHjeqNpxpxuc9ZIUblBgcaSYWeIElIwNasOCxGrfvqB5HSdNuVK7Ei
         NvjO2powWdSUOZON5iC/S0fMblp5tdI1hcvbVYLV7ZdiHopGnOqbSqGilW1OYCvmlaNB
         jgyA==
X-Gm-Message-State: AOAM532MEf593A5XdcFXtSOAyCC7UjHrKsxZO580pFBzCpkrN4OLrj3D
        cZWcweFRgM2lh41U3qMXCNpT27ycuZc=
X-Google-Smtp-Source: ABdhPJwInwzjVseuQ5TztVmlEInFPmfG3b4OA9nT5yZ8n2NOxV0Jc7ZP/4Mzxzz7+73Sry8LFcNnUA==
X-Received: by 2002:a17:907:6d9d:b0:6da:7d4c:287f with SMTP id sb29-20020a1709076d9d00b006da7d4c287fmr31814245ejc.741.1651166551131;
        Thu, 28 Apr 2022 10:22:31 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-010-136-150.77.10.pool.telefonica.de. [77.10.136.150])
        by smtp.gmail.com with ESMTPSA id ci21-20020a170906c35500b006f394323ccesm215301ejb.34.2022.04.28.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:22:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux/utils/getsebool: add options to display en-/disabled booleans
Date:   Thu, 28 Apr 2022 19:22:19 +0200
Message-Id: <20220428172219.28520-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add command line options to getsebool(8) to display either all enabled
or all disabled booleans.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man8/getsebool.8 |  8 +++++++-
 libselinux/utils/getsebool.c    | 36 +++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/libselinux/man/man8/getsebool.8 b/libselinux/man/man8/getsebool.8
index d70bf1e4..d8356d36 100644
--- a/libselinux/man/man8/getsebool.8
+++ b/libselinux/man/man8/getsebool.8
@@ -4,7 +4,7 @@ getsebool \- get SELinux boolean value(s)
 .
 .SH "SYNOPSIS"
 .B getsebool
-.RB [ \-a ]
+.RB [ \-a | \-0 | \-1 ]
 .RI [ boolean ]
 .
 .SH "DESCRIPTION"
@@ -26,6 +26,12 @@ their pending values as desired and then committing once.
 .TP
 .B \-a
 Show all SELinux booleans.
+.TP
+.B \-0
+Show all disabled SELinux booleans.
+.TP
+.B \-1
+Show all enabled SELinux booleans.
 .
 .SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/libselinux/utils/getsebool.c b/libselinux/utils/getsebool.c
index 36994536..7fb0b58b 100644
--- a/libselinux/utils/getsebool.c
+++ b/libselinux/utils/getsebool.c
@@ -6,21 +6,31 @@
 #include <string.h>
 #include <selinux/selinux.h>
 
+enum list_mode {
+	SPECIFIED,
+	ALL,
+	DISABLED,
+	ENABLED,
+};
+
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
-	fprintf(stderr, "usage:  %s -a or %s boolean...\n", progname, progname);
+	fprintf(stderr, "usage:  %s [-a|-0|-1] or %s boolean...\n", progname, progname);
 	exit(1);
 }
 
 int main(int argc, char **argv)
 {
-	int i, get_all = 0, rc = 0, active, pending, len = 0, opt;
+	int i, rc = 0, active, pending, len = 0, opt;
+	enum list_mode mode = SPECIFIED;
 	char **names = NULL;
 
-	while ((opt = getopt(argc, argv, "a")) > 0) {
+	while ((opt = getopt(argc, argv, "a01")) > 0) {
 		switch (opt) {
 		case 'a':
-			if (argc > 2)
+		case '0':
+		case '1':
+			if (argc > 2 || mode != SPECIFIED)
 				usage(argv[0]);
 			if (is_selinux_enabled() <= 0) {
 				fprintf(stderr, "%s:  SELinux is disabled\n",
@@ -39,7 +49,17 @@ int main(int argc, char **argv)
 				printf("No booleans\n");
 				return 0;
 			}
-			get_all = 1;
+			switch (opt) {
+			case 'a':
+				mode = ALL;
+				break;
+			case '0':
+				mode = DISABLED;
+				break;
+			case '1':
+				mode = ENABLED;
+				break;
+			}
 			break;
 		default:
 			usage(argv[0]);
@@ -74,7 +94,7 @@ int main(int argc, char **argv)
 	for (i = 0; i < len; i++) {
 		active = security_get_boolean_active(names[i]);
 		if (active < 0) {
-			if (get_all && errno == EACCES) 
+			if (mode != SPECIFIED && errno == EACCES)
 				continue;
 			fprintf(stderr, "Error getting active value for %s\n",
 				names[i]);
@@ -88,6 +108,10 @@ int main(int argc, char **argv)
 			rc = -1;
 			goto out;
 		}
+		if ((mode == ENABLED  && active == 0 && pending == 0) ||
+		    (mode == DISABLED && active == 1 && pending == 1)) {
+			continue;
+		}
 		char *alt_name = selinux_boolean_sub(names[i]);
 		if (! alt_name) {
 			perror("Out of memory\n");
-- 
2.36.0

