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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C65C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6954020775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs+kD4in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgDTPp4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPpz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3304C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o15so4676631pgi.1
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+GHpS308QcQeu7LgIaP2e8Hs1RM6+ox8w7monB8uBM=;
        b=Rs+kD4inT1k+YMUyNMGb7Kgxn7VKkZrwp8WsrvQeuyo9bqpgd+SkRB+J2cbfOq5vEL
         FnlZcN8DjeqOicYqxnkcknaeFC3NXR3BdP/yNxaI7+Oa+n7Qa9NL/DQwf0cJIlHKVib8
         A0vHQTdhfMzmm+2RMGKx346XKMHTd9Hx0ESPoFm76uiEyM8dZ9njTVcdhyK6GbRUaSTa
         fC+QNxog/v6KLREYrhoSI3KNs4vMKWs/5/D4OQOGbHnwWzrDdD7gv5gTiOQMcKXC4yLg
         Jq+4L1B6oh3RGkrQkfWd5ourvk6NZEe6cCL5b59udx39sPnxr7CMNOliZhgeeXCv3ECK
         Vxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+GHpS308QcQeu7LgIaP2e8Hs1RM6+ox8w7monB8uBM=;
        b=Mkl2EMrqi/sxNYGv32jpKQMI18FzJq3JZtmXm9lrQSmwRIUKiiUmRDPtrLDS7rp94y
         JYiyH2urR6fS0QMc3lAhvKaWv1X8K5kW66FSDZ8XM7aTyrYgNEjr2Iy8yx5BVm2Ea4q+
         d98OEJnSiOm13tECBh/MyRjrQfse4RnYV1HcHuySa7mewqkCbXyiHG4k4muLAwAwc/lw
         VUxz1NV0KERVM6AW5uYx4nuZ235S2fQPUFtDxDIl0tu87PeFvnaZqbKCLkDJwnsa19Uc
         PKcvE437fwlXZra3pruiz+Xggjd1mqa8zR1nIX/D8SV4B1Ds3VqQz9nYUaQRXycSXrBd
         c/+w==
X-Gm-Message-State: AGi0PuZfffWR9OtvdCToZQoMUfMPh2egX2UWSM3em0dCaPfyDIaYMali
        yCJdoZEbyug+feP8ejQTMbIzqrF7lN0=
X-Google-Smtp-Source: APiQypIFFSOXPKzRJj/m9+dqUMs+X4b7bghgcPEIPW7Q2xIcoVQ7lwhbHeqDR3Ud/cFtIK2yKlsjLg==
X-Received: by 2002:a62:19d5:: with SMTP id 204mr17539261pfz.75.1587397555252;
        Mon, 20 Apr 2020 08:45:55 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:54 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 05/19] rpm_execcon: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:23 -0500
Message-Id: <20200420154537.30879-6-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
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

