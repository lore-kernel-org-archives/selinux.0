Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5679BC433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 13:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbiDANhw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDANhv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 09:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81F2818383A
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648820161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/APoZMCYR14ys76aaGjDb7h8Aie7VV6DLr4eQ+tun34=;
        b=Nl4g0hgX0sJ+qlK9uOF27DDDctHItKaD+9LX3pvcNhITPdXDGurvgFC4v8pmwDU6ol5hob
        mS0plVv1IMaJaK/8xNhGzY9zaX2+1rOR+4E1YJFTrBMqQf/JQ4/7Yn2cGkBk6xhjqDKDe7
        lygDYYFUvwz5V/ieBHIKw2g4mBCbxYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-5DeFH22TNCu3kbNal43p_g-1; Fri, 01 Apr 2022 09:36:00 -0400
X-MC-Unique: 5DeFH22TNCu3kbNal43p_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E6BF811E76
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AAA540C1438;
        Fri,  1 Apr 2022 13:35:59 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/3] semodule_package: Close leaking fd
Date:   Fri,  1 Apr 2022 15:35:48 +0200
Message-Id: <20220401133549.122069-2-plautrba@redhat.com>
In-Reply-To: <20220401133549.122069-1-plautrba@redhat.com>
References: <20220401133549.122069-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 semodule-utils/semodule_package/semodule_package.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index 3515234e36de..bc8584b51079 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -73,6 +73,7 @@ static int file_to_data(const char *path, char **data, size_t * len)
 		goto err;
 	}
 	if (!sb.st_size) {
+		close(fd);
 		*len = 0;
 		return 0;
 	}
-- 
2.35.1

