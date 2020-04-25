Return-Path: <SRS0=uu7d=6J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3B4C55185
	for <selinux@archiver.kernel.org>; Sat, 25 Apr 2020 06:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C0E20748
	for <selinux@archiver.kernel.org>; Sat, 25 Apr 2020 06:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgDYGwq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Apr 2020 02:52:46 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33894 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYGwp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Apr 2020 02:52:45 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 655895646B6
        for <selinux@vger.kernel.org>; Sat, 25 Apr 2020 08:52:39 +0200 (CEST)
Received: by mail-ot1-f47.google.com with SMTP id e26so16665229otr.2
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2020 23:52:39 -0700 (PDT)
X-Gm-Message-State: AGi0Pub6nMyNkBa5tQlYr9ZWbtMajKH1h5Q4/W85yuJBx0SzJtWLmbtb
        37NEbTaImEHgcAGFDkQ3UdTVkJDt7kZTpd3vlGQ=
X-Google-Smtp-Source: APiQypKuJvBFPMN8ggdqfI0qyVsIiLYOG2PURR/KOkfqz6C0X0YG1lUaeHgteHrQzGhOY0JBGm9HBG18I0wFDjWpmxI=
X-Received: by 2002:a05:6830:2421:: with SMTP id k1mr5026846ots.279.1587797558240;
 Fri, 24 Apr 2020 23:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200424145941.242949-1-plautrba@redhat.com> <476DC76E7D1DF2438D32BFADF679FC5649ED77DF@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649ED77DF@ORSMSX101.amr.corp.intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 25 Apr 2020 08:52:27 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mv_e7zo2T8MBOmODW8NHc48cr3GB1Jvi8=Gg-qm7QPTQ@mail.gmail.com>
Message-ID: <CAJfZ7=mv_e7zo2T8MBOmODW8NHc48cr3GB1Jvi8=Gg-qm7QPTQ@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Use ipaddress module instead of IPy
To:     "Roberts, William C" <william.c.roberts@intel.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Apr 25 08:52:39 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 24, 2020 at 9:46 PM Roberts, William C
<william.c.roberts@intel.com> wrote:
>
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of Petr Lautrbach
> > Sent: Friday, April 24, 2020 10:00 AM
> > To: selinux@vger.kernel.org
> > Cc: Petr Lautrbach <plautrba@redhat.com>
> > Subject: [PATCH] python/semanage: Use ipaddress module instead of IPy
> >
> > ipaddress python module was added to standard library in Python 3.3 -
> > https://docs.python.org/3/library/ipaddress.html
> >
> > seobject.py was the only consumer of IPy module so this dependency is not
> > needed anymore.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >  python/semanage/seobject.py | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index f2a139c970bd..c89c67e491b6 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -32,7 +32,7 @@ from semanage import *  PROGNAME = "policycoreutils"
> >  import sepolicy
> >  import setools
> > -from IPy import IP
> > +import ipaddress
> >
> >  try:
> >      import gettext
> > @@ -1860,13 +1860,13 @@ class nodeRecords(semanageRecords):
> >
> >          # verify valid combination
> >          if len(mask) == 0 or mask[0] == "/":
> > -            i = IP(addr + mask)
> > -            newaddr = i.strNormal(0)
> > -            newmask = str(i.netmask())
> > -            if newmask == "0.0.0.0" and i.version() == 6:
> > +            i = ipaddress.ip_network(addr + mask)
> > +            newaddr = str(i.network_address)
> > +            newmask = str(i.netmask)

I was wondering whether there was a change of behavior with addresses
that are not network masks, such as 10.0.0.1/24 (and why
ipaddress.ip_network is used instead of ipaddress.ip_interface). But
it seems that "semanage node" already only accepts valid network
masks:

Before:

    >>> IP('10.0.0.1/24').netmask()
    Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
     File "/usr/lib/python3.8/site-packages/IPy.py", line 260, in __init__
       raise ValueError("%s has invalid prefix length (%s)" %
(repr(self), self._prefixlen))
    ValueError: IP('10.0.0.1/24') has invalid prefix length (24)

After:

    >>> ipaddress.ip_network('10.0.0.1/24')
    Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
     File "/usr/lib/python3.8/ipaddress.py", line 74, in ip_network
       return IPv4Network(address, strict)
     File "/usr/lib/python3.8/ipaddress.py", line 1454, in __init__
       raise ValueError('%s has host bits set' % self)
    ValueError: 10.0.0.1/24 has host bits set

So this change looks good to me :) Nevertheless the comment can be
improved, from "# verify valid combination" to "verify that (addr,
mask) is either a IP address (without a mask) or a valid network
mask", for example.

> > +            if newmask == "0.0.0.0" and i.version == 6:
> >                  newmask = "::"

What does this check do? It seems to be a workaround for some bug in
IPy related to IPv6, where an IPv6 address could return a 0.0.0.0
netmask. Does this bug also exist in ipaddress? If yes, it would be
useful to add a comment to document how to reproduce this bug.

> >
> > -            protocol = "ipv%d" % i.version()
> > +            protocol = "ipv%d" % i.version
> >
> >          try:
> >              newprotocol = self.protocol.index(protocol)
> > --
> > 2.26.0
>
> LGTM
> <Reviewed-by: William.c.Roberts@intel.com>
>
> I can give it an acked by if you give me testing steps.

For testing such things, I usually use a Vagrant virtual machine: I
have one to test Arch Linux packages
(https://github.com/archlinuxhardened/selinux/tree/master/_vagrant),
and I also contributed to a Debian VM to test refpolicy
(https://github.com/SELinuxProject/refpolicy/blob/2b2b5bad06f0eb2f45217ae337542e5e15bacda8/Vagrantfile#L121).
I usually patch the Arch Linux packages when testing small patches
that can be applied on top of previous releases. When the previous
release is quite old, I copy the whole project in the VM, run "make
clean distclean && make DESTDIR=/tmp/dest install install-pywrap",
relabel binaries in /tmp/dest and run them.

Anyway, +1 for migrating to ipaddress :) Thanks!
Nicolas

