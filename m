Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF157C433EF
	for <selinux@archiver.kernel.org>; Mon, 21 Feb 2022 14:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356007AbiBUOHR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiBUOHQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Feb 2022 09:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADAE31D301
        for <selinux@vger.kernel.org>; Mon, 21 Feb 2022 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645452412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x5xLc6dmz29paDaQ4yPSiej4Lf69VT3T52msvdTnrho=;
        b=iRSW9gNcPE1anegMslLN5CqgmWBtAjDKrE8Mbe/A4FLhOH5nWOKxLwzIhZMCA0b/UYNYZ6
        cbMvz0jHh0Vb5uAGqq8lt7fT/vPFu4WUr9jMIR8CjiP7NwiQbT6i0DZgMJ279ol/YXF7Sv
        tJyyS+8YYlf5EtcotuPKzzaNwFq/Z+o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-bjgkzvL6OJW2QLHCWEafuQ-1; Mon, 21 Feb 2022 09:06:51 -0500
X-MC-Unique: bjgkzvL6OJW2QLHCWEafuQ-1
Received: by mail-ed1-f69.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so4485746edd.3
        for <selinux@vger.kernel.org>; Mon, 21 Feb 2022 06:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x5xLc6dmz29paDaQ4yPSiej4Lf69VT3T52msvdTnrho=;
        b=gayXBdUs/1I23Iz7LSvxzfD1imNH/wmwrErByt3ZKsm2KWO/Y7f9DAVN1Ho1aou8qX
         ZBko+A6zXr4SxDy5fp0KPCEkYRG7t2WpTcHtYbSCA10DlY4fytoTVq2ZGakMjRAjKVPd
         BjhsQtcUGw0Qu/JofCFgo+e38XUXj683j5RwArFNcAjxGIunGLAZAehW0lNuaZxb+oYC
         DhMQAgBwQ5BGOqRZlOxEGItKXolC+Oju2K0fhWj/2ETHFmYmC6hxuWrSgDFaeeu5O3g+
         758GB1FycHf22Z3f724etyP1PjPy6uoS+vv3aMfwpKq4N+PeVUmv7F/ff6Omp2pFYTa4
         sN2Q==
X-Gm-Message-State: AOAM5307UrNQFa/DscLBL6t0PyyLnC4/yA0pE/8h9QigBirm8ZkEKWyQ
        gKXrY9JjSjuhrR4U8wrRlzfimmmeJTcLJV1ikkHWVTw25ltggXkLvlcLPq7YeR++PvNscd3qdue
        2QN1SojfScGAfkuijnQ==
X-Received: by 2002:aa7:df1a:0:b0:409:5174:68a9 with SMTP id c26-20020aa7df1a000000b00409517468a9mr21951074edy.145.1645452410245;
        Mon, 21 Feb 2022 06:06:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyADFxqO+yimd0EAr8r9bKcl7Fi+Hy8PBtWFjfI5yPxFOTgIVbC+BLHdVLWE59v09Z7BM7hBA==
X-Received: by 2002:aa7:df1a:0:b0:409:5174:68a9 with SMTP id c26-20020aa7df1a000000b00409517468a9mr21951056edy.145.1645452410027;
        Mon, 21 Feb 2022 06:06:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id f27sm5198478ejf.135.2022.02.21.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:06:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: fix misuse of mutex_is_locked()
Date:   Mon, 21 Feb 2022 15:06:49 +0100
Message-Id: <20220221140649.360897-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

mutex_is_locked() tests whether the mutex is locked *by any task*, while
here we want to test if it is held *by the current task*. To avoid
false/missed WARNINGs, use lockdep_assert_is_held() and
lockdep_assert_is_not_held() instead, which do the right thing (though
they are a no-op if CONFIG_LOCKDEP=n).

Fixes: 2554a48f4437 ("selinux: measure state and policy capabilities")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ima.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 727c4e43219d..ff7aea6b3774 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -77,7 +77,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	size_t policy_len;
 	int rc = 0;
 
-	WARN_ON(!mutex_is_locked(&state->policy_mutex));
+	lockdep_assert_held(&state->policy_mutex);
 
 	state_str = selinux_ima_collect_state(state);
 	if (!state_str) {
@@ -117,7 +117,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
  */
 void selinux_ima_measure_state(struct selinux_state *state)
 {
-	WARN_ON(mutex_is_locked(&state->policy_mutex));
+	lockdep_assert_not_held(&state->policy_mutex);
 
 	mutex_lock(&state->policy_mutex);
 	selinux_ima_measure_state_locked(state);
-- 
2.35.1

