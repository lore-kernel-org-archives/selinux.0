Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D0C3F2CD
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEE72469C
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgCAVcj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:32:39 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37476 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCAVcj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 16:32:39 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 222CF564857
        for <selinux@vger.kernel.org>; Sun,  1 Mar 2020 22:32:36 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id d62so8370456oia.11
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 13:32:36 -0800 (PST)
X-Gm-Message-State: APjAAAVnNVMRjEyg/rYjXoqjOb99FAQgHbt6LmdGCQjFP4Evvnf70W6Q
        TfBfD8SkqzLtF/sWKp3LJK+L2m3RjL7hLxFOxBg=
X-Google-Smtp-Source: APXvYqzklEIdU4lakgtEpQPeYeHx36si7bikr0088/nzJLl/QenV7S8SPVWbfqVyROfPapZ6Go7DtYzd/eSJrjSpxkE=
X-Received: by 2002:a05:6808:983:: with SMTP id a3mr3942973oic.172.1583098355130;
 Sun, 01 Mar 2020 13:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20200225224841.2693481-1-nicolas.iooss@m4x.org> <CAFqZXNuySxX6M0P2azXxFBD68EB6m89xG8-4++m-RD1h8uW8Qg@mail.gmail.com>
In-Reply-To: <CAFqZXNuySxX6M0P2azXxFBD68EB6m89xG8-4++m-RD1h8uW8Qg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Mar 2020 22:32:23 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mJZnc9VchMG8F8b7q94MW8xROmQgz_MrmcrEx1F17q8Q@mail.gmail.com>
Message-ID: <CAJfZ7=mJZnc9VchMG8F8b7q94MW8xROmQgz_MrmcrEx1F17q8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: make ebitmap_cardinality() of linear complexity
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar  1 22:32:36 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 9:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Feb 25, 2020 at 11:49 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > As ebitmap_get_bit() complexity is linear in the size of the bitmap, the
> > complexity of ebitmap_cardinality() is quadratic. This can be optimized
> > by browsing the nodes of the bitmap directly in ebitmap_cardinality().
> >
> > While at it, use built-in function __builtin_popcountll() to count the
> > ones in the 64-bit value n->map for each bitmap node. This seems better
> > suited than "count++". This seems to work on gcc and clang on x86,
> > x86_64, ARM and ARM64 but if it causes compatibility issues with some
> > compilers or architectures (or with older versions of gcc or clang),
> > the use of __builtin_popcountll() can be replaced by a C implementation
> > of a popcount algorithm.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/src/ebitmap.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > index d23444ce5064..a5108b7184c5 100644
> > --- a/libsepol/src/ebitmap.c
> > +++ b/libsepol/src/ebitmap.c
> > @@ -128,14 +128,15 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
> >
> >  unsigned int ebitmap_cardinality(ebitmap_t *e1)
> >  {
> > -       unsigned int i, count = 0;
> > +       unsigned int count = 0;
> > +       ebitmap_node_t *n;
> >
> >         if (e1->cardinality || e1->highbit == 0)
> >                 return e1->cardinality;
> >
> > -       for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
> > -               if (ebitmap_get_bit(e1, i))
> > -                       count++;
> > +       for (n = e1->node; n; n = n->next) {
> > +               count += __builtin_popcountll(n->map);
> > +       }
> >         e1->cardinality = count;
> >         return count;
> >  }
> > --
> > 2.25.0
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> I'll check if the cardinality caching still makes any measurable
> difference and if not, I'll post a revert patch.

Thanks. I applied this patch.
Nicolas

