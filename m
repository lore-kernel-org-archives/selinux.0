Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB30FC07E9B
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD53961C3C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhGFR50 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhGFR5Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35EC061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t3so29133563edt.12
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kw9tONUBoPcTpbjcLQASEBtB8/lqOXIVnp171hSswSQ=;
        b=evloRo/PPkU0O/Aj/YCcK/qCQs4I6Gn8w44q40tFd5gW0e+rNHhdcCX5/eAM1aohLZ
         GKCi3YeF5nR254okP0hIxw7HHldakyW+Doe526tAr9YKfY7MI4H5pQ3+X6/0Wass2Opy
         sxAqOF0QkyDNJh2EA29oLqjTShgtGshrBkXO01L5rqI5IJiDYN073k9pDH8iwwemf7uQ
         Pj2twQgTl3h41fs1bsqREDFpxZ2ZKG/7YjOsQMFGOP4AZjvPkppYL8DnxCg5FxYFeEEO
         aPDdtTK/boMdfg9rzW0DJAv0YtteVektuTSUqPeQNwCrgIAf1nUhiYSb9EbnEgH038Bf
         4oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kw9tONUBoPcTpbjcLQASEBtB8/lqOXIVnp171hSswSQ=;
        b=sXl8/Mro6ut1pbIoeOc30FIaldbWCPAwX6WnsdTmuE3y4bN0TXUKDRbN8xRrcv3H60
         tIL7k2pC0MiCWjk8chl+EJeTfi439btsRP0+o1Wv62DzVU6N/SaALhELp+K/WG3pijWP
         426yAeFFMZ7XqNPE4RYBsubUbBBH9ePYSH4lml928pyP3gG+oLSIbcXUIBETw15XkQGS
         3Haee2i9TnVrF9BzK9Z+f3B71EcAlYb+lVaVqcGb9mMliwFMoJTeQih7C3vdCqcOiW6n
         kd9Tg9Wke7cNb//otD/rWtC9fypn3gWTfLlaTzZCqZr35FZeSPyNDsKfsBtmEAbm6pxw
         Au3A==
X-Gm-Message-State: AOAM531cBGu2hSEM5Rdx1daAKscMK7113Z5IIyNuhTG9Q6qhMr1A2Xbg
        zQSyLG97gMskGgeYjUJ5AVdGHs+jBvI=
X-Google-Smtp-Source: ABdhPJyoBUDFxqYc87/i3zO3EIbaSxrGBKfRZuPhJJAdIvkI8pDKKl5crxPvphxJjOZ1xiZAdR01VA==
X-Received: by 2002:a05:6402:28b3:: with SMTP id eg51mr321444edb.216.1625594084755;
        Tue, 06 Jul 2021 10:54:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 09/13] checkpolicy: avoid potential use of uninitialized variable
Date:   Tue,  6 Jul 2021 19:54:29 +0200
Message-Id: <20210706175433.29270-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    checkpolicy.c: In function ‘main’:
    checkpolicy.c:1000:25: error: ‘tsid’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     1000 |                         printf("if_sid %d default_msg_sid %d\n", ssid, tsid);
          |                         ^

    checkpolicy.c: In function ‘main’:
    checkpolicy.c:971:25: error: ‘tsid’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
      971 |                         printf("fs_sid %d default_file_sid %d\n", ssid, tsid);
          |                         ^

Found by GCC 11 with LTO enabled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index c88ca542..04f35eda 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -967,8 +967,12 @@ int main(int argc, char **argv)
 			printf("fs kdevname?  ");
 			FGETS(ans, sizeof(ans), stdin);
 			ans[strlen(ans) - 1] = 0;
-			sepol_fs_sid(ans, &ssid, &tsid);
-			printf("fs_sid %d default_file_sid %d\n", ssid, tsid);
+			ret = sepol_fs_sid(ans, &ssid, &tsid);
+			if (ret) {
+				printf("unknown fs kdevname\n");
+			} else {
+				printf("fs_sid %d default_file_sid %d\n", ssid, tsid);
+			}
 			break;
 		case '9':
 			printf("protocol?  ");
@@ -996,8 +1000,12 @@ int main(int argc, char **argv)
 			printf("netif name?  ");
 			FGETS(ans, sizeof(ans), stdin);
 			ans[strlen(ans) - 1] = 0;
-			sepol_netif_sid(ans, &ssid, &tsid);
-			printf("if_sid %d default_msg_sid %d\n", ssid, tsid);
+			ret = sepol_netif_sid(ans, &ssid, &tsid);
+			if (ret) {
+				printf("unknown name\n");
+			} else {
+				printf("if_sid %d default_msg_sid %d\n", ssid, tsid);
+			}
 			break;
 		case 'b':{
 				char *p;
-- 
2.32.0

