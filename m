Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DA3C8C46
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227054; cv=pass; b=py/dLwfwdnZdju0LDsLiw8VUri4RDQCYbv0sF5scvzOjikG6IgBpN74I5imYjCrpGbUSzsPub7DTX96t+maLgEb9ErMbgt4aSbuxCfiIxNE/x0uZUzeWhqtGBvhVHsLzA5eK5lNoVEBayxcKuDSTaVfZ1xwlU3EYE5v6DLo1nB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227054; c=relaxed/simple;
	bh=PKB3m4nK+ILwHmYetjGfqnYTVyWEfD18Vx8H5tWnL5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/TEXnz6KWu3eqBGGLGWYTtiOXjXyJcY5VGlsxr2XQnt7TnqS6md4V+Emwz09cpJncwUdeF35mqMV0+xzV9v8uMYu6zNKkjxsmGQbVEJPiWZ3w7A2ecRPDs4Ku/ABIzDJyIlRTbCfGtKNvR2rFD/Z5HzSgbrx7aw8VK5EmMgY6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFLscU2q; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFLscU2q"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37d826e9811so18860a91.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227051; cv=none;
        d=google.com; s=arc-20240605;
        b=jG1oE8ApSngFs7mBcPJuI/EX9AAgtzgsojNFdeIE3K69egadSJYuL7poO+BnjJB+jW
         KKCdpNuaJgNCWLJpt2DTWtn5b575AVvnL385BQj4aQlvyCu/sufe3SRDAOwqOG5F7Eqe
         NtCb3kVN3SXn2w3kMXjbb1OeWs8dhZayw5zQvHDtc+o41TgZz2XpI6S8etiBP2jK0SVy
         WNkSfFhA7hkVMq+QloeEUUtlNKpgY6F6WA2PHiRGfLiJMzmjOKCOgclSSvs7d2gR3xDg
         99LS49I4eGcI95wai0gAAjdO3vhvKyRzBc7LvT5JfOpXrS/MhpTq8tniccQpNLqCZTpJ
         klmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Eqh1N3kt0B+tTpeTozPE/zjNfrWcpRUjqm3GYwWaCY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=JRVt7yIIBu3hqt8f80K9I3uYYSoI4gTe68PJQzs/k44GrkYgBRqRifYD3mPgKFYuqR
         n1lXKfZkaFNdIDZ+Wc36jh3Anv4FhI/IistHqcsllLcutJ7Z/7+pmua0eTictC5PrVCk
         nmeAnCtfUwfg/9c8cpKs7d86G1LYRorj9WlMro/gcYj41EFi6WA55ukhXJG0fA/w+AVQ
         3wanhrPG6I1KRarsaEMV2WdjIG58BfJncVFCH0vQcldBOagxdLjf3biXgPQIm3dZTr/0
         Op4bzR0xu5B1PrxOF/b9ae6Msn1JdAFAj0TbU7AT0igQktA97aKzzQpk6st6qYsk/tFe
         Oh0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227051; x=1782831851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Eqh1N3kt0B+tTpeTozPE/zjNfrWcpRUjqm3GYwWaCY=;
        b=aFLscU2qFF3Jagfx+LQmkJkODSLOiRPBAQ6N6IAoL0m0uXv2N1aqiaVM2ZSciYmqz6
         t4eThz5YSY3ZCyJ9hYFYElxzywpxefAQ/SM1hZN8PAWIPlaPTewIucsNXNT7DKzgQhCl
         zsPMbtKk+Tas7BJM3MPtZrLCE6kSIcCuADoFI4DaIw2hCZfqBzeCYFjnsgR1z7DfcpH6
         U7XkEE7rcK/6m1XDAfqJPPP+pxgl+sgen+iYy2SF4aiuL0guRd2LpLLYnR4GB7gEaGff
         c1vTYLkaMOmDBMnNTQOyK6Nc1c3psPUtOixuBMPkFhVHpI2DwY74CrZgAh0UJlF9I3LC
         UllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227051; x=1782831851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Eqh1N3kt0B+tTpeTozPE/zjNfrWcpRUjqm3GYwWaCY=;
        b=UsjYCiR7SFAxG1ZFLftF51+Ni7PgqCuISID7jbPHGZPcEJGrbkq0rt9vpyym7KmG/L
         xpR99jySjJoKQ2Glai8cNMStgzJho108mlJc82tR9Q7k/1PjBwKM7XtfyhpOrFo7uAKG
         WJy3B1E03HSG5HSYjxbCs+hFUrB1avvIfCAdlTR3mYWitKmnwy88DJGGSWmrr3mOVsIH
         T4EozoOM2ICJlPSUBu7TquSd4dpBkSj0XruoZREtSAdJNGtbudGIZ0O8DH8f21wg9n/O
         oQzsPhOZPgrwcXDj5xCPxOLQ6Nbq9oTrQyz9fZAPcMJXeAyRl7w/cIaGMWhgD3J8yuGq
         ms0g==
