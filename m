Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED96C0015E
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 19:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjHATlN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHATlM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Aug 2023 15:41:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6119AA
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 12:41:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so41596471fa.0
        for <selinux@vger.kernel.org>; Tue, 01 Aug 2023 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690918867; x=1691523667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPirjeVHMe9zl+/E0ttwi4/YgUcXry9a87C65dWzono=;
        b=YeY7vmDrZavSMDYsdQCW2OGZZUFIXNClp7NM6gYxGzguwKFWOSD6Ul3Wjl7GWXkstl
         vZ+jNV4SIukQew/R1QwJzie71uKiJx8a3Nuy6lpJVyV7h2iDV6OEUd3XV1Bmv7050wme
         jaMwE/6AsthVqC3lzeCnMz++1HXZEI5o07t5aOhHo/55cmeZFm5BtYNYC+tB+E3FTKtG
         KZLM2PvqpNw+T+ixmXAIwuGnsSn2JQA5nTVuD5LOSHjCl++83EpFYJGcsDuwha6ZlB+k
         IMBoQofLoX6VnK4BLkBS4d4VQ8h/m5fYUsA/Z7e8H0e46wNSq1wQtwo5Wmv2O2FrGZWM
         HHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918867; x=1691523667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPirjeVHMe9zl+/E0ttwi4/YgUcXry9a87C65dWzono=;
        b=UiRwqmNFjvvv68Gavd2Vv2wtCZkwa/YuMQHTI6vzCVUjRCcyZKF167bUL6dhFBEJMu
         U8pIdQqxCU1eQGobGmmHXuke/O5lYqU9NCWbEscChc89psDDWPUa5k7T0Ij1uryfhwp8
         Aade3/AGHi/jlsyi4o1FAp1Qt9NNdrPmdGyK2OCNugSzvY+ukxD1YMvkx7qRHnBKwSd6
         JMAksnwK1Eo96CereGO5J2ujUnKfu53+JyvPvbYhOvXhqdnWCYMi82pTqgpgUS7vn3yA
         eF2gg+jjlaFCqw1oYQw4/CcsgK/FE1e3BuH/hg+gzYVLdecAc3VLCeTBlNvU/fhqDql+
         NPrw==
X-Gm-Message-State: ABy/qLbG5JP2y4gmcIQDWq8jfJYhOnrhf6OGMXqEUi1laAhrqgthhQd6
        o+pR1xtpIw4PWIgtoJSMvazCpvRNANfBNrK1s0upYvUK
X-Google-Smtp-Source: APBJJlH/DpEgy5vBvfFXt+6vekKFezJ7TMdEQbcnc5PvG+l1OzJNfaH2A0SVozcSbeiDiAA72EMrg4Nh9YWU7KEqeNY=
X-Received: by 2002:a2e:889a:0:b0:2b9:df53:4c2a with SMTP id
 k26-20020a2e889a000000b002b9df534c2amr3554681lji.20.1690918867073; Tue, 01
 Aug 2023 12:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230714182406.28723-1-cgzones@googlemail.com>
In-Reply-To: <20230714182406.28723-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 1 Aug 2023 15:40:55 -0400
Message-ID: <CAP+JOzRMud_=PbEbN_Q4LE9ji2g=5zrptd7mMuY-nEU1ybn-Ug@mail.gmail.com>
Subject: Re: [PATCH] libsepol: optional data destruction in hashtab_destroy()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 2:40=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Support the destruction of the hashtable entries via an optional
> callback in hashtab_destroy(), to avoid iterating the hashtable twice in
> common use cases, one time for the entry destruction via hashtab_map()
> and a second time via hashtab_destroy() to free the hashtable itself.
>
> Also convert all the destroy callbacks to return void instead of the
> needless value of 0.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/module_compiler.c                 |  6 +-
>  libsepol/cil/src/cil_binary.c                 |  9 +--
>  libsepol/cil/src/cil_strpool.c                |  6 +-
>  libsepol/cil/src/cil_symtab.c                 |  6 +-
>  libsepol/include/sepol/policydb/conditional.h |  2 +-
>  libsepol/include/sepol/policydb/hashtab.h     |  8 ++-
>  libsepol/include/sepol/policydb/policydb.h    |  2 +-
>  libsepol/src/conditional.c                    |  3 +-
>  libsepol/src/hashtab.c                        |  7 ++-
>  libsepol/src/policydb.c                       | 55 +++++++------------
>  libsepol/src/symtab.c                         |  3 +-
>  libsepol/src/write.c                          |  6 +-
>  12 files changed, 48 insertions(+), 65 deletions(-)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 5fe1729a..554b625f 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -761,20 +761,18 @@ int add_perm_to_class(uint32_t perm_value, uint32_t=
 class_value)
