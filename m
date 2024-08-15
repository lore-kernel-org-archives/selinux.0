Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1F3214
	for <selinux@vger.kernel.org>; Thu, 15 Aug 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733456; cv=none; b=KBA4/UFoE3YyQbnI1p0B8jgOiyayReSAE7SvZj8DgDVFbJ5Io/yQd1onJaW1V6DdPm9S3P73ARi5kHynceIaJIisaA/NmRjcYU5f3GK19+r1UnnesIPlzC8pdMAstlxFfM51ARq5+U7NJKqpuGDmGmQYCLLaT6BR+9jNZtsB65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733456; c=relaxed/simple;
	bh=/uV4oPNKpmdzyTWJujKaQDJeRrqVA7NyYaFaILC/I2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOz2HioSs1cORAaKfAVi263vjeVEcAc5EzkekFj+9R+SKfG2wyBFToOaF5oL40OEkeuVxVUp9qfSW+1COJJ/jc/2kPVxV5wdOA1jdpYpdmhPw5WTUQFTDqXjL94ro38tUoDBjgK4cnNu/+U+eEgh+LsbwRopBHknUyMS06Ys9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EyLFWuab; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EyLFWuab"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso759373276.1
        for <selinux@vger.kernel.org>; Thu, 15 Aug 2024 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723733453; x=1724338253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VfQUYby8t6xTkVrATPO/gXDwfRbNOC7zQho16RwzIpM=;
        b=EyLFWuab0OGW6vyoSneA0kbtk4Et96vVPqNUCqGFcdY6FP7KN9Lm3XaVGHSQWlBkwR
         Wrob/hXoVau013vJhsRBpRMxBj26yGCG+briZV7YY6kzqLSsanJS5NLCRv2fBa+kbuVU
         WzYCoQGJ1AlpgjbJmtb/UwFXUcgNW/Gt1xyy6Ja47ay5upgA2gxfIv8wRIemKylxtP3w
         wBdO5BlOpK/AlwOpDlTsxrZJ/0DWbQQKGTSgTge3zhr4Z/XHW6uj/qhpGmm5ez/FupfW
         NZFb+6JhgcxktpMv9vbzWSNl6H08XEKxL7agn45e8zLqriQhQglmUW3CS+qx6RwWhnUZ
         g5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723733453; x=1724338253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfQUYby8t6xTkVrATPO/gXDwfRbNOC7zQho16RwzIpM=;
        b=LHstDDA2y9CgCuxRDwhT1gzI+8K//PZg2FpCTl7zz3fogbDpxIw5J+qNMOqJdcw3qp
         gTGjreFVud4vggt7riXPQYrDrBT6Tm9TGmi3PBP75Jon2UemGsu8Puc8sLYe9fTmRlmm
         Ew53NACGJCsBEDUsZ49VtAdy2+jCyRTuEwTFElWAKi9ON0uJ3Slp+TVporBgF+m5ZNwt
         Ve94yjzlM3BayA5wG1WIO3fgh8O9ow5WzPv8xMZKKaWCPba6/vArVjzNTJixMoLafqOP
         d4LFSHj2USLktKvWso2KL40M8NtdR8FhvhyU08YWLs/7EceAGQZp3WiDpKxTUtlrRN8U
         d+rA==
X-Gm-Message-State: AOJu0YzhBa4K38+w1XO9CKbnSXUvyrE3Pz+StHiRbuAy/jLEpMrS9m5Z
	xOBrTOjmyNzmyh6R1q/dgW3St+tQU3Elnk72FWZ0StqiKibhXQPcy0C2dUEIdB2GEi5c72mBwQw
	04G/iGRh5fLU6hXK0Pcr+GZrVfuw=
X-Google-Smtp-Source: AGHT+IFFG/kI4IJzKpKd38qdZ0pFgWuVw+5ak4qYSQiu2kRcfAYqDVtxLg2GJLTz4HWyS7R78UXH3Kjp1AQ6/2vYYjE=
X-Received: by 2002:a05:6902:848:b0:e0b:1049:f935 with SMTP id
 3f1490d57ef6-e116cc58fb7mr3260897276.6.1723733453336; Thu, 15 Aug 2024
 07:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814190319.321748-1-jwcart2@gmail.com>
