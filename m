Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A022CA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615B7206DD
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgELTtF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:49:05 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40202 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgELTtF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 15:49:05 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4EFBE565BB3
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 21:49:01 +0200 (CEST)
Received: by mail-oo1-f48.google.com with SMTP id x16so2977710oop.13
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:49:01 -0700 (PDT)
X-Gm-Message-State: AGi0PubVFXxbvVNkDPOXzAam6wHmnGH5v96DYXaXZk/0x89sLo0oRKDb
        Cdw1H51q1o293pn1SYZ67p8TzLLRtFIwvJ7DZMc=
X-Google-Smtp-Source: APiQypJB7kWTnXB0BRfIwe46XrINcK49kxkCjP/zerEIQB3E35tnOq2iRs5l1PubvoqBBMnYPKSZTATeisri+8c36X4=
X-Received: by 2002:a4a:accf:: with SMTP id c15mr18856673oon.29.1589312940097;
 Tue, 12 May 2020 12:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200512192957.112866-1-nicolas.iooss@m4x.org> <476DC76E7D1DF2438D32BFADF679FC5649EDD4EF@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649EDD4EF@ORSMSX101.amr.corp.intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 12 May 2020 21:48:48 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==howfQTaXCReSGYk=U=4V28t1szosFBZKhO_tU=Ej_=A@mail.gmail.com>
Message-ID: <CAJfZ7==howfQTaXCReSGYk=U=4V28t1szosFBZKhO_tU=Ej_=A@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: silence new flake8 warnings
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue May 12 21:49:02 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 12, 2020 at 9:40 PM Roberts, William C
<william.c.roberts@intel.com> wrote:
>
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of Nicolas Iooss
> > Sent: Tuesday, May 12, 2020 2:30 PM
> > To: selinux@vger.kernel.org
> > Subject: [PATCH] python/sepolicy: silence new flake8 warnings
> >
> > pyflakes 2.2.0 improved the way format strings are analyzed, which triggers new
> > warnings in flake8:
> >
> >     python/sepolicy/sepolicy/manpage.py:1046:23: F999 '...' % ... has
> >     unused named argument(s): type
> >
> >     python/sepolicy/sepolicy/manpage.py:1225:23: F999 '...' % ... has
> >     unused named argument(s): user
> >
> > Remove the unused arguments in order to silence these warnings.
> >
> > This fixes failures in Travis-CI such as
> > https://travis-ci.org/github/SELinuxProject/selinux/jobs/686230518#L5153
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  python/sepolicy/sepolicy/manpage.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/manpage.py
> > b/python/sepolicy/sepolicy/manpage.py
> > index 442608191cc8..3e8a3be907e3 100755
> > --- a/python/sepolicy/sepolicy/manpage.py
> > +++ b/python/sepolicy/sepolicy/manpage.py
> > @@ -1074,7 +1074,7 @@ If you wanted to change the default user mapping to
> > use the %(user)s_u user, you
> >
> >  .B semanage login -m -s %(user)s_u __default__
> >
> > -""" % {'desc': self.desc, 'type': self.type, 'user': self.domainname, 'range':
> > self._get_users_range()})
> > +""" % {'desc': self.desc, 'user': self.domainname, 'range':
> > +self._get_users_range()})
> >
> >          if "login_userdomain" in self.attributes and "login_userdomain" in
> > self.all_attributes:
> >              self.fd.write("""
> > @@ -1245,7 +1245,7 @@ Execute the following to see the types that the SELinux
> > user %(type)s can execut
> >
> >  .B $ sesearch -A -s %(type)s -c process -p transition
> >
> > -""" % {'user': self.domainname, 'type': self.type})
> > +""" % {'type': self.type})
> >
> >      def _role_header(self):
> >          self.fd.write('.TH  "%(user)s_selinux"  "8"  "%(user)s" "mgrepl@redhat.com"
> > "%(user)s SELinux Policy documentation"'
> > --
> > 2.26.2
>
> I just hit this issue in the CI, good timing.
>
> Acked-by: William Roberts <william.c.roberts@intel.com>

So did I, while wanting to test the last patches that have been sent
to the mailing list
(https://travis-ci.org/github/fishilico/selinux/builds/686257022). As
the CI worked fine at least 4 days ago, it is a very recent change. I
reproduced it easily on my Arch Linux development system by updating
it, and downgrading python-pyflakes to its previous version (2.1.1)
made the issue disappear. This is why I am sure this is caused by the
latest release of pyflakes.

Cheers,
Nicolas