>         return 0;
>  }
>
> -static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
> +static void perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
>                         __attribute__ ((unused)))
>  {
>         if (key)
>                 free(key);
>         free(datum);
> -       return 0;
>  }
>
>  static void class_datum_destroy(class_datum_t * cladatum)
>  {
>         if (cladatum !=3D NULL) {
> -               hashtab_map(cladatum->permissions.table, perm_destroy, NU=
LL);
> -               hashtab_destroy(cladatum->permissions.table);
> +               hashtab_destroy(cladatum->permissions.table, perm_destroy=
, NULL);
>                 free(cladatum);
>         }
>  }
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index ea0cef32..8aa305c9 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1984,13 +1984,11 @@ exit:
>         return rc;
>  }
>
> -static int __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t =
datum, __attribute__((unused)) void *args)
> +static void __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t=
 datum, __attribute__((unused)) void *args)
>  {
>         free(k);
>         ebitmap_destroy(datum);
>         free(datum);
> -
> -       return SEPOL_OK;
>  }
>
>  static int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __a=
ttribute__((unused)) uint32_t *finished, void *extra_args)
> @@ -5230,9 +5228,8 @@ int cil_binary_create_allocated_pdb(const struct ci=
l_db *db, sepol_policydb_t *p
>         rc =3D SEPOL_OK;
>
>  exit:
> -       hashtab_destroy(role_trans_table);
> -       hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy, NUL=
L);
> -       hashtab_destroy(avrulex_ioctl_table);
> +       hashtab_destroy(role_trans_table, NULL, NULL);
> +       hashtab_destroy(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy,=
 NULL);
