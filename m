Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E4FC433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 09:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiDAJ7a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiDAJ73 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 05:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8278A26C557
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648807058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yuDP1Bvn14Fq2yiv6at6cYWw4U15ZtHxR8jqm/zdMEg=;
        b=KBHpMdXTFj9h8ghU2zcTr/yCTG1QlAfYzxuslPODEx1t1BTsMQNNzUzH4r05Uv0TL6S8jg
        K9ZrXxIvOiRxvTlzzDi8R/SlOjGJN2YpicfF/JSMat1OYYRGT1DDiGIwV82Ns03Kkdb2ar
        nBs0Lx1gSoBS3rlnE5csbX4LLZ5QPKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-I-rV5AdzPkCmP2TU-MiGSA-1; Fri, 01 Apr 2022 05:57:37 -0400
X-MC-Unique: I-rV5AdzPkCmP2TU-MiGSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2B079730C2
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78FD740D0160
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 09:57:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Translate or not?
Date:   Fri,  1 Apr 2022 11:57:23 +0200
Message-Id: <20220401095724.98956-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

the translations in this project wasn't really updated since 2013. There was only a minor French
translation update in 2016.

OTOH Fedora project still provides translations which are used there
https://translate.fedoraproject.org/projects/selinux/

Also there's was a split back in 2016 which moved gui, python and sandbox out of
policycoreutils.

The following patch splits also the translations. And there's second patch
available in my github repository which updates the translations from
https://translate.fedoraproject.org/projects/selinux/ and which is too big
for this list:

https://github.com/bachradsusi/SELinuxProject-selinux/commit/afa35aea4a95089d9c99504e627fb573d836f7e8

Thanks,

Petr

