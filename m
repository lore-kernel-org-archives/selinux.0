Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBDC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5021556
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exqhoJj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCBQaU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:30:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46234 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBQaU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 11:30:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so10844352oid.13
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YG6t5IRdjYt/xh5RgBA6cL88aW4cutVC4OHSNydLDg=;
        b=exqhoJj92u9fM5dGUA1LXD/QQxQypF/fIbj1prDVYkAQ+Z+5BnXsy7drepNi+fNXEU
         6++EdtAXqhph+eA546VW17ukXVF5narJ/A0RhwF6qj/zMTcOmKVeXvaWujq64HMyiW6u
         v5WQyfb1Oea95pbP/NhJ6K1imIsGozA0QQ+e6tXeZakycSxkSdgDfIkZ+fTc3EJfNZgk
         QYbxER6TwdpapOWguT6u+w3Yizmu5asv1pCup/Ge84GdfrEbZMwd0BhA8h7aBGK9Vpt4
         Bud088hgWm4TmlwxFKhxX6YBiI8UXZcFTfzUKvEfr5UENjRlgcfqxwM1JdQikJQDt5t0
         R3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YG6t5IRdjYt/xh5RgBA6cL88aW4cutVC4OHSNydLDg=;
        b=EfDN1Lj4QVanHnqDDsnwouI5Dzs1bixM+ZjIcFVWjamMUz8G8NlZMTiiijyQdrDWHV
         4eiA9L0oql3WaOszqg6nVxcr+XYOxh7f8wfOuGzmGz8vDHc7jJzGw5KjiHA/AWO+k3TC
         17LQYZWea2GKWii6ekbbQGrAaDBAFZLUhwpFi1gTwmE9yU4Uw6P1FR4QFzaCu73WvIGp
         VY17P4RweFr60ER2nWbU9fLkPSs8TD4GTVjULAZ+ShRTsRiq9d+n1Q05NJd5Vk20CYv8
         bWpzJH3oGOQVOD1dOSNqTiQ5RupOBHWJ8rF+88aCsNbAuhvOxSPFkdz/WsmlkrBITrRm
         hwPg==
X-Gm-Message-State: ANhLgQ3HpKb76Ad4tDMiYIW1paC1p8lRKIIrhu8f2MD0fvL45qhdctUs
        gqrV2IUl+STa6340z0V2fyP7+uvRJFXDfeGI+qyrXw==
X-Google-Smtp-Source: ADFU+vuyiuJouL5IOqeB6Lkoh2Mx28pUYOcoJi9VZkK4ZfOTOuvTJ+gZ65i7WjKANVLk2BkN7MeKhLDx4Z201xXQGOM=
X-Received: by 2002:aca:4a86:: with SMTP id x128mr220819oia.29.1583166619959;
 Mon, 02 Mar 2020 08:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-3-omosnace@redhat.com>
 <CAP+JOzSRMFHF0FXOtkfjAsignPhX0UyEzyWAQiM-8LPQii-ULw@mail.gmail.com>
In-Reply-To: <CAP+JOzSRMFHF0FXOtkfjAsignPhX0UyEzyWAQiM-8LPQii-ULw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Mar 2020 11:31:47 -0500
Message-ID: <CAP+JOzS8WWfMTcxtB2n6JZVkjaN0+azw4g+ea7iZS8R_b0gAxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: optimize inner loop in build_type_map()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 10:24 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Only attributes can be a superset of another attribute, so we can skip
> > non-attributes right away.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  libsepol/src/optimize.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > index 4d835d47..2b5102af 100644
> > --- a/libsepol/src/optimize.c
> > +++ b/libsepol/src/optimize.c
> > @@ -50,6 +50,9 @@ static ebitmap_t *build_type_map(const policydb_t *p)
> >                         for (k = 0; k < p->p_types.nprim; k++) {
> >                                 ebitmap_t *types_k = &p->attr_type_map[k];
> >
> > +                               if (p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
> > +                                       continue;
> > +
>
> I haven't tested this yet, but I suspect that this is what is causing
> the difference noted by Stephen. A type is a superset of itself.
>

This is definitely what is causing the change. Your explanation is
correct. This prevents a type from being considered as a super set of
an attribute that only contains that type.

Jim

> Jim
>
>
> >                                 if (ebitmap_contains(types_k, types_i)) {
> >                                         if (ebitmap_set_bit(&map[i], k, 1))
> >                                                 goto err;
> > --
> > 2.24.1
> >
