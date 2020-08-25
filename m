Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38593C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119B42075F
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Nu8vjPUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYNnU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHYNnB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 09:43:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB32C061756
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:43:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so626325ejp.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hlDp35H/I6+USSlz9g7OmWeqrjbkaygsZYJJyv3rOI=;
        b=Nu8vjPUe8U98pyTachMTwlIAYOi8LIMuy6fMnFcNjRydnj/xvFpemrnKzYbfphjqCr
         93kVIRJJglIKVZF/I2vsmp0ojbN6Wvy0hgqASO5oecpYuX024j2XvEW9uGK3XAcaYMYO
         LkTIRKH8XyqkLob8X0gFIfzmLjX/fnur1SJ0u2D6pIzFeAVwulk0bqIZ2ND0le5G3zQE
         f/InR04CfHR6MvZd081RuTpHHj2q3sIDoDT/EIIrd57BWLSQt1k0XGQysY3xvtioQir4
         Tf06mitbWg1KDF0XaX6TOz+NaV6/FbzRbFQkDKAovpYEhw6qxgMJzXIMIlgy3hgOUe9A
         RzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hlDp35H/I6+USSlz9g7OmWeqrjbkaygsZYJJyv3rOI=;
        b=fpGYGiuG1NSyvEKlMh88Qci5owaOZwsToSiPW2x7Bn4+cU4HY24xJhAC1ySI+ilpQm
         K9s6oC7kh7HpakbPckIJmJGZGNNmSxKNhgS4gpGJ61tKfLzvQUhFOhHCzLStlzyAsodn
         SVbACmDA0LBzLrWkse1aUgFgM/XXG/hoqauDXV1GHVwTYqBhsm8Oav4ZMWRYS5dFR3zZ
         /SFXmEmUeb03bTjKRm5YSfFmbT1haSQtAxLZufjXONKHlVw4nb3C9KQz8c1ddTLPQQDh
         T6HFPFrTaGTUOFrptg2i3aOKeHfyOo7gv7qJG/Tftm1jT9di4S/SN1k81nJ1brmJnjHv
         hIRA==
X-Gm-Message-State: AOAM531sn0ZdiXbG11qZigkeNZz/+86HhlpM4PjUUZKhqgmmFycfyjoa
        3RADD+FNF0Riv2FAzzx4EOBR4X6m5a9HA/8yEgUt
X-Google-Smtp-Source: ABdhPJznGI0EHgg0IHuuLG+w87xpoF/6sJ2RMCWcY4yoJxxLYAwe/4S9pm93wobqH13gwjujO+JN75K/cXrSoaFUPyY=
X-Received: by 2002:a17:906:3390:: with SMTP id v16mr10312086eja.106.1598362979816;
 Tue, 25 Aug 2020 06:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200821154704.1214330-1-omosnace@redhat.com> <CAEjxPJ5gZhE2RB7A4LQyBOi5FQF5PLw_vs6gHeiwsiB1-j6Rog@mail.gmail.com>
 <CAFqZXNvdtpxveqesYMz3ZxoWGd_vi5euqy6c9gzhmdkKgbU-Fg@mail.gmail.com> <CAEjxPJ5zFv7wDccDP2+0Z=B9-03g03H3wgy5pgu-DHjE3CGU5Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5zFv7wDccDP2+0Z=B9-03g03H3wgy5pgu-DHjE3CGU5Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 09:42:48 -0400
Message-ID: <CAHC9VhQT+G13pdVpf7rfQqeTv387vytNUeQ1wbyCu1GGCpcNog@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a race condition in security_read_policy()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 8:40 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 24, 2020 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Aug 21, 2020 at 7:39 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Fri, Aug 21, 2020 at 11:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > In security_read_policy(), the policy length is computed using
> > > > security_policydb_len(), which does a separate transaction, and then
> > > > another transaction is done to write the policydb into a buffer of this
> > > > length.
> > > >
> > > > The bug is that the policy might be re-loaded in between the two
> > > > transactions and so the length can be wrong. In case the new length is
> > > > lower than the old length, the length is corrected at the end of the
> > > > function. In case the new length is higher than the old one, an error is
> > > > returned.
> > > >
> > > > Fix it by doing everything in a single transaction and getting the
> > > > length directly from policydb instead of calling
> > > > security_policydb_len().
> > > >
> > > > Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  security/selinux/ss/services.c | 19 +++++++++++--------
> > > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > > index a48fc1b337ba9..ab4de2a01634a 100644
> > > > --- a/security/selinux/ss/services.c
> > > > +++ b/security/selinux/ss/services.c
> > > > @@ -3842,22 +3842,25 @@ int security_read_policy(struct selinux_state *state,
> > > >                          void **data, size_t *len)
> > > >  {
> > > >         int rc;
> > > > +       struct policydb *policydb;
> > > >         struct policy_file fp;
> > > >
> > > >         if (!selinux_initialized(state))
> > > >                 return -EINVAL;
> > > >
> > > > -       *len = security_policydb_len(state);
> > > > +       read_lock(&state->ss->policy_rwlock);
> > > > +       policydb = &state->ss->policy->policydb;
> > > >
> > > > +       *len = policydb->len;
> > > >         *data = vmalloc_user(*len);
> > >
> > > I don't believe you can hold a read_lock() across a vmalloc.  That's
> > > why this is done the way it is now.
> >
> > Fair point. Then I guess the only option is to keep retrying the
> > allocation until the allocated size is >= the size we are about to
> > write. I'll send a revised patch soon.
>
> Wondering if this is worthwhile/necessary versus just having userspace
> retry if needed. Reading /sys/fs/selinux/policy is not a common or
> frequent operation.

I tend to agree.  If the kernel is under memory pressure, continually
hammering it with requests seems like the last thing we want to do;
not to mention that we would need to bound the requests at some point
so we don't potentially hang userspace (or worse).  Failing and
letting userspace rety seems like the best option to me.

-- 
paul moore
www.paul-moore.com
