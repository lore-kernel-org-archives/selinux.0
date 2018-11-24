Return-Path: <SRS0=cKeS=OD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90406C43441
	for <selinux@archiver.kernel.org>; Sat, 24 Nov 2018 09:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE1C20865
	for <selinux@archiver.kernel.org>; Sat, 24 Nov 2018 09:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJu3molL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE1C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeKXT7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:59:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39798 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeKXT7d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 24 Nov 2018 14:59:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so6308740wra.6
        for <selinux@vger.kernel.org>; Sat, 24 Nov 2018 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=php17Hs4JRcbx3zxFiXoJ55wSs7I9qOx6pZjPIGaQSE=;
        b=BJu3molLt1YUvdT2SPTJeg8cYP0hqWqU/Iy3asJ688Ys/0BufGuaWTt3Z/cStOU8oZ
         gkk0E0OW9QNorV/Fyw8WCajaa6kDC3yfaPtlV3+GdyKVFmdoJ8KFOFrDYVYUbPZB8Fup
         /Z23BgXBa2MPOws1+B2ToyG+WAUUXr7QmQmVGovtgrkqhjbYw8aiX0UjJbAz6K9DvDq+
         OeJDD7g7hcsj17SMGEyMPAbQ/JqUG9bTnd2yawc5txTEOgsJ5oXt+clLmfcuAS7BZoZr
         1JMdfIdeKPtJm9x+xoXa2ofdjUnRSMFBinykIOqJVtS4fIPI3ma6PlxNkaFaEdAq+uUc
         vH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=php17Hs4JRcbx3zxFiXoJ55wSs7I9qOx6pZjPIGaQSE=;
        b=WxlEGigJMC8lWlzDfzNrtF9J2a8C5hdBOh+kGXiM3RJjCU1tgovGBGgfvzoHplu5As
         mUq+3Gv9vsgBieXSS9D9KaKag4+2bugaz++NEGrMdmvj0RGNOX4vSOIXZE5Z9VL5udLX
         fiITdMShTWejfLxeJv0m0SXA0lSNi317raSmExqnzQx/ByBw113bgdzGpXW4xQx0Cw3H
         840SQNB9HAL7x26F5pHnjGe3s/cJFRSYa+i6WdYq7gisTM+o4JdjQTPjbu30BP20bYys
         JNjy9vFahMEDToVmBnOH6vuWW8xCImxKFTE69QI/5yHpUJP96nZnHB2bbStVG79Smgxh
         FapA==
X-Gm-Message-State: AA+aEWYUKnA4RCtopL893E9ZIzmmOYZhbFEw+xaR4aBfE268U7v2Pfwd
        bDwW+PI8KKhuwdHQSMigdZOnrcw=
X-Google-Smtp-Source: AFSGD/WRAvD9M5/lWfd9d6/S+jcnko4O9zpLlrm2MqZaUEOQF1SI24aJOnGYYNccaxcOFKFTrVM8Dw==
X-Received: by 2002:adf:9484:: with SMTP id 4mr15611271wrr.98.1543050694972;
        Sat, 24 Nov 2018 01:11:34 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id r3-v6sm11578159wmd.25.2018.11.24.01.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 01:11:34 -0800 (PST)
Date:   Sat, 24 Nov 2018 12:11:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: make "selinux_policycap_names[]" const char *
Message-ID: <20181124091132.GB10969@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Those strings aren't written.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 security/selinux/include/security.h |    2 +-
 security/selinux/ss/services.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -81,7 +81,7 @@ enum {
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
 
-extern char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
+extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
 
 /*
  * type_datum properties
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -71,7 +71,7 @@
 #include "audit.h"
 
 /* Policy capability names */
-char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
+const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"network_peer_controls",
 	"open_perms",
 	"extended_socket_class",
