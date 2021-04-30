Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAEBC433ED
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 19:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AC161476
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 19:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhD3TZf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 15:25:35 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:51706 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhD3TZe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Apr 2021 15:25:34 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E4A8C564E59
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 21:24:44 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id c17so14542639pfn.6
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 12:24:44 -0700 (PDT)
X-Gm-Message-State: AOAM531prjr5wNtxrtIkCoCxpVmJFQCGM6XNcKliSY4IpWrLkYwEVC5+
        gmZYE1m5yMVvZPOGcQRRYS/EplHRAXasjV4d1N8=
X-Google-Smtp-Source: ABdhPJwSttXXVUv6bDM/x6UN2U2eGb1UxRIfljBAFre5dmb5770xsay9JF7MxlRENXihnuulyQBBKyP4P2lG2TVKSgc=
X-Received: by 2002:aa7:80d6:0:b029:258:9404:13e with SMTP id
 a22-20020aa780d60000b02902589404013emr6192757pfn.37.1619810683745; Fri, 30
 Apr 2021 12:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210422064356.249361-1-nicolas.iooss@m4x.org> <87bla1w96s.fsf@redhat.com>
In-Reply-To: <87bla1w96s.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 30 Apr 2021 21:24:32 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kYDdBenFbk_9Sjzc36UUWvmLRt-D96ix961KGOCxWoLw@mail.gmail.com>
Message-ID: <CAJfZ7=kYDdBenFbk_9Sjzc36UUWvmLRt-D96ix961KGOCxWoLw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: do not duplicate make target when going into subdirectory
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Apr 30 21:24:45 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 26, 2021 at 1:56 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > When running "make install-pywrap", make displays:
> >
> >     make[1]: Entering directory '/root/selinux/libselinux'
> >     make -C src install-pywrap install-pywrap
> >     make[2]: Entering directory '/root/selinux/libselinux/src'
> >
> > The duplicated "install-pywrap" is not expected. Remove it from the
> > Makefile.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks!

Applied.

Thanks,
Nicolas
> > ---
> >  libselinux/Makefile | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/libselinux/Makefile b/libselinux/Makefile
> > index ac16c15e8d0a..439bc6a9b7fd 100644
> > --- a/libselinux/Makefile
> > +++ b/libselinux/Makefile
> > @@ -50,24 +50,24 @@ all install relabel clean distclean indent:
> >       done
> >
> >  swigify: all
> > -     $(MAKE) -C src swigify $@
> > +     $(MAKE) -C src $@
> >
> >  pywrap:
> > -     $(MAKE) -C src pywrap $@
> > +     $(MAKE) -C src $@
> >
> >  rubywrap:
> > -     $(MAKE) -C src rubywrap $@
> > +     $(MAKE) -C src $@
> >
> >  install-pywrap:
> > -     $(MAKE) -C src install-pywrap $@
> > +     $(MAKE) -C src $@
> >
> >  install-rubywrap:
> > -     $(MAKE) -C src install-rubywrap $@
> > +     $(MAKE) -C src $@
> >
> >  clean-pywrap:
> > -     $(MAKE) -C src clean-pywrap $@
> > +     $(MAKE) -C src $@
> >
> >  clean-rubywrap:
> > -     $(MAKE) -C src clean-rubywrap $@
> > +     $(MAKE) -C src $@
> >
> >  test:
> > --
> > 2.31.0
>

