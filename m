Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A786C38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E2F24955
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbTdF9qZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEHPmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgEHPmT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:19 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A9C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:18 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di6so824446qvb.10
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=by8fACLKcraplFL3iLNX7GLMGBAf9SBuZP9GRoqhlEI=;
        b=pbTdF9qZVYZVEicg4den/6PPITYbWP9wlYe+N/34hG2ekEpPMi3rOUPQEtGoN1CwG+
         /IEPUFKAbRCVfaLTOBr6WNi2ruKIREmwADjWNcGWtHZSYS7Kyy/2g8ZuJZOFqJn2GJ8u
         9ch1hYR4HHbZhOvnA+2pi3OC2vHdkUJHj7hFLuPZp+k+I3zMxyUvlf3O1+ZF/TpFRQig
         mMSxSt/nwnEZQCr+gRd5abk9fUIvz9RXyZ7zsiITnmxAmcuSg59HagCcmWZ69OqbBAki
         chDCs2KLtd8hEbe5JZmFNP9Wsp7Xlx5EMH180YiQmIaGVb4zTOIKkZpY+asgcDoXzkwU
         JcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=by8fACLKcraplFL3iLNX7GLMGBAf9SBuZP9GRoqhlEI=;
        b=XdjqGDmLxfS7vuHhrgOOFugt4pUwJyqbMQvo+yzxCIKNYZH59dPXorUYsTxf/30/AJ
         WLFYHi+9hCSm1V2vg0MSabBhDy3oSfMWv8k2j+uxxr9Wq2g1RIpV3QhVnR5jXdbc1i23
         GXaxEYhdnih/VK9ZH01laj9rN2+qb1Spf5j89f8WtgOj7fKVzlVmwpe5ntGIi13jwsQY
         zyCkDBYdU7g6Uur7s8NbY7vG04wU5IRAo2BWoI6EXf+Z9tpCyNuukXTG6fYf8BBdwIim
         +6IyW0d4vOjBrR/v5pvcYyYRblKsVc//CXqi1O5U/sIlV0PPsw2hiIXBl/A0RbEjel/4
         qeTA==
X-Gm-Message-State: AGi0PuYzPwRe6hJgAqFqaHkgCPjyr2XZqfowYpjPUfvtxQ4P2g8MImt4
        el6TYcFgNiTEcdQKLRsf+WH9LXQI
X-Google-Smtp-Source: APiQypJiM5MXCAcLIzBDPzN7BalnUjJnVklglq7ie3aydgXbRtvqZtoyT5Wf/rF5+mzUcgkMIZYohA==
X-Received: by 2002:a0c:b651:: with SMTP id q17mr3161796qvf.135.1588952538086;
        Fri, 08 May 2020 08:42:18 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:17 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 01/15] test_capable_net.te: remove corenet_tcp/udp_sendrecv_all_ports()
Date:   Fri,  8 May 2020 11:41:24 -0400
Message-Id: <20200508154138.24217-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove obsolete corenet_tcp/udp_sendrecv_all_ports() calls; the interfaces
have been removed from upstream refpolicy since the permissions were
obsolete and unused in upstream kernels.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_capable_net.te | 2 --
 1 file changed, 2 deletions(-)

diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
index 80559f6..2255a14 100644
--- a/policy/test_capable_net.te
+++ b/policy/test_capable_net.te
@@ -28,8 +28,6 @@ corenet_raw_sendrecv_generic_if(capabledomain)
 corenet_tcp_sendrecv_all_nodes(capabledomain)
 corenet_udp_sendrecv_all_nodes(capabledomain)
 corenet_raw_sendrecv_all_nodes(capabledomain)
-corenet_tcp_sendrecv_all_ports(capabledomain)
-corenet_udp_sendrecv_all_ports(capabledomain)
 corenet_all_recvfrom_unlabeled(test_ncap_t)
 corenet_all_recvfrom_unlabeled(test_resncap_t)
 corenet_tcp_bind_all_nodes(capabledomain)
-- 
2.23.1