In-Reply-To: <20240814190319.321748-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 15 Aug 2024 16:50:41 +0200
Message-ID: <CAJ2a_DeXkO2HZbuSchEi3KzGkRdP92NLYP0ji7EuyeLQxmCR_g@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix MLS users in optional blocks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 21:03, James Carter <jwcart2@gmail.com> wrote:
>
> When a user is created in an optional block, a user datum is added
> to both the avrule_decl's symtab and the policydb's symtab, but
> the semantic MLS information is only added to the avrule_decl's
> user datum. This causes an error to occur during policy expansion
> when user_copy_callback() is called. If this error did not occur
> then the policydb's user datum would be written without any MLS
> info and the policy would fail validation when read later.
>
> When creating a user datum, search for a user datum with the same
> key in the policydb's symtab. If that datum has no MLS information,
> then copy the MLS information from the avrule_decl's datum. If it
> does, then compare the default level, low level, and high level
> sensitivities and give an error if they do not match. There is not
> enough information to expand the categories for the high and low
> levels, so merge the semantic categories. If the two category sets
> are not equal an error will occur during the expansion phase.
>
> A minimum policy to demonstrate the bug:
> class CLASS1
> sid kernel
> class CLASS1 { PERM1 }
> sensitivity SENS1;
> dominance { SENS1 }
> level SENS1;
> mlsconstrain CLASS1 { PERM1 } ((h1 dom h2) and (l1 domby h1));
> type TYPE1;
> allow TYPE1 self : CLASS1 PERM1;
> role ROLE1;
> role ROLE1 types TYPE1;
> optional {
>   require {
>     role ROLE1;
>   }
>   user USER2 roles ROLE1 level SENS1 range SENS1;
> }
> user USER1 roles ROLE1 level SENS1 range SENS1;
> sid kernel USER1:ROLE1:TYPE1:SENS1
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2:
>   - Fixed mls_semantic_cats_merge() so that it keeps existing cats in dst
>   - Made src const in mls_add_or_check_level()
>
>  checkpolicy/policy_define.c | 71 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index bfeda86b..52045484 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4175,6 +4175,50 @@ static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats
>         return 0;
>  }
>
> +static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
> +                                                                  const mls_semantic_cat_t * src)
> +{
> +       mls_semantic_cat_t *new;
> +
> +       while (src) {
> +               new = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
> +               if (!new)
> +                       return -1;
> +
> +               mls_semantic_cat_init(new);
> +               new->low = src->low;
> +               new->high = src->high;
> +               new->next = *dst;
> +               *dst = new;

Seems similar to the adding in parse_semantic_categories().
Thanks.

> +
> +               src = src->next;
> +       }
> +
> +       return 0;
> +}
> +
> +static int mls_add_or_check_level(mls_semantic_level_t *dst, const mls_semantic_level_t *src)
> +{
> +       if (!dst->sens) {
> +               if (mls_semantic_level_cpy(dst, src) < 0) {
> +                       yyerror("out of memory");
> +                       return -1;
> +               }
> +       } else {
> +               if (dst->sens != src->sens) {
> +                       return -1;
> +               }
> +               /* Duplicate cats won't cause problems, but different cats will
> +                * result in an error during expansion */
> +               if (mls_semantic_cats_merge(&dst->cat, src->cat) < 0) {
> +                       yyerror("out of memory");
> +                       return -1;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int parse_semantic_categories(char *id, level_datum_t * levdatum __attribute__ ((unused)),
>                                      mls_semantic_cat_t ** cats)
>  {
> @@ -4233,7 +4277,7 @@ static int parse_semantic_categories(char *id, level_datum_t * levdatum __attrib
>  int define_user(void)
>  {
>         char *id;
> -       user_datum_t *usrdatum;
> +       user_datum_t *usrdatum, *usr_global;
>         level_datum_t *levdatum;
>         int l;
>
> @@ -4258,10 +4302,15 @@ int define_user(void)
>                 return 0;
>         }
>
> +       id = strdup(queue_head(id_queue));
> +
>         if ((usrdatum = declare_user()) == NULL) {

Isn't `id` still leaking in this error branch?

>                 return -1;
>         }
>
> +       usr_global = hashtab_search(policydbp->p_users.table, (hashtab_key_t) id);
> +       free(id);
> +
>         while ((id = queue_remove(id_queue))) {
>                 if (set_user_roles(&usrdatum->roles, id))
>                         return -1;
> @@ -4288,6 +4337,7 @@ int define_user(void)
>                 usrdatum->dfltlevel.sens = levdatum->level->sens;
>
>                 while ((id = queue_remove(id_queue))) {
> +                       /* This will add to any already existing categories */
>                         if (parse_semantic_categories(id, levdatum,
>                                                     &usrdatum->dfltlevel.cat)) {
>                                 free(id);
> @@ -4313,6 +4363,7 @@ int define_user(void)
>                         usrdatum->range.level[l].sens = levdatum->level->sens;
>
>                         while ((id = queue_remove(id_queue))) {
> +                               /* This will add to any already existing categories */
>                                 if (parse_semantic_categories(id, levdatum,
>                                                &usrdatum->range.level[l].cat)) {
>                                         free(id);
> @@ -4333,6 +4384,24 @@ int define_user(void)
>                                 return -1;
>                         }
>                 }
> +
> +               if (usr_global && usr_global != usrdatum) {
> +                       if (mls_add_or_check_level(&usr_global->dfltlevel,
> +                                                                          &usrdatum->dfltlevel)) {
> +                               yyerror("Problem with user default level");
> +                               return -1;
> +                       }
> +                       if (mls_add_or_check_level(&usr_global->range.level[0],
> +                                                                          &usrdatum->range.level[0])) {
> +                               yyerror("Problem with user low level");
> +                               return -1;
> +                       }
> +                       if (mls_add_or_check_level(&usr_global->range.level[1],
> +                                                                          &usrdatum->range.level[1])) {
> +                               yyerror("Problem with user high level");
> +                               return -1;
> +                       }
> +               }
>         }
>         return 0;
>  }
> --
> 2.46.0
>
