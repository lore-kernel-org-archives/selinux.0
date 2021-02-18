Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56FCC433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C864E6F
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 17:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhBRRz6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 12:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhBRPH5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 10:07:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E86C0617A7
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 07:06:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id h17so2281413oih.5
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNsuSmupwydm+nIltiTgg/CWOyMQ7TxzmYHY5iSkpEw=;
        b=QNtBWE1YRIER6mL15Gz9hsXK+9QfIuqjneLqzOi5amoBXiD5n1lF3cVH3hxoYrBlkF
         hhZn4VY5gqWOB3fDVbkm2qA2tWybw6L7ruPB8vwJssmPXKwAdBlnQihjDFbuM8mVFsEw
         +7nYzsr0f8EZUtdw75AXuEdy8VH0MaDw3D+cB85/PyXXqQ8biT8+42jLbuG/MQr3dGOk
         xq0BX4sYsh1R5RAdSWPtBN9Ta2a5o7fmi6UaerdrAFjqU4XftN6HWDGvNe01o2KMX7u6
         fWcGg1sybhb7M9OgKIPQpkMSfb9pBem8zDQdpYdYaERz1gkLkmABIPJAn4I297D3WAFk
         jk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNsuSmupwydm+nIltiTgg/CWOyMQ7TxzmYHY5iSkpEw=;
        b=O3mAx9jTEKsjsPASCNRW5bq+5ixSN8kZ1gY3yL2a2oBB8jaeRuWxR5tTauro3ZrIDc
         OXwcGRW6XenrinF8C5jli5zaGliVILSXblVyLaKNiaWESv5OeXszu2YH3waBOKtCyyr3
         25ksqQ1xCiz7Ei2NFuquti96FJDj4PkPwy49HLlqx2aKME7DD2GybGgt65bUix/l7Igo
         z3E+6MSUveblPG0GbrJe6Qjv0Wr/3cI3k+bV0FEqtZeQZlSZBsvtvdo5PHk9TCuuEpQc
         o3oxRktqUP2YxoJcqaR3sFLVla9tfYIqSixpDbWuapfthUXFZ27q+lCO2aGU6iPs5eRF
         EZsA==
X-Gm-Message-State: AOAM531GuZk3G1t25r9mkD1HxryMsRsIx5n+bGCm63zi2xQdUOTTezJH
        9HyRQ6d99BchVXef/JNuq3aApx+7aMe9KvGe6vWFI5T4nDE=
X-Google-Smtp-Source: ABdhPJxZtWJdVuCHKSQ5aCz50wEb2t75/JlqC8qnjntSqItVs6d69MhFujGnGqM6MygB/3A57gSeG0/PQPZ4P9Fc4B4=
X-Received: by 2002:aca:ecc8:: with SMTP id k191mr2945244oih.16.1613660762403;
 Thu, 18 Feb 2021 07:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20210205204934.314141-1-jwcart2@gmail.com> <CAJfZ7=kaJDrwTuJw0uSCPwF=gkj2SWmPirKJ5QnvusPd7tDPUw@mail.gmail.com>
