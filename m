Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFAC433EF
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 16:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhKWQmZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:42:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233425AbhKWQmG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 11:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637685537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jqnl9juJIO6+y/Z8vtH2D2kSORO1B+RZ2STGamOgK3Y=;
        b=JdPS0QiQQ2nqE0RRlpeMuewgOqV7fXYjm3lS67dip9NDBfx+Rq+8SASuKJgGqlqOiW+MqN
        hqWdqC1lVO29cuJpkrEEACm6B+1AUw/ZcaEMiFcR0uAeCJYNc9wgRI0IpHtjvBxEWjr47L
        7XmHNKEdyYuIm8UOwdsn0JSl5fLMs/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-VUi4qAjYMCOfYV3OAgvQRQ-1; Tue, 23 Nov 2021 11:38:56 -0500
X-MC-Unique: VUi4qAjYMCOfYV3OAgvQRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5806F1966321
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 16:38:55 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 581D61981F;
        Tue, 23 Nov 2021 16:38:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] semodule: Don't forget to munmap() data
Date:   Tue, 23 Nov 2021 17:38:51 +0100
Message-Id: <20211123163851.438425-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

semanage_module_extract() mmap()'s the module raw data but it leaves on
the caller to munmap() them.

Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 57f005ce2c62..94a9d131bb79 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -394,6 +394,9 @@ static char *hash_module_data(const char *module_name, const int prio) {
 	sha256_buf[i * 2] = 0;
 
 cleanup_extract:
+	if (data_len > 0) {
+		munmap(data, data_len);
+	}
 	semanage_module_info_destroy(sh, extract_info);
 	free(extract_info);
 	semanage_module_key_destroy(sh, modkey);
-- 
2.33.1