>         free(type_value_to_cil);
>         free(class_value_to_cil);
>         if (perm_value_to_cil !=3D NULL) {
> diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpoo=
l.c
> index e32ee4e9..18ecfe87 100644
> --- a/libsepol/cil/src/cil_strpool.c
> +++ b/libsepol/cil/src/cil_strpool.c
> @@ -87,12 +87,11 @@ char *cil_strpool_add(const char *str)
>         return strpool_ref->str;
>  }
>
> -static int cil_strpool_entry_destroy(hashtab_key_t k __attribute__ ((unu=
sed)), hashtab_datum_t d, void *args __attribute__ ((unused)))
> +static void cil_strpool_entry_destroy(hashtab_key_t k __attribute__ ((un=
used)), hashtab_datum_t d, void *args __attribute__ ((unused)))
>  {
>         struct cil_strpool_entry *strpool_ref =3D (struct cil_strpool_ent=
ry*)d;
>         free(strpool_ref->str);
>         free(strpool_ref);
> -       return SEPOL_OK;
>  }
>
>  void cil_strpool_init(void)
> @@ -115,8 +114,7 @@ void cil_strpool_destroy(void)
>         pthread_mutex_lock(&cil_strpool_mutex);
>         cil_strpool_readers--;
>         if (cil_strpool_readers =3D=3D 0) {
> -               hashtab_map(cil_strpool_tab, cil_strpool_entry_destroy, N=
ULL);
> -               hashtab_destroy(cil_strpool_tab);
> +               hashtab_destroy(cil_strpool_tab, cil_strpool_entry_destro=
y, NULL);
>                 cil_strpool_tab =3D NULL;
>         }
>         pthread_mutex_unlock(&cil_strpool_mutex);
> diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.=
c
> index 7e43a690..73cdd734 100644
> --- a/libsepol/cil/src/cil_symtab.c
> +++ b/libsepol/cil/src/cil_symtab.c
> @@ -133,18 +133,16 @@ int cil_symtab_map(symtab_t *symtab,
>         return hashtab_map(symtab->table, apply, args);
>  }
>
> -static int __cil_symtab_destroy_helper(__attribute__((unused)) hashtab_k=
ey_t k, hashtab_datum_t d, __attribute__((unused)) void *args)
> +static void __cil_symtab_destroy_helper(__attribute__((unused)) hashtab_=
key_t k, hashtab_datum_t d, __attribute__((unused)) void *args)
>  {
>         struct cil_symtab_datum *datum =3D d;
>         datum->symtab =3D NULL;
> -       return SEPOL_OK;
>  }
>
>  void cil_symtab_destroy(symtab_t *symtab)
>  {
>         if (symtab->table !=3D NULL){
> -               cil_symtab_map(symtab, __cil_symtab_destroy_helper, NULL)=
;
> -               hashtab_destroy(symtab->table);
> +               hashtab_destroy(symtab->table, __cil_symtab_destroy_helpe=
r, NULL);
>                 symtab->table =3D NULL;
>         }
>  }
> diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/inc=
lude/sepol/policydb/conditional.h
> index 5318ea19..9b19946b 100644
> --- a/libsepol/include/sepol/policydb/conditional.h
> +++ b/libsepol/include/sepol/policydb/conditional.h
> @@ -127,7 +127,7 @@ extern void cond_policydb_destroy(policydb_t * p);
>  extern void cond_list_destroy(cond_list_t * list);
>
>  extern int cond_init_bool_indexes(policydb_t * p);
> -extern int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, v=
oid *p);
> +extern void cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, =
void *p);
>
>  extern int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum,
>                            void *datap);
> diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include=
/sepol/policydb/hashtab.h
> index 354ebb43..7aa88f3b 100644
> --- a/libsepol/include/sepol/policydb/hashtab.h
> +++ b/libsepol/include/sepol/policydb/hashtab.h
> @@ -89,8 +89,14 @@ extern hashtab_datum_t hashtab_search(hashtab_t h, con=
st_hashtab_key_t k);
>
>  /*
>     Destroys the specified hash table.
> +   Applies the specified destroy function to (key,datum,args) for
> +   all entries.
> +
>   */
> -extern void hashtab_destroy(hashtab_t h);
> +extern void hashtab_destroy(hashtab_t h,
> +                           void (*destroy) (hashtab_key_t k,
> +                                           hashtab_datum_t d,
> +                                           void *args), void *args);
>

The args argument is never used. For hashtab_map() it is in other
cases, but not in the case of destroying the items in the hashtab.
Also, 1/3 of the calls to hashtab_destroy() do not even need to pass
in a destroy function.

I think that it would make more sense to create a new function
(without the args argument) that could be used to destroy both the
elements and the hashtab. If the destroy function is not needed, then
the old hashtab_destroy() function could be used. If something more
complex comes up in the future, there would still be the option of
using the hashtab_map()  and the hashtab_destroy() functions to deal
with it.

Thanks,
Jim


>  /*
>     Applies the specified apply function to (key,datum,args)
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 48b7b8bb..8cf82da6 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -634,7 +634,7 @@ extern int policydb_context_isvalid(const policydb_t =
* p,
>                                     const context_struct_t * c);
>
>  extern void symtabs_destroy(symtab_t * symtab);
> -extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p);
> +extern void scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void=
 *p);
>
>  extern void class_perm_node_init(class_perm_node_t * x);
>  extern void type_set_init(type_set_t * x);
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index 7900e928..b51639d4 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -528,13 +528,12 @@ int cond_init_bool_indexes(policydb_t * p)
>         return 0;
>  }
>
> -int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p
> +void cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p
>                       __attribute__ ((unused)))
>  {
>         if (key)
>                 free(key);
>         free(datum);
> -       return 0;
>  }
>
>  int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *data=
p)
> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index 922a8a4a..7f3dd00b 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -193,7 +193,10 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_ha=
shtab_key_t key)
>         return cur->datum;
>  }
>
> -void hashtab_destroy(hashtab_t h)
> +void hashtab_destroy(hashtab_t h,
> +                    void (*destroy) (hashtab_key_t k,
> +                                     hashtab_datum_t d,
> +                                     void *args), void *args)
>  {
>         unsigned int i;
>         hashtab_ptr_t cur, temp;
> @@ -206,6 +209,8 @@ void hashtab_destroy(hashtab_t h)
>                 while (cur !=3D NULL) {
>                         temp =3D cur;
>                         cur =3D cur->next;
> +                       if (destroy)
> +                               destroy(temp->key, temp->datum, args);
>                         free(temp);
>                 }
>                 h->htable[i] =3D NULL;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 552eb77a..f443ea88 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -895,10 +895,10 @@ int policydb_init(policydb_t * p)
>
>         return 0;
>  err:
> -       hashtab_destroy(p->range_tr);
> +       hashtab_destroy(p->range_tr, NULL, NULL);
>         for (i =3D 0; i < SYM_NUM; i++) {
> -               hashtab_destroy(p->symtab[i].table);
> -               hashtab_destroy(p->scope[i].table);
> +               hashtab_destroy(p->symtab[i].table, NULL, NULL);
> +               hashtab_destroy(p->scope[i].table, NULL, NULL);
>         }
>         avrule_block_list_destroy(p->global);
>         return rc;
> @@ -1264,16 +1264,15 @@ int policydb_index_others(sepol_handle_t * handle=
,
>   * symbol data in the policy database.
>   */
>
> -static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
> +static void perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
>                         __attribute__ ((unused)))
>  {
>         if (key)
>                 free(key);
>         free(datum);
> -       return 0;
>  }
>
> -static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void=
 *p
