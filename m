Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF8C4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 07:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855E4208C3
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 07:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEAHry (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 03:47:54 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57952 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgEAHrx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 03:47:53 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E639A5646AE
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 09:47:35 +0200 (CEST)
Received: by mail-ot1-f52.google.com with SMTP id c3so1981900otp.8
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 00:47:35 -0700 (PDT)
X-Gm-Message-State: AGi0PuYJtM9eK/rHyGrZgo15zhAMAeBGj2I0zakc6pqyU4hBYTEnr94q
        Es/e7r52wVn3MmYzOBvVBzVgDXX8hw0inOrV3mE=
X-Google-Smtp-Source: APiQypIPpDJhtS+/jNniZL3ZT9QcSxDWulpMJHjvExKxf6JGXKPKqG8U7udqay1xVzBtN/UZ30cp1MOXxEKkJJx+RD4=
X-Received: by 2002:a9d:7082:: with SMTP id l2mr2446570otj.361.1588319254885;
 Fri, 01 May 2020 00:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=mv_e7zo2T8MBOmODW8NHc48cr3GB1Jvi8=Gg-qm7QPTQ@mail.gmail.com>
 <20200427153438.17061-1-plautrba@redhat.com> <CAJfZ7=mjM5YqgaF0sjibssaj3Jdb03f5HDtXdwg-VQcF7_ygPg@mail.gmail.com>
In-Reply-To: <CAJfZ7=mjM5YqgaF0sjibssaj3Jdb03f5HDtXdwg-VQcF7_ygPg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 1 May 2020 09:47:23 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mFZMVu-_a2REPQSzgYq2wLJZK7tvpVyXzhr+CERcPZLQ@mail.gmail.com>
Message-ID: <CAJfZ7=mFZMVu-_a2REPQSzgYq2wLJZK7tvpVyXzhr+CERcPZLQ@mail.gmail.com>
Subject: Re: [PATCH v2] python/semanage: Use ipaddress module instead of IPy
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May  1 09:47:36 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 11:28 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Apr 27, 2020 at 5:35 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > ipaddress python module was added to standard library in Python 3.3 -
> > https://docs.python.org/3/library/ipaddress.html
> >
> > seobject.py was the only consumer of IPy module so this dependency is not needed
> > anymore.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >
> > Based on Nicolas input:
> >
> > - improved the check comment
> > - dropped the unnecessary check
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Applied.
Thanks,
Nicolas

> >  python/semanage/seobject.py | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index f2a139c970bd..6e0b87f2fa3c 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -32,7 +32,7 @@ from semanage import *
> >  PROGNAME = "policycoreutils"
> >  import sepolicy
> >  import setools
> > -from IPy import IP
> > +import ipaddress
> >
> >  try:
> >      import gettext
> > @@ -1858,15 +1858,12 @@ class nodeRecords(semanageRecords):
> >          if addr == "":
> >              raise ValueError(_("Node Address is required"))
> >
> > -        # verify valid combination
> > +        # verify that (addr, mask) is either a IP address (without a mask) or a valid network mask
> >          if len(mask) == 0 or mask[0] == "/":
> > -            i = IP(addr + mask)
> > -            newaddr = i.strNormal(0)
> > -            newmask = str(i.netmask())
> > -            if newmask == "0.0.0.0" and i.version() == 6:
> > -                newmask = "::"
> > -
> > -            protocol = "ipv%d" % i.version()
> > +            i = ipaddress.ip_network(addr + mask)
> > +            newaddr = str(i.network_address)
> > +            newmask = str(i.netmask)
> > +            protocol = "ipv%d" % i.version
> >
> >          try:
> >              newprotocol = self.protocol.index(protocol)
> > --
> > 2.26.2
> >

