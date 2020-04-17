Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87589C2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C73E2078E
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="l/F22cru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgDQTXJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgDQTXI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 15:23:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A66BC061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 12:23:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id re23so2390386ejb.4
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4eZKFQQzpKvCSuz+JxEqerI4TCDArtdLCUt7x5ydLo=;
        b=l/F22cruMor1ErNyJgHkqoKr+GtpDLoQjgU8YZMe79AlE/nBIdPEqCw21G/H5wR5Sc
         O5KLm/fNR1WOWYxpz/8xHtDNUWxVFYcQKOoky30IlSEl9XA+UkNW1lEGgUOU8ZLmxbia
         TBQGKzl9pud5HAEeuIL5pnSVifUtcO9++L8dCfxZIlhq/2vaUmUfUqEwDt84WnqyNSMh
         JURjtbVjHXQBtm+oIeCwfLhBjYUrdtGd2tpAeDHktKhYXevvp5XfA+ZEq/2PSZHOGM/i
         hgmuxHR8pvKM4FkpSadnNrDR4b2hAMRBPltfSEbh5+39ljoN+cxPTf0D16TBDIXa/ADu
         pmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4eZKFQQzpKvCSuz+JxEqerI4TCDArtdLCUt7x5ydLo=;
        b=omAiX/pkIHLjITyWgmpbHyka4AfHEqrNrrkdxnBwNW31jupNAJj3mLkTvPjsQN/B3A
         U8d4n6t892vSkoYWZvRdgNwa9QLF6yrERdXbsTG5xtXp7R2yXHGK/fvL3QJe6oVtSSkg
         qjgqoY3NPnWduRKrBQ7WTPdwbewQXFUANayOgCrCWSijT/TsuauC4tG4+3fWkNbQ9V3l
         avjTxtE70PDgZbv/ItqediU247a4pUVZZdgK4rfdojezG/3pKHiG0flCGh5ju2s9NpHK
         hjQMbsnWGQudtcl/rM6ZzQEKtm+rIDCJiZesbETxgzmljrmS6RwusoDdlMT4z4e4f3j2
         3oog==
X-Gm-Message-State: AGi0PuY3zGYSkppdASYm5c2GRC9y6SNXkRfo3ZfOKOHsZAizUqvNfVjL
        /AGBxf3iDdbuA9toWaT5ifRDxoIt4+AcToerXKFA
X-Google-Smtp-Source: APiQypIlpNqqHEcOatludEQyR2RB8vrG7cB26/sP8v32FsgiBJPeMczEdX1d1wEQDxzZlg1QUrDvMRAG4FpUmlpzIVM=
X-Received: by 2002:a17:906:4cd2:: with SMTP id q18mr4645525ejt.70.1587151386653;
 Fri, 17 Apr 2020 12:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200407182858.1149087-1-omosnace@redhat.com> <CAHC9VhQu0B8KwBLP+qD9JvtyFJS-X3ANThp8EytG4R0scyzoCA@mail.gmail.com>
 <CAFqZXNtcvX2TkBkicaddk07HUQS37vTdbupOgK=3EXw5pP78SQ@mail.gmail.com> <CAHC9VhQVEMe5BWcCt_ntgu9jJBd5CN+h-QL6fQ_ws0ouvSmg3w@mail.gmail.com>
In-Reply-To: <CAHC9VhQVEMe5BWcCt_ntgu9jJBd5CN+h-QL6fQ_ws0ouvSmg3w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 15:22:55 -0400
Message-ID: <CAHC9VhQn5j2MfWEVVfF9JcqO-qa3dKqwz2d9ixNqamygfZKvxw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: store role transitions in a hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 9:20 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 16, 2020 at 5:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Apr 16, 2020 at 3:41 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Apr 7, 2020 at 2:29 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Currently, they are stored in a linked list, which adds significant
> > > > overhead to security_transition_sid(). On Fedora, with 428 role
> > > > transitions in policy, converting this list to a hash table cuts down
> > > > its run time by about 50%. This was measured by running 'stress-ng --msg
> > > > 1 --msg-ops 100000' under perf with and without this patch.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >
> > > > v2:
> > > >  - fix typo scontext->tcontext in security_compute_sid()
> > > >  - suggest a better command for testing in the commit msg
> > > >
> > > >  security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
> > > >  security/selinux/ss/policydb.h |   8 +-
> > > >  security/selinux/ss/services.c |  21 +++--
> > > >  3 files changed, 107 insertions(+), 60 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > > index 70ecdc78efbd..4f0cfffd008d 100644
> > > > --- a/security/selinux/ss/policydb.c
> > > > +++ b/security/selinux/ss/policydb.c
> > > > @@ -458,6 +465,30 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> > > >         return v;
> > > >  }
> > > >
> > > > +static u32 role_trans_hash(struct hashtab *h, const void *k)
> > > > +{
> > > > +       const struct role_trans_key *key = k;
> > > > +
> > > > +       return (key->role + (key->type << 3) + (key->tclass << 5)) &
> > > > +               (h->size - 1);
> > > > +}
> > > > +
> > > > +static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
> > > > +{
> > > > +       const struct role_trans_key *key1 = k1, *key2 = k2;
> > > > +       int v;
> > > > +
> > > > +       v = key1->role - key2->role;
> > > > +       if (v)
> > > > +               return v;
> > > > +
> > > > +       v = key1->type - key2->type;
> > > > +       if (v)
> > > > +               return v;
> > > > +
> > > > +       return key1->tclass - key2->tclass;
> > >
> > > Why just a simple boolean statement?
> > >
> > >   return key1->role != key2->role || \
> > >          key1->type != key2->type || \
> > >          key1->tclass != key2->tclass;
> >
> > Because hashtab sorts the entries in each bucket, so it needs a proper
> > sort function. Other such functions (rangetr_cmp(), filenametr_cmp())
> > do a similar thing.
>
> Ooops, yep, of course you're correct.  Sorry about the noise :)
>
> I'll send a note later today when it's merged, but this looks good to me.

A day later than expected, but I just merged this into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