X-Gm-Message-State: AOJu0YxegVHSE7mnXE4j2QrDwMLJ1bP42bDfJeEIgHCHA8axZKq2JbcM
	d053sxRvoFhDoq1y/+4dpzvhu1/e4mZw5PSqlall1tTyrBnrb35DpnxDh/vHr/4uNHxSNEvJtQc
	49339a72i1HkrVVDOP59+v/RQuTqxsr8=
X-Gm-Gg: AfdE7cm9belA/iiwGd63eDBGGuPLL15EwsgCjiDks9NykjIzxrNgFptaGqMvHRu/Jmh
	dTZ/7RugNgu1HaxIdFNJkNQ7uuJjEBBDN+dA2QtVS1gWfis0sypznlZkkfCPd8/qaBQo+9EJLDS
	C9MnXgwfufbk7bXxbQLlz+AWQjN6Gn6PJBPREEpJRgOCQeW4m0Faj3Kxaq8qOFO1ovXu/xm11F8
	cg0MwVAzEz5xsiOBYVOUScfg3ejXDEPhEYN6G/wBuZ5oWCo7l+0UFt1wch8fONWUIY6d49l
X-Received: by 2002:a17:90b:4d0a:b0:37d:8426:40de with SMTP id
 98e67ed59e1d1-37dd16b58abmr3001678a91.1.1782227050773; Tue, 23 Jun 2026
 08:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:03:59 -0400
X-Gm-Features: AVVi8CdewAR4HMyQwxTH-rAjFkHxs1tpTNmToW3Loxd1a0JL1wCQ2_jAEYIoeDw
Message-ID: <CAEjxPJ58coU5x3+FqsGY3wnt+43d17j06vzdSabf2UZKrUhqpw@mail.gmail.com>
Subject: Re: [PATCH 07/24] libselinux: free resources on avc_init_internal failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The single "out" label returned the error code without releasing what
> had already been set up, so a failed security_getenforce() or
> selinux_status_open() (and the earlier allocation failures) leaked the
> audit buffer, the SID table, the freelist nodes and both locks. Replace
> it with cascading cleanup labels that unwind only what was allocated.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/avc.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index d6556bc9..ae988729 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -175,7 +175,7 @@ static int avc_init_internal(const char *prefix,
>         if (rc) {
>                 avc_log(SELINUX_ERROR, "%s:  unable to initialize SID tab=
le\n",
>                         avc_prefix);
> -               goto out;
> +               goto err_locks;
>         }
>
>         avc_audit_buf =3D (char *)avc_malloc(AVC_AUDIT_BUFSIZE);
> @@ -183,7 +183,7 @@ static int avc_init_internal(const char *prefix,
>                 avc_log(SELINUX_ERROR, "%s:  unable to allocate audit buf=
fer\n",
>                         avc_prefix);
>                 rc =3D -1;
> -               goto out;
> +               goto err_sidtab;
>         }
>
>         for (i =3D 0; i < AVC_CACHE_MAXNODES; i++) {
> @@ -205,7 +205,7 @@ static int avc_init_internal(const char *prefix,
>                         avc_log(SELINUX_ERROR,
>                                 "%s:  could not determine enforcing mode:=
 %m\n",
>                                 avc_prefix);
> -                       goto out;
> +                       goto err_audit_buf;
>                 }
>                 avc_enforcing =3D rc;
>         }
> @@ -215,10 +215,24 @@ static int avc_init_internal(const char *prefix,
>                 avc_log(SELINUX_ERROR,
>                         "%s: could not open selinux status page: %d (%m)\=
n",
>                         avc_prefix, errno);
> -               goto out;
> +               goto err_audit_buf;
>         }
>         avc_running =3D 1;
> -out:
> +       return rc;
> +
> +err_audit_buf:
> +       while (avc_node_freelist) {
> +               new =3D avc_node_freelist;
> +               avc_node_freelist =3D new->next;
> +               avc_free(new);
> +       }
> +       avc_free(avc_audit_buf);
> +       avc_audit_buf =3D NULL;
> +err_sidtab:
> +       sidtab_destroy(&avc_sidtab);
> +err_locks:
> +       avc_free_lock(avc_lock);
> +       avc_free_lock(avc_log_lock);

Let's NULL avc_lock and avc_log_lock after freeing just to be safe
against future misuse.

>         return rc;
>  }
>
> --
> 2.53.0
>
>
