Return-Path: <SRS0=/80D=SB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72054C43381
	for <selinux@archiver.kernel.org>; Sat, 30 Mar 2019 22:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127962184C
	for <selinux@archiver.kernel.org>; Sat, 30 Mar 2019 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="k3IkhCeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfC3WCg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 30 Mar 2019 18:02:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41254 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3WCg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 30 Mar 2019 18:02:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so6429261qta.8
        for <selinux@vger.kernel.org>; Sat, 30 Mar 2019 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OBn/P2KIKlQuqRJh73NqABaieFKZtP/ZEWuHdEOwDOc=;
        b=k3IkhCeAqk3GNEZaFMMOYoS7QIcqBbbr4j3tlwV19O/pL7GMnM9+tjlGP+RLa24Tf+
         FnNtgXU/oC5OqadrXTbVqEd2Q7a2hPgt8KkxT4I3ENhoy6M5L2oGaH3mbBMAmP7wpxR1
         WWEAkXMoeu+NU+xcNKvTYR1yr2cXUwYISYCF3JIUp2rYwoneu7rKVS9l012+kTFbNJ1z
         rAbsbCT0iqlXuEEsnE8RXMOIWuV1vbxcelnxx4hyUuU8vA5J5LrPelX79b0xzxg13TFi
         Athc2Yj/p+Z1DkqBrWRV6wnbXNOJEAEGutn8BVyTp1f9coPX9UNVqTR2kZ7winqb2+VF
         7c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=OBn/P2KIKlQuqRJh73NqABaieFKZtP/ZEWuHdEOwDOc=;
        b=SaGoOvgbMlx80+6wZN3u7SggAzw3kugXMi2vOoW7czLuqjY1huX7uSQduGvYqIqt9y
         Roiyk4K7UNnzasEvN8yTkNlMqnzpHJTiV56EPnpBsdLfpVnJDyBhT6R5iFgR3qBPBFM9
         JdJshS4wJu9b1YOo8lB6VdCi7JtsvNYU+2fEW0fq3ZM3lolAmWXW0J05nh0oisVw80+d
         +yRcDCDQrKWImPFLk5y93+j2wnCzY1RbaR6vq6czunGFq5PjXCE4oxBLgVkVuP3WR6vE
         tynVysHF14JWObTmZRKiDiqmx37sgVm/cDZGjmx98Bp7ovyvpkIragZLygBArPypEdkJ
         xZbw==
X-Gm-Message-State: APjAAAXLM2yhsi4CCbgXMLnV1yv70r0p62NbUOZlxv2QWzbFdaXkPo4n
        fF1FX9icWPo6T4YMykOdMxgBvADVSg==
X-Google-Smtp-Source: APXvYqxPCllMXW6KH/rMRHsqQw1gVnxFPQhfYvHC27Htu2cZXC9rSRvcVmMEc6XEFM4YLhL/WpgOCg==
X-Received: by 2002:a0c:91cc:: with SMTP id r12mr46230480qvr.35.1553983354874;
        Sat, 30 Mar 2019 15:02:34 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id z5sm3465949qke.51.2019.03.30.15.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 15:02:33 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: update SELinux file patterns
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     joe@perches.com, casey@schaufler-ca.com
Date:   Sat, 30 Mar 2019 18:02:32 -0400
Message-ID: <155398335292.21282.3368996467557801907.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update MAINTAINERS to reflect that there are no SELinux headers under
include/linux, but we do have include/uapi/linux/selinux_netlink.h.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..7b2e7887f3a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13937,7 +13937,7 @@ W:	https://selinuxproject.org
 W:	https://github.com/SELinuxProject
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 S:	Supported
-F:	include/linux/selinux*
+F:	include/uapi/linux/selinux_netlink.h
 F:	security/selinux/
 F:	scripts/selinux/
 F:	Documentation/admin-guide/LSM/SELinux.rst

