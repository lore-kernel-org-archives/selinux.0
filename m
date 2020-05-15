Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C4C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 19:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B2C20728
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 19:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqhB7CCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgEOTly (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 15:41:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47785 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726188AbgEOTly (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 15:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589571712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDLINAEAOFdpSubTL80h8u5xhUnITWR1dCfwAOe5Gio=;
        b=BqhB7CCBQHl6wj8IDpizWhpWtyV/WVT1CRNDwpTqwGyKafbvCkUBJk9/sV7yyhkdGpNkMo
        c/ELqpZrpPOTAH14BG8pobasJ9d2TQcN3zRlFjDXOsSBtkT4R8Pxq1myOyw0Zp/ZuzNSgw
        pgIy7zv9pO+GWVAI2Bd3edxTAZ+JwVs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-HDfWzZSdN5W8F7L3r1LEJQ-1; Fri, 15 May 2020 15:41:40 -0400
X-MC-Unique: HDfWzZSdN5W8F7L3r1LEJQ-1
Received: by mail-oo1-f69.google.com with SMTP id y1so1943697oog.6
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 12:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDLINAEAOFdpSubTL80h8u5xhUnITWR1dCfwAOe5Gio=;
        b=Uiu9PjcamVu+oiPms+Prm2JwShkHrDNMDtQfgZt4CLxyncZizUmoNFcPSywuwu3XAi
         f4qYdTezjua4nZ4+4Jv07e1DEB5DdUGW1k3u9d/xZvJlWeBRkusAwBD/h8BR06v6hTlg
         HALkz7S1qa8IlyBDqUrNUW6SFn+h+xfJStqmi3LZQ5rvZ4MIXadKV3oxEjd3L2aMxJ1Q
         Vt1S0ORkcJsl8K5S5PCdAw6TRSjRnLsrfHTj9+zLIRS9D/GwzqDFLZ1k3Ds10Cb50kJe
         5BX4iAZ3ubKKbFprTxAwPbY8pP7Wz9zD09X+9M8RMLTDZ223TvCxSmhTHeMW+xIelT6X
         CYJw==
X-Gm-Message-State: AOAM533i7B/PDHHSwBxBNzT5Sxcyl2harFUtNnbjwVKqwEc+V14AA0UF
        HF+EIBqDLMiicMooxvk6gukkSEkjpmukP/0C9cfXdu6f8GZ7y5ewAJmwuC+6uAyjphS7ijyq1mC
        J56FV9FdIEj/OInt5LwWnTsBcthwXTXP+eQ==
X-Received: by 2002:aca:ed44:: with SMTP id l65mr3318829oih.127.1589571699178;
        Fri, 15 May 2020 12:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5C6INXIzBy/88wyMEj8llWg796NSpLnE2ZhYGSWWHg/McnSle2EpEbISSgbkbm5kVpuk4HexSQJJFdSkdoY=
X-Received: by 2002:aca:ed44:: with SMTP id l65mr3318822oih.127.1589571698945;
 Fri, 15 May 2020 12:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
 <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
 <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com> <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com>
In-Reply-To: <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 May 2020 21:41:27 +0200
Message-ID: <CAFqZXNvSgE5Eb+89D_j9M1mQFAdgq1Q6PhJbUuzYPeunR4RtHw@mail.gmail.com>
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

On Fri, May 15, 2020 at 9:27 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, May 15, 2020 at 1:51 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, May 15, 2020 at 2:11 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > >
> > > > > The text above states that kernel-devel is needed, but it's missing from
> > > > > the dnf command.
> > > > >
> > > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > > ---
> > > > >  README.md | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/README.md b/README.md
> > > > > index 1f7e5d92a100..a73e9cc0c06d 100644
> > > > > --- a/README.md
> > > > > +++ b/README.md
> > > > > @@ -77,7 +77,8 @@ following command:
> > > > >                 kernel-devel \
> > > >
> > > > It's actually right there already ^^
> > >
> > > Yeah that's the foot cannon, I thought I was good, but you need the
> > > specific ones
> > > as Ondrej pointed out to me.
> > >
> > > >
> > > > >                 quota \
> > > > >                 xfsprogs-devel \
> > > > > -               libuuid-devel
> > > > > +               libuuid-devel \
> > > > > +               kernel-devel-$(uname -r)
> > > >
> > > > I proposed adding the -$(uname -r) before, but there were some valid
> > > > counterarguments. See the discussion here:
> > > > https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
> > > >
> > >
> > > Arguments for why the dnf command should have it with uname:
> > > 1. We tried to add it twice, it's bit people twice.
> > > 2. The README states "On a modern Fedora system you can install these
> > > dependencies with the following command:"
> > >     - which is wrong, you need the specific package
> > >     - If you're going to provide a "dnf install" or a apt-get install,
> > > it should just work
> > >     - the apt-get example has uname -r in it.
> > >     - so the precludes building your own kernel, if you do that as
> > > Paul stated, you're on your own. (lore comment)
> >
> > I'm ok with adding it.
>
> Does anyone want to ack this one?

As Stephen already said while I was writing this message, please just
update the existing kernel-devel line.

>
> Ok I found another one, kernel-modules-extra is needed for the sctp module.

On Fedora it shouldn't be, only on RHEL/CentOS 8.

>
> The tests expect sctp support, should we conditionally skip these if
> sctp is not enabled?
> Whats the best way of checking for that proto if we want this? just an
> ls of /proc/sys/net:
> ls /proc/sys/net/
> bridge  core  ipv4  ipv6  netfilter  nf_conntrack_max  sctp  unix
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

