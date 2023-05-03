Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B2C77B78
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 12:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjECMGB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 08:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECMGA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 08:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2083A5585
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683115515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=41q8VIOUlU0TFy0MsUtJ3UQUaXdT54P+PzOYQG+lxlk=;
        b=VFcip7nLmbMYrBQ7i7P9E8l9DP9kTwcvjU7VXKRvkW/9ZFlmbVYO5wvyWBVqy1U+nnVOf8
        ozm1UTKxSbW8Ap33QGPlnOxAIgzI2DT+uKLOWBKMoAJe+sldG4tTzwmYrXjiVlP9OHwWHg
        Ig7GteQnTtdD008bzgkQH50K+lUGYuY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-K_4Atj_cPQW2mdSrQ5HADA-1; Wed, 03 May 2023 08:05:14 -0400
X-MC-Unique: K_4Atj_cPQW2mdSrQ5HADA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C59FF3C0F362
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 12:05:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6662D1410F29
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 12:05:13 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/3] python: Improve man pages 
Date:   Wed,  3 May 2023 14:03:29 +0200
Message-Id: <20230503120332.699464-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch series tries to improve man pages of python tools (add
missing parameteres, improve descriptions, note corner cases).
I'm not a native speaker so please excuse grammar mistakes (but please
let me know so that I can fix the patchset).


