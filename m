Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C219C2D0D2
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EE620684
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 12:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="msrN2966"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfLTMDf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:03:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:39648 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfLTMDe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 07:03:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576843414; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=QOv7RvAgmSKMtzh5ZYK35DY3wv0oF/I4SlruXDv4xY4=; b=msrN29664aWsdlW6La9scC+zL7jMGF4WHMu2BAkuHMNI6upY/T4P1qg/b+o1vtc3Abm5JewU
 0JGy7v3VOXbharkJISapjpiPiJVxPgKkavBZwTW4wP3cvUUpmqiGe0V/F8/dU+/Tzj9mVxRZ
 3tvsBOufkxO8onEuI8LcxJjM/gI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfcb895.7f6b5df855a8-smtp-out-n03;
 Fri, 20 Dec 2019 12:03:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4933DC447A4; Fri, 20 Dec 2019 12:03:33 +0000 (UTC)
Received: from rsiddoji-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C231AC433A2;
        Fri, 20 Dec 2019 12:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C231AC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        sds@tycho.nsa.gov
Cc:     rsiddoji@codeaurora.org,
        Jaihind Yadav <jaihindyadav@codeaurora.org>
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel 
Date:   Fri, 20 Dec 2019 17:33:01 +0530
Message-Id: <1576843382-24184-1-git-send-email-rsiddoji@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAHC9VhSv9BsjqNtwdpAv1yj630L-k8UBcWA5bwC9ySevrPw34w@mail.gmail.com>
References: <CAHC9VhSv9BsjqNtwdpAv1yj630L-k8UBcWA5bwC9ySevrPw34w@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Thanks for correcting , Adding the signoff of orginal author in the 
following commit .

From 6308b405e2097ab9d82c5a3894815daf7331e0b6 Mon Sep 17 00:00:00 2001
From: Jaihind Yadav <jaihindyadav@codeaurora.org>
Date: Tue, 17 Dec 2019 17:25:47 +0530
Subject: [PATCH] selinux: ensure we cleanup the internal AVC counters on error
 in avc_update()
To: rsiddoji@codeaurora.org

In AVC update we don't call avc_node_kill() when avc_xperms_populate()
fails, resulting in the avc->avc_cache.active_nodes counter having a
false value.In last patch this changes was missed , so correcting it.


Signed-off-by: Jaihind Yadav <jaihindyadav@codeaurora.org>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ecd3829996aa..9c69e83834b0 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -907,7 +907,7 @@ static int avc_update_node(struct selinux_avc *avc,
        if (orig->ae.xp_node) {
                rc = avc_xperms_populate(node, orig->ae.xp_node);
                if (rc) {
-                       kmem_cache_free(avc_node_cachep, node);
+                       avc_node_kill(avc, node);
                        goto out_unlock;
                }
        }
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
