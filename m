Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BE1E53A
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651581; cv=none; b=AQ4aUp3m4qdXRoTMuVjSRujAeJi03k0N83CjxlO8WvZs2kNxmVGxJLD+OVWpcuYnzfj03bfZugR5zbXcPwdgt5aqOU+FkzcIqwsdJp/2nKRiJeFr19HtYQqTpeDFaGLvXboavOeouASONls86BoXKhqGVz+6TjJLZR9clf/1TdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651581; c=relaxed/simple;
	bh=Ng3pf9buUHHYuy2YWD6KhD/sXr2+FpETMYl3Qabx3rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJjdeFQtSuzPw/EF1gyRa6qi4s7xeuQ1JA2/tFIa6isTWs+po3i+U6s/LPibiJpd5r412MxL+DY8Ot+riJIMlD35dyb6AxvhGY3G53PP4GWkU3e5DQLgmIDMfHwl0xwxf0Xogm5jgBe+PJvIoTaWvFPDowNlc+y07fUaUbUakWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Mwdw/vWS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Mwdw/vWS"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso92232276.2
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723651579; x=1724256379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7yVTWUzIMcAvWIxQNtdqyARxt66V04oc0MvOoo/OKs=;
        b=Mwdw/vWShQEYteV/5egbjNukGMasuOh4QWKlQ4geCo6lO4ucGzHCIUMrfUozp5HQc9
         gghZfnYy0cMOAyfyB6jIwnvZ17ihmpEaYsRtz6F4r0JVJfCei4U2tuIW1BI+GJ4kpphr
         ColH6387K+yLNGvjmgZVccmlIaFRILLGKdGcCZn0pWc5rJW+QwMH8SUZ8MXlz/cSaqVh
         4AB4U6pGitvNA+OmEwqTd+nSADCq+eswlLOrLtC0nxuSPeAfV/dsUTl5ST9ODKFx0wRb
         GM4hN1MYALyN44SzASUZWvw4Y/jX+l4KoTSvbYJedXYHFLl27BlFSsf69Gdcabe1W3V6
         9OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651579; x=1724256379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7yVTWUzIMcAvWIxQNtdqyARxt66V04oc0MvOoo/OKs=;
        b=S7ZoEHiKeheSqFFhgX6TNgLgJvLV7o7FG2XcNlSmw2q2IHh+d4hnD1dj7qBIkRPVO4
         peUORzT/yKi0H38l4ESUNyWQTMEKkBw7lvMkH6lXB+bO4wX7ekXUuEmEcJRmoinp9H3f
         ZwIl/Myz8bA49GmAQtDOzAKzIvHkMXh6z2srMNHBwFXYAj5+i2hvfMN7xKbi+L+b2BtQ
         711w3eGpzQ+A9Cbt6z51u0Ci5Umb806+Lf5GnmWXITq8RVxqozXOoCiQADNe7q3L37OF
         NkOu5QOc3AApPwG1crkW35Bl7bqDwk70lrKUCYEpEmHPjbcFVwf45cdUqKnpwQ/IEx/G
         aMSw==
X-Gm-Message-State: AOJu0Yyn0V/ErhpkNhJwFWpC9gjlvn6VLeIkZIDKgKONPkmLmD9AK8up
	U953+LdddR4NPP9xHj0VT0ClnyYv5uEf8n55MWvtxjUlp1PW2xyayn7oq0P0f5+X3LiJT8Aj8jZ
	AWrb8Gn/o/tRoKKWvqjXbrR/N5Xw=
X-Google-Smtp-Source: AGHT+IHQmjxIXe+E9QuAyxV5cCyocRcrRIvKM69dXLUYMR3cvsUHK6cTFaGq4P1ZUK/t3dP1zQyrvuxezO3YYi7Yqkc=
X-Received: by 2002:a05:6902:240a:b0:e0b:c1bf:3ad0 with SMTP id
 3f1490d57ef6-e1155ab3657mr4211818276.16.1723651578984; Wed, 14 Aug 2024
 09:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812194051.66157-1-jwcart2@gmail.com>
In-Reply-To: <20240812194051.66157-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 14 Aug 2024 18:06:07 +0200
Message-ID: <CAJ2a_Df+rYMNdfav-YWw+47S6CnDyKMxUcJnBSJfJ1a49UabCw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix MLS users in optional blocks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Aug 2024 at 21:41, James Carter <jwcart2@gmail.com> wrote:
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

Maybe add this optional block to checkpolicy/tests/policy_allonce_mls.conf?

> user USER1 roles ROLE1 level SENS1 range SENS1;
> sid kernel USER1:ROLE1:TYPE1:SENS1
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  checkpolicy/policy_define.c | 76 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index bfeda86b..93a1397e 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4175,6 +4175,55 @@ static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats
>         return 0;
>  }
>
> +static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
> +                                                                  const mls_semantic_cat_t * src)
> +{
> +       mls_semantic_cat_t *new, *dcat;
> +
> +       dcat = *dst;

Does this always work?
*dst is the pointer to the first category (which might be NULL).
What if the list is not empty, so dcat->next is not NULL, then we
would override it later and lose the existing tail of the list.

> +       while (src) {
> +               new = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
> +               if (!new)
> +                       return -1;
> +
> +               mls_semantic_cat_init(new);
> +               new->low = src->low;
> +               new->high = src->high;
> +
> +               if (dcat)
> +                       dcat->next = new;
> +               else
> +                       *dst = new;
> +               dcat = new;
> +
> +               src = src->next;
> +       }
> +
> +       return 0;
> +}
> +
> +static int mls_add_or_check_level(mls_semantic_level_t *dst, mls_semantic_level_t *src)

src can be declared const

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
> @@ -4233,7 +4282,7 @@ static int parse_semantic_categories(char *id, level_datum_t * levdatum __attrib
>  int define_user(void)
>  {
>         char *id;
> -       user_datum_t *usrdatum;
> +       user_datum_t *usrdatum, *usr_global;
>         level_datum_t *levdatum;
>         int l;
>
> @@ -4258,10 +4307,15 @@ int define_user(void)
>                 return 0;
>         }
>
> +       id = strdup(queue_head(id_queue));
> +
>         if ((usrdatum = declare_user()) == NULL) {

free(id);

>                 return -1;
>         }
>
> +       usr_global = hashtab_search(policydbp->p_users.table, (hashtab_key_t) id);
> +       free(id);
> +
>         while ((id = queue_remove(id_queue))) {
>                 if (set_user_roles(&usrdatum->roles, id))
>                         return -1;
> @@ -4288,6 +4342,7 @@ int define_user(void)
>                 usrdatum->dfltlevel.sens = levdatum->level->sens;
>
>                 while ((id = queue_remove(id_queue))) {
> +                       /* This will add to any already existing categories */
>                         if (parse_semantic_categories(id, levdatum,
>                                                     &usrdatum->dfltlevel.cat)) {
>                                 free(id);
> @@ -4313,6 +4368,7 @@ int define_user(void)
>                         usrdatum->range.level[l].sens = levdatum->level->sens;
>
>                         while ((id = queue_remove(id_queue))) {
> +                               /* This will add to any already existing categories */
>                                 if (parse_semantic_categories(id, levdatum,
>                                                &usrdatum->range.level[l].cat)) {
>                                         free(id);
> @@ -4333,6 +4389,24 @@ int define_user(void)
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
>
