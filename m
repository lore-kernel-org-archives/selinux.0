Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643FCC64E7B
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 17:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09895217A0
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 17:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgLBRf6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:35:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgLBRf5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 12:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606930471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QWi+P/ty4wJq0I9GhGXrdYSPRodmxM9aMTl1ifH+ma0=;
        b=UZJTRurueqbVH3kuBFIIk6iIMw6Jj/ChUHdOMKhmrT5UetsB0Pd24/dn2g8eVrzb43luYT
        S0Kr0JiSs0l6avEXUXwBboCh2WmTroamZfstfZJo5tTHe0i7R4ZUP7jHCpMy9046+JlMF/
        oyshdlm1SBFkOZbus5egX/xM808IFQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-Kxm6KQjpOTudAXLxzeHIPA-1; Wed, 02 Dec 2020 12:34:29 -0500
X-MC-Unique: Kxm6KQjpOTudAXLxzeHIPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D766185E489;
        Wed,  2 Dec 2020 17:34:28 +0000 (UTC)
Received: from localhost (unknown [10.40.193.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 691605D6BA;
        Wed,  2 Dec 2020 17:34:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Hu Keping <hukeping@huawei.com>
Subject: Re: https://github.com/SELinuxProject/selinux/pull/271
In-Reply-To: <87eekfi1kg.fsf@redhat.com>
References: <20201127085220.813760-1-plautrba@redhat.com>
 <87eekfi1kg.fsf@redhat.com>
Date:   Wed, 02 Dec 2020 18:34:25 +0100
Message-ID: <87eek8p0wu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Petr Lautrbach <plautrba@redhat.com> writes:
>
>> Resending patches for review from https://github.com/SELinuxProject/selinux/pull/271
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged, thanks!

