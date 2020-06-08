Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03268C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4174206C3
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="UVbYb0jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgFHQT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 12:19:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA5C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 09:19:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l17so3986801qki.9
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XviiyKoghIfjRHDOebEJqU3IIRsrTJ65GSomCMGccYk=;
        b=UVbYb0jYCqgmzNLWN4gT35RscZ3Unr3/ItzJ1cbWj3gqJ9qesNqXPkNQLrLYuDxZXL
         QnXzCZt+na72C2NJzV7xKkEQ4SgtYOddrZT2lnCS11Yj1exjS67SB2DRLTjBhHzyX5nI
         Qan5fTZJYt2u7dGn6Wl5Bl49yRqN9jvQQFutfsdcpZ/fT4qiQLzfkxcUUts+yxtF33Pg
         qEwuXRHryFsixQKIYciRVHB6HO45VZvo4xlu2VUVJaO2qfZg+yJzrYeC9JKp7rBSb84N
         72uTL0I73YRdXTGvmCesbzyO3j0PjefUabPKSS72DyzBhnEX2WhlMm+3b7ODu5c6/G6O
         sH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XviiyKoghIfjRHDOebEJqU3IIRsrTJ65GSomCMGccYk=;
        b=TH71EKMO/LcX1mew22xwtjs/ex3mmA1Pbu32zWpt07FGAqqZKgrRyKRMuYZJIaSQI0
         s+2i+jFa8DiiRjB1mFloYgfBiu94bfHSwCBh6kafukiPJG4bnrtNuZyzANcdXVrHRMMO
         QY5oXZplhSdCy1A3Fp5ZG1+kidsTP12PhhwzoQm86As63vulDqp7DLkyNMJCQBQZSHZg
         Zeb4MOTbxJ6nDtcPtWxw/INTwRWnL0/WRKtajDwPrpA3BmudI8Lgxfx2FME/qxhDIRKz
         QHFilBQ+WKo7nx6TzfwcGvQTHQA7BYPF55pbRcsVpb2YVoP1YPVJrmbJOoOMjJeWv4k9
         TgdA==
X-Gm-Message-State: AOAM530b3HBcrK4DB/6OYz5GrFdhKwz9r4jpwZgODsT4aXB57Par3LNl
        u2sq7keCGT4fve5GrShpQ+mRqA0ut8I=
X-Google-Smtp-Source: ABdhPJw5wDZs4nUa24yH+nb6u3QaewBkqVs7xu9KhmAe7CtOy8sLXm1xNlI5/yqx5rLb9JFmIQ52uw==
X-Received: by 2002:a05:620a:483:: with SMTP id 3mr22191088qkr.299.1591633195019;
        Mon, 08 Jun 2020 09:19:55 -0700 (PDT)
Received: from localhost.localdomain (arpron0203w-grc-05-142-113-221-96.dsl.bell.ca. [142.113.221.96])
        by smtp.gmail.com with ESMTPSA id 207sm6770490qki.134.2020.06.08.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:19:54 -0700 (PDT)
From:   Peter Whittaker <pww@edgekeep.com>
To:     selinux@vger.kernel.org
Cc:     Peter Whittaker <pww@edgekeep.com>
Subject: [PATCH v2] Add restorecon -x option to not cross FS boundaries
Date:   Mon,  8 Jun 2020 09:20:09 -0700
Message-Id: <20200608162010.122077-1-pww@edgekeep.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes: https://github.com/SELinuxProject/selinux/issues/208

Signed-off-by: Peter Whittaker <pww@edgekeep.com>
---
 policycoreutils/setfiles/restorecon.8 |  7 +++++++
 policycoreutils/setfiles/setfiles.c   | 13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index bbfc83fe..0d1930de 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -13,6 +13,7 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-F ]
 .RB [ \-W ]
 .RB [ \-I | \-D ]
+.RB [ \-x ]
 .RB [ \-e
 .IR directory ]
 .IR pathname \ ...
@@ -31,6 +32,7 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-F ]
 .RB [ \-W ]
 .RB [ \-I | \-D ]
+.RB [ \-x ]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -153,6 +155,11 @@ option of GNU
 .B find
 produces input suitable for this mode.
 .TP
+.B \-x
+prevent
+.B restorecon
+from crossing file system boundaries.
+.TP
 .SH "ARGUMENTS"
 .IR pathname \ ...
 The pathname for the file(s) to be relabeled.
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 16bd592c..ed67b5f1 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -43,8 +43,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
-			"usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
+			"usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
+			"usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	size_t buf_len;
 	const char *base;
 	int errors = 0;
-	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0";
+	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0x";
 	const char *sopts = "c:de:f:hiIDlmno:pqr:svEFR:W0";
 	const char *opts;
 	union selinux_callback cb;
@@ -386,6 +386,13 @@ int main(int argc, char **argv)
 		case '0':
 			null_terminated = 1;
 			break;
+                case 'x':
+                        if (iamrestorecon) {
+				r_opts.xdev = SELINUX_RESTORECON_XDEV;
+                        } else {
+				usage(argv[0]);
+                        }
+                        break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
-- 
2.26.2

