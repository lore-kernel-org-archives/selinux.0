Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E7C2D0EA
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 09:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FB92074F
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 09:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7AkllpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDHJIQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:08:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726775AbgDHJIQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Apr 2020 05:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586336895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m0Id8T047mWeL0hqFZpuotQZxr8D83lsMn0Xkkzurjs=;
        b=S7AkllpHVtYErdiNoJ+eoqliR2GVUQ/mgfxif4Eh+WyJZOTqk0A6OT5fk0DljxU8rWes/w
        to0/atTuaXQbnNnh9hIXeXLRoVTt4oHS5g5zl5z0849HcTKvGqB763TgUbp/lWhe4bOl65
        6C0c91aS41gS4JQZx+5UIAwnbRsSkww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-pTjIWEe0PoOp_8NuwMqi2g-1; Wed, 08 Apr 2020 05:08:13 -0400
X-MC-Unique: pTjIWEe0PoOp_8NuwMqi2g-1
Received: by mail-wr1-f72.google.com with SMTP id h95so3639780wrh.11
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2020 02:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0Id8T047mWeL0hqFZpuotQZxr8D83lsMn0Xkkzurjs=;
        b=kwrPx6zxKnteK9cP77kjIeHBgQVG1Szko6NRq+gD8qNwhrsWnR4ujTkdSP2NkuTjvu
         IaUHFe3VEvBD61ti7yvne6e6K4Z7m31laRPF0vtJFsEaR5l2NtrOS8sk4KGm4VpK8PVY
         M7d1owv67O60o4iPR3e1eDx8OyrfX07jOr/7pphwdGxzifDJgwMsTOECTDL3oL0hwVmQ
         t+CFgQR12Y55KZeeTj02CLrCQqf6bAFPVTUIJuMLwlP3HOp8MUsmHJZZzuqp04G4r8up
         lg8HsGx5PpF99Cgbkukd+JGNMg+VRjseH5dMqtfc6p/mS0gksvJaKQDYt7FIvl4Nk34J
         uKYA==
X-Gm-Message-State: AGi0PuYGAFJqMlOe13w9PXZVKSJmQiuknbuKkKGW4x9A6PdRyWFqbL9F
        K2RwgaKnevNmuwUxhA7pypdDnVhDTzqp5m5J+8Kki+dHwWQKT2Rf+DcmB/I9ZXbEBTtRKVt9T3x
        Frp+Nhkcya/Jzir0t/w==
X-Received: by 2002:a05:600c:4102:: with SMTP id j2mr3793557wmi.159.1586336891936;
        Wed, 08 Apr 2020 02:08:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypIRRL6VlC/x12dwIOxc4XF3F5YipUEuQvjEJaG99Ib0M+quARXjM3JI7qXywhHSBFQT8TAgww==
X-Received: by 2002:a05:600c:4102:: with SMTP id j2mr3793536wmi.159.1586336891700;
        Wed, 08 Apr 2020 02:08:11 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y7sm33763116wrq.54.2020.04.08.02.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 02:08:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH] selinux: drop unnecessary smp_load_acquire() call
Date:   Wed,  8 Apr 2020 11:08:08 +0200
Message-Id: <20200408090808.1219529-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In commit 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table") the
corresponding load is moved under the spin lock, so there is no race
possible and we can read the count directly. The smp_store_release() is
still needed to avoid racing with the lock-free readers.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/sidtab.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a308ce1e6a13..f90397284a57 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -276,8 +276,7 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 	if (*sid)
 		goto out_unlock;
 
-	/* read entries only after reading count */
-	count = smp_load_acquire(&s->count);
+	count = s->count;
 	convert = s->convert;
 
 	/* bail out if we already reached max entries */
-- 
2.25.2

