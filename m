Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00915C433EF
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF94360E93
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 19:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbhICTOO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 15:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350992AbhICTOK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 15:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630696389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zIX28nC6zmFqgyrrEB9WZTna3+EnmmaaEBI/PAMciI=;
        b=RM9g+CzGoXYS3nfey1Fp1QZ+rn75s1ahK0cU7dWYbtfmiJ1jIqaazS4KOMo5fOppWzncvj
        bbjtyxk5EIFzg0M50sqfuPHl5Uwau/Vk7Q33nRcoXdih27Coj5/0tpaiRVtpFXa/Ff1BE0
        dwPFKa86MJ1gxpSYvZww9tBgPsE8zrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-ZP7XQFBTMeO4RWijpqLjzw-1; Fri, 03 Sep 2021 15:13:08 -0400
X-MC-Unique: ZP7XQFBTMeO4RWijpqLjzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E340210866A0
        for <selinux@vger.kernel.org>; Fri,  3 Sep 2021 19:13:07 +0000 (UTC)
Received: from localhost (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F80C19C59
        for <selinux@vger.kernel.org>; Fri,  3 Sep 2021 19:13:07 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: lets think about 3.3 release
In-Reply-To: <87zgsu9j9c.fsf@redhat.com>
References: <87fsvmu2xa.fsf@redhat.com> <87zgsu9j9c.fsf@redhat.com>
Date:   Fri, 03 Sep 2021 21:13:06 +0200
Message-ID: <87pmtpa2wt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Petr Lautrbach <plautrba@redhat.com> writes:
>
>> Hello,
>>
>> I's about 184 commits and 5 months since the last release so I think
>> it's time to slowly stop the development and start with 3.3 release
>> candidates.
>
>
> Currently patchwork contains just these patches which should be relevant
> to 3.3:
>
> https://patchwork.kernel.org/patch/12435365/ New [1/2] libsepol/cil: Improve in-statement to allow use after inheritance
> https://patchwork.kernel.org/patch/12435363/ New [2/2] libsepol/secilc/docs: Update the CIL documentation
>
> These are probably superseeded already, but I'm not sure. Please take a look.
>
>
> https://patchwork.kernel.org/patch/12470297/ New [1/3,v2] libsepol/cil: Remove redundant syntax checking
> https://patchwork.kernel.org/patch/12470301/ New [2/3,v2] libsepol/cil: Use size_t for len in __cil_verify_syntax()
> https://patchwork.kernel.org/patch/12470299/ New [3/3,v2] libsepol/cil: Fix syntax checking in __cil_verify_syntax()
>
> Wait for review.
>
> So I think selinux-3.3-rc1 can be released on next Wednesday 2021-09-08
>
> If you have any concerns, comments or suggestion, let us know.
>
> Also I really don't understand all the changes in libsepol so please help me
> to collect release notes information for it. I'll post a release notes
> draft with other components later today.
>

I'm sorry but I won't make it today. I have to leave it on Monday
morning.


Petr

