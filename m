Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD2C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18CE42071C
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 18:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgDTSa2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:30:28 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47497 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTSa2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 14:30:28 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6DD8E56492D
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 20:30:24 +0200 (CEST)
Received: by mail-oo1-f48.google.com with SMTP id d21so2344116ook.10
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 11:30:24 -0700 (PDT)
X-Gm-Message-State: AGi0PubNum99J7ULQmU13hRtlYUkM6iQW4t1KkLVT5GPdLjVQwcuStLC
        WyyldfELBgdpquaKySOSNXzSVXC1Kg8rZDb2U90=
X-Google-Smtp-Source: APiQypLIKZ7UYgeZnyJhoPZSin79AyGCUg8KMNmnULek6wtHdCjIb2ZhJTS9bo4TvInpM3Jq5WJIH8ervbkoYziLD9I=
X-Received: by 2002:a4a:accf:: with SMTP id c15mr13613894oon.29.1587407423248;
 Mon, 20 Apr 2020 11:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200419140055.86159-1-nicolas.iooss@m4x.org> <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 20 Apr 2020 20:30:11 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==KyK=+AE8+tojCbZRo-UnB-QwEgL8tseLSfq73kL+mQg@mail.gmail.com>
Message-ID: <CAJfZ7==KyK=+AE8+tojCbZRo-UnB-QwEgL8tseLSfq73kL+mQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] python/semanage: check rc after getting it
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 20 20:30:24 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 20, 2020 at 4:29 PM Roberts, William C
<william.c.roberts@intel.com> wrote:
>
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of Nicolas Iooss
> > Sent: Sunday, April 19, 2020 9:01 AM
> > To: selinux@vger.kernel.org
> > Subject: [PATCH 1/1] python/semanage: check rc after getting it
> >
> > This issue has been found using lgtm.com:
> > https://lgtm.com/projects/g/SELinuxProject/selinux/snapshot/4946f674a6da9cc3
> > 68cc826f963aedd39b6a94cf/files/python/semanage/seobject.py?sort=name&dir
> > =ASC&mode=heatmap#x5c052fffe98aee02:1
> >
> > Fixes: 49706ad9f808 ("Revised Patch for local nodecon support in semanage (was:
> > Adding local nodecon's through semanage)")
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  python/semanage/seobject.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 0e9ce2900892..f2a139c970bd 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -1895,10 +1895,10 @@ class nodeRecords(semanageRecords):
> >          (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
> >          if rc < 0:
> >              raise ValueError(_("Could not create key for %s") % addr)
> > -        if rc < 0:
> > -            raise ValueError(_("Could not check if addr %s is defined") % addr)
> >
> >          (rc, exists) = semanage_node_exists(self.sh, k)
> > +        if rc < 0:
> > +            raise ValueError(_("Could not check if addr %s is defined")
> > + % addr)
> >          if exists:
> >              raise ValueError(_("Addr %s already defined") % addr)
> >
> > --
> > 2.26.0
>
> Acked-by: William Roberts <william.c.roberts@intel.com>
>
> We should probably add the checker so it comments on the PRs. It would have caught it
> Before it got in tree.

In this case, the bug has been introduced in 2008 ;) Anyway, I have
never configured lgtm.com to look on PRs, or contributed to a project
that did this. For SELinux, I am wondering whether the hundreds of
alerts currently reported in
https://lgtm.com/projects/g/SELinuxProject/selinux/?mode=list could
affect the usefulness of having it integrated to PRs.

> Completely unrelated, do you see these warnings?
>
> swigging selinuxswig_python.i to selinuxswig_python_wrap.c
> swig -python -o selinuxswig_python_wrap.c selinuxswig_python.i
> ../include/selinux/avc.h:414: Warning 302: Identifier 'avc_cache_stats' redefined (ignored),
> ../include/selinux/avc.h:394: Warning 302: previous definition of 'avc_cache_stats'.
> ../include/selinux/selinux.h:143: Warning 451: Setting a const char * variable may leak memory.
> ../include/selinux/selinux.h:378: Warning 451: Setting a const char * variable may leak memory.
>
> I created a ticket, so I don't lose them:
> https://github.com/SELinuxProject/selinux/issues/222

Yes, and I see that an explanation has already been given in the GitHub issue.

Cheers,
Nicolas

