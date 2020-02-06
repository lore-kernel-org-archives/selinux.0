Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31994C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BE0222C2
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5axv5g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBFP21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:28:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727138AbgBFP21 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 10:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xb+g2uFMytA+NJ8bKu9Zxj0XEObza8gsoR4NaVmi07s=;
        b=I5axv5g490ugeRJiAg4zGGDgfQrk2D3/Wt9G/ogjllq+xivzMIqJOCfFpwFvk+DatO3h4H
        T5hN4J7O8Ui9IHYB5Th6CeKY6+KeLu+H4Mf5Ag5zHKlKIQTn/c890FxtbCZKZ+k8HRaC8K
        Sm4bMH9/uNF2BecAPdrQeZmIoo2+yuo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Ko1x9rPDOl6FApRQBI_mQQ-1; Thu, 06 Feb 2020 10:28:25 -0500
X-MC-Unique: Ko1x9rPDOl6FApRQBI_mQQ-1
Received: by mail-ot1-f70.google.com with SMTP id n22so3383677otr.23
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 07:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb+g2uFMytA+NJ8bKu9Zxj0XEObza8gsoR4NaVmi07s=;
        b=aWaL4fGeXsYAN1cVTp0eUlAw1cV9kXArAq6mcQhHN0AF3UTfkMdu8k3Du7MZM3G5tE
         /aRxGyRNqnFGSig7om8H5plYIcxsb52N9fzEchdQ5RX4TVRyUY2viIT9iqfEouDiwiSO
         GTZ2k+41CDjaDIFiio+P0Qb7GyuukmM21vq7KmPo7ivpLQ1+0EghNSQ0OabUYSvdKB6d
         tIgkwLsQjOIO+wzZktxhou69jqU5aIL08eq07nnKyqkMTXGggp2JL2RZlQ1Wxjoj9xub
         gETszynPGrYCUBzL0nvjj6IIPZGkD6bCYODqcRJza6KLm0Xf6tT8urPNOj29ihIziHeO
         Da4A==
X-Gm-Message-State: APjAAAXcZqLMznn4F1rB+brkfjU1U3j1SNffERqz6aJS+CEzZdjOiYeI
        CUBBImxjDUo/sA0y8XAXnPQRC8bSCq8CSM5gIA0+QQUGjb/6MKLsAqMhIJIoq+tVsf8iObyXsbT
        BkglPBtg1ZKT+9+3FUiQKycB/XEJVeNP0Jw==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr7411267oid.26.1581002904165;
        Thu, 06 Feb 2020 07:28:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyV4TPvm2Znts8GG2Xo90qRcG8OESkqLBNTVZuMSZauRJwumhwg4IERJvunWdACZiyrR/geQSVjLv7A2hAl/wY=
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr7411252oid.26.1581002903892;
 Thu, 06 Feb 2020 07:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20200206131253.535302-1-omosnace@redhat.com> <20200206131253.535302-3-omosnace@redhat.com>
 <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov> <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
 <5714f2b9-2dc1-feaf-1f73-2a50a464101b@tycho.nsa.gov>
In-Reply-To: <5714f2b9-2dc1-feaf-1f73-2a50a464101b@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 6 Feb 2020 16:28:13 +0100
Message-ID: <CAFqZXNuAZWx4b9UrT68ui2HbD8mY94jz393ErowaC2soV6f7Vw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command line
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 6, 2020 at 3:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/6/20 9:19 AM, Ondrej Mosnacek wrote:
> > On Thu, Feb 6, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 2/6/20 8:12 AM, Ondrej Mosnacek wrote:
> >>> When using semodule for building a distribution policy package (as
> >>> Fedora does), the environment might not have selinuxfs available and
> >>> provide no way to modify semanage.conf. When we want to build a policy
> >>> with version X (because our kernel doesn't support X+1 and above yet),
> >>> but our libsepol already has support for X+1, then we currently have no
> >>> way to do so.
> >>
> >> Not fundamentally opposed, but unclear on the motivation.  The current
> >> approach is to generate the highest policy version supported by our
> >> libsepol at build time, then libselinux selinux_mkload_policy() uses
> >> libsepol functions (sepol_policydb_set_vers(),
> >> sepol_policydb_to_image()) to automatically downgrade the policy in
> >> memory to whatever version is supported by the kernel before writing it
> >> to the kernel.  This works as long as one uses the same or newer
> >> libsepol at load time as at build time and as long as policydb_write()
> >> supports writing older policy versions (generally discarding newer
> >> features).
> >
> > The problem is that:
> > 1. selinux-policy expects that the generated /etc/selinux/.../policy.X
> > file will be generated with a specific (hard-coded) value X, so if the
> > userspace is updated in buildroot, the selinux-policy build fails.
> > 2. If we fix the above by expecting any value X and ship that, then
> > the build passes in such case, but if a user updates selinux-policy
> > without updating userspace and reboots, the system will not boot. So
> > even if we stop incrementing the expected policy version manually, we
> > would still need to manually increment the minimum required userspace
> > version each time the policy is rebuilt with userspace that has
> > incremented its max policyvers.
>
> Seems like you could just have selinux-policy depend on the version of
> libsepol used to build it.
>
> The problem with both your current approach and your proposed one is
> that it means that if a user or package does a semodule -B (or any other
> semodule/semanage command) on their system, that will generate the
> latest policy.N version supported by their libsepol, and libselinux will
> give precedence to that policy at load time.  So if they then later
> update their selinux-policy package, and it only installs a prebuilt
> policy.(N-1), that won't actually get loaded - libselinux
> selinux_mkload_policy() will keep using the policy.N file (which may be
> older).  Unless I'm missing something.

Hm, yes, you're right... It seems we have no other choice than to
better handle the dependency between selinux-policy and libsepol.
Please disregard this patch series.

>
> > With these patches we can call semodule -V %{POLICYVER} ... and new
> > rebuilds of selinux-policy wouldn't be disrupted by userspace
> > upgrades. The only downside is that we would need to remember to
> > increment the specfile versions from time to time.
> >
> > OTOH, maybe the build failure is actually a good thing in that it
> > serves as a reminder to bump all the hard-coded versions whenever
> > userspace bumps max policyvers...
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

