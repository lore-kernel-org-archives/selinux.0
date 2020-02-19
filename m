Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D619AC34056
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A649624654
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 20:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZxQL7gMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSU1u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:27:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSU1u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 15:27:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so2082390wrw.8
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 12:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZF99zcCR4fAD3fPERxmS3huqCPsl8Pvmh7DBcLnWN4=;
        b=ZxQL7gMPW8PQ3x1hpH2czCxRf2eQqO6CzajXunDfCAIIUNdawl1kk9JRGG59YwvZdj
         oOUGvXSk9PETGnTxGtn++Zdxjdw65cYQmQsJPVDOqQLr+jhCkRtk06TM9AQTtTJXj/3I
         G2ItwMo2Qfku4YH8jRX0HFRRLl47rm+xmq/rOL8gXVjCafHfkBxMXI7y55EhC6cYZqBi
         aiBySAnAIAi+7hxUevvqBX+CXnS4HbLVA0LF2z05YNE0vcn9huKk+pQRH2HfyPgfj+N4
         AN8x17d+ct3EihjYi9/CX8TR5DJthtbLJ4wCR06eWqr3YaPd4MSQWGhJ6uGX+iz0S9Ym
         Jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZF99zcCR4fAD3fPERxmS3huqCPsl8Pvmh7DBcLnWN4=;
        b=lmKfYOYDvVuCn7I1ukzdCwiP+1FRgkxbUBOJK0BAxiR3W6Tgw+fBYH/3Jv5Vbj5IKA
         JFYhBeAJ/bBSmi4LlSaxkIm3OCqfM9ivkiitXWxSycpqwVjpflLQrV9w0RWGCzHZ4ERD
         bMyCOApO7RJTRGtPqWJpmFsNVVWS6AEIVrfIcrHtQa9JeNZqxpfBHQ7ICw6pYML7DtUC
         S9c5YCv6V+Ns3wXKCUlTSUxX8H7mM50Qjr30uIgpI9jJ6UvIJ4mILfeTst2zMawgtqyS
         9oV68o+EeUokKaWD2dhFfz+0lbeEV5SUFie9xsJSMj8F6fjsl4j0DYPpkBVhYTLAvwXc
         tgHg==
X-Gm-Message-State: APjAAAXvoEmZb+LvDmXZ5IgGwP4SGezkLmwQseHA7bnbHaxXsChVOFhD
        hyXbcOZSNkVlHe6Uj+slVtPu0tr4
X-Google-Smtp-Source: APXvYqyb3x+wBKjJ/UVXqAbqiGPWuHqsrGpduUzjCLLsXDGyYrt34mlEmp9I40MwvplF4DaiNfSbzA==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr37905891wrn.61.1582144066714;
        Wed, 19 Feb 2020 12:27:46 -0800 (PST)
Received: from desktopdebian.localdomain (x4d036072.dyn.telefonica.de. [77.3.96.114])
        by smtp.gmail.com with ESMTPSA id b10sm1160026wrw.61.2020.02.19.12.27.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:27:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux/getconlist: add verbose switch to print more information
Date:   Wed, 19 Feb 2020 21:27:37 +0100
Message-Id: <20200219202737.18524-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getconlist.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 29c16640..8841c96f 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -11,7 +11,7 @@
 
 static __attribute__ ((__noreturn__)) void usage(const char *name, const char *detail, int rc)
 {
-	fprintf(stderr, "usage:  %s [-l level] user [context]\n", name);
+	fprintf(stderr, "usage:  %s [-l level] user [context] [-v]\n", name);
 	if (detail)
 		fprintf(stderr, "%s:  %s\n", name, detail);
 	exit(rc);
@@ -21,9 +21,9 @@ int main(int argc, char **argv)
 {
 	char **list, *cur_context = NULL;
 	char *user = NULL, *level = NULL;
-	int ret, i, opt;
+	int ret, i, opt, verbose = 0;
 
-	while ((opt = getopt(argc, argv, "l:")) > 0) {
+	while ((opt = getopt(argc, argv, "l:v")) > 0) {
 		switch (opt) {
 		case 'l':
 			level = strdup(optarg);
@@ -33,6 +33,9 @@ int main(int argc, char **argv)
 				return 3;
 			}
 			break;
+		case 'v':
+			verbose = 1;
+			break;
 		default:
 			usage(argv[0], "invalid option", 1);
 		}
@@ -58,8 +61,16 @@ int main(int argc, char **argv)
 			free(level);
 			return 2;
 		}
-	} else
+	} else {
 		cur_context = argv[optind + 1];
+		if (verbose) {
+			if (security_check_context(cur_context) != 0) {
+				fprintf(stderr, "Given context '%s' is invalid.\n", cur_context);
+				free(level);
+				return 3;
+			}
+		}
+	}
 
 	/* Get the list and print it */
 	if (level)
@@ -72,6 +83,12 @@ int main(int argc, char **argv)
 		for (i = 0; list[i]; i++)
 			puts(list[i]);
 		freeconary(list);
+
+		if (ret == 0 && verbose)
+			fprintf(stderr, "No valid contexts found.\n");
+	} else {
+		if (verbose)
+			fprintf(stderr, "get_ordered_context_list%s failed.\n", level ? "_with_level" : "");
 	}
 
 	free(level);
-- 
2.25.1

