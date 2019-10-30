Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2FCA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FC120862
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 12:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZbpTu2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJ3MkF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:40:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbfJ3MkF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 08:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572439202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjkbQVGLodIdXnuOIccs6sTEVHNxGCJtuaZ5uz3bheE=;
        b=XZbpTu2bvTTxIUm7uWAR4DmMktOIPYe0SDUE3rHC3/D19etPkr1hY8ptlkE7vyPVZsclzV
        8OHO+fa+d5FPXN8q3ELpcb5/EU+XhkniWYlhy0mr/f9/xutcDs6gbKC4agpkevxSUkYSWl
        AZTfVT6R5SO3ftpkSZqd1nTuahjmDtk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-FEGNw0SVPdOYkrVx3l8aTw-1; Wed, 30 Oct 2019 08:37:30 -0400
Received: by mail-oi1-f198.google.com with SMTP id w20so1091927oie.17
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2019 05:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHBs1b43wJKKi9P2N+j7ZShO3TwYLmLgn8lEy/FhVF0=;
        b=ns7zG5WB2eRXbnlDjrfAKFkPNxZkT74EE8Ol91nz10lLMW+/r68PBABuuHzEQ7EV1F
         dbC2WeXJ9/lWD4Z7drI68X3GNe1IR7LqHpeElgJXADQYQRyqE0sszO99IJ9FJi751aH8
         uH9bh9U1P0I6dnFkFz7+gWw2QMjnN822YhZ9riTohPB65ZF4CPowGT/a+alZFoSlmkgN
         8ABwSqpKJEM/rc0XWJ9aqoEuuMFO5jtJTW4MVg9gJa8/mkZyd84pdpC+K1H/lHFSscMA
         n91tvSUNnzzWxCIp+WARWD+nZ8IMPVIudQb6699qyKHcSiTBZ93EAp7JVa5v11SmpQta
         Sc8A==
X-Gm-Message-State: APjAAAWnBrhgtHokjxbaB3PY18+YX5BA4JUSGDsW18Xi9vCn08wNJFHN
        QCeP2XOZwuHOtTa2ocoDQC2Y4U8VeBviLFN6n30D7nz72hEH+Kxt3vaSaFypISsoKhIBd70z7Bn
        /e9vy4fhvzTPncZbm5+0Y922jkRzjQP7KNA==
X-Received: by 2002:a05:6830:1d9:: with SMTP id r25mr22373806ota.66.1572439049149;
        Wed, 30 Oct 2019 05:37:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuLnoGql6+dA0lMPaqo6J4QRP436KW7N285M0o4vvrQtvLdw10nI6abRl2ppVdxHneVMJginN/xF5iXR+Jpig=
X-Received: by 2002:a05:6830:1d9:: with SMTP id r25mr22373760ota.66.1572439048273;
 Wed, 30 Oct 2019 05:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191030101949.191788-1-jeffv@google.com>
In-Reply-To: <20191030101949.191788-1-jeffv@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 30 Oct 2019 13:37:17 +0100
Message-ID: <CAFqZXNsawo1L2_ToFR5pzn-eLgNAge=kPwA+b1syURQvM_Fhrg@mail.gmail.com>
Subject: Re: [PATCH] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
X-MC-Unique: FEGNw0SVPdOYkrVx3l8aTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Jeff,

thank you for working on this! This is certainly a nice improvement.
See a couple quick comments below.

On Wed, Oct 30, 2019 at 11:20 AM Jeff Vander Stoep <jeffv@google.com> wrote=
:
>
> This replaces the reverse table lookup and reverse cache with a
> hashtable which improves cache-miss reverese-lookup times from

spelling nit: reverse-lookup

> O(n) to O(1) and maintains the same performance as a reverse
> cache hit.

This is only half-true, since at some point when the number of
contexts gets too high, it becomes O(n) again
(SIDTAB_HASH_BUCKETS-times faster O(n), but still O(n) :). To make it
really O(1) you'd need to dynamically resize the hashtable (which I
recently tried to implement, but then got stuck - it is really hard to
do it without too much locking...). But of course this is just a
formal nitpick, a fixed-size hashtable is still much better than no
hashtable :)

>
> This reduces the time needed to add a new sidtab entry from ~500us
> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
>
> The implementation uses the kernel's generic hashtable API,
> It uses the context's string represtation as the hash source,

spelling nit: representation

> and the kernels generic string hashing algorithm full_name_hash()
> to reduce the string to a 32 bit value.

