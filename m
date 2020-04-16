Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7637FC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B8D21D79
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 13:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oDh0KwYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895051AbgDPNVI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895032AbgDPNVG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 09:21:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC89C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 06:21:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rh22so1256400ejb.12
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Awdi6Mst5uxrN1DjcsHeXK3/SiVXhB7owCH0B3oiOAQ=;
        b=oDh0KwYvsHGlcrhcyXHZGcmKnwk9cBJ39HGTEvQL6p+OBqa4o/VhQTSKcY0QGlAD9v
         DqZina0JjJKcY+hAeEXl067fSeH5UucAAJ2hh6m6w7lLuP+3+7RIlSnXjfDrGACQH9EV
         j4Efi5JStOeoZYzJ2LHQOK8sevmY4+tkes/5hCh0RZJ6xxPzLectu8+xfxh7uaXS1qzj
         fzXB1eEgOnUM6aR8Cs6Cvm043FvxkM8b26I03dfIlr3kMpnaYstkbX0Ywt+/9d7gphtC
         YaTz4HXmK4GRmXBpjT2YJ82zrodLmPW7/oTiXbyJZmteqYy5dVHTksV70bKKX3XiUM7M
         2SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Awdi6Mst5uxrN1DjcsHeXK3/SiVXhB7owCH0B3oiOAQ=;
        b=UEFC1JnZ4UhkV2iIPbVdOrBVqoHCZKIWROFd35yGwzRtP0LVBOVYyvRXQRboFnXf1o
         lbdVd3PJKJroi78+ufvOAEBt7aGRSFRNJqnmV/4c6PQzmbnYLvtEE1Mgvci6JoFd+/Ev
         2zUqVsq7Yc1pSC0VF5PWjviF9jPSCfY4n3BemXfuU4JoMa1c5Dfq1sG5dy2hCJkKNLOy
         FM0A9j2z4+BEuDbKh362EVsgUfx3Y8O8K/KbFja7BbfFzsNIvJYhZWFpRw04o2iSTmFA
         ckJfqWMTjQHqtHNmRM8KDLxz/d1RGCSsNyrzxEJ/az2JEuvHXLyM4166RRq/NJ8iqS4n
         dfgA==
X-Gm-Message-State: AGi0PualejbgldnavOfnmVJOgD5cnzrv0LtkZe/Etf94ArV2dlsVhMX/
        D3jih7CGsd9hTeOCXsEV23a/+mFzjW/C1pjRyXEttcY=
X-Google-Smtp-Source: APiQypJWNjdmw+SKKuFDXlQyI6YkV5MIKHIyLVLPOit8McWinZvSnunLTFDgiuBTLBQYOf9HmzX5innX9s3VSt91Yt0=
X-Received: by 2002:a17:906:4cd2:: with SMTP id q18mr9838414ejt.70.1587043263162;
 Thu, 16 Apr 2020 06:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200407182858.1149087-1-omosnace@redhat.com> <CAHC9VhQu0B8KwBLP+qD9JvtyFJS-X3ANThp8EytG4R0scyzoCA@mail.gmail.com>
 <CAFqZXNtcvX2TkBkicaddk07HUQS37vTdbupOgK=3EXw5pP78SQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtcvX2TkBkicaddk07HUQS37vTdbupOgK=3EXw5pP78SQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Apr 2020 09:20:52 -0400
Message-ID: <CAHC9VhQVEMe5BWcCt_ntgu9jJBd5CN+h-QL6fQ_ws0ouvSmg3w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: store role transitions in a hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 5:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Apr 16, 2020 at 3:41 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Apr 7, 2020 at 2:29 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Currently, they are stored in a linked list, which adds significant
> > > overhead to security_transition_sid(). On Fedora, with 428 role
> > > transitions in policy, converting this list to a hash table cuts down
> > > its run time by about 50%. This was measured by running 'stress-ng --msg
> > > 1 --msg-ops 100000' under perf with and without this patch.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > v2:
> > >  - fix typo scontext->tcontext in security_compute_sid()
> > >  - suggest a better command for testing in the commit msg
> > >
> > >  security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
> > >  security/selinux/ss/policydb.h |   8 +-
> > >  security/selinux/ss/services.c |  21 +++--
> > >  3 files changed, 107 insertions(+), 60 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index 70ecdc78efbd..4f0cfffd008d 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -458,6 +465,30 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> > >         return v;
> > >  }
> > >
> > > +static u32 role_trans_hash(struct hashtab *h, const void *k)
> > > +{
> > > +       const struct role_trans_key *key = k;
> > > +
> > > +       return (key->role + (key->type << 3) + (key->tclass << 5)) &
> > > +               (h->size - 1);
> > > +}
> > > +
> > > +static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
> > > +{
> > > +       const struct role_trans_key *key1 = k1, *key2 = k2;
> > > +       int v;
> > > +
> > > +       v = key1->role - key2->role;
> > > +       if (v)
> > > +               return v;
> > > +
> > > +       v = key1->type - key2->type;
> > > +       if (v)
> > > +               return v;
> > > +
> > > +       return key1->tclass - key2->tclass;
> >
> > Why just a simple boolean statement?
> >
> >   return key1->role != key2->role || \
> >          key1->type != key2->type || \
> >          key1->tclass != key2->tclass;
>
> Because hashtab sorts the entries in each bucket, so it needs a proper
> sort function. Other such functions (rangetr_cmp(), filenametr_cmp())
> do a similar thing.

Ooops, yep, of course you're correct.  Sorry about the noise :)

I'll send a note later today when it's merged, but this looks good to me.

-- 
paul moore
www.paul-moore.com
