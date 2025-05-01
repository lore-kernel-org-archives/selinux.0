Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D8243969
	for <selinux@vger.kernel.org>; Thu,  1 May 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135837; cv=none; b=kEswKXnH1gl45aQggsHChr1bRRkGsrPl7SoEGUJqBG/7Xnt3Z3nNqAWFfwoQYG1QGJeWoqiTp8qFQfljijMUQhjU7g4mUxMHSVWYohZFq0ZH2hOJzJj94h0zyTTbbeqlQN+f1YwkYUTkVjQTUpF3DxnGS9KPVlkJaTrhK88bzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135837; c=relaxed/simple;
	bh=kJ/23fzPKFRi3fSSpDajeKBp7crbxBaPq6Ylu7hFsBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVHkffZfjGfQ1dlYk+NzoPnWeJtd9hMebV7hDhG59ZeOQ6QlSWKrpVkC/KKDAE6YPUy3ohYb6m/jgVtx3yfFrjHDw/2YwlixpBsRKnF1TXoBEGVIACB9a+bNr97HbN/H3+70/CL8GaIWcHymRbdK8DTkS9tLfFgiVhFQBnDOh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gGvv+TgV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gGvv+TgV"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e756416045bso327373276.2
        for <selinux@vger.kernel.org>; Thu, 01 May 2025 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746135834; x=1746740634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAUun8j3HNJH68syuCtSTJ7Wf3dR00TxC0OMse6bKT0=;
        b=gGvv+TgViL5swipZRrw8Sa7Ghuav3e4aEAxSAQAxzz8CcRb1t2sLIaUONzN4kHFZvy
         hpZVnGVthrI874caP5bPIXnYKMETAp3FUileOSjSqVTscVNtwk/MjGT9/nDgiZbej0cI
         NB+3dDYzMb+4uxgfJ14jVcDTbwzGWSlEgXq/0qnfGabGeFanSsODopU/+O9PC/XWe37F
         GlZrg+92aRlmB/RgehbX4+9tQlfDP7c5UdJ+l/5TGK01l4Qr1yyb0k3EUqUvH6G1RPc0
         LeMUYHYyaOdsaDSND4G1dY1ZqBB0HZTuzXzl+EjqPXAQ3vM/9Wa2LH0eAnyZNCzky4fc
         MSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746135834; x=1746740634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAUun8j3HNJH68syuCtSTJ7Wf3dR00TxC0OMse6bKT0=;
        b=reki9hF/s/yFfBD4Txd4Q8xP2STqxsso0NLiR1NcLTcffBbAC/WkvQR0CV+UTiotF0
         SCnUrzpEAHvvDWxCjilJWn4IAoue5YyqPhFURm+H9KWka/NHbpLDlgGAfM2Wq3Cq+uj5
         48nTh5Pu13lSJItSKGpJR5GKjAfYF0JmK5S2mnbmc5GX9INWeFs9eQHBO10yrw+rEo70
         zqpHRkmr9OzUuVuQ+eoZ8Py6TjAeVNktvnPo5gGAWGIfT+T1GMxCziJ4ZIBJtpDenEjd
         TPi9oBeM9pCQm9/lxp7fWAIiVyjzHQMQPkTb7Ha9NW1tmBSDxX9BXlyuPqYJpzn+mNRY
         ZtdQ==
X-Gm-Message-State: AOJu0Ywe7Gx6x2iEC/bPQ6Npp/9ksNc8nwFDKoBP3SHdLdnrMKqJWiv6
	BDhA2ivSPZFlWJC7hv0S/EQXuOdpdIpII8jAXa2oQxeDWh9AWO/bLhZoknTize5m80p3IvPvNPj
	d0TgmAlFbRPsWDctx4l7t+EwxvKgQVwBSA4eC
X-Gm-Gg: ASbGncsI4LaxQ6+/U7hKzdDl5lovnEGdlt4jqriF3YCz6fAgGIgdwzP6kkNbo79dCzX
	6uw6SlVabaJrxerLHwidxe/1f6LztPxUo1Qb0bULgeRdJd8rG/03/5yoD158c8hQE7xWvPuBzXK
	aSyx18sjrwOpBIAuLwTwllwnG8OssMUvdf
X-Google-Smtp-Source: AGHT+IHgp/AyKVaj+oCd8HCNPnDpjgA1MZ3WoaX2xXV9eAHi49oTSofEHg7wKqRhRi7wnxCi23teb4RqegzgOmWOL2Q=
X-Received: by 2002:a05:6902:2b05:b0:e72:b481:a490 with SMTP id
 3f1490d57ef6-e7565537cbcmr1026039276.5.1746135834272; Thu, 01 May 2025
 14:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425123719.5984-2-stephen.smalley.work@gmail.com> <20250425144708.14504-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250425144708.14504-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 May 2025 17:43:43 -0400
X-Gm-Features: ATxdqUGsrZTAhvSsQwRijgr1Bmssy9tElj-GqnWnpQfENnnhFvVFwDl6gwNw1dY
Message-ID: <CAHC9VhQ6erSpZexwwnCpy6PJZhQjea9dmE-Lmux9Owbxuj2frg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: optimize selinux_inode_permission() for
 unconfined tasks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Extend the task avdcache to also cache whether the task SID
> unconfined aka permissive|neveraudit and if so, optimize
> selinux_inode_permission(). The same approach could be applied
> to all of the hook functions.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This change demonstrates how the previous patch could be leveraged
> to optimize selinux_inode_permission().
>
>  security/selinux/hooks.c          | 7 ++++++-
>  security/selinux/include/objsec.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536ab..2e7eb0864bfd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3184,6 +3184,7 @@ static inline void task_avdcache_update(struct task=
_security_struct *tsec,
>         tsec->avdcache.dir[spot].audited =3D audited;
>         tsec->avdcache.dir[spot].allowed =3D avd->allowed;
>         tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_PE=
RMISSIVE;
> +       tsec->avdcache.unconfined =3D (avd->flags =3D=3D (AVD_FLAGS_PERMI=
SSIVE|AVD_FLAGS_NEVERAUDIT));
>  }
>
>  /**
> @@ -3210,10 +3211,14 @@ static int selinux_inode_permission(struct inode =
*inode, int requested)
>         if (!mask)
>                 return 0;
>
> +       tsec =3D selinux_cred(current_cred());
> +       if (tsec->avdcache.unconfined && tsec->sid =3D=3D tsec->avdcache.=
sid &&
> +               tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> +               return 0;
> +
>         isec =3D inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
>         if (IS_ERR(isec))
>                 return PTR_ERR(isec);
> -       tsec =3D selinux_cred(current_cred());
>         perms =3D file_mask_to_av(inode->i_mode, mask);
>
>         rc =3D task_avdcache_search(tsec, isec, &avdc);
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 6ee7dc4dfd6e..c659dafbee60 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -49,6 +49,7 @@ struct task_security_struct {
>                 u32 seqno; /* AVC sequence number */
>                 unsigned int dir_spot; /* dir cache index to check first =
*/
>                 struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries=
 */
> +               bool unconfined; /* unconfined */

Once again, I understand the end result is effectively the same, but
please don't call this "unconfined" as I worry about confusion with
the unconfined_t type.  I would suggest "permissive_noaudit" or
something similar; if you come up with something shorter, that's even
better.

>         } avdcache;
>  } __randomize_layout;
>
> --
> 2.49.0

--=20
paul-moore.com