If I'm not mistaken, the context strings have a caveat that after a
policy reload the canonical string representation of a given context
(SID) can change slightly (IIRC it has to do with ordering of the
levels/categories). I didn't dive deep enough into the patch to be
sure if this may cause issues here, but it is definitely something to
watch out for. Stephen and Paul know the guts of SELinux better than
me, so hopefully they'll be able to provide more insight here.

>
> This change also maintains the improvement introduced in commit
> ee1a84fd which removed the need to keep the current sidtab locked
> during policy reload. It does however introduce periodic locking of
> the target sidtab while converting the hashtable. Sidtab entries
> are never modified or removed, so the context struct stored in the
> sid_to_context tree can also be used for the context_to_sid
> hashtable to reduce memory usage.
>
> This bug was reported by:
> - Stephen Smally on the selinux bug tracker.
>   BUG: kernel softlockup due to too many SIDs/contexts #37
>   https://github.com/SELinuxProject/selinux-kernel/issues/37
> - Jovana Knezevic on Android's bugtracker.
>   Bug: 140252993
>   "During multi-user performance testing, we create and remove users
>   many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>   20ms after about 200 user creations and removals. Accumulated over
>   ~280 packages, that adds a significant time to user creation,
>   making perf benchmarks unreliable."
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Reported-by: Jovana Knezevic <jovanak@google.com>
> ---
>  security/selinux/include/security.h |   1 +
>  security/selinux/selinuxfs.c        |  27 +++
>  security/selinux/ss/context.h       |   9 +
>  security/selinux/ss/policydb.c      |   5 +
>  security/selinux/ss/services.c      |  81 +++++---
>  security/selinux/ss/services.h      |   4 +-
>  security/selinux/ss/sidtab.c        | 283 ++++++++++++++++------------
>  security/selinux/ss/sidtab.h        |  20 +-
>  8 files changed, 283 insertions(+), 147 deletions(-)
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index ae840634e3c7..8c0dbbd076c6 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -395,5 +395,6 @@ extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg=
_type, u32 *perm);
>  extern void avtab_cache_init(void);
>  extern void ebitmap_cache_init(void);
>  extern void hashtab_cache_init(void);
> +extern int security_sidtab_hash_stats(struct selinux_state *state, char =
*page);
>
>  #endif /* _SELINUX_SECURITY_H_ */
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ee94fa469c29..ebdec88d9ccb 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1482,6 +1482,32 @@ static ssize_t sel_read_avc_hash_stats(struct file=
 *filp, char __user *buf,
>         return length;
>  }
>
> +static ssize_t sel_read_sidtab_hash_stats(struct file *filp, char __user=
 *buf,
> +                                       size_t count, loff_t *ppos)
> +{
> +       struct selinux_fs_info *fsi =3D file_inode(filp)->i_sb->s_fs_info=
;
> +       struct selinux_state *state =3D fsi->state;
> +       char *page;
> +       ssize_t length;
> +
> +       page =3D (char *)__get_free_page(GFP_KERNEL);
> +       if (!page)
> +               return -ENOMEM;
> +
> +       length =3D security_sidtab_hash_stats(state, page);
> +       if (length >=3D 0)
> +               length =3D simple_read_from_buffer(buf, count, ppos, page=
,
> +                                               length);
> +       free_page((unsigned long)page);
> +
> +       return length;
> +}
> +
> +static const struct file_operations sel_sidtab_hash_stats_ops =3D {
> +       .read           =3D sel_read_sidtab_hash_stats,
> +       .llseek         =3D generic_file_llseek,
> +};
> +
>  static const struct file_operations sel_avc_cache_threshold_ops =3D {
>         .read           =3D sel_read_avc_cache_threshold,
>         .write          =3D sel_write_avc_cache_threshold,
> @@ -1572,6 +1598,7 @@ static int sel_make_avc_files(struct dentry *dir)
>                 { "cache_threshold",
>                   &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
>                 { "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
> +               { "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUG=
O },
>  #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
>                 { "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
>  #endif
> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.=
h
> index 513e67f48878..01fea944177d 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -31,6 +31,7 @@ struct context {
>         u32 len;        /* length of string in bytes */
>         struct mls_range range;
>         char *str;      /* string representation if context cannot be map=
ped. */
> +       u32 hash;       /* a hash of the string representation */
>  };
>
>  static inline void mls_context_init(struct context *c)
> @@ -168,6 +169,7 @@ static inline int context_cpy(struct context *dst, st=
ruct context *src)
>                 kfree(dst->str);
>                 return rc;
>         }
> +       dst->hash =3D src->hash;
>         return 0;
>  }
>
> @@ -182,6 +184,8 @@ static inline void context_destroy(struct context *c)
>
>  static inline int context_cmp(struct context *c1, struct context *c2)
>  {
> +       if (c1->hash && c2->hash && (c1->hash !=3D c2->hash))
> +               return 0;
>         if (c1->len && c2->len)
>                 return (c1->len =3D=3D c2->len && !strcmp(c1->str, c2->st=
r));
>         if (c1->len || c2->len)
> @@ -192,5 +196,10 @@ static inline int context_cmp(struct context *c1, st=
ruct context *c2)
>                 mls_context_cmp(c1, c2));
>  }
>
> +static inline unsigned int context_compute_hash(const char *s)
> +{
> +       return full_name_hash(NULL, s, strlen(s));
> +}
> +
>  #endif /* _SS_CONTEXT_H_ */
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index e20624a68f5d..e369b0092cdf 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -878,6 +878,11 @@ int policydb_load_isids(struct policydb *p, struct s=
idtab *s)
>                         sidtab_destroy(s);
>                         goto out;
>                 }
> +               rc =3D context_add_hash(p, &c->context[0]);
> +               if (rc) {
> +                       sidtab_destroy(s);
> +                       goto out;
> +               }
>
>                 rc =3D sidtab_set_initial(s, c->sid[0], &c->context[0]);
>                 if (rc) {
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index a5813c7629c1..29076c15cdf7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1257,6 +1257,11 @@ static int context_struct_to_string(struct policyd=
b *p,
>
>  #include "initial_sid_to_string.h"
>
> +int security_sidtab_hash_stats(struct selinux_state *state, char *page)
> +{
> +       return sidtab_hash_stats(state->ss->sidtab, page);
> +}
> +
>  const char *security_get_initial_sid_context(u32 sid)
>  {
>         if (unlikely(sid > SECINITSID_NUM))
> @@ -1384,6 +1389,8 @@ static int string_to_context_struct(struct policydb=
 *pol,
>         int rc =3D 0;
>
>         context_init(ctx);
> +       /* hash the string before it gets mutated */
> +       ctx->hash =3D context_compute_hash(scontext);
>
>         /* Parse the security context. */
>
> @@ -1442,6 +1449,7 @@ static int string_to_context_struct(struct policydb=
 *pol,
>         rc =3D -EINVAL;
>         if (!policydb_context_isvalid(pol, ctx))
>                 goto out;
> +
>         rc =3D 0;
>  out:
>         if (rc)
> @@ -1449,6 +1457,42 @@ static int string_to_context_struct(struct policyd=
b *pol,
>         return rc;
>  }
>
> +int context_add_hash(struct policydb *policydb,
> +                    struct context *context)
> +{
> +       int rc;
> +       char *str;
> +       int len;
> +
> +       if (context->str) {
> +               context->hash =3D context_compute_hash(context->str);
> +       } else {
> +               rc =3D context_struct_to_string(policydb, context,
> +                                             &str, &len);
> +               if (rc)
> +                       return rc;
> +               context->hash =3D context_compute_hash(str);
> +               kfree(str);
> +       }
> +       return 0;
> +}
> +
> +static int context_to_sid(struct selinux_state *state,
> +                         struct context *context, u32 *sid)
> +{
> +       int rc;
> +       struct sidtab *sidtab =3D state->ss->sidtab;
> +       struct policydb *policydb =3D &state->ss->policydb;
> +
> +       if (!context->hash) {
> +               rc =3D context_add_hash(policydb, context);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return sidtab_context_to_sid(sidtab, context, sid);
> +}
> +
>  static int security_context_to_sid_core(struct selinux_state *state,
>                                         const char *scontext, u32 scontex=
t_len,
>                                         u32 *sid, u32 def_sid, gfp_t gfp_=
flags,
> @@ -1501,7 +1545,7 @@ static int security_context_to_sid_core(struct seli=
nux_state *state,
>                 str =3D NULL;
>         } else if (rc)
>                 goto out_unlock;
> -       rc =3D sidtab_context_to_sid(sidtab, &context, sid);
> +       rc =3D context_to_sid(state, &context, sid);
>         context_destroy(&context);
>  out_unlock:
>         read_unlock(&state->ss->policy_rwlock);
> @@ -1805,7 +1849,7 @@ static int security_compute_sid(struct selinux_stat=
e *state,
>                         goto out_unlock;
>         }
>         /* Obtain the sid for the context. */
> -       rc =3D sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> +       rc =3D context_to_sid(state, &newcontext, out_sid);
>  out_unlock:
>         read_unlock(&state->ss->policy_rwlock);
>         context_destroy(&newcontext);
> @@ -2033,6 +2077,10 @@ static int convert_context(struct context *oldc, s=
truct context *newc, void *p)
>                         goto bad;
>         }
>
> +       rc =3D context_add_hash(args->newp, newc);
> +       if (rc)
> +               goto bad;
> +
>         return 0;
>  bad:
>         /* Map old representation to string and save it. */
> @@ -2280,9 +2328,7 @@ int security_port_sid(struct selinux_state *state,
>
>         if (c) {
>                 if (!c->sid[0]) {
> -                       rc =3D sidtab_context_to_sid(sidtab,
> -                                                  &c->context[0],
> -                                                  &c->sid[0]);
> +                       rc =3D context_to_sid(state, &c->context[0], &c->=
sid[0]);
>                         if (rc)
>                                 goto out;
>                 }
> @@ -2374,9 +2420,7 @@ int security_ib_endport_sid(struct selinux_state *s=
tate,
>
>         if (c) {
>                 if (!c->sid[0]) {
> -                       rc =3D sidtab_context_to_sid(sidtab,
> -                                                  &c->context[0],
> -                                                  &c->sid[0]);
> +                       rc =3D context_to_sid(state, &c->context[0], &c->=
sid[0]);
>                         if (rc)
>                                 goto out;
>                 }
> @@ -2416,14 +2460,10 @@ int security_netif_sid(struct selinux_state *stat=
e,
>
>         if (c) {
>                 if (!c->sid[0] || !c->sid[1]) {
> -                       rc =3D sidtab_context_to_sid(sidtab,
> -                                                 &c->context[0],
> -                                                 &c->sid[0]);
> +                       rc =3D context_to_sid(state, &c->context[0], &c->=
sid[0]);
>                         if (rc)
>                                 goto out;
> -                       rc =3D sidtab_context_to_sid(sidtab,
> -                                                  &c->context[1],
> -                                                  &c->sid[1]);
> +                       rc =3D context_to_sid(state, &c->context[1], &c->=
sid[1]);
>                         if (rc)
>                                 goto out;
>                 }
> @@ -2601,7 +2641,7 @@ int security_get_user_sids(struct selinux_state *st=
ate,
>                                                  &usercon))
>                                 continue;
>
> -                       rc =3D sidtab_context_to_sid(sidtab, &usercon, &s=
id);
> +                       rc =3D context_to_sid(state, &usercon, &sid);
>                         if (rc)
>                                 goto out_unlock;
>                         if (mynel < maxnel) {
> @@ -2672,7 +2712,6 @@ static inline int __security_genfs_sid(struct selin=
ux_state *state,
>                                        u32 *sid)
>  {
>         struct policydb *policydb =3D &state->ss->policydb;
> -       struct sidtab *sidtab =3D state->ss->sidtab;
>         int len;
>         u16 sclass;
>         struct genfs *genfs;
> @@ -2707,7 +2746,7 @@ static inline int __security_genfs_sid(struct selin=
ux_state *state,
>                 goto out;
>
>         if (!c->sid[0]) {
> -               rc =3D sidtab_context_to_sid(sidtab, &c->context[0], &c->=
sid[0]);
> +               rc =3D context_to_sid(state, &c->context[0], &c->sid[0]);
>                 if (rc)
>                         goto out;
>         }
> @@ -2770,8 +2809,7 @@ int security_fs_use(struct selinux_state *state, st=
ruct super_block *sb)
>         if (c) {
>                 sbsec->behavior =3D c->v.behavior;
>                 if (!c->sid[0]) {
> -                       rc =3D sidtab_context_to_sid(sidtab, &c->context[=
0],
> -                                                  &c->sid[0]);
> +                       rc =3D context_to_sid(state, &c->context[0], &c->=
sid[0]);
>                         if (rc)
>                                 goto out;
>                 }
> @@ -3026,8 +3064,7 @@ int security_sid_mls_copy(struct selinux_state *sta=
te,
>                         goto out_unlock;
>                 }
>         }
> -
> -       rc =3D sidtab_context_to_sid(sidtab, &newcon, new_sid);
> +       rc =3D context_to_sid(state, &newcon, new_sid);
>  out_unlock:
>         read_unlock(&state->ss->policy_rwlock);
>         context_destroy(&newcon);
> @@ -3620,7 +3657,7 @@ int security_netlbl_secattr_to_sid(struct selinux_s=
tate *state,
>                 if (!mls_context_isvalid(policydb, &ctx_new))
>                         goto out_free;
>
> -               rc =3D sidtab_context_to_sid(sidtab, &ctx_new, sid);
> +               rc =3D context_to_sid(state, &ctx_new, sid);
>                 if (rc)
>                         goto out_free;
>
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/service=
s.h
> index 9a36de860368..fc40640a9725 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -8,7 +8,7 @@
>  #define _SS_SERVICES_H_
>
>  #include "policydb.h"
> -#include "sidtab.h"
> +#include "context.h"
>
>  /* Mapping for a single class */
>  struct selinux_mapping {
> @@ -39,4 +39,6 @@ void services_compute_xperms_drivers(struct extended_pe=
rms *xperms,
>  void services_compute_xperms_decision(struct extended_perms_decision *xp=
ermd,
>                                         struct avtab_node *node);
>
> +int context_add_hash(struct policydb *policydb, struct context *context)=
;
> +
>  #endif /* _SS_SERVICES_H_ */
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..e4710f32b6d9 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -23,23 +23,32 @@ int sidtab_init(struct sidtab *s)
>
>         memset(s->roots, 0, sizeof(s->roots));
>
> -       /* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX =
*/
> -       for (i =3D 0; i < SIDTAB_RCACHE_SIZE; i++)
> -               s->rcache[i] =3D SIDTAB_MAX;
> -
>         for (i =3D 0; i < SECINITSID_NUM; i++)
>                 s->isids[i].set =3D 0;
>
>         s->count =3D 0;
>         s->convert =3D NULL;
> +       hash_init(s->context_to_sid);
>
>         spin_lock_init(&s->lock);
>         return 0;
>  }
>
> +static u32 context_to_sid(struct sidtab *s, struct context *context)
> +{
> +       struct sidtab_node *node;
> +
> +       hash_for_each_possible(s->context_to_sid, node, list, context->ha=
sh) {
> +               if (context_cmp(node->context, context))
> +                       return node->sid;
> +       }
> +       return 0;
> +}
> +
>  int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *contex=
t)
>  {
>         struct sidtab_isid_entry *entry;
> +       struct sidtab_node *node =3D NULL;
>         int rc;
>
>         if (sid =3D=3D 0 || sid > SECINITSID_NUM)
> @@ -52,9 +61,57 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, stru=
ct context *context)
>                 return rc;
>
>         entry->set =3D 1;
> +
> +       /*
> +        * Multiple initial sids may map to the same context. Check that =
this
> +        * context is not already represented in the context_to_sid hasht=
able
> +        * to avoid duplicate entries and long linked lists upon hash
> +        * collision.
> +        */
> +       if (!context_to_sid(s, context)) {
> +               node =3D kzalloc(sizeof(struct sidtab_node), GFP_ATOMIC);
> +               if (!node)
> +                       return -ENOMEM;
> +               node->sid =3D sid;
> +               node->context =3D &entry->context;
> +               hash_add(s->context_to_sid, &node->list, context->hash);
> +       }
> +
>         return 0;
>  }
>
> +int sidtab_hash_stats(struct sidtab *sidtab, char *page)
> +{
> +       int i;
> +       int chain_len =3D 0;
> +       int slots_used =3D 0;
> +       int entries =3D 0;
> +       int max_chain_len =3D 0;
> +       int cur_bucket =3D 0;
> +       struct sidtab_node *node;
> +
> +
> +       hash_for_each(sidtab->context_to_sid, i, node, list) {
> +               entries++;
> +               if (i =3D=3D cur_bucket) {
> +                       chain_len++;
> +                       if (chain_len =3D=3D 1)
> +                               slots_used++;
> +               } else {
> +                       cur_bucket =3D i;
> +                       if (chain_len > max_chain_len)
> +                               max_chain_len =3D chain_len;
> +                       chain_len =3D 0;
> +               }
> +       }
> +       if (chain_len > max_chain_len)
> +               max_chain_len =3D chain_len;
> +       return scnprintf(page, PAGE_SIZE, "%s:  %d entries and %d/%d buck=
ets "
> +                        "used, longest chain length %d\n", "context_to_s=
id",
> +                        entries, slots_used, SIDTAB_HASH_BUCKETS,
> +                        max_chain_len);
> +}
> +
>  static u32 sidtab_level_from_count(u32 count)
>  {
>         u32 capacity =3D SIDTAB_LEAF_ENTRIES;
> @@ -150,7 +207,7 @@ static struct context *sidtab_search_core(struct sidt=
ab *s, u32 sid, int force)
>
>         if (sid !=3D 0) {
>                 if (sid > SECINITSID_NUM)
> -                       context =3D sidtab_lookup(s, sid - (SECINITSID_NU=
M + 1));
> +                       context =3D sidtab_lookup(s, sid_to_index(sid));
>                 else
>                         context =3D sidtab_lookup_initial(s, sid);
>                 if (context && (!context->len || force))
> @@ -170,132 +227,70 @@ struct context *sidtab_search_force(struct sidtab =
*s, u32 sid)
>         return sidtab_search_core(s, sid, 1);
>  }
>
> -static int sidtab_find_context(union sidtab_entry_inner entry,
> -                              u32 *pos, u32 count, u32 level,
> -                              struct context *context, u32 *index)
> -{
> -       int rc;
> -       u32 i;
> -
> -       if (level !=3D 0) {
> -               struct sidtab_node_inner *node =3D entry.ptr_inner;
> -
> -               i =3D 0;
> -               while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
> -                       rc =3D sidtab_find_context(node->entries[i],
> -                                                pos, count, level - 1,
> -                                                context, index);
> -                       if (rc =3D=3D 0)
> -                               return 0;
> -                       i++;
> -               }
> -       } else {
> -               struct sidtab_node_leaf *node =3D entry.ptr_leaf;
> -
> -               i =3D 0;
> -               while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
> -                       if (context_cmp(&node->entries[i].context, contex=
t)) {
> -                               *index =3D *pos;
> -                               return 0;
> -                       }
> -                       (*pos)++;
> -                       i++;
> -               }
> -       }
> -       return -ENOENT;
> -}
> -
> -static void sidtab_rcache_update(struct sidtab *s, u32 index, u32 pos)
> -{
> -       while (pos > 0) {
> -               WRITE_ONCE(s->rcache[pos], READ_ONCE(s->rcache[pos - 1]))=
;
> -               --pos;
> -       }
> -       WRITE_ONCE(s->rcache[0], index);
> -}
> -
> -static void sidtab_rcache_push(struct sidtab *s, u32 index)
> -{
> -       sidtab_rcache_update(s, index, SIDTAB_RCACHE_SIZE - 1);
> -}
> -
> -static int sidtab_rcache_search(struct sidtab *s, struct context *contex=
t,
> -                               u32 *index)
> -{
> -       u32 i;
> -
> -       for (i =3D 0; i < SIDTAB_RCACHE_SIZE; i++) {
> -               u32 v =3D READ_ONCE(s->rcache[i]);
> -
> -               if (v >=3D SIDTAB_MAX)
> -                       continue;
> -
> -               if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
> -                       sidtab_rcache_update(s, v, i);
> -                       *index =3D v;
> -                       return 0;
> -               }
> -       }
> -       return -ENOENT;
> -}
> -
> -static int sidtab_reverse_lookup(struct sidtab *s, struct context *conte=
xt,
> -                                u32 *index)
> +int sidtab_context_to_sid(struct sidtab *s, struct context *context,
> +                         u32 *sid)
>  {
>         unsigned long flags;
> -       u32 count, count_locked, level, pos;
> +       u32 count;
>         struct sidtab_convert_params *convert;
>         struct context *dst, *dst_convert;
> +       struct sidtab_node *dst_node, *dst_node_convert =3D NULL;
>         int rc;
>
> -       rc =3D sidtab_rcache_search(s, context, index);
> -       if (rc =3D=3D 0)
> -               return 0;
> -
> -       /* read entries only after reading count */
> -       count =3D smp_load_acquire(&s->count);
> -       level =3D sidtab_level_from_count(count);
> -
> -       pos =3D 0;
> -       rc =3D sidtab_find_context(s->roots[level], &pos, count, level,
> -                                context, index);
> -       if (rc =3D=3D 0) {
> -               sidtab_rcache_push(s, *index);
> +       *sid =3D context_to_sid(s, context);
> +       if (*sid)
>                 return 0;
> -       }
>
>         /* lock-free search failed: lock, re-search, and insert if not fo=
und */
>         spin_lock_irqsave(&s->lock, flags);
>
> +       *sid =3D context_to_sid(s, context);
> +       if (*sid)
> +               goto out_unlock;
> +
>         convert =3D s->convert;
> -       count_locked =3D s->count;
> -       level =3D sidtab_level_from_count(count_locked);
> -
> -       /* if count has changed before we acquired the lock, then catch u=
p */
> -       while (count < count_locked) {
> -               if (context_cmp(sidtab_do_lookup(s, count, 0), context)) =
{
> -                       sidtab_rcache_push(s, count);
> -                       *index =3D count;
> -                       rc =3D 0;
> +       count =3D s->count;
> +
> +       rc =3D -ENOMEM;
> +       dst_node =3D kzalloc(sizeof(struct sidtab_node), GFP_ATOMIC);
> +       if (!dst_node)
> +               goto out_unlock;
> +
> +       if (convert) {
> +               dst_node_convert =3D kzalloc(sizeof(struct sidtab_node),
> +                                          GFP_ATOMIC);
> +               if (!dst_node_convert) {
> +                       kfree(dst_node);
>                         goto out_unlock;
>                 }
> -               ++count;
>         }
>
>         /* bail out if we already reached max entries */
>         rc =3D -EOVERFLOW;
> -       if (count >=3D SIDTAB_MAX)
> +       if (count >=3D SIDTAB_MAX) {
> +               kfree(dst_node);
> +               kfree(dst_node_convert);
>                 goto out_unlock;
> +       }
>
>         /* insert context into new entry */
>         rc =3D -ENOMEM;
>         dst =3D sidtab_do_lookup(s, count, 1);
> -       if (!dst)
> +       if (!dst) {
> +               kfree(dst_node);
> +               kfree(dst_node_convert);
>                 goto out_unlock;
> +       }
> +
> +       dst_node->sid =3D index_to_sid(count);
> +       dst_node->context =3D dst;
>
>         rc =3D context_cpy(dst, context);
> -       if (rc)
> +       if (rc) {
> +               kfree(dst_node);
> +               kfree(dst_node_convert);
>                 goto out_unlock;
> +       }
>
>         /*
>          * if we are building a new sidtab, we need to convert the contex=
t
> @@ -306,25 +301,35 @@ static int sidtab_reverse_lookup(struct sidtab *s, =
struct context *context,
>                 dst_convert =3D sidtab_do_lookup(convert->target, count, =
1);
>                 if (!dst_convert) {
>                         context_destroy(dst);
> +                       kfree(dst_node);
> +                       kfree(dst_node_convert);
>                         goto out_unlock;
>                 }
>
>                 rc =3D convert->func(context, dst_convert, convert->args)=
;
>                 if (rc) {
>                         context_destroy(dst);
> +                       kfree(dst_node);
> +                       kfree(dst_node_convert);
>                         goto out_unlock;
>                 }
> +               dst_node_convert->sid =3D index_to_sid(count);
> +               dst_node_convert->context =3D dst_convert;
>
>                 /* at this point we know the insert won't fail */
> +               spin_lock_irqsave(&convert->target->lock, flags);
>                 convert->target->count =3D count + 1;
> +               hash_add(convert->target->context_to_sid,
> +                        &dst_node_convert->list, dst_convert->hash);
> +               spin_unlock_irqrestore(&convert->target->lock, flags);
>         }
> +       hash_add(s->context_to_sid, &dst_node->list, context->hash);
>
>         if (context->len)
>                 pr_info("SELinux:  Context %s is not valid (left unmapped=
).\n",
>                         context->str);
>
> -       sidtab_rcache_push(s, count);
> -       *index =3D count;
> +       *sid =3D index_to_sid(count);
>
>         /* write entries before writing new count */
>         smp_store_release(&s->count, count + 1);
> @@ -335,27 +340,41 @@ static int sidtab_reverse_lookup(struct sidtab *s, =
struct context *context,
>         return rc;
>  }
>
> -int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32=
 *sid)
> +static int sidtab_convert_hashnode(struct sidtab *s, u32 index)
>  {
> -       int rc;
> -       u32 i;
> +       unsigned long flags;
> +       struct context *context;
> +       struct sidtab_node *node;
>
> -       for (i =3D 0; i < SECINITSID_NUM; i++) {
> -               struct sidtab_isid_entry *entry =3D &s->isids[i];
> +       context =3D sidtab_do_lookup(s, index, 0);
>
> -               if (entry->set && context_cmp(context, &entry->context)) =
{
> -                       *sid =3D i + 1;
> -                       return 0;
> -               }
> -       }
> +       node =3D kzalloc(sizeof(struct sidtab_node), GFP_ATOMIC);
> +       if (!node)
> +               return -ENOMEM;
>
> -       rc =3D sidtab_reverse_lookup(s, context, sid);
> -       if (rc)
> -               return rc;
> -       *sid +=3D SECINITSID_NUM + 1;
> +       node->sid =3D index_to_sid(index);
> +       node->context =3D context;
> +       spin_lock_irqsave(&s->lock, flags);
> +       hash_add(s->context_to_sid, &node->list, context->hash);
> +       spin_unlock_irqrestore(&s->lock, flags);
>         return 0;
>  }
>
> +static int sidtab_convert_hashtable(struct sidtab *s, u32 count)
> +{
> +       u32 i;
> +       int rc =3D 0;
> +
> +       for (i =3D 0; i < count; i++) {
> +               rc =3D sidtab_convert_hashnode(s, i);
> +               if (rc)
> +                       break;
> +
> +               cond_resched();
> +       }
> +       return rc;
> +}
> +
>  static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                                union sidtab_entry_inner *esrc,
>                                u32 *pos, u32 count, u32 level,
> @@ -400,6 +419,7 @@ static int sidtab_convert_tree(union sidtab_entry_inn=
er *edst,
>                 }
>                 cond_resched();
>         }
> +
>         return 0;
>  }
>
> @@ -449,7 +469,16 @@ int sidtab_convert(struct sidtab *s, struct sidtab_c=
onvert_params *params)
>                 spin_lock_irqsave(&s->lock, flags);
>                 s->convert =3D NULL;
>                 spin_unlock_irqrestore(&s->lock, flags);
> +               return rc;
> +       }
> +
> +       rc =3D sidtab_convert_hashtable(params->target, count);
> +       if (rc) {
> +               spin_lock_irqsave(&s->lock, flags);
> +               s->convert =3D NULL;
> +               spin_unlock_irqrestore(&s->lock, flags);
>         }
> +
>         return rc;
>  }
>
> @@ -478,6 +507,19 @@ static void sidtab_destroy_tree(union sidtab_entry_i=
nner entry, u32 level)
>         }
>  }
>
> +

Extraneous newline?

> +static void sidtab_destroy_hashtable(struct sidtab *s)
> +{
> +       struct sidtab_node *node;
> +       struct hlist_node *tmp;
> +       int i;
> +
> +       hash_for_each_safe(s->context_to_sid, i, tmp, node, list) {
> +               hash_del(&node->list);
> +               kfree(node);
> +       }
> +}
> +
>  void sidtab_destroy(struct sidtab *s)
>  {
>         u32 i, level;
> @@ -491,4 +533,5 @@ void sidtab_destroy(struct sidtab *s)
>                 --level;
>
>         sidtab_destroy_tree(s->roots[level], level);
> +       sidtab_destroy_hashtable(s);
>  }
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index 1f4763141aa1..85afef719a43 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -13,6 +13,7 @@
>
>  #include <linux/spinlock_types.h>
>  #include <linux/log2.h>
> +#include <linux/hashtable.h>
>
>  #include "context.h"
>
> @@ -66,7 +67,16 @@ struct sidtab_convert_params {
>         struct sidtab *target;
>  };
>
> -#define SIDTAB_RCACHE_SIZE 3
> +struct sidtab_node {
> +       u32 sid;
> +       struct context *context;
> +       struct hlist_node list;
> +};

How about just adding the sid and hlist_node fields directly to struct
sidtab_entry_leaf and add that to the hash table? That should simplify
the code a lot and also reduce memory allocation overhead.

> +
> +#define SIDTAB_HASH_BITS 9
> +#define SIDTAB_HASH_BUCKETS (1 << SIDTAB_HASH_BITS)

Maybe we should make SIDTAB_HASH_BITS configurable via Kconfig?

> +#define index_to_sid(index) (index + SECINITSID_NUM + 1)
> +#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))

I think these last two macros should be rather defined inside
sidtab.c, since they are not useful outside sidtab internals.

>
>  struct sidtab {
>         /*
> @@ -83,11 +93,11 @@ struct sidtab {
>         struct sidtab_convert_params *convert;
>         spinlock_t lock;
>
> -       /* reverse lookup cache - access atomically via {READ|WRITE}_ONCE=
() */
> -       u32 rcache[SIDTAB_RCACHE_SIZE];
> -
>         /* index =3D=3D SID - 1 (no entry for SECSID_NULL) */
>         struct sidtab_isid_entry isids[SECINITSID_NUM];
> +
> +       /* Hash table for fast reverse context-to-sid lookups. */
> +       DECLARE_HASHTABLE(context_to_sid, SIDTAB_HASH_BITS);
>  };
>
>  int sidtab_init(struct sidtab *s);
> @@ -101,6 +111,8 @@ int sidtab_context_to_sid(struct sidtab *s, struct co=
ntext *context, u32 *sid);
>
>  void sidtab_destroy(struct sidtab *s);
>
> +int sidtab_hash_stats(struct sidtab *sidtab, char *page);
> +
>  #endif /* _SS_SIDTAB_H_ */
>
>
> --
> 2.24.0.rc0.303.g954a862665-goog
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

