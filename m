Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D1CC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BF064DE0
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 07:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBRHbU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 02:31:20 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39146 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBRH1I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 02:27:08 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C26DD564DE1
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 08:25:38 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id r75so973933oie.11
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 23:25:38 -0800 (PST)
X-Gm-Message-State: AOAM5308jzyxR7jtBFPXpxZpkUSzBkVdMFHYSoYTZOT3OcIBTJM8y+B3
        xPlvAM3cMpjjevxC/UP7QETC8KiHQ39ixnWQ5oI=
X-Google-Smtp-Source: ABdhPJwGWzqleTQTAo7yraHQEiLondSwFwhxNij0dETzooIwZRzXEvyWTkvpbcYL7C+3X+OafWt3zA6oN0/vCL03tbU=
X-Received: by 2002:aca:b254:: with SMTP id b81mr1904415oif.20.1613633137743;
 Wed, 17 Feb 2021 23:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20210205204934.314141-1-jwcart2@gmail.com>
In-Reply-To: <20210205204934.314141-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 18 Feb 2021 08:25:27 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kaJDrwTuJw0uSCPwF=gkj2SWmPirKJ5QnvusPd7tDPUw@mail.gmail.com>
Message-ID: <CAJfZ7=kaJDrwTuJw0uSCPwF=gkj2SWmPirKJ5QnvusPd7tDPUw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Eliminate gaps in the policydb role arrays
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb 18 08:25:39 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 9:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> Since the kernel binary policy does not include role attributes,
> they are expanded when creating the policy and there are gaps
> in the role values written to the policy. When this policy is
> read from a file and the policydb is created there will be gaps
> in the p_role_val_to_name and role_val_to_struct arrays.
>
> When expanding a policy into a new policydb, copy the roles first
> and then copy the role attributes. When writing a kernel binary
> policy, update the nprim of the role symtab by subtracting the number
> of role attributes. Now when that policy is read and its policydb is
> created there will be no gaps in the role arrays.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/expand.c | 40 ++++++++++++++++++++++++++++++++--------
>  libsepol/src/write.c  |  6 ++++--
>  2 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index eac7e450..ea1b115a 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -789,19 +789,15 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
>         return 0;
>  }
>
> -static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> -                             void *data)
> +static int role_copy_callback_helper(char *id, role_datum_t *role, expand_state_t *state, unsigned int copy_attr)
>  {
>         int ret;
> -       char *id, *new_id;
> -       role_datum_t *role;
> +       char *new_id;
>         role_datum_t *new_role;
> -       expand_state_t *state;
>         ebitmap_t tmp_union_types;
>
> -       id = key;
> -       role = (role_datum_t *) datum;
> -       state = (expand_state_t *) data;
> +       if ((!copy_attr && role->flavor == ROLE_ATTRIB) || (copy_attr && role->flavor != ROLE_ATTRIB))
> +               return 0;
>
>         if (strcmp(id, OBJECT_R) == 0) {
>                 /* object_r is always value 1 */
> @@ -878,6 +874,26 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>         return 0;
>  }
>
> +static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> +                             void *data)
> +{
> +       char *id = key;
> +       role_datum_t *role = (role_datum_t *) datum;
> +       expand_state_t *state = (expand_state_t *) data;
> +
> +       return role_copy_callback_helper(id, role, state, 0);
> +}
> +
> +static int role_attr_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> +                             void *data)
> +{
> +       char *id = key;
> +       role_datum_t *role = (role_datum_t *) datum;
> +       expand_state_t *state = (expand_state_t *) data;
> +
> +       return role_copy_callback_helper(id, role, state, 1);
> +}
> +
>  int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
>                               policydb_t * p, sepol_handle_t * h)
>  {
> @@ -3014,6 +3030,9 @@ int expand_module(sepol_handle_t * handle,
>         /* copy roles */
>         if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
>                 goto cleanup;
> +       /* copy role attrs */
> +       if (hashtab_map(state.base->p_roles.table, role_attr_copy_callback, &state))
> +               goto cleanup;
>         if (hashtab_map(state.base->p_roles.table,
>                         role_bounds_copy_callback, &state))
>                 goto cleanup;
> @@ -3074,6 +3093,11 @@ int expand_module(sepol_handle_t * handle,
>                     (decl->p_roles.table, role_copy_callback, &state))
>                         goto cleanup;
>
> +               /* copy role attrs */
> +               if (hashtab_map
> +                   (decl->p_roles.table, role_attr_copy_callback, &state))
> +                       goto cleanup;
> +
>                 /* copy users */
>                 if (hashtab_map
>                     (decl->p_users.table, user_copy_callback, &state))
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 84bcaf3f..95a2c376 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -2321,8 +2321,10 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
>                 if ((i == SYM_ROLES) &&
>                     ((p->policy_type == POLICY_KERN) ||
>                      (p->policy_type != POLICY_KERN &&
> -                     p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
> -                       (void)hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
> +                         p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB))) {
> +                       hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
> +                       buf[0] -= p->symtab[i].table->nel - buf[1];

Hello,
Sorry for the delay, I was busy in the last few days.
While reviewing this patch, I stumbled upon this line which changes
buf[0]. At the beginning of the for where these lines are modified
there is:

    buf[0] = cpu_to_le32(p->symtab[i].nprim);

Does doing "buf[0] -= ..." works on Big Endian systems? It would be
more intuitive if the code was:

    buf[0] = p->symtab[i].nprim
    /* ... */
    if (...) {
        buf[0] -= p->symtab[i].table->nel - buf[1];
    }
    buf[0] = cpu_to_le32(buf[0]);
    buf[1] = cpu_to_le32(buf[1]);
    items = put_entry(buf, sizeof(uint32_t), 2, fp);

Thanks!
Nicolas

