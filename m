Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C1C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C681720775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiVFLhWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgDTPqS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgDTPqR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A03C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w3so4091287plz.5
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThytxPAXFKfJwqL1E34wdemZ6YzRL2kXegLVFr+oRIk=;
        b=RiVFLhWQy+s+TaZvKpB9avxR3PXqAAfmaRHomA7K3x0yV4nqyun5+rBYRh+Odab5Lt
         rubXjloMRpR/JxusSuxEHYwnVEhKLz4BlLuUcmUo3qq87bEie0zsI6Y+vp6GMnxiGro5
         hAorRzYERQDmYDJumob3kU4CazCxCKDzSYFHRTWGfaNVCp9Wl24UfwWmNLPINjYM7oW0
         D0R/2squcNUz7QzNj3bdfp1J0YaRV4ijKVw75ld54HBiuXce1dyCfZfxx4Y2rWHTnoJR
         jEIDk/veKfQlgfbfb8OENUGEWpDKEClItPwmz9ps+A2+N4aiaBKroR03NJqzJTSLH47H
         SgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ThytxPAXFKfJwqL1E34wdemZ6YzRL2kXegLVFr+oRIk=;
        b=Eg9UG3kVjtIwxPbBVGE8Z9bifajTqtmLHY2Tj1hJo5KBWjAy4WVST224YxLZ67H9TK
         UeLqaMtIu2yZXuEPzm09wJMggoyHYTTMtHpuNU7DS/WiPUk26xzDoamB5QQYdDo2S7RL
         ByeXUI4HsrVe4mziP8RnkM1zx8Nx4tbzvyeqVTty2uwo5LgNUB7WF7C58OWKWxJtZxOC
         ybpYyjbEqNCTkP7L2JGoeDXauab9moIjybGhU6ZxQfptW0s7/yA+fbkYR9Da0idozafp
         FRDzhj+Ac9WjDXZnkY46F8UQROm5qxKskIV+B+EJNY2uKWU3YsMUzMx4h7oQcrQ1vRaT
         amsA==
X-Gm-Message-State: AGi0PubYPyvlRXkWvq6LsdUeD6uUDI0JMWBHwQowT59F//r6OSUpqPsS
        YLzPnAMCjs8qL7iRbtS/U30=
X-Google-Smtp-Source: APiQypIP2DBxeqHCxFLkUgogH0fygVWiKmkLtiUyrmXjnHsitMqPPlY9MUHfY1A9bTYB+W3OM7u3Jw==
X-Received: by 2002:a17:90a:d0c3:: with SMTP id y3mr23696pjw.128.1587397576164;
        Mon, 20 Apr 2020 08:46:16 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:15 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 15/19] matchpathcon: create internal matchpathcon interface
Date:   Mon, 20 Apr 2020 10:45:33 -0500
Message-Id: <20200420154537.30879-16-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Now that matchpathcon is marked deprecated, create an
matchpathcon2 interface for internal users.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/matchpathcon.c          | 8 ++++++--
 libselinux/src/matchpathcon_internal.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 8515c88c2bb8..88539e627f5d 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -433,7 +433,11 @@ out:
 	return rc;
 }
 
-int matchpathcon(const char *path, mode_t mode, char ** con)
+int matchpathcon(const char *path, mode_t mode, char ** con) {
+	return matchpathcon2(path, mode, con);
+}
+
+int matchpathcon2(const char *path, mode_t mode, char ** con)
 {
 	char stackpath[PATH_MAX + 1];
 	char *p = NULL;
@@ -456,7 +460,7 @@ int matchpathcon(const char *path, mode_t mode, char ** con)
 
 int matchpathcon_index(const char *name, mode_t mode, char ** con)
 {
-	int i = matchpathcon(name, mode, con);
+	int i = matchpathcon2(name, mode, con);
 
 	if (i < 0)
 		return -1;
diff --git a/libselinux/src/matchpathcon_internal.h b/libselinux/src/matchpathcon_internal.h
index 3affa687327f..c63bcecfec89 100644
--- a/libselinux/src/matchpathcon_internal.h
+++ b/libselinux/src/matchpathcon_internal.h
@@ -3,4 +3,6 @@
 
 void matchpathcon_fini2(void);
 
+int matchpathcon2(const char *path, mode_t mode, char ** con);
+
 #endif
-- 
2.17.1

