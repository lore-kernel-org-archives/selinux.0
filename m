Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD74BEB64DD
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjHKQ1v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKQ1u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A518F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bccc9ec02so305766166b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771269; x=1692376069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T+4o5IqM1ckjv1vB6Hj+yuZO8zxIn1UbsF72lQnCa4=;
        b=s2dmwkaLUFhmAijBFdlWbeqv2QrB3dKO/3TTZh+E8jApsORUA9D7lzIFyp/aH9Q8Mq
         vHOvTQq0F2QdJ2Qm+osWH+vtUktF7HqLU92RXzRWdAfKru+fQHObWRztpYg3/5wQBbtD
         CvKDHuRkMAZGJJwWTq7uZPmFYXQ5kVS+yYEqOpujsmBpwK4fKsx6CtXUTq20zFdkkcS0
         GCGCOoQT1wRPYOoj11Y2ib7bYY7NANc0V7V/l4+OZVyFvQFZq/f9tnKMtQjkQBMSj/TP
         B9iSjgcj/eiIonrSRcRbK5rHtp7Z+ThK1BDvDaH3f4au1UtTeDm5R8DNi+3h+gkg/huV
         YXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771269; x=1692376069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T+4o5IqM1ckjv1vB6Hj+yuZO8zxIn1UbsF72lQnCa4=;
        b=AI85/39z7A4Ba4M3qDIofADBJWE51D1jPzvF49QAhLZ8g6pS6jNtLixnTBM5yweAT8
         A7NT+7rYye8ENAbFNm6kJ670EIOv+Spinv7tr1pPr1S/qGO/auilTw5noNTdYSUffM3j
         4fjCqMZsWU6vATe+q0FGaPb79ezDu469JDLsuh85ZoUUDgQf/Jnmj+4xl7seu5bom6Qa
         w++WK2DmnYHaZUef7AZp7XKN05nVCUoAThRTmwENSVoj6dThr7tJeoi7VDy58kom5AH6
         IYoeCE1aC6bu098XZ66fZh2SkhFMTPF3e8Z/U7B+NbNSxX/XTFcZGyDpiU77ar+WSNsw
         S4Mw==
X-Gm-Message-State: AOJu0YzJtXUuyxww6Y8oDzEBWbSwB4CmnuKjxx+z7ePOjK7szf0tMwmT
        oL0KGsiYf7IL2Qs6qGIfTVxvyYS88yph8A==
X-Google-Smtp-Source: AGHT+IFv7SHxkdM/2E4TjjFpEjVEZQ16enNZRMUSNrKHZ5zy6f27SYbHoaoUgF0f4tcBzyPUBGQvkA==
X-Received: by 2002:a17:906:3044:b0:992:42d4:a7dc with SMTP id d4-20020a170906304400b0099242d4a7dcmr2050725ejd.21.1691771268569;
        Fri, 11 Aug 2023 09:27:48 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 01/24] libselinux/utils: update selabel_partial_match
Date:   Fri, 11 Aug 2023 18:27:08 +0200
Message-Id: <20230811162731.50697-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Print usage information and exit if required path option is not given
or superfluous arguments are given.

Constify read-only variables assigned command line arguments.

Simplify bool evaluation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_partial_match.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/selabel_partial_match.c
index 7bbd5777..0df2627a 100644
--- a/libselinux/utils/selabel_partial_match.c
+++ b/libselinux/utils/selabel_partial_match.c
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 {
 	int opt;
 	bool partial_match;
-	char *validate = NULL, *path = NULL, *file = NULL;
+	const char *validate = NULL, *path = NULL, *file = NULL;
 
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = {
@@ -55,6 +55,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (!path || optind != argc)
+		usage(argv[0]);
+
 	selabel_option[0].value = file;
 	selabel_option[1].value = validate;
 
@@ -69,7 +72,7 @@ int main(int argc, char **argv)
 	partial_match = selabel_partial_match(hnd, path);
 
 	printf("Match or Partial match: %s\n",
-		    partial_match == 1 ? "TRUE" : "FALSE");
+		    partial_match ? "TRUE" : "FALSE");
 
 	selabel_close(hnd);
 	return partial_match;
-- 
2.40.1

