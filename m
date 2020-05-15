Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5964EC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DF0206D4
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3rBq8du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgEOVGN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:06:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726727AbgEOVGN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 17:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589576771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gm+2LIDcw/PMftBz8tr4dMYfDtOr1gDio78r1U9cPug=;
        b=O3rBq8duftyTaaPlLmtmfooa90s+85Imrm250/JntaVJmkpOIgbvwaaAuTSR12VQpXsQdu
        CRbT2a1kWslvlfVycn6nHvofjY4ENik3waS8Y2OP3H1lEbRVJVCZ7ZWPj1AMnGWYmX29EA
        nFPFc8b7pke9gR+IHDETj4hn0B/fvwA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-lgHcpYH_P3S1_bZa46pDyA-1; Fri, 15 May 2020 17:06:02 -0400
X-MC-Unique: lgHcpYH_P3S1_bZa46pDyA-1
Received: by mail-ot1-f72.google.com with SMTP id b15so1834057oti.23
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm+2LIDcw/PMftBz8tr4dMYfDtOr1gDio78r1U9cPug=;
        b=jDTbsIT0lykG8A3HYQY1NVaFNcl/Fs9ff0OeVXKxbNuQATyT4eUumZ5IiueXQWWZHw
         ZImnL28j1nD8AdXm7Lbxo0tbN851c3yxxZ1xAiC/ct7blMInaTGXtfniq5VG9WKtMWYJ
         KHsRMu14RgXMMHIzT+uncviHKIaXHamIPF8ccU1sInW9+3nms8aO1WucIZUsWqOrc07O
         3ozGZ/p53lj+fXb2ouI7fM+eMKcuFR1giHnO2jH+gYTvPC7yuMU6qT2NtfwXKTA5weDs
         ghW/O5ZN6BD2UUhHOk1Vj3q3BRvdK0ivtOikRP4alXdtk/9kRfT0Gl+6fzOEx9q2ZDBf
         jDYw==
X-Gm-Message-State: AOAM5313OAU4wLQ7lQL3DyZQeej7Gzh+LJU6VeUHcdWISJJBxi9eAZWR
        /EH61OoJAJ/4GG5di4n/Ws6d6jQhByDFjakF1ZavQJv70Ikh5kzCk+SckmtEZgQ3i1Fa3y5d2R5
        CoglbaIQAUD3DmhPL2R/q0N/K5jKlKgn7cg==
X-Received: by 2002:aca:ed44:: with SMTP id l65mr3538795oih.127.1589576761805;
        Fri, 15 May 2020 14:06:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw1EXzUiGg37/m6XGeLj/F+UIhNIMLKVb1O1VYLJ9x4D2/Fsj/Z38GWwaWO3XcFyocrCr13LY82GacTpZsIso=
X-Received: by 2002:aca:ed44:: with SMTP id l65mr3538776oih.127.1589576761501;
 Fri, 15 May 2020 14:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
 <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
 <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
 <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com>
 <CAFqZXNvSgE5Eb+89D_j9M1mQFAdgq1Q6PhJbUuzYPeunR4RtHw@mail.gmail.com> <CAFftDdrN+f7D=OhdQbTLUvFZL8QDw_+eqN3scqBgxdWT2yB+=A@mail.gmail.com>
In-Reply-To: <CAFftDdrN+f7D=OhdQbTLUvFZL8QDw_+eqN3scqBgxdWT2yB+=A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 May 2020 23:05:49 +0200
Message-ID: <CAFqZXNv=FhQBy1FNbP4_=8i0UPQprwhyfnxSFqkEtTUX00YfEQ@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 10:46 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, May 15, 2020 at 2:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, May 15, 2020 at 9:27 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Fri, May 15, 2020 at 1:51 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, May 15, 2020 at 2:11 PM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > > > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > > > >
> > > > > > > The text above states that kernel-devel is needed, but it's missing from
> > > > > > > the dnf command.
> > > > > > >
> > > > > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > > > > ---
> > > > > > >  README.md | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/README.md b/README.md
> > > > > > > index 1f7e5d92a100..a73e9cc0c06d 100644
> > > > > > > --- a/README.md
> > > > > > > +++ b/README.md
> > > > > > > @@ -77,7 +77,8 @@ following command:
> > > > > > >                 kernel-devel \
> > > > > >
> > > > > > It's actually right there already ^^
> > > > >
> > > > > Yeah that's the foot cannon, I thought I was good, but you need the
> > > > > specific ones
> > > > > as Ondrej pointed out to me.
> > > > >
> > > > > >
> > > > > > >                 quota \
> > > > > > >                 xfsprogs-devel \
> > > > > > > -               libuuid-devel
> > > > > > > +               libuuid-devel \
> > > > > > > +               kernel-devel-$(uname -r)
> > > > > >
> > > > > > I proposed adding the -$(uname -r) before, but there were some valid
> > > > > > counterarguments. See the discussion here:
> > > > > > https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
> > > > > >
> > > > >
> > > > > Arguments for why the dnf command should have it with uname:
> > > > > 1. We tried to add it twice, it's bit people twice.
> > > > > 2. The README states "On a modern Fedora system you can install these
> > > > > dependencies with the following command:"
> > > > >     - which is wrong, you need the specific package
> > > > >     - If you're going to provide a "dnf install" or a apt-get install,
> > > > > it should just work
> > > > >     - the apt-get example has uname -r in it.
> > > > >     - so the precludes building your own kernel, if you do that as
> > > > > Paul stated, you're on your own. (lore comment)
> > > >
> > > > I'm ok with adding it.
> > >
> > > Does anyone want to ack this one?
> >
> > As Stephen already said while I was writing this message, please just
> > update the existing kernel-devel line.
> >
> > >
> > > Ok I found another one, kernel-modules-extra is needed for the sctp module.
> >
> > On Fedora it shouldn't be, only on RHEL/CentOS 8.
>
> Not on the cloud image, so I am assuming that desktop just has it already
> fulfilled.

That's strange... Was this with the 5.6.6-300.fc32.x86_64 kernel
mentioned in the other thread? I just downloaded the RPMs for that
build and sctp.ko was in kernel-modules, not kernel-modules-extra.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

