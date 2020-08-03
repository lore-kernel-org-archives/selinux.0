Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F12C433DF
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 08:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06F92072A
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 08:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2MuxH3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHCICD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:02:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37761 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbgHCICD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 04:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596441722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLImK/Yjiy4JO5zgoTr+IqJjSCl+Vtn7vWF7+ZUqg18=;
        b=I2MuxH3kCtPu9hPocbm4ZM7ruW707sLp9wVEeXAz9Icgs+8bsytlOmmqlPMvxWRYbKK1+T
        oM+ppVVRvxeBkVZpljMF1wGBumAEeD5KaV4gH4fFNLB2LxoDO21Txp8YjtXmL9d6bn6o4R
        IwO3IcTCCxPl0qIidNJtDkoUHO5OnCI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-7RGZz6vUPzS1pMcGa2D--w-1; Mon, 03 Aug 2020 04:01:58 -0400
X-MC-Unique: 7RGZz6vUPzS1pMcGa2D--w-1
Received: by mail-lf1-f69.google.com with SMTP id u11so10440351lfg.11
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 01:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLImK/Yjiy4JO5zgoTr+IqJjSCl+Vtn7vWF7+ZUqg18=;
        b=Xb6lVhVHrraa+zQjsW+CFTj/mlGEFxibLKPEnZRcs+MORoF7pv9W5QFiW/zsPSLXuk
         iaYYB9CsmODT6mXg6zai/EVxk3rDsVEsJ7BQvsROr1rnQ0CJTvO2lbN9mSSbuxdYiT9W
         9xG3hRn89/cz5JVmzkvCUq+8YpFjkIjD3nMqK1KbEKi3lcsLSylINP0GDtnuSoIT01f8
         SeQ7RBLiQvTuVFgDFYrN1OhLfj28wyVKYDA1hL01y0l10Cx6Sb3dmJrcMbZapPIlJ5Lh
         4abYynJJ3XoDeH2KKQbts0gYx0Rq+CeGIaRMk11Ru63FnrmKNQ5Kk4RzzBOv6vQHawO/
         X0ig==
X-Gm-Message-State: AOAM530Bmdsw2h6/RldrX/hrfBPTZxA2AZQCsnjtNDA7UJAWmQZp4FAX
        xAdLSapVtatDNl/Rp0vakH0KeMoJBhmYqiaPLBdYDZ9ZJ/m97l1yB4zV2jNG9UKGH7o03KSgKEo
        75/0EkNJcnabs34jjWNpRGUpN78cZJh7BvQ==
X-Received: by 2002:a19:be53:: with SMTP id o80mr7920869lff.33.1596441716890;
        Mon, 03 Aug 2020 01:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNMYhleoQwWKK2PxmnTEbct5PZsSYFPwwTuOs61MBX2U3XOX2BQVW/Pm1OYz2CUQMfwsgGldKCiTC8dI9i87o=
X-Received: by 2002:a19:be53:: with SMTP id o80mr7920860lff.33.1596441716688;
 Mon, 03 Aug 2020 01:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdo2XOU1iH1Gn1bf8UF7VLHVXF9wuop9SOHj44P4pet-kQ@mail.gmail.com>
 <20200731173309.31528-1-william.c.roberts@intel.com> <CAFqZXNtnzP=F_-n_6VRuEnErqmFex0x0C7z5nP=970-n-4aurw@mail.gmail.com>
 <CAFftDdr6RQLX7odto1uC2SWHTO4ukHD7xHAo1Frr202kab5fiw@mail.gmail.com>
In-Reply-To: <CAFftDdr6RQLX7odto1uC2SWHTO4ukHD7xHAo1Frr202kab5fiw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Aug 2020 10:01:45 +0200
Message-ID: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
Subject: Re: [PATCH] scripts/ci: license as Apache 2.0
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 11:23 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Jul 31, 2020 at 4:11 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Jul 31, 2020 at 7:33 PM <bill.c.roberts@gmail.com> wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > License the ci scripts with a permissive, OSI approved license, such as
> > > Apache 2.0.
> >
> > Thanks! On second thought though, I guess any open source license
> > would be fine, since the scripts don't "link" with the rest of the
> > testsuite (which is GPLv2). So if you prefer some more permissive (or
> > shorter... :) license or just public domain, you can probably use
> > that, too.
>
> I can do MIT, does that work?

Yes, works for me.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

