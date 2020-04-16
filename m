Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DAC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A7820732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQuGgJ+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395482AbgDPPob (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409096AbgDPPo0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413CC061A41
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so1522091pjk.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pkf6RDUcM+U9vRmkqya6tgtwe70FQLzaa9VRXRP+Hrs=;
        b=UQuGgJ+YjXIdwtdKSnfEQshp5BdM7TjNFr5WLe1lYeYzLaXYGrnGp0WV8XrEpIalgi
         sCpQblFp8njZFRWz69eDdFxYlKw5ZCX99jhvrlJ4IPeINHXoXHRV7eaR6OEZ8V9OnCF3
         wLDW5BaK5mAd46ZDVPGIpX4rAdi/CIs6eI2i/YuJYjvhIYTzfEvYVOfC5hpaEfnANu6r
         yp7GSxwrH/8MXEfr5ffemIaRvtzaPDFhyuxqLtA2X+3/4meo6nZoQUxkDv4mk0u/mt0U
         ft+IEmhcyDRSGTLNMGZs/nyRHjLuDcfmijS8+Wa3pkrue1ukTaDNPR/+x6aUxoievM/C
         XsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pkf6RDUcM+U9vRmkqya6tgtwe70FQLzaa9VRXRP+Hrs=;
        b=XRhaXR1SY4iNDRqUTbKBikmdUtbZj/0YC7wPyv6x+7kusosSV0Fh8LoXmADXHK1LH+
         rXuqjdjNWelRkcIK1VRCmIfJM9FFPJGy2ZHsBYPTszYnVQAe7INHkSMAMl04nPj0f64P
         K0LBw1gOPmvr/tGeNSSAW61gAlxl2Qt8VyUsZn52bZNxPg0rY6gsP7RnOx+IdGLD9PgB
         vpL3MCM3knK9uOv2FKH3Axo6cOggD8x9/XxKooz3YBEdgwCLUQYS4DkzwlK1Qor65akb
         2W2YoBuT6zpJ15Q0ROYaKA7jVH5K53J8+MKW7P8vTi2Qa1yQARsZwBrIMRtlnqFbzljE
         p94Q==
X-Gm-Message-State: AGi0PuYAKyH4SyeNwH5bxXKhKSO7ce1vWeG7r4nkRaXoT89ZOiz1VmE7
        Q2emsAu5Z3y5NhUbfK5xiS0=
X-Google-Smtp-Source: APiQypLkb42Dg6zL821BfypdqqBw7fuvl4X7iTPt9CnslYN9R4ETs/ayWmIFz+U4QQO+kSAmnRUhXQ==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr5957557pjb.45.1587051865467;
        Thu, 16 Apr 2020 08:44:25 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:25 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 11/18] matchpathcon: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:45 -0500
Message-Id: <20200416154352.21619-12-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 96a071a8dea4..5a66fa6f9d78 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -484,7 +484,8 @@ extern int realpath_not_final(const char *name, char *resolved_path);
    If matchpathcon_init has not already been called, then this function
    will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
-			mode_t mode, char ** con);
+			mode_t mode, char ** con)
+	__attribute__ ((deprecated("Use selabel_lookup instead")));
 
 /* Same as above, but return a specification index for 
    later use in a matchpathcon_filespec_add() call - see below. */
-- 
2.17.1

