Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2026C7EE24
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjELKXw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbjELKXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2FCE
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96aadfb19d7so79797766b.2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887012; x=1686479012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eivSVdUQICgh4MaBbhp/ck88yPGPptoEbUC2TVWUHh4=;
        b=SSJLgH0ILNIk4GHn7Oy62scp4KB2uBZobrsxkxh4jKm+WRSVQ0skaNLKV+QOfQcPN4
         nGhijxR2GLt/KSl1VUEzHrOzJ5QoYDMs1lxRR6X/XtlU1rzKbFxZ/UOTWw9F+oL8/9Oc
         vHeSJ0O7u21PHFksbQP23ch2ZgWx7TKoQZt9mHC/ajkTo7B/cZNAXjzQWJBE+jDxAbfC
         7Q8xMFXdK5TGdF7FmNEida9Z8Cir7Amq3UbE0TdGYf/S0YsZppo9bArtX+CLsW8zLgA+
         fH3KTKGsoxy3xXZigHpYMi+MbmOH5jt6AxvNbi+xg5mErvcTIUudiFyU7VOWgSfT+eDd
         Q7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887012; x=1686479012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eivSVdUQICgh4MaBbhp/ck88yPGPptoEbUC2TVWUHh4=;
        b=PZc9vkLrKlPMDAee2n91cJrIiScgnnV3MoAuf9vHERN0D2uK81YdnfjC1iQwQY4Tcp
         jjka7J3TfWUVi7ePlzdJ8XVqTpSqzAra0fVvjTu387vJHtTrmyBtJ3HqciLKNReSkmR1
         BmQmP7g9e1uJYJbgzeL9orDR75OvosdLROS4pRSFM/TqL29rDswYlyN6EeK88cXrKGnU
         DnN5wvkRv54hpfEDA9AvOv9/uFi16dL+ayLumlSCHbV1Xc+kAgaQ+R8GgmJVOZwGtlKv
         rY2V6yl/rORTV62hCIVcw1JR/JUh9uxqTOirJ1sCQjdEGRfrmiMnSYtr+aT5ArLTUxPz
         lgLQ==
X-Gm-Message-State: AC+VfDzvryHjM/gKvljXaE586Xn5i1GX8kP7i1spUS9tKu//DFqHl8eo
        X/7nweyZQo99SdVUWyilyowtxhUHpEYVqQ==
X-Google-Smtp-Source: ACHHUZ7zHK3EGPEyqS9TG0xppsy3vQ/6nVw0CeER+uMorO5NbY2mvi4olwN/9aSYQOaE/3oS1kNuBA==
X-Received: by 2002:a17:907:31cb:b0:95e:ce3b:a471 with SMTP id xf11-20020a17090731cb00b0095ece3ba471mr22423762ejb.55.1683887012004;
        Fri, 12 May 2023 03:23:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 8/9] restorecond: check selinux_restorecon(3) for failure
Date:   Fri, 12 May 2023 12:23:21 +0200
Message-Id: <20230512102322.72235-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    watch.c: In function ‘watch_list_add’:
    watch.c:74:25: error: ignoring return value of ‘selinux_restorecon’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
       74 |                         selinux_restorecon(globbuf.gl_pathv[i],
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       75 |                                            r_opts.restorecon_flags);
          |                                            ~~~~~~~~~~~~~~~~~~~~~~~~
    watch.c: In function ‘watch_list_find’:
    watch.c:141:33: error: ignoring return value of ‘selinux_restorecon’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
      141 |                                 selinux_restorecon(path,
          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
      142 |                                                    r_opts.restorecon_flags);
          |                                                    ~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 restorecond/watch.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 98ff797b..64bc29c6 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -71,8 +71,12 @@ void watch_list_add(int fd, const char *path)
 			if (len > 0 &&
 			    strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
 				continue;
-			selinux_restorecon(globbuf.gl_pathv[i],
-					   r_opts.restorecon_flags);
+
+			if (selinux_restorecon(globbuf.gl_pathv[i], r_opts.restorecon_flags) < 0) {
+				if (errno != ENOENT)
+					syslog(LOG_ERR, "Unable to relabel %s:  %s\n",
+					       globbuf.gl_pathv[i], strerror(errno));
+			}
 		}
 		globfree(&globbuf);
 	}
@@ -138,8 +142,12 @@ int watch_list_find(int wd, const char *file)
 				    0)
 					exitApp("Error allocating memory.");
 
-				selinux_restorecon(path,
-						   r_opts.restorecon_flags);
+				if (selinux_restorecon(path, r_opts.restorecon_flags) < 0) {
+					if (errno != ENOENT)
+						syslog(LOG_ERR, "Unable to relabel %s:  %s\n",
+						       path, strerror(errno));
+				}
+
 				free(path);
 				return 0;
 			}
-- 
2.40.1