> +static void common_destroy(hashtab_key_t key, hashtab_datum_t datum, voi=
d *p
>                           __attribute__ ((unused)))
>  {
>         common_datum_t *comdatum;
> @@ -1281,13 +1280,11 @@ static int common_destroy(hashtab_key_t key, hash=
tab_datum_t datum, void *p
>         if (key)
>                 free(key);
>         comdatum =3D (common_datum_t *) datum;
> -       (void)hashtab_map(comdatum->permissions.table, perm_destroy, 0);
> -       hashtab_destroy(comdatum->permissions.table);
> +       hashtab_destroy(comdatum->permissions.table, perm_destroy, NULL);
>         free(datum);
> -       return 0;
>  }
>
> -static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
> +static void class_destroy(hashtab_key_t key, hashtab_datum_t datum, void=
 *p
>                          __attribute__ ((unused)))
>  {
>         class_datum_t *cladatum;
> @@ -1297,10 +1294,9 @@ static int class_destroy(hashtab_key_t key, hashta=
b_datum_t datum, void *p
>                 free(key);
>         cladatum =3D (class_datum_t *) datum;
>         if (cladatum =3D=3D NULL) {
> -               return 0;
> +               return;
>         }
> -       (void)hashtab_map(cladatum->permissions.table, perm_destroy, 0);
> -       hashtab_destroy(cladatum->permissions.table);
> +       hashtab_destroy(cladatum->permissions.table, perm_destroy, NULL);
>         constraint =3D cladatum->constraints;
>         while (constraint) {
>                 constraint_expr_destroy(constraint->expr);
> @@ -1320,37 +1316,33 @@ static int class_destroy(hashtab_key_t key, hasht=
ab_datum_t datum, void *p
>         if (cladatum->comkey)
>                 free(cladatum->comkey);
>         free(datum);
> -       return 0;
>  }
>
> -static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
> +static void role_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
>                         __attribute__ ((unused)))
>  {
>         free(key);
>         role_datum_destroy((role_datum_t *) datum);
>         free(datum);
> -       return 0;
>  }
>
> -static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
> +static void type_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
>                         __attribute__ ((unused)))
>  {
>         free(key);
>         type_datum_destroy((type_datum_t *) datum);
>         free(datum);
> -       return 0;
>  }
>
> -static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
> +static void user_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
>                         __attribute__ ((unused)))
>  {
>         free(key);
>         user_datum_destroy((user_datum_t *) datum);
>         free(datum);
> -       return 0;
>  }
>
> -static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
> +static void sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void =
*p
>                         __attribute__ ((unused)))
>  {
>         level_datum_t *levdatum;
> @@ -1362,25 +1354,23 @@ static int sens_destroy(hashtab_key_t key, hashta=
b_datum_t datum, void *p
>         free(levdatum->level);
>         level_datum_destroy(levdatum);
>         free(levdatum);
> -       return 0;
>  }
>
> -static int cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
> +static void cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *=
p
>                        __attribute__ ((unused)))
>  {
>         if (key)
>                 free(key);
>         cat_datum_destroy((cat_datum_t *) datum);
>         free(datum);
> -       return 0;
>  }
>
> -static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t dat=
um,
> +static void (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t da=
tum,
>                                   void *datap) =3D {
>  common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
>             cond_destroy_bool, sens_destroy, cat_destroy,};
>
> -static int range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
> +static void range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
>                             void *p __attribute__ ((unused)))
>  {
>         struct mls_range *rt =3D (struct mls_range *)datum;
> @@ -1388,7 +1378,6 @@ static int range_tr_destroy(hashtab_key_t key, hash=
tab_datum_t datum,
>         ebitmap_destroy(&rt->level[0].cat);
>         ebitmap_destroy(&rt->level[1].cat);
>         free(datum);
> -       return 0;
>  }
>
>  static void ocontext_selinux_free(ocontext_t **ocontexts)
> @@ -1468,8 +1457,7 @@ void policydb_destroy(policydb_t * p)
>         free(p->decl_val_to_struct);
>
>         for (i =3D 0; i < SYM_NUM; i++) {
> -               (void)hashtab_map(p->scope[i].table, scope_destroy, 0);
> -               hashtab_destroy(p->scope[i].table);
> +               hashtab_destroy(p->scope[i].table, scope_destroy, NULL);
>         }
>         avrule_block_list_destroy(p->global);
>         free(p->name);
> @@ -1515,8 +1503,7 @@ void policydb_destroy(policydb_t * p)
>         if (lra)
>                 free(lra);
>
> -       hashtab_map(p->range_tr, range_tr_destroy, NULL);
> -       hashtab_destroy(p->range_tr);
> +       hashtab_destroy(p->range_tr, range_tr_destroy, NULL);
>
>         if (p->type_attr_map) {
>                 for (i =3D 0; i < p->p_types.nprim; i++) {
> @@ -1539,12 +1526,11 @@ void symtabs_destroy(symtab_t * symtab)
>  {
>         int i;
>         for (i =3D 0; i < SYM_NUM; i++) {
> -               (void)hashtab_map(symtab[i].table, destroy_f[i], 0);
> -               hashtab_destroy(symtab[i].table);
> +               hashtab_destroy(symtab[i].table, destroy_f[i], NULL);
>         }
>  }
>
> -int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
> +void scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>                   __attribute__ ((unused)))
>  {
>         scope_datum_t *cur =3D (scope_datum_t *) datum;
> @@ -1553,7 +1539,6 @@ int scope_destroy(hashtab_key_t key, hashtab_datum_=
t datum, void *p
>                 free(cur->decl_ids);
>         }
>         free(cur);
> -       return 0;
>  }
>
>  /*
> diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
> index a6061851..3430bfc0 100644
> --- a/libsepol/src/symtab.c
> +++ b/libsepol/src/symtab.c
> @@ -51,7 +51,6 @@ void symtab_destroy(symtab_t * s)
>         if (!s)
>                 return;
>         if (s->table)
> -               hashtab_destroy(s->table);
> -       return;
> +               hashtab_destroy(s->table, NULL, NULL);
>  }
>  /* FLASK */
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index f0ed9e33..2eb08bb7 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -539,7 +539,7 @@ static int filenametr_cmp(hashtab_t h __attribute__ (=
(unused)),
>         return strcmp(ft1->name, ft2->name);
>  }
>
> -static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
> +static void filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
>                               void *p __attribute__ ((unused)))
>  {
>         filenametr_key_t *ft =3D (filenametr_key_t *)key;
> @@ -553,7 +553,6 @@ static int filenametr_destroy(hashtab_key_t key, hash=
tab_datum_t datum,
>                 free(fd);
>                 fd =3D next;
>         } while (fd);
> -       return 0;
>  }
>
>  typedef struct {
> @@ -778,8 +777,7 @@ static int avtab_filename_trans_write(policydb_t *pol=
, avtab_t *a,
>
>  out:
>         /* destroy temp filename transitions table */
> -       hashtab_map(fnts_tab, filenametr_destroy, NULL);
> -       hashtab_destroy(fnts_tab);
> +       hashtab_destroy(fnts_tab, filenametr_destroy, NULL);
>
>         return rc ? -1 : 0;
>  }
> --
> 2.40.1
>
