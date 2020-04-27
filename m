Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B296C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4188E20656
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/lLKKr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgD0UXb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UXa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B8C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so119462pju.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+GHpS308QcQeu7LgIaP2e8Hs1RM6+ox8w7monB8uBM=;
        b=J/lLKKr4x3RA0p2NKRhH2we5Zf/k6qq0iUWGSrtJk3bBG/t8ilaVxtCraR9ZObeaZO
         +vCa2Rjh22r0mIvqYvcBokvYoUM9UxmD7RwdVaRrEImWxHZj9CLylf175GR3oI21RjlK
         c5xMARxcPapYH/ZYNm/utoy0C9Xg34Jq+Pz72Hqw4085PIXcOHTHsSpD6trc19Jyfy1g
         +HkGDrGo548+KFe9BzEfGZ3MhmFvs2IjWZpfx3qL1lMvzbt5jPio+Ck9CFW4rM1xYn/f
         zzzh0EzC5PlrDPzTUyMP3za2+TJacdcnViDmQ8DvnBqWyuGi4leKktuf4LyIJ6/gnzLt
         8A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+GHpS308QcQeu7LgIaP2e8Hs1RM6+ox8w7monB8uBM=;
        b=OESPsvZr4OxAEKirVbXl1sQLpUn3fjUGLVv6Xlxd7I/mBEUlVSo2ro1hJ/GVKsKhs2
         h8nc37UDArXw4tc7LqdnOuXS5x+qFDdbqdIO8UD8VtkzX+NEH1OLYDjoDzqgWHvnWcs+
         z4nsbA3tqiWr+oS9LFO9+pDpYVP3AKK2Ehq+MWSH5U5CzcDWrw2wTRaOUW79J3aEachn
         T2//h5Xhdsd3k1Gye8lzd65iwrTtW0l8XFIF1Rb71cPhhS5awxXFX7giagVzA2lDmzUt
         HSP10Q8O71vUZlvpbg9mDtcMblDQp/nXxqXpbSG+I0yK+zsjfOH5jGAJNdulmeK4fZ47
         Ha6g==
X-Gm-Message-State: AGi0PuYUeC013AE2wu55nSsQLGOAnMAKzCl5NTywe4JkoSornYIWV/sw
        ViQgWXvQg/31WzUaalGR3Ok=
X-Google-Smtp-Source: APiQypLl/ocb6TtajqDMDZMVUwCO9ktopMoCO/sPC5/c7nuq4szli6D5BMjGgbwooai/zp5JEV6C7A==
X-Received: by 2002:a17:90a:d984:: with SMTP id d4mr492365pjv.59.1588019009529;
        Mon, 27 Apr 2020 13:23:29 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:29 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 05/18] rpm_execcon: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:02 -0500
Message-Id: <20200427202315.4943-6-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 75f65e367bf4..deaa3f172586 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -645,7 +645,11 @@ extern int setexecfilecon(const char *filename, const char *fallback_type);
 /* Execute a helper for rpm in an appropriate security context. */
 extern int rpm_execcon(unsigned int verified,
 		       const char *filename,
-		       char *const argv[], char *const envp[]);
+		       char *const argv[], char *const envp[])
+#ifdef __GNUC__
+	__attribute__((deprecated("Use setexecfilecon and execve")))
+#endif
+;
 #endif
 
 /* Returns whether a file context is customizable, and should not 
-- 
2.17.1

