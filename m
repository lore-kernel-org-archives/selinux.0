Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F245C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKIUJy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKIUJx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 15:09:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36412AC0
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 12:09:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id 13so49982269ejn.3
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G28Wq5r7lgIxHleW9iOgrQewl6BMYxNWJrQnl86zz9Y=;
        b=f357tF30k5sSsNLO3fLQm4YCAuyS/LEhlIWunVdomyyRq5myNJdJ5QlBNEUQc/p4q7
         3SE8SrRpwfaO+i7MiqkyQXtCCWXlAyFKKLB0v7j4R+Ju+H7wHakckcoV0nApIHHZLkOV
         BgY7SFrsg3ELyAg8DqoP7f9qf5I+3iDO4+tKu3+gDQbL1PCdpitbHmwf2SewmCdAoYBc
         l31eon0WabU+jnX1NA41Vpsx+/IHVIF+Q5rCxFw8pRJyaoUSNRR9rJ3s3Jci0ZkuCZxf
         reeIhl0H+KfMMYZtVKQNDGlXmG+/HjbORIaby5kj+xFpH6AX5Fw4MFIsVK0HP7snMsil
         fNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G28Wq5r7lgIxHleW9iOgrQewl6BMYxNWJrQnl86zz9Y=;
        b=LFhIF6zvwWH9zQb1WmdZpaZv4jXBrcAGewkmu/ZNZeDmDOWNLNt3dBgaV8+msCBomw
         3XAMRpZNFQUjM0TsK1wTg9ClTEBIbItpifM6kKbTbiei8i1DOP0+7S4vBgPxzVhi4yVk
         EfzbiIn6Dqvbq1jfHxe3ikCaPBhy/EEboOd60y6LeJewmibMCdEZKeKEFt78xMOSH73n
         YQhPL0WTF78j9Fa0Dpt0f2G7wblzFBNIxCOSOguknnZvd++XVSRBC9v8vYwL2bNG48qF
         C+A64gb0PHw30jMZdM10XxV9BUXiOi9bmSPTwFFpys2jAQc2Vh8Xr1esKTKfQMAoQPZj
         UvpQ==
X-Gm-Message-State: ACrzQf1APNXBAkqVpjQhAgiIDt2Fh9Vep9u8dC/7vECCpw8fXumg/V96
        34xNTYXEFhsQ2k2Qfs9JYRe95kw/tdQ=
X-Google-Smtp-Source: AMsMyM7SohpInpGJ/yxbOyKiuqXn3fhtn5B3hMS3Htn7CdMbSi9fXRpLIFTaizbfES/NaC+QbM4utQ==
X-Received: by 2002:a17:906:5a4b:b0:7ad:ba84:faf0 with SMTP id my11-20020a1709065a4b00b007adba84faf0mr54278167ejc.753.1668024587150;
        Wed, 09 Nov 2022 12:09:47 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b007adbd01c566sm6386115ejf.146.2022.11.09.12.09.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:09:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] checkpolicy: simplify string copying
Date:   Wed,  9 Nov 2022 21:09:38 +0100
Message-Id: <20221109200939.62525-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109200939.62525-1-cgzones@googlemail.com>
References: <20221109200939.62525-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use strdup(3) instead of allocating memory and then manually copying the
content.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c   | 10 ++++------
 checkpolicy/policy_define.c |  3 +--
 checkpolicy/test/dispol.c   |  5 ++---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 926ce72c..48c31261 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -1148,12 +1148,11 @@ int main(int argc, char **argv)
 			FGETS(ans, sizeof(ans), stdin);
 			ans[strlen(ans) - 1] = 0;
 
-			name = malloc((strlen(ans) + 1) * sizeof(char));
+			name = strdup(ans);
 			if (name == NULL) {
-				fprintf(stderr, "couldn't malloc string.\n");
+				fprintf(stderr, "couldn't strdup string.\n");
 				break;
 			}
-			strcpy(name, ans);
 
 			printf("state? ");
 			FGETS(ans, sizeof(ans), stdin);
@@ -1296,12 +1295,11 @@ int main(int argc, char **argv)
 			FGETS(ans, sizeof(ans), stdin);
 			ans[strlen(ans) - 1] = 0;
 
-			name = malloc((strlen(ans) + 1) * sizeof(char));
+			name = strdup(ans);
 			if (!name) {
-				fprintf(stderr, "couldn't malloc string.\n");
+				fprintf(stderr, "couldn't strdup string.\n");
 				break;
 			}
-			strcpy(name, ans);
 
 			printf("port? ");
 			FGETS(ans, sizeof(ans), stdin);
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 54bb304b..41e44631 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -117,12 +117,11 @@ int insert_id(const char *id, int push)
 	char *newid = 0;
 	int error;
 
-	newid = (char *)malloc(strlen(id) + 1);
+	newid = strdup(id);
 	if (!newid) {
 		yyerror("out of memory");
 		return -1;
 	}
-	strcpy(newid, id);
 	if (push)
 		error = queue_push(id_queue, (queue_element_t) newid);
 	else
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 8ddefb04..36a3362c 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -486,12 +486,11 @@ int main(int argc, char **argv)
 			}
 			ans[strlen(ans) - 1] = 0;
 
-			name = malloc((strlen(ans) + 1) * sizeof(char));
+			name = strdup(ans);
 			if (name == NULL) {
-				fprintf(stderr, "couldn't malloc string.\n");
+				fprintf(stderr, "couldn't strdup string.\n");
 				break;
 			}
-			strcpy(name, ans);
 
 			printf("state? ");
 			if (fgets(ans, sizeof(ans), stdin) == NULL) {
-- 
2.38.1

