Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C8AC433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09817207FB
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="gYDbFAer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEZRDq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgEZRDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 13:03:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CAC03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 10:03:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p12so16688679qtn.13
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqFus1keyaqsK40IBcrk5tnW1jTEdZRKOqzvDB9ovqY=;
        b=gYDbFAerj8+3vKSlIlrJ1kCGLDEZRYTMdTzMZgiErzjp+gQ7Fhn7cHmvclcs8xhAAd
         ckDzToe1SDuLeFNg6t2JWV4/cFbkZ1xOgI6xFV85kruTt7CBGiVDnW9HufzLGm1mCviH
         Fat6uotwyHSDB0EuKrKW5WD59eqvZYhTswZ1U4/BTRWuj1zKPPOqFi2DPxxI8kL3dtZm
         S4bbfV2bVuNDYaLyp8AlMV/2a5RUtpkNeT6a9dIJcUtEfxTf8fyRN8tITs7SW4d5dmcg
         5nKmX/7o6o7UCICGEz3RSRt7yCnH+GhtzxhIyHZNns1Ii7/HOX0JtqinDMrJmoP35IPD
         0GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqFus1keyaqsK40IBcrk5tnW1jTEdZRKOqzvDB9ovqY=;
        b=MEIVNLa7MLgS6fRUjwTtVl5WExAwUefj0xxAuW6PThisLFR0pKRfxq/+58mTUHJZ9u
         S++gxso5fdXa+QlrjYCdLxQT7YVP3rHMBlFtrQl/vk0taA/InKXsfDjUtZOYORuGc67E
         0BTRSJozdha4ds0kHDF2FJvq4i6UvHArvUtlSdNxH+JbYn4SnOfdKP1jMB/kkRhjZd2r
         U5D5rtQ6YDCjeCw2VPD2z+UQpWCQ/7I/zCFS8QDXVwHQ0XMNjsWVsiQeSUOfupagTbbq
         AFVb15lrzT4fGrM7ExSb7UazOrWc7eE7RfB8c6Amfod+ELt3LkdWjlDjToYxcFdryXXy
         c/2A==
X-Gm-Message-State: AOAM532i0S82jMFOBARx0Un3F16jPDgP0S3uGj970mzqf8ecA6V4jUlQ
        93BE1/6Wnm4of66wIaKA5QYm81J4gDc=
X-Google-Smtp-Source: ABdhPJwwKwSRVh/i0hWv6jioyNn/4qPB4aNq5vNrlWT2XbnYYHz7Cu09EmZGAiV9MY+94yyg/AjzZw==
X-Received: by 2002:ac8:43ce:: with SMTP id w14mr2204031qtn.42.1590512623185;
        Tue, 26 May 2020 10:03:43 -0700 (PDT)
Received: from localhost.localdomain (arpron0203w-grc-01-70-49-249-103.dsl.bell.ca. [70.49.249.103])
        by smtp.gmail.com with ESMTPSA id n63sm141645qkn.104.2020.05.26.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:03:42 -0700 (PDT)
From:   Peter Whittaker <pww@edgekeep.com>
To:     selinux@vger.kernel.org
Cc:     Peter Whittaker <pww@edgekeep.com>
Subject: [PATCH] Add restorecon -x opt to not cross FS boundaries (cf github #208)
Date:   Tue, 26 May 2020 13:02:17 -0400
Message-Id: <20200526170217.32966-1-pww@edgekeep.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Folks, this patch adds and documents a "-x" option for restorecon
to prevent it from crossing file system boundaries, as requested
in github issue #208.

P

Signed-off-by: Peter Whittaker <pww@edgekeep.com>
---
 policycoreutils/setfiles/restorecon.8 |  7 +++++++
 policycoreutils/setfiles/setfiles.c   | 11 +++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

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
index 16bd592c..afd579e3 100644
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
2.20.1

