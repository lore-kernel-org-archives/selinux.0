Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7292DC46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424C9204FD
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 19:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424C9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeJXDsV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:48:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53210 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDsV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 23:48:21 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 25FEC561291
        for <selinux@vger.kernel.org>; Tue, 23 Oct 2018 21:23:34 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id p125-v6so2098838oic.3
        for <selinux@vger.kernel.org>; Tue, 23 Oct 2018 12:23:34 -0700 (PDT)
X-Gm-Message-State: ABuFfoik/Co5ZyVqg0NObWsLVRoJetBCy0tw768OfOCXZ8mtxeMornns
        gO3v9sJX2pXhJS3wpc/aMmqqXzHejapkkph2koo=
X-Google-Smtp-Source: ACcGV60S5zb31X0M+dGVn0l8epQ3XFpq6zjgdQokQ6T1MxPOlgThymbG09teAZVKpEW90PDlzb6NR0eoRmO3SClsONQ=
X-Received: by 2002:aca:db05:: with SMTP id s5-v6mr28269453oig.173.1540322612993;
 Tue, 23 Oct 2018 12:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=nSsAKJ=MB6HiZ3mDE3kVa4Yx8imkVDsq-ngC-2O8Vfpg@mail.gmail.com>
 <20181022154313.19577-1-vmojzis@redhat.com> <CAJfZ7==tKhuWAmzgw+O5fhX9n8h0Jo_0zgmn3zbcqW=yf_JaJw@mail.gmail.com>
In-Reply-To: <CAJfZ7==tKhuWAmzgw+O5fhX9n8h0Jo_0zgmn3zbcqW=yf_JaJw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 23 Oct 2018 21:23:21 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
Message-ID: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Oct 23 21:23:35 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 22, 2018 at 7:53 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Oct 22, 2018 at 5:43 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Fix CheckDomain and CheckPortType classes to properly deal with aliases.
> >
> > Resolves:
> >    https://bugzilla.redhat.com/show_bug.cgi?id=1600009
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  python/sepolicy/sepolicy.py          |  8 +++-----
> >  python/sepolicy/sepolicy/__init__.py | 16 +++++++++++++++-
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> > index a000c1ad..01380fbe 100755
> > --- a/python/sepolicy/sepolicy.py
> > +++ b/python/sepolicy/sepolicy.py
> > @@ -60,8 +60,6 @@ class CheckPath(argparse.Action):
> >  class CheckType(argparse.Action):
> >
> >      def __call__(self, parser, namespace, values, option_string=None):
> > -        domains = sepolicy.get_all_domains()
> > -
> >          if isinstance(values, str):
> >              setattr(namespace, self.dest, values)
> >          else:
> > @@ -103,7 +101,7 @@ class CheckDomain(argparse.Action):
> >          domains = sepolicy.get_all_domains()
> >
> >          if isinstance(values, str):
> > -            if values not in domains:
> > +            if sepolicy.get_real_type_name(values) not in domains:
> >                  raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (values, ", ".join(domains)))
> >              setattr(namespace, self.dest, values)
> >          else:
> > @@ -112,7 +110,7 @@ class CheckDomain(argparse.Action):
> >                  newval = []
> >
> >              for v in values:
> > -                if v not in domains:
> > +                if sepolicy.get_real_type_name(v) not in domains:
> >                      raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (v, ", ".join(domains)))
> >                  newval.append(v)
> >              setattr(namespace, self.dest, newval)
> > @@ -167,7 +165,7 @@ class CheckPortType(argparse.Action):
> >          if not newval:
> >              newval = []
> >          for v in values:
> > -            if v not in port_types:
> > +            if sepolicy.get_real_type_name(v) not in port_types:
> >                  raise ValueError("%s must be an SELinux port type:\nValid port types: %s" % (v, ", ".join(port_types)))
> >              newval.append(v)
> >          setattr(namespace, self.dest, values)
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index 8484b28c..9ea10835 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -446,6 +446,20 @@ def get_file_types(setype):
> >              mpaths[f] = []
> >      return mpaths
> >
> > +def get_real_type_name(name):
> > +    """Return the real name of a type
> > +
> > +    * If 'name' refers to a type, return the same name.
> > +    * If 'name' refers to a type alias, return the corresponding type name.
> > +    * Otherwise return None.
> > +    """
> > +    if not name:
> > +        return None
> > +
> > +    try:
> > +        return next(info(TYPE, name))["name"]
> > +    except (RuntimeError, StopIteration):
> > +        return None
> >
> >  def get_writable_files(setype):
> >      file_types = get_all_file_types()
> > @@ -1061,7 +1075,7 @@ def gen_short_name(setype):
> >          domainname = setype[:-2]
> >      else:
> >          domainname = setype
> > -    if domainname + "_t" not in all_domains:
> > +    if get_real_type_name(domainname + "_t") not in all_domains:
> >          raise ValueError("domain %s_t does not exist" % domainname)
> >      if domainname[-1] == 'd':
> >          short_name = domainname[:-1] + "_"
> > --
> > 2.17.2
> >
> Looks good to me. I will let the possibility for others to comment and
> will merge these patches tomorrow.
>
> Thanks,
> Nicolas

Merged.
Nicolas

