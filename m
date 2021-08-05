Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DEDC432BE
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578A860F25
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbhHEO0c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbhHEO0c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D10BC061798
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id zb12so5106786ejb.5
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iyIBJpxEAk/eUuTHFHW5DfAw+gaP0xjCoc4Mr46PUXk=;
        b=dRkplSMv0yhEixH7eecs9pzFDq5U+TVOwZ50vPzK2YOm6mWZO1PTf5dSKb0xxmxXe8
         dv5KEfCo5sqWL6KRT9fJB7i0IDfOH24jGnttam1lSK5YmFrg73AOmQLyDPlCfliXvhGi
         0uM4YKKYeyxypLRVatNceVdARBBVAfYrZ8YrQaikY3MYJYZFYHrra1tESkkaSBlmA9KB
         95OeLzMhpU/CiAMj8lhPVjbTni6gve5pgOz187hLOJZIL9S9W3Pi+xZ14U6+gMGPydWc
         KurmhD4XdT18hVySSZka2W3wZuvBkAdEk8gdwcutn8vtqzzZUdJm6usbloloiqE5FJNE
         BQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyIBJpxEAk/eUuTHFHW5DfAw+gaP0xjCoc4Mr46PUXk=;
        b=Jgiq0ZAp1q7ArM1YR2CAQgwWi410oIeEwE0yZX3kkc9iHZWQTYiYr+VxE+QDNtAu6f
         rtJtZuE+Gm04FO2GBx/M7n7lXb6wJUWeOk4UE275C6d7ybTAAeJrmxzImrL55vO0FL6p
         uZCbUdqKpap1iiYHdqahmx8LtJitppdX2Jnc/gskupfoBAhqFkf7ikvUPg/2gzIJyacC
         TcsjD+qN5mlnuxdvCRzZoC3tzpdh7O6/3Mgyk1+81Jkf7alWvdyNJqZ4/cMOldqUgex4
         yYEeYTd58qWph21ITPpFkaBFNqcbWWXu+CsskNAn6VpjuzKrfFycmhd/HSMCE/VwAt8S
         1eMg==
X-Gm-Message-State: AOAM533rLHtv4jxBgKvQLBVTw8jQFjpUaWSiF71ocXyMW6+K1FhtfNFy
        WceDtMC7uz0oEsuJvGKohkunEVyCXPc=
X-Google-Smtp-Source: ABdhPJx8byHAp+XGmYfqrSO1vweBMmaJGqX/o3bfnPZeZVBK1AjbzFuRCi5X/Ac4erqeLsdZC0hwvw==
X-Received: by 2002:a17:907:d09:: with SMTP id gn9mr5163632ejc.447.1628173575860;
        Thu, 05 Aug 2021 07:26:15 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 2/7] selinux: improve debug log format
Date:   Thu,  5 Aug 2021 16:24:40 +0200
Message-Id: <20210805142445.61725-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

path might be NULL when checking against the system permissions, so wrap
with strna().

The command line might not be available over D-Bus and thus cl might be
empty.  To improve readability quote the corresponding value.
---
 src/core/selinux-access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index e8e73a5951..e40fd937a6 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -279,8 +279,8 @@ int mac_selinux_generic_access_check(
         }
 
         log_full_errno_zerook(LOG_DEBUG, r,
-                              "SELinux access check scon=%s tcon=%s tclass=%s perm=%s state=%s func=%s path=%s cmdline=%s: %m",
-                              scon, fcon, tclass, permission, enforce ? "enforcing" : "permissive", func, path, cl);
+                              "SELinux access check scon=%s tcon=%s tclass=%s perm=%s state=%s func=%s path=%s cmdline='%s': %m",
+                              scon, fcon, tclass, permission, enforce ? "enforcing" : "permissive", func, strna(path), cl);
         return enforce ? r : 0;
 }
 
-- 
2.32.0

