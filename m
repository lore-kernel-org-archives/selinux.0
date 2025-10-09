Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAF1E9B3D
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024361; cv=none; b=p9CqWKREHnV6IPgcLS3pSCivz1ttqa/JEUkBhEiVwGGS/CaHn9orSzLKM3GMaV4DQfsIcMLc8w56o1mPBNFgD8dKMTW2zV7f8DX3g5khK/q1QIXiXeEv8VAOlXGx7uzp9DKxq/wZQpDSw1Dk/gsj5I6FhmY6FBp56EtU7d6pOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024361; c=relaxed/simple;
	bh=aMUbGNwMIdznzmFs7SqyN0AHPxBP2LpXKm4AotuI1cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEgIB9YJ+530NkgibCfmf2Exb2tV4WXC+SXC+6xeh6cUGcJWpt1jsbSQwbj8RnG2s6m4axBR/L0plAj73cmOptOTjUyIviyZU4nenrsK3Wb3o9rbHFuHlh3pew78IlGAg8dnWHxJi+OoObWaL9cN966tlL/AR4dTIrZrGSGirYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzQXZu7k; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzQXZu7k"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so1190861a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024359; x=1760629159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OTy1cXXmwwyURJiSGGJQygGG4kBEC9K/nDUcdZzUkY=;
        b=fzQXZu7kQ27CMLJgxXcrNpAWC/NQ7JRF68TFaXHcT+wrDCkNWMU+nWZGpzZP6hyMLm
         mQa/IFpx73uHXIW4Mk5X1Eu25bWDz15sxnXden9uMLs2uV9jcthRr2g3viHsyZ2Rg30/
         90Bw1ZTmd17JQUpJ8T1oDr2a3Nw6wIaoYProziR+RvBk13F7GbzdTu583r46gWITGA3q
         eeic+i3rBA+W9nNr0h62pbRa7Z5Zgjw2d+tIrgwMZUqxCzPZKfAb6jKXJfGBzBWb9DGA
         Q11/yRKeA7d01wnRbaRiK1qU5hJRbNkPux2OvjcNgVdAaES0P0CLzPQNbuvRZNvbkFxh
         /Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024359; x=1760629159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OTy1cXXmwwyURJiSGGJQygGG4kBEC9K/nDUcdZzUkY=;
        b=kOAP/7lsKBI+OxvnrVnmtH51s2Bw5lkVxXyatYpEXEz4ckHikOn2cRjM5czYZ96g3Z
         OAhZvl9G8k5Z147GNQM2z7nIpINyjemVuTAC7/S6wwi8XvbxYGBBPsC9T5YM2c0v49Me
         epUbuUozKkeZdM5WPTr885fMkU6F9YqpRDs0VDpbuX2tlTTW14M6uluIGk7hCdUd6Hc3
         tdED0zSSYGLbBIIijIxHsT3PHMZXoTnmoJRZtgSDON3+xhujdIpcW63V8Awi5Y75o1Z3
         toYu34i7m424hkxmFYEq48z/MbXExLnmE0K/IKN2fx+kTFIYzCLgs+Qep2GuyENQib2T
         FkRg==
X-Gm-Message-State: AOJu0Yz9cAEJOmehyfg5ul/ugVfDIECSKqQedDrVd+SqVpqmOf3zJU0f
	ePODntrFihEJ6kLRtRUwnJ8FJDQ9CCwZtXE0bNRGvqAnlMF4C2Ft+sWZhHiF/RTiK8JXTANRtXc
	6minDbl98ZseSXRr9NErxmnJL3j1UogE=
X-Gm-Gg: ASbGncsSxq9wI/kh3SmRnvl6tUMtupM/Gn1w8jU/gcldqkLz39u+C2iouSrQBDNdRfE
	AtvYM2oVwRWgFGx2zwIJd5aiRMTM2nXsQNW5q/8KvL4/AAbv6X4kf+sc7Wyd+sKj2ja/4MRDXg7
	qkM2lcgtD8n7KRxkEc0YwJgWW2LU5t5yKaGMQyLUlmYeFRQSfNJ/rFtvg0cXwRY6GO5r8J6cKlw
	A/VtBpy5Si1t0npCx5BmEXjQC0QTWQ=
X-Google-Smtp-Source: AGHT+IE2H6lhSRxCMADJa3hz+hLDURP3uWo1AtWOe4+4ODIgD2NoG+TTJYUJMsdPS8Fkj8jv+JXFCVs2yuUQPl7UWNY=
X-Received: by 2002:a17:90b:3e82:b0:32e:64ca:e84e with SMTP id
 98e67ed59e1d1-33b51149d92mr11055812a91.15.1760024358846; Thu, 09 Oct 2025
 08:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008233305.2098-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251008233305.2098-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 11:39:07 -0400
X-Gm-Features: AS18NWBxDx_eYbvwJDUdOgqgmntwK0OcBxujRk55a0Hl6fs1U2xdNfMZjPF-8lo
Message-ID: <CAEjxPJ6mnmC8YZ5+O=WzdTEZdKUKS5FcZnLbsJdbEu4EOxEc1g@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: add bpf_token_perms polcap
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:33=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.co=
m> wrote:
>
> New policy capability 'bpf_token_perms' required by patch to support SELi=
nux
> for BPF token control:
>   https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.micr=
osoft.com/
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>

Will wait to merge until after the kernel patch is merged.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes in v2:
> - Rebase to the latest changes
>
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include=
/sepol/policydb/polcaps.h
> index 5a3fbdb4..ef529e76 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -21,6 +21,7 @@ enum {
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>         POLICYDB_CAP_FUNCTIONFS_SECLABEL,
>         POLICYDB_CAP_MEMFD_CLASS,
> +       POLICYDB_CAP_BPF_TOKEN_PERMS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 526f35ed..31b52d70 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -20,6 +20,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_seclab=
el_wildcard",
>         [POLICYDB_CAP_FUNCTIONFS_SECLABEL]              =3D "functionfs_s=
eclabel",
>         [POLICYDB_CAP_MEMFD_CLASS]                      =3D "memfd_class"=
,
> +       [POLICYDB_CAP_BPF_TOKEN_PERMS]                  =3D "bpf_token_pe=
rms",
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.50.1
>
>
