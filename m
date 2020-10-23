Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD0C4363A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447BB206DD
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdie4ugE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461187AbgJWOzo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461122AbgJWOzn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 10:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603464941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6KYsimbR87QURge3qwcOQDzqlR+dacQdGzjSfYzGfo=;
        b=Kdie4ugEcZT9sjyhiBEm486fwaegBLVoy9FagOheHjfJOPlQw1ErQ+0f30mTJv1sT/vswz
        Nvc3ximoZg9yF+EBtlw6Ob6ZeV4VDJRzu4Ud+5LZKEhRytz5BVbV64b5agAc4ZVGLt0vVC
        0aUcENW4bGFYUh/n5IcIMjFFTJnZ4xo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Fo8zUvRCNLCy0BnmG_E1DA-1; Fri, 23 Oct 2020 10:55:40 -0400
X-MC-Unique: Fo8zUvRCNLCy0BnmG_E1DA-1
Received: by mail-lj1-f200.google.com with SMTP id s25so775730ljo.13
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6KYsimbR87QURge3qwcOQDzqlR+dacQdGzjSfYzGfo=;
        b=r5Jf75gvzr7hQroOy2i2o9SN43QegpVzojBjRAVsoPW0bl5c+WyXcUhGm7qOem5Y+G
         RxT8oIbiP1k0XsJcwOtzeYYLaYGVHzluNW8EZnNhMmlOAOspy0lHdY5+iQDFI8VJiWds
         OYE8H8QCgiXg9OyLvpIbV0y2BKhPwQui7+myonGqQSLzkYPTikyXI7aU+j033Y/I/kvs
         uqPZ4fgyRuBtQqAmJBuWQ0//N5rpNnHYVudupGlLWMITBoITXEogML68WwcOqQ8k14QZ
         B6tADCHV07NlF51ANMf5FwfKxpHB40k8btQu9mUTISQUBWtZ8JcpCytyvt3DkrRdf61V
         j1rw==
X-Gm-Message-State: AOAM530yK341UlsHeAVHxmOpauAMCu2cIMUnUn48P2OQfWrL3rOFY27X
        jlU1P/KqhMCpkUANMjBWnx7wQt7IsFtWdAHv0E+JYhVV5SAmIySea+OmyQNo1GGBRYaRX0KS4us
        AYWqtuByT7vAxai7QP27Oqevq0p81cSDUEw==
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr984617ljj.38.1603464938188;
        Fri, 23 Oct 2020 07:55:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTOXbIbi41CUywRwLqaXPjiecw/dU28yJVILf2V8O93poGcNTBr4t6nepDQldVDaOCPn3wn10rff/QePk6/xI=
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr984610ljj.38.1603464937977;
 Fri, 23 Oct 2020 07:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201021214453.400811-1-omosnace@redhat.com> <20201021214453.400811-3-omosnace@redhat.com>
 <e27493a79082271836c5fef11d494b052de83319.camel@btinternet.com>
In-Reply-To: <e27493a79082271836c5fef11d494b052de83319.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Oct 2020 16:55:27 +0200
Message-ID: <CAFqZXNu13Jj5KnNZUQJPNdr-TcYFxmeL8QKbHte1K5LY=kcNdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/sctp: set up a GRE tunnel to activate ASCONF tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 22, 2020 at 4:11 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2020-10-21 at 23:44 +0200, Ondrej Mosnacek wrote:
> > Currently, the ASCONF tests will activate only if the test system has
> > two global IPv4 addresses, otherwise they are just skipped. Most
> > systems, including the VM in CI, don't fulfill this condition.
> >
> > As it turns out, this second IPv4 address can be set up very easily
> > by
> > creating a GRE trunnel interface over loopback. So make the SCTP test
> > create such interface so that the ASCONF tests can be always run.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  tests/sctp/test | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
>
> Acked-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks! I applied both patches now.

>
> > diff --git a/tests/sctp/test b/tests/sctp/test
> > index eede42f..1170921 100755
> > --- a/tests/sctp/test
> > +++ b/tests/sctp/test
> > @@ -35,6 +35,12 @@ BEGIN {
> >      else {
> >          $test_count = 75;
> >
> > +        # Set up a GRE tunnel over loopback to ensure we have enough
> > addresses
> > +        # for the ASCONF tests.
> > +        system "ip link add mygre type gretap local 127.0.0.1 remote
> > 127.0.0.1";
> > +        system "ip addr add 10.123.123.123 dev mygre";
> > +        system "ip link set mygre up";
> > +
> >          # asconf parameter tests require two local non-loopback
> > addresses.
> >          $ipaddress_list = `ip -o addr show up scope global`;
> >          $test_asconf    = 0;
> > @@ -909,4 +915,6 @@ if ($test_nft) {
> >      system "nft -f $basedir/nftables-flush";
> >  }
> >
> > +system "ip link del mygre";
> > +
> >  exit;
>


-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

