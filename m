Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAD33468F
	for <selinux@vger.kernel.org>; Thu,  4 Dec 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875100; cv=none; b=nleBb5O3diWTz6PZ4J2GEUAlj3bti0gp4pp6VKBfCrTyJ/tvY/puzNUIH0abmBvG4ybjFYsQWrMtznTnb22pys3M5EvaSOvJ/yyLs1EBLrBgLD/nWSNRtU/LoHKA2DzjhH0Kfz2CmeyUFra1U11+9ZPG2M2R8Rjj9spHFH8Ihpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875100; c=relaxed/simple;
	bh=BAdFtp1gaDM3bBLDoEonEHEvGJAUcvDa+C5c0Vhgas8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa1Vkag42y4FHV8FUYreXT+68TWnTnQ/G1W6ZVZTvRyDEZdqSu5+ZDei3CtQw3gbohdPYAkzKIJCul2Ztmn96Z5pRzJobMZ12hirpz9uwsxMtLIWufDm26WCXFxhxUriTa9tE9BgRvi0sw70pw2zVfa+8mo71iK6dv9N6rvZbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et0lP6mD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et0lP6mD"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3438231df5fso1571418a91.2
        for <selinux@vger.kernel.org>; Thu, 04 Dec 2025 11:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764875096; x=1765479896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVLkLuFgm3tfA0hALVxxmbZoZ8dW5SuaFelp14l2LsE=;
        b=Et0lP6mDwcEiERN6KPU28Sgj1BFNqwaRgJ9LzjYnOrzdgyIMygy75L00GLeL133l8U
         VLyzj/D0o5yNrQteoSbLCCHMeFNs2k5aGoVs1rHUwJGu4y5jypZZe4AcDMG9qSzVU1ct
         NgpgVlLRp3BCqbY34h1GGANDkG3KB/iEAXVJXSOeDcA14xSsnDFdj8Hi2v1zzETq6+9X
         7h1Z+Qp/WvLYha+L0udBvsTaq8aB2ylTf8ViY1Zq/JpPz12cUaZ+Cwfz5Lwcso44WbwD
         Wn7Up1GxHKUaL5GWagskTAijCZcAiJtOZDlnBGKwEZUI840C1KJ/9dmxVAJZwLVgJRr6
         xNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764875096; x=1765479896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVLkLuFgm3tfA0hALVxxmbZoZ8dW5SuaFelp14l2LsE=;
        b=pOKH0TvbbMtjtXEs4QpzHEdrKNyDdKUCI/Il51kryZcwMN4Az3wyMhdwPW2kXvrEMm
         ECFTpYpUfAeDyS2SuzTcoCbBL9Od2qKyc/3KeDJF6+zgY5UB1vwqC9jMMhEIx3ntC2Y+
         u3ef9ijK/96XxO3dUY5+X3KQy1MYmitumlfNNNLeMdDPXnHSEYYWCQihmHE3M9xy56P8
         VJDNL+Bpl2+fEwAnlJtO/+cigMTYWWS2kFgD5vY7c1bMv7oaa8nitKlM76tWGVTtE2je
         y1hsM2b46N9oARErc/bkjXgh3X4lsBj6kVRccID+2xB1eIUdeyETsfguukh9s1JPKEPU
         XtqA==
X-Gm-Message-State: AOJu0YwMUc6tVB+5NsA8A8qsgKklD7Jkjc7KR+DReEvz4X/NRLfBtomi
	Asb1FIyhig0C5+hiwOo4m0A/5/+F1oMFGTLxAmEWzEJmdvfTiqIpnSQvs8+orlbp5+cRzC9c+n7
	yulfsltMxxCzzHoQ2yhOjPnGPmGGUZDE=
X-Gm-Gg: ASbGncsQq20Mg3jqjZ05b/Unt4x7yMr7jwNCrMstNBO4F43u7q9lJtcXVo4WK7UAqkH
	WfQAqd0D7b3pP9VDv/xSPMylsamitA9b6BvFsd/qS8HKTo5bhCy0JFIakSGh6HEQ0NtlPfGRVGW
	7QvCU5oYWwzxQ6KFWl307ahQtqTYA5op95XHbT/iyLYnEKqLsVkKlusrejdjYvtAKZhVdHI6M86
	HSYSBV48lApcHs5KeE+AiYj4PBbqVHA+uFvfxrQ6DJutwP1GTgAbu4VKf8iJC3kTYkXqjKwX0Lq
	iVGd6Q==
X-Google-Smtp-Source: AGHT+IE9+xZE0fFztqXX7V+vpC8mVMseuHIYvukwtSjOMcUVNCMCkMdZDwIPd4rVoT8xMAZEZuKbHjGu1m/ptN6W18A=
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id
 98e67ed59e1d1-34947b5ffbfmr4278904a91.3.1764875096136; Thu, 04 Dec 2025
 11:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204171222.12148-1-danieldurning.work@gmail.com>
In-Reply-To: <20251204171222.12148-1-danieldurning.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Dec 2025 14:04:44 -0500
X-Gm-Features: AWmQ_bmtsPxe2UMLAdBC2CfXioUmOCoaTng0o0E-rlUE3YLnZObNwalf3imqtgs
Message-ID: <CAEjxPJ6G7Kj6Zg=MG2EihMapq9LDTrk1=henPOOHhDeC34os-w@mail.gmail.com>
Subject: Re: [RFC PATCH selinuxns] selinux: optimize context string handling
 and global sidtab
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:13=E2=80=AFPM <danieldurning.work@gmail.com> wrot=
e:
>
> From: Daniel Durning <danieldurning.work@gmail.com>
>
> Changed context structs to always hold the context string.
> Context strings must always be held in the global sidtab anyway, so this
> avoids needing to frequently allocate and free the context strings.
> Context validity is now determined by the user field being set rather
> than the string field being empty. Removed sid2str cache since context
> strings no longer have to be generated at runtime. Removed unnecessary
> string copies in the global sidtab, and updated callers to avoid freeing
> context strings. This makes accessing contexts quicker at runtime at
> the cost of some additional memory overhead.
>
> KASAN and kmemleak were used to ensure that the patch did not introduce
> any double-frees or memory leaks.
>
> Performance data was collected to measure both the performance gain and
> memory usage increase.
>
> We used the following command to test runtime for an operation involving
> heavy use of security contexts. Other performance measurements like
> kcbench showed virtually no change in runtime. This command accesses
> file contexts many times, calling the relevant functions to
> produce/retrieve context strings.
>
> perf stat setfiles -n /etc/selinux/targeted/contexts/files/file_contexts =
/
>
> The command was run 5 times and the results were averaged.
>
> Without Patch:
>
> Average Cycles: 13972133072
> Average Seconds (Sys): 3.6534178
>
> With Patch:
>
> Average Cycles: 13713806342.4
> Average Seconds (Sys): 3.3724038
>
> The command ran ~8.33% faster (in terms of sys seconds) and used ~1.88%
> less cycles on average with the patch than without.
>
> We added some additional code to the sidtab_hash_stats() function to
> print the total length of all cached context strings and measure memory
> overhead.
>
> Without Patch:
>
> entries: 378
> context length (rounded): 0 (bytes)
>
> With Patch:
>
> entries: 378
> context length (rounded): 21792 (bytes)
>
> The patch used ~22 kb of additional memory.
>
> Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>

