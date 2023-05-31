Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E6C7EE23
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 01:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjEaBdX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 21:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjEaBdW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 21:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF0EC
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685496757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vDkeU+bLjWmsBkzjdSe+wO+l3/2bG6fd53zNAmYr0s=;
        b=Cmok18x0GmtDiUdxeTzalVOI96Szoty6IC9y0k2HIiXufuWjV1QuBbdGhZGguQAQN4msc4
        5Z2rIOCgv5iFA7Gxc81ov8y09XpoV+Gfx46lghZVW0eNTCpDB2MgexxT8D/bu3I8N2/vCt
        XF9OqqB8+GA1BPVmNoNCZq4okhUgNFo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-atFJT_tpNOCf72TjhU-PgQ-1; Tue, 30 May 2023 21:32:36 -0400
X-MC-Unique: atFJT_tpNOCf72TjhU-PgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C827C381494A
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 01:32:35 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20721140E955;
        Wed, 31 May 2023 01:32:34 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 2/4] dismod: delete an unnecessary empty line
Date:   Wed, 31 May 2023 10:32:22 +0900
Message-Id: <20230531013224.1135775-2-yamato@redhat.com>
In-Reply-To: <20230531013224.1135775-1-yamato@redhat.com>
References: <20230531013224.1135775-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dismod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index eb090a36..f1b879b0 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -1,4 +1,3 @@
-
 /* Authors: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
  * Copyright (C) 2003,2004,2005 Tresys Technology, LLC
-- 
2.40.1

