Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3EC63777
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7449121534
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 09:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gch2nNLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgK0JgZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 04:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgK0JgY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 04:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606469783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJT7k73LrJRo6W1RFgQklUXf1aB6XBq2N6TcrTh3tqk=;
        b=Gch2nNLPsGjCD78bA0ATiv6V+TplKyE6VM6AJTHb83HvBpdfTG50ZPMa2F1stlpAGLyLsg
        ks/FiKmdUSqvyAGDdjalkesldJIAfikMACdJ8zr6Ubj2SEnMKBc37JsuzXvooYFN1Mut79
        ZVwDHGkHggMJNE+onzCq/hlg0biKIZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-0w5UbhdwPWiFILMFeH2DNQ-1; Fri, 27 Nov 2020 04:36:18 -0500
X-MC-Unique: 0w5UbhdwPWiFILMFeH2DNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEA3C107AD3C;
        Fri, 27 Nov 2020 09:36:16 +0000 (UTC)
Received: from localhost (unknown [10.40.194.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66EF15C1C2;
        Fri, 27 Nov 2020 09:36:16 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Hu Keping <hukeping@huawei.com>
Subject: Re: https://github.com/SELinuxProject/selinux/pull/271
In-Reply-To: <20201127085220.813760-1-plautrba@redhat.com>
References: <20201127085220.813760-1-plautrba@redhat.com>
Date:   Fri, 27 Nov 2020 10:36:15 +0100
Message-ID: <87eekfi1kg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Resending patches for review from https://github.com/SELinuxProject/selinux/pull/271

Acked-by: Petr Lautrbach <plautrba@redhat.com>

