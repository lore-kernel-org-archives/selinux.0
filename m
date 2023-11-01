Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43976C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjKAQiJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQiJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:38:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89E10C
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:38:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9cf83c044b7so978574866b.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856680; x=1699461480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NrVX1rT/+N1kltIEl1Aly/v2iMzXV2g51rU9ugrCuE=;
        b=Q0imGyr4vNbwGPp9sUqjIE12z45x+wcOHxbTcczuntbIv/QtqGjRvt9ceSRYQZQerk
         pTaRYWNQLO2okUQ/f2AhhguPcWZemrRx5HXwhN2OSfHoV1yNh0GQL4r3T9km/49imnun
         kgIJrKpSoDT4sheoCTiPWp+ClyifNVY6ljSS48Mb2wM+mSrFO9rxYz6I65vaMeMq6lNF
         i65rKT+C8vnzCErV+rspA/Jt6mGxAV0DeCCi/iZHJoWSq/o63VrNlIbe6tcB9G+Yvd4u
         7P3lH/gfqiiWqAtJieObGH5VyM26AdCM+w1lHouO6Mo2lV78veL5gqAeb5P7v/4wxVPH
         +gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856680; x=1699461480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NrVX1rT/+N1kltIEl1Aly/v2iMzXV2g51rU9ugrCuE=;
        b=CuGRRTsu0gxsVYYF77TH2mqy7xWuLuy4l2luDQuNdwz2l/Sl2s7zDdqiQnu7DjaOPv
         ntUQkk2m7sFWK7v0ccOT1vE0IqfEqV3kkpCdkXcKErh13Y1MYPcw+GeMj2Sfcz2F37+P
         yYDJtfxeKYhTExv5D8tPIEuldTg1HL0/UI+x/SN7SumoemZozJ3EMGDKrH3d4duHg1ZE
         /CtNTkb7aYaabNQN4ydmMlQlono9vRM/eNspvoM2YKpKJa5EA7q7lc3p2G33ZvOTdSWN
         9s7rv/XcdJtc+OaIu+FBu7yIakwc7Zm17eezx2H6JsUm3eAigrAZ/RpCKYtHycVd9u96
         QhTQ==
X-Gm-Message-State: AOJu0Yw+WtXJNKMe1ETUuR7j7hHAWxR3Ga7McQeq7DtNWEcpVot9YQYz
        XQGLbuE2om/BC9zaBUb6/GB9IPi+nyA=
X-Google-Smtp-Source: AGHT+IHoTaeQIBu8zjS+T87M/f1r8thjeNdzdEo7ZLRjd12KA20SPLe77yGkXbRWtUWSmKNx1JDrmw==
X-Received: by 2002:a17:907:3181:b0:9d2:b968:9ddf with SMTP id xe1-20020a170907318100b009d2b9689ddfmr2524209ejb.25.1698856679927;
        Wed, 01 Nov 2023 09:37:59 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906684800b00993a37aebc5sm121531ejs.50.2023.11.01.09.37.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:37:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux/utils: update getdefaultcon
Date:   Wed,  1 Nov 2023 17:37:54 +0100
Message-ID: <20231101163754.177452-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* mention -r <role> and -v command line options in usage string
* use distinct error messages on getseuser(3) and
  get_default_context_with_[role]level(3) failure
* always print program name on error
* drop unnecessary double parenthesis

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getdefaultcon.c | 40 ++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 93102e5e..50f1ea91 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -11,7 +11,7 @@
 
 static __attribute__ ((__noreturn__)) void usage(const char *name, const char *detail, int rc)
 {
-	fprintf(stderr, "usage:  %s [-l level] [-s service] user [fromcon]\n", name);
+	fprintf(stderr, "usage:  %s [-r role] [-l level] [-s service] [-v] user [fromcon]\n", name);
 	if (detail)
 		fprintf(stderr, "%s:  %s\n", name, detail);
 	exit(rc);
@@ -60,9 +60,9 @@ int main(int argc, char **argv)
 	user = argv[optind];
 
 	/* If a context wasn't passed, use the current context. */
-	if (((argc - optind) < 2)) {
+	if ((argc - optind) < 2) {
 		if (getcon(&cur_context) < 0) {
-			fprintf(stderr, "Couldn't get current context:  %s\n", strerror(errno));
+			fprintf(stderr, "%s:  couldn't get current context:  %s\n", argv[0], strerror(errno));
 			return 2;
 		}
 	} else
@@ -73,23 +73,29 @@ int main(int argc, char **argv)
 		return 3;
 	}
 
-	if ((ret = getseuser(user, service, &seuser, &dlevel)) == 0) {
-		if (! level) level=dlevel;
-		if (role != NULL && role[0]) 
-			ret=get_default_context_with_rolelevel(seuser, role, level,cur_context,&usercon);
-		else
-			ret=get_default_context_with_level(seuser, level, cur_context,&usercon);
+	ret = getseuser(user, service, &seuser, &dlevel);
+	if (ret) {
+		fprintf(stderr, "%s:  failed to get seuser:  %s\n", argv[0], strerror(errno));
+		goto out;
 	}
-	if (ret < 0)
-		perror(argv[0]);
-	else {
-		if (verbose) {
-			printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
-		} else {
-			printf("%s\n", usercon);
-		}
+
+	if (! level) level=dlevel;
+	if (role != NULL && role[0])
+		ret = get_default_context_with_rolelevel(seuser, role, level, cur_context, &usercon);
+	else
+		ret = get_default_context_with_level(seuser, level, cur_context, &usercon);
+	if (ret) {
+		fprintf(stderr, "%s:  failed to get default context:  %s\n", argv[0], strerror(errno));
+		goto out;
+	}
+
+	if (verbose) {
+		printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
+	} else {
+		printf("%s\n", usercon);
 	}
 
+out:
 	free(role);
 	free(seuser);
 	if (level != dlevel) free(level);
-- 
2.42.0

