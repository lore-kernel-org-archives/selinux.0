Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B48BC433F5
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F5F6052B
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhJLO4I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236987AbhJLO4I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 10:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634050446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqzffMUKKlQ+aSeD+udH8qSMj3xtr36+LJy2qI+5/HM=;
        b=Q1VLXZYZWCbro3kaiuMlBJK4gwFWbKahxHQvYJZNHn12/tKXrBGTRqcnzpvTP2EA/Rcuj2
        afmtbPzLt/JHFrIdOR0JIIUhJeyNOmz0i5eX4UF/2yquCBAib0cABi5aLrtgwDrEqXSW4i
        MxYm6PROKpp8Fzo2tjoCnJOFiODAu8A=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-RS3taG85MpSnyiDrCniEmg-1; Tue, 12 Oct 2021 10:54:04 -0400
X-MC-Unique: RS3taG85MpSnyiDrCniEmg-1
Received: by mail-yb1-f199.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so27311795ybk.16
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqzffMUKKlQ+aSeD+udH8qSMj3xtr36+LJy2qI+5/HM=;
        b=M9jriqxLbK8wrBbhyuxKCu6rgsGkk0A/BUGiN6bW05dYJHOXdt0Bb5MVivDDsDxk9/
         2yCPzMKbkEXS4AcZCF+wNw2vR5r5zwiEHt8rPLLxM8VUkUnZfiEo0ENGAPwOZJmVD6xm
         KNurgIwtdbh2zP87vTJCSDNe+JdpravRemuP5x1U3I/7bsOImSHE1cJWN55+MGGwbqdO
         khSKBivreHtK+h4SaZ7NQo2ethtR2T0p3e4NSpbi0xLJ+y2zT+8fja1HvsJwliuqVVT6
         1qzrTauLXkDS/qlbs67qxkLQrRcy79Nj9otGgXlgrtbgELX/mQM0RoGZHtDNL7sBvmZb
         XIEg==
X-Gm-Message-State: AOAM530TRcEU9LBmovjNToQ1On+JMBHiNhOno/qS2/RtPIbJNsgxRN9N
        3rtc9CBKyWQux1sA77a7TSJfPT94P8EaBIiW1HCeEYZvR7QvaAphLfHuhTIyJkqmp6RMRLXhxrK
        LxUFgl3bgPv5BUZBDFGDzu13LZpPBzWM7eg==
X-Received: by 2002:a25:7452:: with SMTP id p79mr27195080ybc.513.1634050444226;
        Tue, 12 Oct 2021 07:54:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeIEayWq296RPYUcWPYDoQ0P9KSWt0Uv5vRXbytEJXo5nos8VEevb4MpDOMci5UutkaMQ6PnoCk/tUqtIRQ+Q=
X-Received: by 2002:a25:7452:: with SMTP id p79mr27195055ybc.513.1634050443956;
 Tue, 12 Oct 2021 07:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
 <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
 <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com>
 <CAHC9VhQF9R76ojBBrAQ=WHOAgHNGKJDobY+a_qohJJCQWQDw4w@mail.gmail.com>
 <CAFqZXNs_hU_r6uxiUiWPGiYhJ5EzdxMWWwtbp-ZPMfaZ1rTNCg@mail.gmail.com> <CAHC9VhRQdyF0tMGLgW1dzvwrKeH32z-n49ohxbhwFQLTVghxjg@mail.gmail.com>
In-Reply-To: <CAHC9VhRQdyF0tMGLgW1dzvwrKeH32z-n49ohxbhwFQLTVghxjg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 12 Oct 2021 16:53:52 +0200
Message-ID: <CAFqZXNv7nWMvvZQDJjbFJ1vuyrQL=7B3Fxrsb660prJgC+jLhA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Oct 11, 2021 at 4:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Oct 7, 2021 at 5:34 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Aug 16, 2021 at 4:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > Please try to come up with a better solution that leverages proper
> > > > locking primitives, and if that isn't possible please explain (in
> > > > detail) why.
> > >
> > > It's been a little while so I wanted to check the status of this ...
> > > have you spent any time on this, or is your position such that this is
> > > the best you can come up with for a fix?
> >
> > Sorry, I had to put this on the "let me get back to this later" list
> > because of other priorities and didn't get to pop it out of that list
> > yet :/ I haven't yet looked at other alternatives.
>
> Okay.  I'm going to go ahead and merge this simply because it does fix
> a visible problem, but I really would like you to revisit this in the
> near future to see if there is a better fix.
>
> While I'm going to mark this with the stable tag, considering the
> relatively low rate of occurrence on modern kernels and the fact that
> I'm not in love with the fix, I'm going to merge this into
> selinux/next and not selinux/stable-5.15.  This should give us another
> couple of weeks in case you come up with a better fix in the near
> term.

OK, though it seems something went wrong when you applied the patch -
in the commit it's missing the subject line:
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?h=next&id=0550e9155dfb566e9817b776dd0ece0b3fb361f2

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

