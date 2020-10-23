Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646AC4363A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8379D206DD
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ideKRiR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460890AbgJWOxC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S460728AbgJWOxC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 10:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603464780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkhQu9ppbT/c1/1r1X4hFZCzKOoslni4D7hXcBGCnpA=;
        b=ideKRiR4zC1Z8rt2cVrRzWmUAOscLAA8FlnuVjXyBHLnHVjLD5CG59JSnsCyyCoAT6t1F8
        tOvg3Vqd0BOG5C8r+EdMn3qTu6+SIlxgcYlfDg71IpKkA2/PRHc4rlHAD8SRTrjq8FvVYI
        58xjWmY8Wi5fO4ZqxcDLHaSoSiIpj3E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-ZE4J9wphO1uKRlT6H2N_4Q-1; Fri, 23 Oct 2020 10:52:57 -0400
X-MC-Unique: ZE4J9wphO1uKRlT6H2N_4Q-1
Received: by mail-lj1-f198.google.com with SMTP id r27so775164ljd.8
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FkhQu9ppbT/c1/1r1X4hFZCzKOoslni4D7hXcBGCnpA=;
        b=mMLhdiJPJMPLBt5GiMfXtW/qrTYyv2XMiYZANY96m4SQ7nwYmI/b3yHFXCvOJ7/r/B
         rLihLbV5s6nJDZWX3xcdbIkhLBymg/C19ux84XyMbxYFaOqgr8W3LrhT92MMyz7PQ2pW
         6ux+9l04uP4x5UmSFUkIz53X51nArZRI8L4lvUL24vFKwaqdXSTzmYErj8RcpDR6/3tT
         NhmXYJV+nvQlPVHEjAkZlfjQ9Tx+7AzVb72i4IRuA9yOwtM0sNXi13XtttS7p78zeSOt
         R6Rk/ESchGDOs98yW7Z3RJYmIG8+wup3JLLTl/abW6x/8qjUl0yeB0piorf6V9uvBVwF
         ytIg==
X-Gm-Message-State: AOAM530ofHnDMkN7Fd71sL/gBOAuuhcvkwE7kRawtNZmSYuUP/poi9ia
        tW4nYvZJTTYV87uPHN/fDAqpwsaJW/ASm1humc5asNJDTyL0jnIwrqS0fzR1PSDFQaXrgsSNPOF
        umrwMPA9xUQmKw+3OSuJN577Yhb7Glngblg==
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr1101133ljn.337.1603464775196;
        Fri, 23 Oct 2020 07:52:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHjqcbp5e9jnHIz2Vixs7LBK7Ppbf9QmQL3cRiSqxbakgtOnNgZzh7qFSSwPDVhqomEL91aL2SJlIGSfZeKAc=
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr1101130ljn.337.1603464774942;
 Fri, 23 Oct 2020 07:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201014073721.392783-1-omosnace@redhat.com> <20201014073721.392783-2-omosnace@redhat.com>
In-Reply-To: <20201014073721.392783-2-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Oct 2020 16:52:43 +0200
Message-ID: <CAFqZXNvi8EPutEZfiHX3ALDv-bYdDqD__sYbSB7YEoHJh-n-rA@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/1] tests/keys: fix the KEYCTL_DH_COMPUTE
 parameter values
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 14, 2020 at 9:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The KEYCTL_DH_COMPUTE key payloads are interpreted as MPI-formatted
> numbers. Even though the generic DH algorithm implementation doesn't
> look at the actual values when setting the parameters (and probably only
> validates them later when doing the actual operation), this isn't
> necessarily true for other implementations. Specifically, the Intel QAT
> driver checks if the prime size is one of 1536, 2048, 3072, or 4096
> bits, causing the KEYCTL_DH_COMPUTE operation to fail with -EINVAL.
>
> While it is questionable if the QAT implementation should reject unusual
> prime sizes (it should use a fallback to generic instead), let's just
> make sure we pass valid numbers to avoid similar validation errors.
>
> I verified on a machine with an Intel QAT device that this patch makes
> the testsuite pass there.
>
> Fixes: 2d7aad8a1f8c ("selinux-testsuite: Add keys tests")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

I have now applied this patch:
https://github.com/SELinuxProject/selinux-testsuite/commit/19b43c07d87278023b8637eba1be83eb73f22606

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

