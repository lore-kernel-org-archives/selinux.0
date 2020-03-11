Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD62DC2BAEE
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CE920739
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 20:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TecqeIK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgCKUGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:06:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39592 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgCKUGq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 16:06:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id e16so3399878qkl.6
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TAt81c2HdFkmftRqyWaJuvimbz5jIXyBZKzls6skKx8=;
        b=TecqeIK4bub2iUsWVJJJ/DKRaOnogmaAH4hZKU7eT8WoKXw3d8QthSCZ8HoY1qtXDx
         TeYRoJopOWqZFtXdklHfEgKWs5f+l14QE2qJ3zHbAfKniuFms+RiLYHzvvx5a2YeJrMQ
         cU1DXCWvSO80WGm82bsHB36FgKINiqK7wtjCLtd/CwnEkiTJuCEYXWC2bqwF0uxRz8yf
         XDZswAsEsBldes9fQrgr3FIv+D/BCCt3fym/qLrOmC9nvHJ81wTKV4POfnr64LA39oMk
         Hz1o/mQ58BxQENTQlp0ZcVhwq5msjYP555S+aWxJnMAtfYxI/7hNc9ebTJNcPCxVAOCG
         ieuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TAt81c2HdFkmftRqyWaJuvimbz5jIXyBZKzls6skKx8=;
        b=roZDe7IX3HtKnkZW8qVOlMlJJw2sQZ9VWFLrmhTyaVByUhQBMGriMi/P3O0Pti8/s6
         TCunXgTVcjI7wFhuhSCgThIYZ+W3rVjq5VpMUovSXOihaWgGnhl3ltMpgcPGF3OrrovO
         DLvYpcgrj2B56FgMdTPRXqShjw1Qj3XWIlIE3geYOaYrfhF1+YuDz+NNC2zDkWdZeNvF
         xVaA20ByyG5PHqvIRvpV8jAujetDTZfGfGyrtPP1MGNF7drGxaRhwqCCPa4HLJvvXIko
         ssAY3q5epsT+acGsXkhxJcHXknh6Q/tRrKjPlZ35/W0CKcSjg5r/N213qJ7sxV5sDjOh
         Su3Q==
X-Gm-Message-State: ANhLgQ0HMHHUsO/AxkRuCxv0le7noG02GYyjPifF3IAOxDO4nI5R+JmI
        0zJSb27vu5kjeVc4Rg4ZpVU=
X-Google-Smtp-Source: ADFU+vsdOTYmCmpZ2PNtP4hzEVTMPrSavUGggsoTQXpeTzttG3Qi4zxvXPafWC8d6iY+6si4o/zktQ==
X-Received: by 2002:a37:cc5:: with SMTP id 188mr4639385qkm.161.1583957205630;
        Wed, 11 Mar 2020 13:06:45 -0700 (PDT)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.gmail.com with ESMTPSA id g2sm25736700qkb.27.2020.03.11.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 13:06:44 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] MAINTAINERS: Update my email address
Date:   Wed, 11 Mar 2020 16:05:51 -0400
Message-Id: <20200311200551.9306-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b370797e8a6..e343b2c75fbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14974,7 +14974,7 @@ X:	security/selinux/
 
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
-M:	Stephen Smalley <sds@tycho.nsa.gov>
+M:	Stephen Smalley <stephen.smalley.work@gmail.com>
 M:	Eric Paris <eparis@parisplace.org>
 L:	selinux@vger.kernel.org
 W:	https://selinuxproject.org
-- 
2.17.1

