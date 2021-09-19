Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379E1C433EF
	for <selinux@archiver.kernel.org>; Sun, 19 Sep 2021 13:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB6611F0
	for <selinux@archiver.kernel.org>; Sun, 19 Sep 2021 13:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhISNKj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhISNKj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Sep 2021 09:10:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECA0C061574
        for <selinux@vger.kernel.org>; Sun, 19 Sep 2021 06:09:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m21-20020a17090a859500b00197688449c4so10775643pjn.0
        for <selinux@vger.kernel.org>; Sun, 19 Sep 2021 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9LJF1SXjVo7PNy9OQR7UT0s1qZsHy5W0L9k9tEdDcM=;
        b=gMHkd55mRf7nT1qitJpJnk2D1j7lUg4GNOiS5iiZeJCh+oAh7gI6e0UzmQ7QdRDnRk
         QbdHbCOpvNWLvq6PJJ3CuLTFt/WC5MfTBR3+Ez1hBkf9LIG5r4q8XFFZdkKBsMlZvUFm
         GTa8Nee+Jdu/FVkEe2dxuEewxQWDptB15xiFobwbWB9K3yrLLeE6pCXqI85JFYjOvh5u
         rzVHEgMng96I7PX3Bc1u2G+D32AQoXR4wWdy9Bt4XUkag3NKE8HSY1IbhPW2gtL9i9G1
         DJEbx2/wWjtfGfId8n8DmmB7ohqF9N7yQAP5qvDIWL/MJJ3qJ4cfsVnQCUksX8E+kcJ/
         tZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9LJF1SXjVo7PNy9OQR7UT0s1qZsHy5W0L9k9tEdDcM=;
        b=EvNMSi9o+3ROLZl5KB8mzpNF1vtxSLGYfuDO49ubR01Gr7IbFVfmUqHCouxsOxot2B
         AfMVEon6DMGPQIOavBQ6dI9JCv1HAcM2JrFAuw0Idg9L4ODmjFDhERRUJC1RvC1IARhf
         pl5ulpZ71+MHR7a4/xJTt47zhHdjgG0ZDGCsJU6bovTs8dve0ZXLNmtXOQaOaunwGgn0
         jkavsalkRpI4RZNeOBxHFGr0fqutLAa0PKM3i+fBGSe4knQYbFK+SglhW+pBNVJJIJv0
         o8/YPXqbgh6fGxU+N0sKHSIGjvhhRucPvC5Eam1G6A5zA4v+8fVA/FmB4Ql17wM2CbeU
         WHSg==
X-Gm-Message-State: AOAM531030zYXdpeV1C1D8iTqQSCtA5fu3VfOt36lglOaWI7ANLjgfDA
        IErI72F/eAWTqhPXAn4KXwIKnlbNVpX+Sb8Sw9E=
X-Google-Smtp-Source: ABdhPJy60HDt4kSGb6zRLMRmKXOH9A4KsqcMNnRfUYmfcS5uOt8BPZM41G096ysNQBSZV65aRyeuIQ==
X-Received: by 2002:a17:903:1103:b0:13a:1dd7:485f with SMTP id n3-20020a170903110300b0013a1dd7485fmr18376228plh.6.1632056953161;
        Sun, 19 Sep 2021 06:09:13 -0700 (PDT)
Received: from localhost (136-24-42-138.cab.webpass.net. [136.24.42.138])
        by smtp.gmail.com with ESMTPSA id b29sm12698100pgn.53.2021.09.19.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 06:09:11 -0700 (PDT)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH setools] __init__.py: Make NetworkX dep optional
Date:   Sun, 19 Sep 2021 06:09:04 -0700
Message-Id: <20210919130904.59107-1-jason@perfinion.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux commit ba23ba068364ab11ff51f52bd1e20e3c63798a62
"python: Import specific modules from setools for less deps"
Makes userspace tools only need specific parts of setools so that the
NetworkX dep can be dropped for minimal installations.
Unfortunately the __init__ still imports the parts which require
NetworkX. Wrap them in try except to guard for missing NetworkX.

$ semanage export
Traceback (most recent call last):
  File "/usr/lib/python-exec/python3.9/semanage", line 29, in <module>
    import seobject
  File "/usr/lib/python3.9/site-packages/seobject.py", line 33, in <module>
    import sepolicy
  File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 15, in <module>
    from setools.boolquery import BoolQuery
  File "/usr/lib/python3.9/site-packages/setools/__init__.py", line 94, in <module>
    from .infoflow import InfoFlowAnalysis
  File "/usr/lib/python3.9/site-packages/setools/infoflow.py", line 24, in <module>
    import networkx as nx
ModuleNotFoundError: No module named 'networkx'

Bug: https://bugs.gentoo.org/809038
Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 setools/__init__.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/setools/__init__.py b/setools/__init__.py
index d72d343..e583737 100644
--- a/setools/__init__.py
+++ b/setools/__init__.py
@@ -91,11 +91,20 @@ from .pcideviceconquery import PcideviceconQuery
 from .devicetreeconquery import DevicetreeconQuery
 
 # Information Flow Analysis
-from .infoflow import InfoFlowAnalysis
+try:
+    from .infoflow import InfoFlowAnalysis
+except ImportError:
+    # NetworkX is optional
+    pass
+
 from .permmap import PermissionMap, RuleWeight, Mapping
 
 # Domain Transition Analysis
-from .dta import DomainTransitionAnalysis, DomainEntrypoint, DomainTransition
+try:
+    from .dta import DomainTransitionAnalysis, DomainEntrypoint, DomainTransition
+except ImportError:
+    # NetworkX is optional
+    pass
 
 # Policy difference
 from .diff import PolicyDifference
-- 
2.32.0

