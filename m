Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF998C2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6453822249
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPz9cicr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgK0IxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgK0IxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 03:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606467201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xacn3ezsyOS7EmVHLDr1GfYlFCfPsPn6J2zL7Xvziyg=;
        b=dPz9cicrM77v/h/QjCDtdgl00mYogKh6nPfTLkScJ6e7ycaIQBCTE33AiD69k3UsGq9GCl
        4ohpr1gCylqxlnFLKyzBW6eWmGJ/Db3vHZWmn8o7Au4Xe6SmYG4utRHaWDrqAgMZwEc0Y9
        XHTe2o3kcPXgNRxbTZ/SvcVeshDmvX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-RBoFmGgxPC-SDMHdLZE-Zw-1; Fri, 27 Nov 2020 03:53:17 -0500
X-MC-Unique: RBoFmGgxPC-SDMHdLZE-Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECCD4185E4A0;
        Fri, 27 Nov 2020 08:53:16 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3D017F73;
        Fri, 27 Nov 2020 08:53:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Hu Keping <hukeping@huawei.com>
Subject: https://github.com/SELinuxProject/selinux/pull/271
Date:   Fri, 27 Nov 2020 09:52:18 +0100
Message-Id: <20201127085220.813760-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Resending patches for review from https://github.com/SELinuxProject/selinux/pull/271


