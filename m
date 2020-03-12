Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F12C1975A
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 13:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8320663
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 13:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFXiKzjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgCLNPI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:15:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727192AbgCLNPI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 09:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584018907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SS/15Ch/CdYmepGJb/AIIBMchNI/NbD2Dtzxe+IF6AQ=;
        b=PFXiKzjKqUdDhzaiKv3MdX/mrz7fGQY5wH4YfBxhhsQC/ckBbWIFmwtzRg/HoTfJ4CqWPR
        OZYtmfARh16OwzjaO4PB4xh1Qcmh/5kxKebdTVAa5ta8Q2CYHL7XJku4z1j9Qp3cc0phIj
        TwzlbfxsinRly1Hxk9er8tu9YGvIo78=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-LwUT6VWMOIe5MId3Bb64UA-1; Thu, 12 Mar 2020 09:15:03 -0400
X-MC-Unique: LwUT6VWMOIe5MId3Bb64UA-1
Received: by mail-ot1-f71.google.com with SMTP id 31so3333219otl.11
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 06:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS/15Ch/CdYmepGJb/AIIBMchNI/NbD2Dtzxe+IF6AQ=;
        b=NHLOp08twcInDZfmW+KZm64EEXb/FXhUMYPGxj+MFL0Fg4H4c6RWLgSUuyFTqOIYPv
         ey0XxMVI7MW8rjorW/petotRmOs433kDxwTYnYHlTzZV+UMmFzBb1jVLOTcX+g6K1eFK
         VwbEI26r/4WVNcN5oiG/0kPuO35Xy622sWZso54oPvzsrM1Gn+ogH6d4k7aQPRAVHwp4
         otjQ6d2KIV21ngUwZrq+sPZPkfTqCWW3IhXn97pHoA6oyIl2gL+WDypj3bL1lZY3718/
         L/g2xauINcyH8QRvss2vW6mTMjnEgMQLCaxGtwyO2oYxZKb6K0pjiGCU12BnIuCgHxpA
         XVFg==
X-Gm-Message-State: ANhLgQ0kOcsYasjbTilfv0J8x1cvl/+bkgJvMzSnUG8dLGbDvTvzFg7F
        HZZPurB2HmiW9jD62erZRDUPBPDQErZnMkoOiGOjeTRlXzqMkmWaToTmdZII5rwGBDw6NYgFvoo
        gd0IUGydRF9XXh7jbuMnABB5zX6jLy05uLQ==
X-Received: by 2002:a9d:77d0:: with SMTP id w16mr6344351otl.66.1584018901423;
        Thu, 12 Mar 2020 06:15:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsmpPEHhtupYlEnbaQdhxs5Xl3NZdfwv6fJASFomsEC9oBeA8/Azo2ZeuELp6xTVVUzn0FciWE31rXtKoDNFRA=
X-Received: by 2002:a9d:77d0:: with SMTP id w16mr6344327otl.66.1584018900957;
 Thu, 12 Mar 2020 06:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200312084001.101645-1-omosnace@redhat.com> <CAHC9VhSD-mLS8C1f+n+8F81ed4nSonWmj=gdDT=YGsG9gm0Cqg@mail.gmail.com>
In-Reply-To: <CAHC9VhSD-mLS8C1f+n+8F81ed4nSonWmj=gdDT=YGsG9gm0Cqg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Mar 2020 14:14:50 +0100
Message-ID: <CAFqZXNt3Bq-wUgnVYpzWnN8GxZn+HFtLJMe9wpPVzxLxJUhayQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: ask for unlimited RLIMIT_MEMLOCK
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 1:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 12, 2020 at 4:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Currently the code sets it to at most 128K, but this is not enough in
> > some aarch64/ppc64le environments. Therefore, stop guessing the magic
> > threshold and just set it straight to RLIM_INFINITY.
> >
> > Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  tests/bpf/bpf_common.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
>
> I have to make a similar fix to the audit-testsuite earlier this week,
> I didn't think to check the selinux-testsuite because the bpf tests
> were running just fine on my aarch64 test system.  Sorry about that, I
> should have checked regardless.

No problem, I had kept the bpf subtest disabled on non-x86_64 in our
testing for some time, since it was failing there and I didn't know
why. Once I saw your audit-testsuite patch I realized that it was
probably the same issue so I did some testing and indeed the
RLIMIT_MEMLOCK was the cause so I put together a patch.

>
> One small style nit below, but otherwise ...
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
> > index 681e2eb..f499034 100644
> > --- a/tests/bpf/bpf_common.c
> > +++ b/tests/bpf/bpf_common.c
> > @@ -41,24 +41,16 @@ int create_bpf_prog(void)
> >
> >  /*
> >   * The default RLIMIT_MEMLOCK is normally 64K, however BPF map/prog requires
> > - * more than this so double it unless RLIM_INFINITY is set.
> > + * more than this (the actual threshold varying across arches) so set it to
> > + * RLIM_INFINITY.
> >   */
> >  void bpf_setrlimit(void)
> >  {
> >         int result;
> >         struct rlimit r;
> >
> > -       result = getrlimit(RLIMIT_MEMLOCK, &r);
> > -       if (result < 0) {
> > -               fprintf(stderr, "Failed to get resource limit: %s\n",
> > -                       strerror(errno));
> > -               exit(-1);
> > -       }
> > -
> > -       if (r.rlim_cur != RLIM_INFINITY && r.rlim_cur <= (64 * 1024)) {
> > -               r.rlim_cur *= 2;
> > -               r.rlim_max *= 2;
> > -       }
> > +       r.rlim_cur = RLIM_INFINITY;
> > +       r.rlim_max = RLIM_INFINITY;
>
> If you really want to simplify things you could assign those values
> when you declare "r":
>
> struct rlimit r = {
>   .rlim_cur = RLIM_INFINITY,
>   .rlim_max = RLIM_INFINITY };

True, but I don't think the difference is big enough to respin the patch.

>
> >         result = setrlimit(RLIMIT_MEMLOCK, &r);
> >         if (result < 0) {
> > --
> > 2.24.1
>
> --
> paul moore
> www.paul-moore.com
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

