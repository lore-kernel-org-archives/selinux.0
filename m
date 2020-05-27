Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD29C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 09:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4795E20888
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 09:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0s15B3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgE0JRp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 05:17:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgE0JRp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 05:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590571063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ywYr8uYr35SK5we0MRArQtUDeNuRZN9hgdq4RYLjMuQ=;
        b=L0s15B3n3JZ9HkZ9U9vEd43dpyNQJdvpZeALTPvW12fKN7XTLBVr8dW8U4Nvynvgr9AOWW
        W9fYgL19l50adK7jr8Lbg9iQbRXrI9BM0sm8Se6Ty6tZkisrjcfw46fT9u8/LQxugvRtrR
        /hRmFbAk6pmluHnveUm23dljI5+/HGc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Hwy_xV9iPoGJiWtOF1fZig-1; Wed, 27 May 2020 05:17:38 -0400
X-MC-Unique: Hwy_xV9iPoGJiWtOF1fZig-1
Received: by mail-oo1-f70.google.com with SMTP id x10so13180450ooq.5
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 02:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywYr8uYr35SK5we0MRArQtUDeNuRZN9hgdq4RYLjMuQ=;
        b=RcVuQcWSv5194cmrfZMIipNX6ySSQi/i5KP08L5nyeP6o9LKvZzPYlcoxrfYSzO6Eo
         x3mToyzltoYMRpaVnh0yMePHot6Hy20rmkrhixt54r8nS/+X8jFVCPW2BR1JiIPpZ2WJ
         sdXu5dCAvGfBn+JKuj5CSoCKD5Tx18Lru7Rgq+5uiRxpJPnHluwfJhLht+daezW1MUvA
         jiXIr3qvwXPrnhe21cm69wYSmYUNROjvAuBOzhAB2Q7XAXLjvKF2hKDOVYoLYmH/GPCr
         mEPhfWhmwfe/2qD2Kw/hZfB1Q0aULq0Q/2Gp+olbb7YCG3HBzU8CbL9bjp4Dlungpb8r
         vXAA==
X-Gm-Message-State: AOAM5317rjQTfCocjex0DEMXPWIf1i9JbuU4w1qc26sK7wv7GZ81Ex1q
        c7lusWfxOK4kmwDWuA8+q+QD9AB9CNTiqdDoWjYwkVdA8Rv/XLpTZlQgECQJ2lUAbKGx/7/C8Bs
        FOL1oM6Q1ju6msDBOHv7+6rspLxTtX+q8NA==
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr3972972otb.66.1590571057974;
        Wed, 27 May 2020 02:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmS7PA2FKJwyHpHHdrDbMMVB8fueKGBhOZ5WyZCbMcSAQ82dC8y5wjAnqQltXk2HW9+ctFE52yU9wj649vK0A=
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr3972953otb.66.1590571057544;
 Wed, 27 May 2020 02:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200520152538.23184-1-william.c.roberts@intel.com>
 <CAFqZXNumYyhzFhzGGrKZcFrAeRMgy4-WqaXvqVwKM1285vSgsQ@mail.gmail.com> <CAFftDdoAiXbZggb9bHDQB5juNJC+EzJT+4-Y74GvwWpHWmeMxg@mail.gmail.com>
In-Reply-To: <CAFftDdoAiXbZggb9bHDQB5juNJC+EzJT+4-Y74GvwWpHWmeMxg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 May 2020 11:17:26 +0200
Message-ID: <CAFqZXNt2KLTRxF1twgSKFYVso1V8Xubj28ewH3f_1r647+vMbQ@mail.gmail.com>
Subject: Re: [PATCH] README: Add kernel-modules for SCTP
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 7:15 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 8:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, May 20, 2020 at 5:26 PM <william.c.roberts@intel.com> wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > Some Fedora images, notably the Fedora 32 cloud image, do not have the
> > > kernel modules package installed by default. Thus SCTP isn't available.
> > > Add the proper kernel-modules package for the running kernel.
> >
> > Hm, I thought it wasn't possible to remove the kernel-modules package
> > for the running kernel, but it really is...
> >
> > >
> > > Note: This applies to selinux-testsuite.
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  README.md | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/README.md b/README.md
> > > index 1bec9fe85c91..1a4c70c40d56 100644
> > > --- a/README.md
> > > +++ b/README.md
> > > @@ -77,7 +77,8 @@ following command:
> > >                 kernel-devel-$(uname -r) \
> > >                 quota \
> > >                 xfsprogs-devel \
> > > -               libuuid-devel
> > > +               libuuid-devel \
> > > +               kernel-modules-$(uname -r)
> >
> > Can you please put both the kernel-* packages together? I think it
> > would be best to always have both at the end so that anyone who uses
> > locally built kernels can easily copy the command without the two. Or
> > I can just amend your patch when applying if you're OK with that.
>
> Thats fine by me, thanks.

OK, the patch is now applied.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel,
Red Hat, Inc.

