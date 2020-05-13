Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9203C433E7
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AD9207D5
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 14:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INDB4XEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbgEMOni (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 10:43:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728345AbgEMOni (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 10:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589381017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yrVUmeZ/CFcwqdSUZpyt1C3ak4pBDdXobJfMlV5Y1cA=;
        b=INDB4XEKHoOeV3yYGd+D8LP6G31bvWgLzE8pf2yrWZU/i1eSW3kQN1B/dCSUkppaAVG+PT
        kZofYgnAN2s65S6PDtpSs6CBw3pIULG97yBI75lsqpPtgrKsOZVOQ9nK7fRA11/kCg8uTG
        ujb0cxnb7EzP9iKQ8l1YQWOGeDTwQmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-davz1c2aPLmidWOXe8ANbQ-1; Wed, 13 May 2020 10:43:34 -0400
X-MC-Unique: davz1c2aPLmidWOXe8ANbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7DD3A0BDF
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED8D95D9C5;
        Wed, 13 May 2020 14:43:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] secilc: Fix policy optimization test
Date:   Wed, 13 May 2020 16:43:29 +0200
Message-Id: <20200513144329.181671-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 692716fc5fd5 ("libsepol/cil: raise default attrs_expand_size to 2") was
reverted and attributes with one type are not expanded anymore.

Fixes:
    ./secilc test/policy.cil
    ./secilc -c 32 -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
    checkpolicy -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
    diff test/opt-expected.cil opt-actual.cil
    11a12
    > (typeattribute at01)
    21a23
    > (typeattributeset at01 (tp01))
    25c27,28
    < (allow tp01 self (cl01 (p01a p01b p11a p11b)))
    ---
    > (allow tp01 at01 (cl01 (p11b)))
    > (allow tp01 self (cl01 (p01a p01b p11a)))

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 secilc/test/opt-expected.cil | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/secilc/test/opt-expected.cil b/secilc/test/opt-expected.cil
index 73ac9045f23e..14033f9be4dd 100644
--- a/secilc/test/opt-expected.cil
+++ b/secilc/test/opt-expected.cil
@@ -9,6 +9,7 @@
 (category c01)
 (categoryorder (c01))
 (sensitivitycategory s01 (c01))
+(typeattribute at01)
 (typeattribute at02)
 (boolean b01 false)
 (type tp01)
@@ -19,10 +20,12 @@
 (type tpr3)
 (type tpr4)
 (type tpr5)
+(typeattributeset at01 (tp01))
 (typeattributeset at02 (tp01 tp02))
 (allow at02 tpr1 (cl01 (p01a p01b p11a)))
 (allow at02 tpr3 (cl01 (p01a p01b p11a)))
-(allow tp01 self (cl01 (p01a p01b p11a p11b)))
+(allow tp01 at01 (cl01 (p11b)))
+(allow tp01 self (cl01 (p01a p01b p11a)))
 (allow tp01 tpr1 (cl01 (p11b)))
 (dontaudit at02 tpr2 (cl01 (p01a p01b p11a)))
 (dontaudit at02 tpr4 (cl01 (p01a p01b p11a)))
-- 
2.26.2