This seems like a generally useful optimization independent of SELinux
namespaces, although the benefits are magnified by the global SID
table. Paul+Ondrej, would this be of interest if the portions not
specific to SELinux namespaces / global SID table were re-based on
selinux/dev and submitted?

> ---
>  security/selinux/Kconfig           |  11 --
>  security/selinux/avc.c             |   4 -
>  security/selinux/global_sidtab.c   |  19 +-
>  security/selinux/hooks.c           |  33 ++--
>  security/selinux/include/context.h |  19 +-
>  security/selinux/include/sidtab.h  |  29 ---
>  security/selinux/selinuxfs.c       |   7 -
>  security/selinux/ss/context.c      |  14 +-
>  security/selinux/ss/policydb.c     |  10 +-
>  security/selinux/ss/services.c     | 301 +++++++++++------------------
>  security/selinux/ss/services.h     |   5 +
>  security/selinux/ss/sidtab.c       | 101 +---------
>  security/selinux/xfrm.c            |   1 -
>  13 files changed, 163 insertions(+), 391 deletions(-)
>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 76d12be7bab6..e26ad833183b 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -58,17 +58,6 @@ config SECURITY_SELINUX_SIDTAB_HASH_BITS
>           chain lengths are high (e.g. > 20) then selecting a higher valu=
e here
>           will ensure that lookups times are short and stable.
>
> -config SECURITY_SELINUX_SID2STR_CACHE_SIZE
> -       int "SELinux SID to context string translation cache size"
> -       depends on SECURITY_SELINUX
> -       default 256
> -       help
> -         This option defines the size of the internal SID -> context str=
ing
> -         cache, which improves the performance of context to string
> -         conversion.  Setting this option to 0 disables the cache comple=
tely.
> -
> -         If unsure, keep the default value.
> -
>  config SECURITY_SELINUX_AVC_HASH_BITS
>         int "SELinux avc hashtable size"
>         depends on SECURITY_SELINUX
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index b1d6d91c9f38..019c789eadc2 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -744,8 +744,6 @@ static void avc_audit_post_callback(struct audit_buff=
er *ab, void *a)
>                 audit_log_format(ab, " permissive=3D%u", sad->result ? 0 =
: 1);
>
>         trace_selinux_audited(sad, scontext, tcontext, tclass);
> -       kfree(tcontext);
> -       kfree(scontext);
>
>         /* in case of invalid context report also the actual context stri=
ng */
>         rc =3D security_sid_to_context_inval(sad->state, sad->ssid, &scon=
text,
> @@ -755,7 +753,6 @@ static void avc_audit_post_callback(struct audit_buff=
er *ab, void *a)
>                         scontext_len--;
>                 audit_log_format(ab, " srawcon=3D");
>                 audit_log_n_untrustedstring(ab, scontext, scontext_len);
> -               kfree(scontext);
>         }
>
>         rc =3D security_sid_to_context_inval(sad->state, sad->tsid, &scon=
text,
> @@ -765,7 +762,6 @@ static void avc_audit_post_callback(struct audit_buff=
er *ab, void *a)
>                         scontext_len--;
>                 audit_log_format(ab, " trawcon=3D");
>                 audit_log_n_untrustedstring(ab, scontext, scontext_len);
> -               kfree(scontext);
>         }
>  }
>
> diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_s=
idtab.c
> index e1acf6607788..67cecfd5c51a 100644
> --- a/security/selinux/global_sidtab.c
> +++ b/security/selinux/global_sidtab.c
> @@ -53,19 +53,7 @@ static int global_sid_to_context(u32 sid, char **scont=
ext, u32 *scontext_len)
>                 return -EINVAL;
>         }
>         *scontext_len =3D ctx->len;
> -       /*
> -        * Could eliminate allocation + copy if callers do not free
> -        * since the global sidtab entries are never freed.
> -        * This however would not match the current expectation
> -        * of callers of security_sid_to_context().
> -        * TODO: Update all callers and get rid of this copy.
> -        */
> -       *scontext =3D kstrdup(ctx->str, GFP_ATOMIC);
> -       if (!(*scontext)) {
> -               rcu_read_unlock();
> -               *scontext_len =3D 0;
> -               return -ENOMEM;
> -       }
> +       *scontext =3D ctx->str;
>
>         rcu_read_unlock();
>         return 0;
> @@ -197,7 +185,6 @@ static int map_global_sid_to_ss(struct selinux_state =
*state, u32 sid,
>                 spin_unlock_irqrestore(&global_sidtab.lock, flags);
>         }
>  #endif
> -       kfree(scontext);
>         return rc;
>  }
>
> @@ -225,7 +212,6 @@ static int map_ss_sid_to_global(struct selinux_state =
*state, u32 ss_sid,
>
>         rc =3D global_context_to_sid(state, ss_sid, scontext, scontext_le=
n,
>                                    out_sid, GFP_ATOMIC);
> -       kfree(scontext);
>         return rc;
>  }
>
> @@ -318,7 +304,6 @@ int security_context_to_sid(struct selinux_state *sta=
te, const char *scontext,
>         *out_sid =3D sid;
>
>  out:
> -       kfree(ctx);
>         return rc;
>  }
>
> @@ -366,7 +351,6 @@ int security_context_to_sid_default(struct selinux_st=
ate *state,
>         *out_sid =3D sid;
>
>  out:
> -       kfree(ctx);
>         return rc;
>  }
>
> @@ -405,7 +389,6 @@ int security_context_to_sid_force(struct selinux_stat=
e *state,
>         *out_sid =3D sid;
>
>  out:
> -       kfree(ctx);
>         return rc;
>  }
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7003a3f96ead..4def6a70ca6e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1096,7 +1096,6 @@ static int show_sid(struct seq_file *m, u32 sid)
>                 if (has_comma)
>                         seq_putc(m, '\"');
>         }
> -       kfree(context);
>         return rc;
>  }
>
> @@ -3005,6 +3004,7 @@ static int selinux_inode_init_security(struct inode=
 *inode, struct inode *dir,
>         u16 newsclass;
>         int rc;
>         char *context;
> +       char *value;
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> @@ -3031,7 +3031,12 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>                                                    &context, &clen);
>                 if (rc)
>                         return rc;
> -               xattr->value =3D context;
> +
> +               value =3D kstrdup(context, GFP_ATOMIC);
> +               if (!(value))
> +                       return -ENOMEM;
> +
> +               xattr->value =3D value;
>                 xattr->value_len =3D clen;
>                 xattr->name =3D XATTR_SELINUX_SUFFIX;
>         }
> @@ -3710,11 +3715,10 @@ static int selinux_inode_getsecurity(struct mnt_i=
dmap *idmap,
>                 return error;
>         error =3D size;
>         if (alloc) {
> -               *buffer =3D context;
> -               goto out_nofree;
> +               *buffer =3D kstrdup(context, GFP_ATOMIC);
> +               if (!(*buffer))
> +                       return -ENOMEM;
>         }
> -       kfree(context);
> -out_nofree:
>         return error;
>  }
>
> @@ -3865,7 +3869,6 @@ static int selinux_kernfs_init_security(struct kern=
fs_node *kn_dir,
>
>         rc =3D kernfs_xattr_set(kn, XATTR_NAME_SELINUX, context, clen,
>                               XATTR_CREATE);
> -       kfree(context);
>         return rc;
>  }
>
> @@ -5550,7 +5553,6 @@ static int selinux_socket_getpeersec_stream(struct =
socket *sock,
>  out_len:
>         if (copy_to_sockptr(optlen, &scontext_len, sizeof(scontext_len)))
>                 err =3D -EFAULT;
> -       kfree(scontext);
>         return err;
>  }
>
> @@ -7023,10 +7025,18 @@ static int selinux_getprocattr(struct task_struct=
 *p,
>                                const char *name, char **value)
>  {
>         unsigned int attr =3D lsm_name_to_attr(name);
> +       char *context;
>         int rc;
>
>         if (attr) {
> -               rc =3D selinux_lsm_getattr(attr, p, value);
> +               rc =3D selinux_lsm_getattr(attr, p, &context);
> +
> +               if (rc > 0) {
> +                       *value =3D kstrdup(context, GFP_ATOMIC);
> +                       if (!(*value))
> +                               return -ENOMEM;
> +               }
> +
>                 if (rc !=3D -EOPNOTSUPP)
>                         return rc;
>         }
> @@ -7083,7 +7093,6 @@ static int selinux_secctx_to_secid(const char *secd=
ata, u32 seclen, u32 *secid)
>  static void selinux_release_secctx(struct lsm_context *cp)
>  {
>         if (cp->id =3D=3D LSM_ID_SELINUX) {
> -               kfree(cp->context);
>                 cp->context =3D NULL;
>                 cp->id =3D LSM_ID_UNDEF;
>         }
> @@ -7202,7 +7211,9 @@ static int selinux_key_getsecurity(struct key *key,=
 char **_buffer)
>                                      &context, &len);
>         if (!rc)
>                 rc =3D len;
> -       *_buffer =3D context;
> +       *_buffer =3D kstrdup(context, GFP_ATOMIC);
> +       if (!(*_buffer))
> +               return -ENOMEM;
>         return rc;
>  }
>
> diff --git a/security/selinux/include/context.h b/security/selinux/includ=
e/context.h
> index dd3b9b5b588e..cff6d2329ef5 100644
> --- a/security/selinux/include/context.h
> +++ b/security/selinux/include/context.h
> @@ -31,7 +31,7 @@ struct context {
>         u32 type;
>         u32 len; /* length of string in bytes */
>         struct mls_range range;
> -       char *str; /* string representation if context cannot be mapped. =
*/
> +       char *str; /* string representation */
>  };
>
>  static inline void mls_context_init(struct context *c)
> @@ -160,15 +160,10 @@ static inline int context_cpy(struct context *dst, =
const struct context *src)
>         dst->user =3D src->user;
>         dst->role =3D src->role;
>         dst->type =3D src->type;
> -       if (src->str) {
> -               dst->str =3D kstrdup(src->str, GFP_ATOMIC);
> -               if (!dst->str)
> -                       return -ENOMEM;
> -               dst->len =3D src->len;
> -       } else {
> -               dst->str =3D NULL;
> -               dst->len =3D 0;
> -       }
> +       dst->str =3D kstrdup(src->str, GFP_ATOMIC);
> +       if (!dst->str)
> +               return -ENOMEM;
> +       dst->len =3D src->len;
>         rc =3D mls_context_cpy(dst, src);
>         if (rc) {
>                 kfree(dst->str);
> @@ -191,9 +186,9 @@ static inline void context_destroy(struct context *c)
>  static inline bool context_equal(const struct context *c1,
>                                  const struct context *c2)
>  {
> -       if (c1->len && c2->len)
> +       if (!c1->user && !c2->user)
>                 return (c1->len =3D=3D c2->len && !strcmp(c1->str, c2->st=
r));
> -       if (c1->len || c2->len)
> +       if (!c1->user || !c2->user)
>                 return 0;
>         return ((c1->user =3D=3D c2->user) && (c1->role =3D=3D c2->role) =
&&
>                 (c1->type =3D=3D c2->type) && mls_context_equal(c1, c2));
> diff --git a/security/selinux/include/sidtab.h b/security/selinux/include=
/sidtab.h
> index 2df3ac0df935..5fd841f6c33b 100644
> --- a/security/selinux/include/sidtab.h
> +++ b/security/selinux/include/sidtab.h
> @@ -32,9 +32,6 @@ struct sidtab_entry {
>         u32 sid;
>         u32 hash;
>         struct context context;
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -       struct sidtab_str_cache __rcu *cache;
> -#endif
>         struct hlist_node list;
>  #ifdef CONFIG_SECURITY_SELINUX_NS
>         u32 ss_sid;
> @@ -107,13 +104,6 @@ struct sidtab {
>         bool frozen;
>         spinlock_t lock;
>
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -       /* SID -> context string cache */
> -       u32 cache_free_slots;
> -       struct list_head cache_lru_list;
> -       spinlock_t cache_lock;
> -#endif
> -
>         /* index =3D=3D SID - 1 (no entry for SECSID_NULL) */
>         struct sidtab_isid_entry isids[SECINITSID_NUM];
>
> @@ -160,25 +150,6 @@ void sidtab_destroy(struct sidtab *s);
>
>  int sidtab_hash_stats(struct sidtab *sidtab, char *page);
>
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> -                       const char *str, u32 str_len);
> -int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, cha=
r **out,
> -                      u32 *out_len);
> -#else
> -static inline void sidtab_sid2str_put(struct sidtab *s,
> -                                     struct sidtab_entry *entry,
> -                                     const char *str, u32 str_len)
> -{
> -}
> -static inline int sidtab_sid2str_get(struct sidtab *s,
> -                                    struct sidtab_entry *entry, char **o=
ut,
> -                                    u32 *out_len)
> -{
> -       return -ENOENT;
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
> -
>  #ifdef CONFIG_SECURITY_SELINUX_NS
>  #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
>  extern void sidtab_invalidate_state(struct sidtab *s,
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 72a6fa8a91e4..637ab4ed101e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -835,7 +835,6 @@ static ssize_t sel_write_context(struct file *file, c=
har *buf, size_t size)
>         memcpy(buf, canon, len);
>         length =3D len;
>  out:
> -       kfree(canon);
>         return length;
>  }
>
> @@ -1208,7 +1207,6 @@ static ssize_t sel_write_create(struct file *file, =
char *buf, size_t size)
>         memcpy(buf, newcon, len);
>         length =3D len;
>  out:
> -       kfree(newcon);
>         kfree(namebuf);
>         kfree(tcon);
>         kfree(scon);
> @@ -1274,7 +1272,6 @@ static ssize_t sel_write_relabel(struct file *file,=
 char *buf, size_t size)
>         memcpy(buf, newcon, len);
>         length =3D len;
>  out:
> -       kfree(newcon);
>         kfree(tcon);
>         kfree(scon);
>         return length;
> @@ -1348,12 +1345,10 @@ static ssize_t sel_write_user(struct file *file, =
char *buf, size_t size)
>                         goto out;
>                 }
>                 if ((length + len) >=3D SIMPLE_TRANSACTION_LIMIT) {
> -                       kfree(newcon);
>                         length =3D -ERANGE;
>                         goto out;
>                 }
>                 memcpy(ptr, newcon, len);
> -               kfree(newcon);
>                 ptr +=3D len;
>                 length +=3D len;
>         }
> @@ -1426,7 +1421,6 @@ static ssize_t sel_write_member(struct file *file, =
char *buf, size_t size)
>         memcpy(buf, newcon, len);
>         length =3D len;
>  out:
> -       kfree(newcon);
>         kfree(tcon);
>         kfree(scon);
>         return length;
> @@ -1933,7 +1927,6 @@ static ssize_t sel_read_initcon(struct file *file, =
char __user *buf,
>                 return ret;
>
>         ret =3D simple_read_from_buffer(buf, count, ppos, con, len);
> -       kfree(con);
>         return ret;
>  }
>
> diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.=
c
> index a528b7f76280..47cdec24f85d 100644
> --- a/security/selinux/ss/context.c
> +++ b/security/selinux/ss/context.c
> @@ -16,14 +16,14 @@ u32 context_compute_hash(const struct context *c)
>         u32 hash =3D 0;
>
>         /*
> -        * If a context is invalid, it will always be represented by a
> -        * context struct with only the len & str set (and vice versa)
> -        * under a given policy. Since context structs from different
> -        * policies should never meet, it is safe to hash valid and
> -        * invalid contexts differently. The context_equal() function
> -        * already operates under the same assumption.
> +        * If a context is invalid, it will never have user set
> +        * (and vice versa) under a given policy. Since context
> +        * structs from different policies should never meet,
> +        * it is safe to hash valid and invalid contexts differently.
> +        * The context_equal() function already operates under the
> +        * under the same assumption.
>          */
> -       if (c->len)
> +       if (!c->user)
>                 return full_name_hash(NULL, c->str, c->len);
>
>         hash =3D jhash_3words(c->user, c->role, c->type, hash);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 91df3db6a88c..f0890f4c158e 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1066,6 +1066,8 @@ static int context_read_and_validate(struct context=
 *c, struct policydb *p,
>  {
>         __le32 buf[3];
>         int rc;
> +       char *str =3D NULL;
> +       u32 str_len =3D 0;
>
>         rc =3D next_entry(buf, fp, sizeof buf);
>         if (rc) {
> @@ -1089,7 +1091,13 @@ static int context_read_and_validate(struct contex=
t *c, struct policydb *p,
>                 context_destroy(c);
>                 goto out;
>         }
> -       rc =3D 0;
> +       rc =3D context_struct_to_string(p, c, &str, &str_len);
> +       if (rc) {
> +               context_destroy(c);
> +               goto out;
> +       }
> +       c->str =3D str;
> +       c->len =3D str_len;
>  out:
>         return rc;
>  }
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index acbb91e18b38..242b47af0991 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -75,11 +75,6 @@ struct selinux_policy_convert_data {
>  };
>
>  /* Forward declaration. */
> -static int context_struct_to_string(struct policydb *policydb,
> -                                   struct context *context,
> -                                   char **scontext,
> -                                   u32 *scontext_len);
> -
>  static int sidtab_entry_to_string(struct policydb *policydb,
>                                   struct sidtab *sidtab,
>                                   struct sidtab_entry *entry,
> @@ -464,11 +459,8 @@ static void security_dump_masked_av(struct policydb =
*policydb,
>         struct class_datum *tclass_dat;
>         struct audit_buffer *ab;
>         char *tclass_name;
> -       char *scontext_name =3D NULL;
> -       char *tcontext_name =3D NULL;
>         char *permission_names[32];
>         int index;
> -       u32 length;
>         bool need_comma =3D false;
>
>         if (!permissions)
> @@ -482,30 +474,21 @@ static void security_dump_masked_av(struct policydb=
 *policydb,
>         if (common_dat &&
>             hashtab_map(&common_dat->permissions.table,
>                         dump_masked_av_helper, permission_names) < 0)
> -               goto out;
> +               return;
>
>         if (hashtab_map(&tclass_dat->permissions.table,
>                         dump_masked_av_helper, permission_names) < 0)
> -               goto out;
> -
> -       /* get scontext/tcontext in text form */
> -       if (context_struct_to_string(policydb, scontext,
> -                                    &scontext_name, &length) < 0)
> -               goto out;
> -
> -       if (context_struct_to_string(policydb, tcontext,
> -                                    &tcontext_name, &length) < 0)
> -               goto out;
> +               return;
>
>         /* audit a message */
>         ab =3D audit_log_start(audit_context(),
>                              GFP_ATOMIC, AUDIT_SELINUX_ERR);
>         if (!ab)
> -               goto out;
> +               return;
>
>         audit_log_format(ab, "op=3Dsecurity_compute_av reason=3D%s "
>                          "scontext=3D%s tcontext=3D%s tclass=3D%s perms=
=3D",
> -                        reason, scontext_name, tcontext_name, tclass_nam=
e);
> +                        reason, scontext->str, tcontext->str, tclass_nam=
e);
>
>         for (index =3D 0; index < 32; index++) {
>                 u32 mask =3D (1 << index);
> @@ -520,10 +503,6 @@ static void security_dump_masked_av(struct policydb =
*policydb,
>                 need_comma =3D true;
>         }
>         audit_log_end(ab);
> -out:
> -       /* release scontext/tcontext */
> -       kfree(tcontext_name);
> -       kfree(scontext_name);
>  }
>
>  /*
> @@ -745,10 +724,6 @@ static int security_validtrans_handle_fail(struct se=
linux_state *state,
>                   " oldcontext=3D%s newcontext=3D%s taskcontext=3D%s tcla=
ss=3D%s",
>                   o, n, t, sym_name(p, SYM_CLASSES, tclass-1));
>  out:
> -       kfree(o);
> -       kfree(n);
> -       kfree(t);
> -
>         if (!enforcing_enabled(state))
>                 return 0;
>         return -EPERM;
> @@ -938,8 +913,6 @@ int selinux_ss_bounded_transition(struct selinux_stat=
e *state,
>                                   "oldcontext=3D%s newcontext=3D%s",
>                                   old_name, new_name);
>                 }
> -               kfree(new_name);
> -               kfree(old_name);
>         }
>  out:
>         rcu_read_unlock();
> @@ -1269,7 +1242,7 @@ void selinux_ss_compute_av_user(struct selinux_stat=
e *state,
>   * to point to this string and set `*scontext_len' to
>   * the length of the string.
>   */
> -static int context_struct_to_string(struct policydb *p,
> +int context_struct_to_string(struct policydb *p,
>                                     struct context *context,
>                                     char **scontext, u32 *scontext_len)
>  {
> @@ -1324,16 +1297,10 @@ static int sidtab_entry_to_string(struct policydb=
 *p,
>                                   struct sidtab_entry *entry,
>                                   char **scontext, u32 *scontext_len)
>  {
> -       int rc =3D sidtab_sid2str_get(sidtab, entry, scontext, scontext_l=
en);
> +       *scontext =3D entry->context.str;
> +       *scontext_len =3D entry->context.len;
>
> -       if (rc !=3D -ENOENT)
> -               return rc;
> -
> -       rc =3D context_struct_to_string(p, &entry->context, scontext,
> -                                     scontext_len);
> -       if (!rc && scontext)
> -               sidtab_sid2str_put(sidtab, entry, *scontext, *scontext_le=
n);
> -       return rc;
> +       return 0;
>  }
>
>  #include "initial_sid_to_string.h"
> @@ -1425,7 +1392,7 @@ static int security_sid_to_context_core(struct seli=
nux_state *state,
>                 rc =3D -EINVAL;
>                 goto out_unlock;
>         }
> -       if (only_invalid && !entry->context.len)
> +       if (only_invalid && entry->context.user)
>                 goto out_unlock;
>
>         rc =3D sidtab_entry_to_string(policydb, sidtab, entry, scontext,
> @@ -1573,6 +1540,7 @@ static int security_context_to_sid_core(struct seli=
nux_state *state,
>         struct policydb *policydb;
>         struct sidtab *sidtab;
>         char *scontext2, *str =3D NULL;
> +       u32 str_len =3D 0;
>         struct context context;
>         int rc =3D 0;
>
> @@ -1600,13 +1568,13 @@ static int security_context_to_sid_core(struct se=
linux_state *state,
>         }
>         *sid =3D SECSID_NULL;
>
> -       if (force) {
> -               /* Save another copy for storing in uninterpreted form */
> -               rc =3D -ENOMEM;
> -               str =3D kstrdup(scontext2, gfp_flags);
> -               if (!str)
> -                       goto out;
> -       }
> +       /* Save another copy for storing in uninterpreted form */
> +       rc =3D -ENOMEM;
> +       str =3D kstrdup(scontext2, gfp_flags);
> +       if (!str)
> +               goto out;
> +       str_len =3D strlen(scontext2) + 1;
> +
>  retry:
>         rcu_read_lock();
>         policy =3D rcu_dereference(state->policy);
> @@ -1614,19 +1582,24 @@ static int security_context_to_sid_core(struct se=
linux_state *state,
>         sidtab =3D policy->sidtab;
>         rc =3D string_to_context_struct(policydb, sidtab, scontext2,
>                                       &context, def_sid);
> -       if (rc =3D=3D -EINVAL && force) {
> -               context.str =3D str;
> -               context.len =3D strlen(str) + 1;
> -               str =3D NULL;
> -       } else if (rc)
> +       if (rc && !(rc =3D=3D -EINVAL && force))
>                 goto out_unlock;
> +       if (rc !=3D -EINVAL) {
> +               kfree(str);
> +               str =3D NULL;
> +               rc =3D context_struct_to_string(policydb, &context, &str,=
 &str_len);
> +               if (rc)
> +                       goto out_unlock;
> +       }
> +       context.str =3D str;
> +       context.len =3D str_len;
> +       str =3D NULL;
>         rc =3D sidtab_context_to_sid(sidtab, &context, sid);
>         if (rc =3D=3D -ESTALE) {
>                 rcu_read_unlock();
> -               if (context.str) {
> -                       str =3D context.str;
> -                       context.str =3D NULL;
> -               }
> +               str =3D context.str;
> +               context.str =3D NULL;
> +               context.len =3D 0;
>                 context_destroy(&context);
>                 goto retry;
>         }
> @@ -1713,30 +1686,25 @@ static int compute_sid_handle_invalid_context(
>  {
>         struct policydb *policydb =3D &policy->policydb;
>         struct sidtab *sidtab =3D policy->sidtab;
> -       char *s =3D NULL, *t =3D NULL, *n =3D NULL;
> -       u32 slen, tlen, nlen;
> +       char *s =3D NULL, *t =3D NULL;
> +       u32 slen, tlen;
>         struct audit_buffer *ab;
>
>         if (sidtab_entry_to_string(policydb, sidtab, sentry, &s, &slen))
>                 goto out;
>         if (sidtab_entry_to_string(policydb, sidtab, tentry, &t, &tlen))
>                 goto out;
> -       if (context_struct_to_string(policydb, newcontext, &n, &nlen))
> -               goto out;
>         ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX=
_ERR);
>         if (!ab)
>                 goto out;
>         audit_log_format(ab,
>                          "op=3Dsecurity_compute_sid invalid_context=3D");
>         /* no need to record the NUL with untrusted strings */
> -       audit_log_n_untrustedstring(ab, n, nlen - 1);
> +       audit_log_n_untrustedstring(ab, newcontext->str, newcontext->len =
- 1);
>         audit_log_format(ab, " scontext=3D%s tcontext=3D%s tclass=3D%s",
>                          s, t, sym_name(policydb, SYM_CLASSES, tclass-1))=
;
>         audit_log_end(ab);
>  out:
> -       kfree(s);
> -       kfree(t);
> -       kfree(n);
>         if (!enforcing_enabled(state))
>                 return 0;
>         return -EACCES;
> @@ -1792,6 +1760,8 @@ static int security_compute_sid(struct selinux_stat=
e *state,
>         u16 tclass;
>         int rc =3D 0;
>         bool sock;
> +       char *str =3D NULL;
> +       u32 str_len =3D 0;
>
>         if (!selinux_initialized(state)) {
>                 switch (orig_tclass) {
> @@ -1943,6 +1913,13 @@ static int security_compute_sid(struct selinux_sta=
te *state,
>         if (rc)
>                 goto out_unlock;
>
> +       /* Set the context string */
> +       rc =3D context_struct_to_string(policydb, &newcontext, &str, &str=
_len);
> +       if (rc)
> +               goto out_unlock;
> +       newcontext.str =3D str;
> +       newcontext.len =3D str_len;
> +
>         /* Check the validity of the context. */
>         if (!policydb_context_isvalid(policydb, &newcontext)) {
>                 rc =3D compute_sid_handle_invalid_context(state, policy, =
sentry,
> @@ -2056,19 +2033,14 @@ int selinux_ss_change_sid(struct selinux_state *s=
tate,
>
>  static inline int convert_context_handle_invalid_context(
>         struct selinux_state *state,
> -       struct policydb *policydb,
>         struct context *context)
>  {
> -       char *s;
> -       u32 len;
> -
>         if (enforcing_enabled(state))
>                 return -EINVAL;
>
> -       if (!context_struct_to_string(policydb, context, &s, &len)) {
> +       if (!context->str) {
>                 pr_warn("SELinux:  Context %s would be invalid if enforci=
ng\n",
> -                       s);
> -               kfree(s);
> +                       context->str);
>         }
>         return 0;
>  }
> @@ -2089,114 +2061,32 @@ int services_convert_context(struct convert_cont=
ext_args *args,
>                              struct context *oldc, struct context *newc,
>                              gfp_t gfp_flags)
>  {
> -       struct ocontext *oc;
> -       struct role_datum *role;
> -       struct type_datum *typdatum;
> -       struct user_datum *usrdatum;
>         char *s;
> -       u32 len;
>         int rc;
>
> -       if (oldc->str) {
> -               s =3D kstrdup(oldc->str, gfp_flags);
> -               if (!s)
> -                       return -ENOMEM;
> +       s =3D kstrdup(oldc->str, gfp_flags);
> +       if (!s)
> +               return -ENOMEM;
>
> -               rc =3D string_to_context_struct(args->newp, NULL, s, newc=
, SECSID_NULL);
> -               if (rc =3D=3D -EINVAL) {
> -                       /*
> -                        * Retain string representation for later mapping=
.
> -                        *
> -                        * IMPORTANT: We need to copy the contents of old=
c->str
> -                        * back into s again because string_to_context_st=
ruct()
> -                        * may have garbled it.
> -                        */
> -                       memcpy(s, oldc->str, oldc->len);
> -                       context_init(newc);
> -                       newc->str =3D s;
> -                       newc->len =3D oldc->len;
> -                       return 0;
> -               }
> +       rc =3D string_to_context_struct(args->newp, NULL, s, newc, SECSID=
_NULL);
> +       if (rc && rc !=3D -EINVAL) {
> +               /* Other error condition, e.g. ENOMEM. */
> +               pr_err("SELinux:   Unable to map context %s, rc =3D %d.\n=
",
> +                       oldc->str, -rc);
>                 kfree(s);
> -               if (rc) {
> -                       /* Other error condition, e.g. ENOMEM. */
> -                       pr_err("SELinux:   Unable to map context %s, rc =
=3D %d.\n",
> -                              oldc->str, -rc);
> -                       return rc;
> -               }
> -               pr_info("SELinux:  Context %s became valid (mapped).\n",
> -                       oldc->str);
> -               return 0;
> -       }
> -
> -       context_init(newc);
> -
> -       /* Convert the user. */
> -       usrdatum =3D symtab_search(&args->newp->p_users,
> -                                sym_name(args->oldp, SYM_USERS, oldc->us=
er - 1));
> -       if (!usrdatum)
> -               goto bad;
> -       newc->user =3D usrdatum->value;
> -
> -       /* Convert the role. */
> -       role =3D symtab_search(&args->newp->p_roles,
> -                            sym_name(args->oldp, SYM_ROLES, oldc->role -=
 1));
> -       if (!role)
> -               goto bad;
> -       newc->role =3D role->value;
> -
> -       /* Convert the type. */
> -       typdatum =3D symtab_search(&args->newp->p_types,
> -                                sym_name(args->oldp, SYM_TYPES, oldc->ty=
pe - 1));
> -       if (!typdatum)
> -               goto bad;
> -       newc->type =3D typdatum->value;
> -
> -       /* Convert the MLS fields if dealing with MLS policies */
> -       if (args->oldp->mls_enabled && args->newp->mls_enabled) {
> -               rc =3D mls_convert_context(args->oldp, args->newp, oldc, =
newc);
> -               if (rc)
> -                       goto bad;
> -       } else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
> -               /*
> -                * Switching between non-MLS and MLS policy:
> -                * ensure that the MLS fields of the context for all
> -                * existing entries in the sidtab are filled in with a
> -                * suitable default value, likely taken from one of the
> -                * initial SIDs.
> -                */
> -               oc =3D args->newp->ocontexts[OCON_ISID];
> -               while (oc && oc->sid[0] !=3D SECINITSID_UNLABELED)
> -                       oc =3D oc->next;
> -               if (!oc) {
> -                       pr_err("SELinux:  unable to look up"
> -                               " the initial SIDs list\n");
> -                       goto bad;
> -               }
> -               rc =3D mls_range_set(newc, &oc->context[0].range);
> -               if (rc)
> -                       goto bad;
> -       }
> -
> -       /* Check the validity of the new context. */
> -       if (!policydb_context_isvalid(args->newp, newc)) {
> -               rc =3D convert_context_handle_invalid_context(args->state=
,
> -                                                           args->oldp, o=
ldc);
> -               if (rc)
> -                       goto bad;
> +               return rc;
>         }
>
> -       return 0;
> -bad:
> -       /* Map old representation to string and save it. */
> -       rc =3D context_struct_to_string(args->oldp, oldc, &s, &len);
> -       if (rc)
> -               return rc;
> -       context_destroy(newc);
> +       /*
> +        * Retain string representation for later mapping.
> +        *
> +        * IMPORTANT: We need to copy the contents of oldc->str
> +        * back into s again because string_to_context_struct()
> +        * may have garbled it.
> +        */
> +       memcpy(s, oldc->str, oldc->len);
>         newc->str =3D s;
> -       newc->len =3D len;
> -       pr_info("SELinux:  Context %s became invalid (unmapped).\n",
> -               newc->str);
> +       newc->len =3D oldc->len;
>         return 0;
>  }
>
> @@ -2835,6 +2725,8 @@ int selinux_ss_get_user_sids(struct selinux_state *=
state,
>         struct context *fromcon, usercon;
>         u32 *mysids =3D NULL, *mysids2, sid;
>         u32 i, j, mynel, maxnel =3D SIDS_NEL;
> +       char *str =3D NULL;
> +       u32 str_len =3D 0;
>         struct user_datum *user;
>         struct role_datum *role;
>         struct ebitmap_node *rnode, *tnode;
> @@ -2881,7 +2773,18 @@ int selinux_ss_get_user_sids(struct selinux_state =
*state,
>                                                  &usercon))
>                                 continue;
>
> +                       /* Set the context string */
> +                       rc =3D context_struct_to_string(policydb, &userco=
n, &str, &str_len);
> +                       if (rc) {
> +                               context_destroy(&usercon);
> +                               goto out_unlock;
> +                       }
> +                       usercon.str =3D str;
> +                       usercon.len =3D str_len;
> +
>                         rc =3D sidtab_context_to_sid(sidtab, &usercon, &s=
id);
> +                       /* all done with usercon, free it */
> +                       context_destroy(&usercon);
>                         if (rc =3D=3D -ESTALE) {
>                                 rcu_read_unlock();
>                                 goto retry;
> @@ -3302,8 +3205,8 @@ int selinux_ss_sid_mls_copy(struct selinux_state *s=
tate,
>         struct context *context1;
>         struct context *context2;
>         struct context newcon;
> -       char *s;
> -       u32 len;
> +       char *s =3D NULL;
> +       u32 len =3D 0;
>         int rc;
>
>         if (!selinux_initialized(state)) {
> @@ -3348,25 +3251,27 @@ int selinux_ss_sid_mls_copy(struct selinux_state =
*state,
>         if (rc)
>                 goto out_unlock;
>
> +       rc =3D context_struct_to_string(policydb, &newcon, &s, &len);
> +       if (rc)
> +               goto out_unlock;
> +       newcon.str =3D s;
> +       newcon.len =3D len;
> +
>         /* Check the validity of the new context. */
>         if (!policydb_context_isvalid(policydb, &newcon)) {
> -               rc =3D convert_context_handle_invalid_context(state, poli=
cydb,
> +               rc =3D convert_context_handle_invalid_context(state,
>                                                         &newcon);
>                 if (rc) {
> -                       if (!context_struct_to_string(policydb, &newcon, =
&s,
> -                                                     &len)) {
> -                               struct audit_buffer *ab;
> -
> -                               ab =3D audit_log_start(audit_context(),
> -                                                    GFP_ATOMIC,
> -                                                    AUDIT_SELINUX_ERR);
> -                               audit_log_format(ab,
> -                                                "op=3Dsecurity_sid_mls_c=
opy invalid_context=3D");
> -                               /* don't record NUL with untrusted string=
s */
> -                               audit_log_n_untrustedstring(ab, s, len - =
1);
> -                               audit_log_end(ab);
> -                               kfree(s);
> -                       }
> +                       struct audit_buffer *ab;
> +
> +                       ab =3D audit_log_start(audit_context(),
> +                                            GFP_ATOMIC,
> +                                            AUDIT_SELINUX_ERR);
> +                       audit_log_format(ab,
> +                                        "op=3Dsecurity_sid_mls_copy inva=
lid_context=3D");
> +                       /* don't record NUL with untrusted strings */
> +                       audit_log_n_untrustedstring(ab, s, len - 1);
> +                       audit_log_end(ab);
>                         goto out_unlock;
>                 }
>         }
> @@ -3970,6 +3875,8 @@ int selinux_ss_netlbl_secattr_to_sid(struct selinux=
_state *state,
>         int rc;
>         struct context *ctx;
>         struct context ctx_new;
> +       char *str =3D NULL;
> +       u32 str_len =3D 0;
>
>         if (!selinux_initialized(state)) {
>                 *sid =3D SECSID_NULL;
> @@ -4007,8 +3914,22 @@ int selinux_ss_netlbl_secattr_to_sid(struct selinu=
x_state *state,
>                         goto out;
>                 }
>
> +               rc =3D context_struct_to_string(policydb, &ctx_new, &str,=
 &str_len);
> +               if (rc) {
> +                       ebitmap_destroy(&ctx_new.range.level[0].cat);
> +                       goto out;
> +               }
> +               ctx_new.str =3D str;
> +               ctx_new.len =3D str_len;
> +
>                 rc =3D sidtab_context_to_sid(sidtab, &ctx_new, sid);
> +               /*
> +                * Done with ctx_new, free its allocated memory.
> +                * NB we cannot use context_destroy here due to
> +                * level[1] being aliased.
> +                */
>                 ebitmap_destroy(&ctx_new.range.level[0].cat);
> +               kfree(str);
>                 if (rc =3D=3D -ESTALE) {
>                         rcu_read_unlock();
>                         goto retry;
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/service=
s.h
> index 8696f9300529..e53c7d677359 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -45,4 +45,9 @@ int services_convert_context(struct convert_context_arg=
s *args,
>                              struct context *oldc, struct context *newc,
>                              gfp_t gfp_flags);
>
> +int context_struct_to_string(struct policydb *policydb,
> +                                   struct context *context,
> +                                   char **scontext,
> +                                   u32 *scontext_len);
> +
>  #endif /* _SS_SERVICES_H_ */
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index eea37f78bec9..36e76f80fb9b 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -21,14 +21,6 @@
>  #include "sidtab.h"
>  #include "services.h"
>
> -struct sidtab_str_cache {
> -       struct rcu_head rcu_member;
> -       struct list_head lru_member;
> -       struct sidtab_entry *parent;
> -       u32 len;
> -       char str[] __counted_by(len);
> -};
> -
>  #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
>  #define sid_to_index(sid)   ((sid) - (SECINITSID_NUM + 1))
>
> @@ -48,12 +40,6 @@ int sidtab_init(struct sidtab *s)
>
>         spin_lock_init(&s->lock);
>
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -       s->cache_free_slots =3D CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZ=
E;
> -       INIT_LIST_HEAD(&s->cache_lru_list);
> -       spin_lock_init(&s->cache_lock);
> -#endif
> -
>         return 0;
>  }
>
> @@ -90,9 +76,6 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struc=
t context *context)
>         if (rc)
>                 return rc;
>
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -       isid->entry.cache =3D NULL;
> -#endif
>         isid->set =3D 1;
>
>         hash =3D context_compute_hash(context);
> @@ -248,7 +231,7 @@ static struct sidtab_entry *sidtab_search_core(struct=
 sidtab *s, u32 sid,
>                         entry =3D sidtab_lookup(s, sid_to_index(sid));
>                 else
>                         entry =3D sidtab_lookup_initial(s, sid);
> -               if (entry && (!entry->context.len || force))
> +               if (entry && (entry->context.user || force))
>                         return entry;
>         }
>
> @@ -520,9 +503,6 @@ void sidtab_freeze_end(struct sidtab *s, unsigned lon=
g *flags)
>  static void sidtab_destroy_entry(struct sidtab_entry *entry)
>  {
>         context_destroy(&entry->context);
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -       kfree(rcu_dereference_raw(entry->cache));
> -#endif
>  }
>
>  static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 leve=
l)
> @@ -570,85 +550,6 @@ void sidtab_destroy(struct sidtab *s)
>          */
>  }
>
> -#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> -
> -void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> -                       const char *str, u32 str_len)
> -{
> -       struct sidtab_str_cache *cache, *victim =3D NULL;
> -       unsigned long flags;
> -
> -       /* do not cache invalid contexts */
> -       if (entry->context.len)
> -               return;
> -
> -       spin_lock_irqsave(&s->cache_lock, flags);
> -
> -       cache =3D rcu_dereference_protected(entry->cache,
> -                                         lockdep_is_held(&s->cache_lock)=
);
> -       if (cache) {
> -               /* entry in cache - just bump to the head of LRU list */
> -               list_move(&cache->lru_member, &s->cache_lru_list);
> -               goto out_unlock;
> -       }
> -
> -       cache =3D kmalloc(struct_size(cache, str, str_len), GFP_ATOMIC);
> -       if (!cache)
> -               goto out_unlock;
> -
> -       if (s->cache_free_slots =3D=3D 0) {
> -               /* pop a cache entry from the tail and free it */
> -               victim =3D container_of(s->cache_lru_list.prev,
> -                                     struct sidtab_str_cache, lru_member=
);
> -               list_del(&victim->lru_member);
> -               rcu_assign_pointer(victim->parent->cache, NULL);
> -       } else {
> -               s->cache_free_slots--;
> -       }
> -       cache->parent =3D entry;
> -       cache->len =3D str_len;
> -       memcpy(cache->str, str, str_len);
> -       list_add(&cache->lru_member, &s->cache_lru_list);
> -
> -       rcu_assign_pointer(entry->cache, cache);
> -
> -out_unlock:
> -       spin_unlock_irqrestore(&s->cache_lock, flags);
> -       kfree_rcu(victim, rcu_member);
> -}
> -
> -int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, cha=
r **out,
> -                      u32 *out_len)
> -{
> -       struct sidtab_str_cache *cache;
> -       int rc =3D 0;
> -
> -       if (entry->context.len)
> -               return -ENOENT; /* do not cache invalid contexts */
> -
> -       rcu_read_lock();
> -
> -       cache =3D rcu_dereference(entry->cache);
> -       if (!cache) {
> -               rc =3D -ENOENT;
> -       } else {
> -               *out_len =3D cache->len;
> -               if (out) {
> -                       *out =3D kmemdup(cache->str, cache->len, GFP_ATOM=
IC);
> -                       if (!*out)
> -                               rc =3D -ENOMEM;
> -               }
> -       }
> -
> -       rcu_read_unlock();
> -
> -       if (!rc && out)
> -               sidtab_sid2str_put(s, entry, *out, *out_len);
> -       return rc;
> -}
> -
> -#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
> -
>  #ifdef CONFIG_SECURITY_SELINUX_NS
>  #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
>  static void sidtab_invalidate_state_entry(struct sidtab_entry *entry,
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 92fb31661e54..538d41c2b0a2 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -376,7 +376,6 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_stat=
e *x,
>         x->security =3D ctx;
>         atomic_inc(&selinux_xfrm_refcount);
>  out:
> -       kfree(ctx_str);
>         return rc;
>  }
>
> --
> 2.51.0
>