In-Reply-To: <CAJfZ7=kaJDrwTuJw0uSCPwF=gkj2SWmPirKJ5QnvusPd7tDPUw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Feb 2021 10:05:51 -0500
Message-ID: <CAP+JOzS3WPY-ew32KHKhjvrBUz7qvWViZYovHQsZpr7LTw=VXA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Eliminate gaps in the policydb role arrays
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 18, 2021 at 2:25 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Feb 5, 2021 at 9:51 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Since the kernel binary policy does not include role attributes,
> > they are expanded when creating the policy and there are gaps
> > in the role values written to the policy. When this policy is
> > read from a file and the policydb is created there will be gaps
> > in the p_role_val_to_name and role_val_to_struct arrays.
> >
> > When expanding a policy into a new policydb, copy the roles first
> > and then copy the role attributes. When writing a kernel binary
> > policy, update the nprim of the role symtab by subtracting the number
> > of role attributes. Now when that policy is read and its policydb is
> > created there will be no gaps in the role arrays.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/expand.c | 40 ++++++++++++++++++++++++++++++++--------
> >  libsepol/src/write.c  |  6 ++++--
> >  2 files changed, 36 insertions(+), 10 deletions(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index eac7e450..ea1b115a 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -789,19 +789,15 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
> >         return 0;
> >  }
> >
> > -static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> > -                             void *data)
> > +static int role_copy_callback_helper(char *id, role_datum_t *role, expand_state_t *state, unsigned int copy_attr)
> >  {
> >         int ret;
> > -       char *id, *new_id;
> > -       role_datum_t *role;
> > +       char *new_id;
> >         role_datum_t *new_role;
> > -       expand_state_t *state;
> >         ebitmap_t tmp_union_types;
> >
> > -       id = key;
> > -       role = (role_datum_t *) datum;
> > -       state = (expand_state_t *) data;
> > +       if ((!copy_attr && role->flavor == ROLE_ATTRIB) || (copy_attr && role->flavor != ROLE_ATTRIB))
> > +               return 0;
> >
> >         if (strcmp(id, OBJECT_R) == 0) {
> >                 /* object_r is always value 1 */
> > @@ -878,6 +874,26 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> >         return 0;
> >  }
> >
> > +static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> > +                             void *data)
> > +{
> > +       char *id = key;
> > +       role_datum_t *role = (role_datum_t *) datum;
> > +       expand_state_t *state = (expand_state_t *) data;
> > +
> > +       return role_copy_callback_helper(id, role, state, 0);
> > +}
> > +
> > +static int role_attr_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> > +                             void *data)
> > +{
> > +       char *id = key;
> > +       role_datum_t *role = (role_datum_t *) datum;
> > +       expand_state_t *state = (expand_state_t *) data;
> > +
> > +       return role_copy_callback_helper(id, role, state, 1);
> > +}
> > +
> >  int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
> >                               policydb_t * p, sepol_handle_t * h)
> >  {
> > @@ -3014,6 +3030,9 @@ int expand_module(sepol_handle_t * handle,
> >         /* copy roles */
> >         if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
> >                 goto cleanup;
> > +       /* copy role attrs */
> > +       if (hashtab_map(state.base->p_roles.table, role_attr_copy_callback, &state))
> > +               goto cleanup;
> >         if (hashtab_map(state.base->p_roles.table,
> >                         role_bounds_copy_callback, &state))
> >                 goto cleanup;
> > @@ -3074,6 +3093,11 @@ int expand_module(sepol_handle_t * handle,
> >                     (decl->p_roles.table, role_copy_callback, &state))
> >                         goto cleanup;
> >
> > +               /* copy role attrs */
> > +               if (hashtab_map
> > +                   (decl->p_roles.table, role_attr_copy_callback, &state))
> > +                       goto cleanup;
> > +
> >                 /* copy users */
> >                 if (hashtab_map
> >                     (decl->p_users.table, user_copy_callback, &state))
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index 84bcaf3f..95a2c376 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -2321,8 +2321,10 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
> >                 if ((i == SYM_ROLES) &&
> >                     ((p->policy_type == POLICY_KERN) ||
> >                      (p->policy_type != POLICY_KERN &&
> > -                     p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
> > -                       (void)hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
> > +                         p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB))) {
> > +                       hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
> > +                       buf[0] -= p->symtab[i].table->nel - buf[1];
>
> Hello,
> Sorry for the delay, I was busy in the last few days.
> While reviewing this patch, I stumbled upon this line which changes
> buf[0]. At the beginning of the for where these lines are modified
> there is:
>
>     buf[0] = cpu_to_le32(p->symtab[i].nprim);
>
> Does doing "buf[0] -= ..." works on Big Endian systems? It would be
> more intuitive if the code was:
>
>     buf[0] = p->symtab[i].nprim
>     /* ... */
>     if (...) {
>         buf[0] -= p->symtab[i].table->nel - buf[1];
>     }
>     buf[0] = cpu_to_le32(buf[0]);
>     buf[1] = cpu_to_le32(buf[1]);
>     items = put_entry(buf, sizeof(uint32_t), 2, fp);
>

You are correct. I also noticed with more testing that I can't update
buf[0] when writing modules. I've also found some other problems when
trying to create modular policy with a version before role attributes
if role attributes exist. I am trying to figure out the best way to
handle the situation.

Thanks for the review.
Jim

> Thanks!
> Nicolas
>
