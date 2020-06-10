Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A35CC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 21:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E554C2072E
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/Mp0GsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFJV52 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:57:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgFJV50 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 17:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591826245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=EmDVUV812Um/BnCfmKxviR5G7cIbPJybAe69FI9PP8c=;
        b=P/Mp0GsJU6x7noigR7GhbVYS8xUVaoO+PxgS/0mUIw20HTlwC5RQwGizqrNR7RV+kXbWS9
        TOpLEQoUjWf2vfNpr27XiAt4563SNtcBBim8dFGETZpFO7uf95ZI0Izd6V/tQEh3aZP1dk
        c7xeXrJupGr2xoLD2Gc11bwN5ZL1x3s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-7z_FXgM7PnSPBd7IFu2qgg-1; Wed, 10 Jun 2020 17:57:24 -0400
X-MC-Unique: 7z_FXgM7PnSPBd7IFu2qgg-1
Received: by mail-qv1-f70.google.com with SMTP id z7so2937690qve.0
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 14:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EmDVUV812Um/BnCfmKxviR5G7cIbPJybAe69FI9PP8c=;
        b=gKRMzGVUV5pIKFNSphpRj6DEA2SAvMyTDOG9kz9xcMIDrAlQkxIhD8DXH1V/KT81in
         JNNDfRh9B2I31YtN1pqtWkqdOYwJgWBpevvxSVr6YWMfNRRIxm7ErkXiU4P2cn+RckIJ
         8qvADqvllZcQmKyS5Q+Fys1XZPl5wO7UA0CmKV96FPxmUTGKkY+OR9xN7/NOlj5+2SUM
         ehT5gYA/d9ASARi+whENIcdleCN/vMOEs7KVg57WcmvzaUVmvOf/u1Px6EtBl8awcRD7
         kmQhJqA/keuqACWMaoFa/HtU5gW2F+YNbUTEMTYDxG3gTVG2eUw0wri2biPfzMjXcm5H
         98Bg==
X-Gm-Message-State: AOAM530VRyVFEGX9Ii6IvJtcuuFOyB3tbCC5aQRWfRPOABmzu0Gpo6iH
        xxsrvRpGCNt9z+cdE1nFIj48cDUJskSgb0Gf40LO5b0pH0V0tPDg+KLpIx8Mwz82MPiR52dzuvW
        mOWKKsqSsHYHtMph5CA==
X-Received: by 2002:a37:7c6:: with SMTP id 189mr5121388qkh.24.1591826244088;
        Wed, 10 Jun 2020 14:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk72KKo1Ch5zw2WW6aFj5l1fiGONWuH1WvqLC0CrvwcuDgU3Kc7we6z0zk1fANufD9rEpO6A==
X-Received: by 2002:a37:7c6:: with SMTP id 189mr5121378qkh.24.1591826243867;
        Wed, 10 Jun 2020 14:57:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t13sm934883qtc.77.2020.06.10.14.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:57:23 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, jeffv@google.com,
        rgb@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/1] selinux: fix double free
Date:   Wed, 10 Jun 2020 14:57:13 -0700
Message-Id: <20200610215713.5319-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200610215713.5319-1-trix@redhat.com>
References: <20200610215713.5319-1-trix@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang's static analysis tool reports these double free memory errors.

security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
                        kfree(bnames[i]);
                        ^~~~~~~~~~~~~~~~
security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(bvalues);
        ^~~~~~~~~~~~~~

So improve the security_get_bools error handling by freeing these variables
and setting their return pointers to NULL and the return len to 0

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 313919bd42f8..ef0afd878bfc 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2888,8 +2888,12 @@ int security_get_bools(struct selinux_state *state,
 	if (*names) {
 		for (i = 0; i < *len; i++)
 			kfree((*names)[i]);
+		kfree(*names);
 	}
 	kfree(*values);
+	*len = 0;
+	*names = NULL;
+	*values = NULL;
 	goto out;
 }
 
-- 
2.18.1

