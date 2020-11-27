Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB08C63777
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10C422249
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDWxgWSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgK0Ixb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgK0Ixa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 03:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606467210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SM39iyZJYJeWrb2MTGGRcWZz25lDnPuBUIEizzF69o=;
        b=hDWxgWSx3YXsbaAOWFOWQoJ7kCTSlN5tWaMl6Mv3gI/JXJMM/bl19TImfio9k7V6N589zH
        KZPAKN83BENt1plqvLJgArzWnc9XNKz8QH2Yb60Dw89r/1jFt6oE+qJdB7brvyApM969qL
        Aa0DtotqwKYW1nNROc2/3g4sPduvnko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-hpPkMrWSMUaQNQ0h_yhzKQ-1; Fri, 27 Nov 2020 03:53:27 -0500
X-MC-Unique: hpPkMrWSMUaQNQ0h_yhzKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F75A3E747;
        Fri, 27 Nov 2020 08:53:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44E1519C46;
        Fri, 27 Nov 2020 08:53:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Hu Keping <hukeping@huawei.com>
Subject: [PATCH 1/3] Introduce VERSION file for selinux
Date:   Fri, 27 Nov 2020 09:52:19 +0100
Message-Id: <20201127085220.813760-2-plautrba@redhat.com>
In-Reply-To: <20201127085220.813760-1-plautrba@redhat.com>
References: <20201127085220.813760-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Hu Keping <hukeping@huawei.com>

Init it to 3.1 as the same with the other 14 VERSION files
in this project.

Signed-off-by: Hu Keping <hukeping@huawei.com>
---
 VERSION | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 VERSION

diff --git a/VERSION b/VERSION
new file mode 100644
index 000000000000..8c50098d8aed
--- /dev/null
+++ b/VERSION
@@ -0,0 +1 @@
+3.1
-- 
2.29.2

