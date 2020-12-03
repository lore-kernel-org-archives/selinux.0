Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69063C63777
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 04:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0994320643
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 04:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgLCEr7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 23:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLCEr7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 23:47:59 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6AC061A4D
        for <selinux@vger.kernel.org>; Wed,  2 Dec 2020 20:47:13 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 4so407698qvh.1
        for <selinux@vger.kernel.org>; Wed, 02 Dec 2020 20:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OKI6aoMZn7qmkONz/CQjmY9+P6ZlYDbLEMF2qo4f2Gw=;
        b=qSAJjkO0Wbkuh2Pmr4b7nRioStMhFZHHBpJ6dt8pSSBlh1XZeD2U8qQzHaG2rL4/ma
         QY6zteJOuWlR1DBILmWL1RVQrlmadsFpoLI/65J2wgrYFr5/fKyw/gwFVQrc+gmHoUSW
         tBpk1exO3NdZ5HWVn9MvRyP30ORT4h5mgSohADzhvatgdDT6L3IgIVYFyyL/dljZ/all
         c5XaS8MdjEQ0lkLw7QeViEg48BJf0Ye/P+qddHWMQM32XHXtFWXvR4z5t8X/fKXF/vMW
         tJVSGGl1H+hBRqzj3FjPejrzglqpiO2o1B++m/BCUB8RkzICKQGX98JEBSPNcCoQktmZ
         O4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=OKI6aoMZn7qmkONz/CQjmY9+P6ZlYDbLEMF2qo4f2Gw=;
        b=np0jfrkoEWOYrk/HEhDUCBhykhnUIsPhKqKbSNjo0DiIIpzYL7hOWfOOGoCAp6DoRt
         Zr4ujBbkXiJBrzOlZ2ezWlxGCNUMnF3ktY5whrlgHYFK7yvpRbsVkKFaOKLWxAqhAqhl
         W3YjUMyuceLgKv/Yp7SiQ1NDSNTEl4S/7g05VaQu1zwAB+Y9QuDQXT/MB0/tzPJdp3Qa
         8KQC276olLyzSdeLdbIAf5771EAvT5G/8SIbbmQsmH2WanYMtywAUpped4nR/AsdlBVH
         BFM36qblk0QdxIyZLrKL4C6DNnRbHcKfT1npqT2Kslp8IaKpwvzsLQ9113jN6B7P9P07
         bpQQ==
X-Gm-Message-State: AOAM530/tKjvPveoa8iZUQbZiWlWOu4wJD+0umNrygKrId4SQslWBNOD
        L86KB/tJhtBsaPQ2qUowoe4jRcoRQDtjp4E=
X-Google-Smtp-Source: ABdhPJzLdu2PJe7Z9rkUrjsVj9QPu5FFCYmuKO2IGp3Wk+Luz+7MU89IS/ZQaQQfCB/YtthFYop41A==
X-Received: by 2002:ad4:5483:: with SMTP id q3mr1364988qvy.24.1606970832108;
        Wed, 02 Dec 2020 20:47:12 -0800 (PST)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id w21sm368067qki.6.2020.12.02.20.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 20:47:11 -0800 (PST)
Subject: [PATCH] all: various small html to markdown conversions
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Date:   Wed, 02 Dec 2020 23:47:10 -0500
Message-ID: <160697083070.45245.11138404605529742839.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/notebook-examples/selinux-policy/README.md |    2 --
 src/notebook-examples/sepgsql/README.md        |    2 --
 src/title.md                                   |    5 +----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/src/notebook-examples/selinux-policy/README.md b/src/notebook-examples/selinux-policy/README.md
index fe6a26e..353bd2f 100644
--- a/src/notebook-examples/selinux-policy/README.md
+++ b/src/notebook-examples/selinux-policy/README.md
@@ -20,8 +20,6 @@ Another basic kernel policy build is avilable in the kernel source, see the
 ***flask-files*** - Contains the Fedora 31 policy source initial_sids,
 security_classes and access_vectors flask files.
 
-<br>
-
 ## Building the Kernel Source MDP
 
 **Note** that the kernel mdp `install_policy.sh` script will not build
diff --git a/src/notebook-examples/sepgsql/README.md b/src/notebook-examples/sepgsql/README.md
index bfa3c09..3e1afc7 100644
--- a/src/notebook-examples/sepgsql/README.md
+++ b/src/notebook-examples/sepgsql/README.md
@@ -20,8 +20,6 @@ installed:
 	postgresql-docs
 ```
 
-<br>
-
 ## Installing PostgreSQL + sepgsql and building sample testdb database
 
 For a good intro to sepgsql read the following:
diff --git a/src/title.md b/src/title.md
index 5c33ac0..caf5b41 100644
--- a/src/title.md
+++ b/src/title.md
@@ -4,13 +4,10 @@
 # The SELinux Notebook
 <!-- %STYLEEND% -->
 
-<!-- %STYLESTART%(display:block;margin-left:auto;margin-right:auto;) -->
+<!-- %STYLESTART%(display:block;margin-left:auto;margin-right:auto;padding:2em) -->
 ![](./images/selinux-penguin.svg)
 <!-- %STYLEEND% -->
 
-<br/>
-<br/>
-
 **<!-- %DATE% -->**
 <!-- %GITHEAD% -->
 

