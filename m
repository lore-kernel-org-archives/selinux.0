Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3271C352A1
	for <selinux@archiver.kernel.org>; Thu, 24 Nov 2022 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKXQdI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXQdH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Nov 2022 11:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B91816FB2F
        for <selinux@vger.kernel.org>; Thu, 24 Nov 2022 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669307523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CloTFOSHtWrAsgAgV5y8ERzmFNIzO8D68rrT0A37/dQ=;
        b=WVQ9HX7kKA3pX5Nateo9sAvCfSFp+nUsrasNOonLO/mL6I2eAoww3kFTa1Euz7DuqwfC+U
        dR8OONPdMGCkoXZR/gXVoHUsrdvXTZ6onuSg6Joc9dbp6aO0zrFZ/OQs2I9vkXPVQxJIuA
        5MeYcSB5V3dcy37FOlIr05GuWO/jLrs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-PQgpW9KhObapY6JNemTcqQ-1; Thu, 24 Nov 2022 11:32:02 -0500
X-MC-Unique: PQgpW9KhObapY6JNemTcqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66E629ABA36
        for <selinux@vger.kernel.org>; Thu, 24 Nov 2022 16:32:01 +0000 (UTC)
Received: from ovpn-194-85.brq.redhat.com (ovpn-194-85.brq.redhat.com [10.40.194.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 860B04C819
        for <selinux@vger.kernel.org>; Thu, 24 Nov 2022 16:32:01 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] checkpolicy: Improve error message for type bounds
Date:   Thu, 24 Nov 2022 17:31:52 +0100
Message-Id: <20221124163153.500945-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make the error message consistent with other occurrences of the
same issue:
https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/module_compiler.c#L243
https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/module_compiler.c#L488

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 41e44631..86d57017 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1416,7 +1416,7 @@ static int define_typebounds_helper(char *bounds_id, char *type_id)
 	if (!type->bounds)
 		type->bounds = bounds->s.value;
 	else if (type->bounds != bounds->s.value) {
-		yyerror2("type %s has inconsistent master {%s,%s}",
+		yyerror2("type %s has inconsistent bounds %s/%s",
 			 type_id,
 			 policydbp->p_type_val_to_name[type->bounds - 1],
 			 policydbp->p_type_val_to_name[bounds->s.value - 1]);
-- 
2.37.3

