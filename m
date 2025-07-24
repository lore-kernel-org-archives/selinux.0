Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46854723;
	Thu, 24 Jul 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383741; cv=none; b=SHX7sYWHBt5hhdMtWyMWIAxM2tB2NDEn0iA7V/OoKURvw8xUSH2EhRYRi2Jlh8rVPMDNPtaBGRf5phxpHLpYwU+Uou4LyKxiBZVmpcs/vsGPnbP9R75MgdWtCTOmC1CFzSMooeJRMIdJ2ngdzeeUFF12jkeyYi8R+aSxVtebadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383741; c=relaxed/simple;
	bh=Ki4/Gr24owF0A82pGIclAhrm3tUXRFh0LjrgcfEMEGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAQUeFK72j7S0xn8nXELB/NaYzpjjNjsa1EXZ5KA6P/Zf9woLx7L+kykUseNUgBFiABnQSwYYYhCUle6sEcJiC3dpOkD1qctmKnvabLRxIlWVlGWVCQQeSYFLh0/wwyIup2rf+UfATN7bK+TllyMG/gLAsm8ZIrwMjUL9X76dIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcgaR1Oz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcgaR1Oz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b391ca6146eso1242413a12.3;
        Thu, 24 Jul 2025 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753383739; x=1753988539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fkz91VXcfgq3iozVOkIDXIOnPY5WxbCgqpgDGeRz9L0=;
        b=KcgaR1OzuxuZD8J5xWXwlAW8dnu2SOjQTqPHlJlQTX1OAQ0NPsvEqL1fYVBVTpWHNa
         J63qAmijW+zdwghDV+P8k6Oay5ZxYNHe1PeUIYmpXeRN6LiT2K8NXRCIB5cF31EKGZhX
         /E29aFL1z022kpMepIoQgafm2mVTZxJTRmMxGkjmTTJbjiu5hZSd1XVk3cv8VLNBB51f
         GikAwhqtoac4H5qd8iYdlmGqry2TZqxZC+O9oZ/tRGecspfhYez3P5OqcsbQTfq7fNrR
         y0GojzZ3505zJ6JEzUqPTm4GGdC+srma7SAdT/p8iEZVC8YCvKrQ7vBQHc1aIF+CYHhk
         lZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383739; x=1753988539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fkz91VXcfgq3iozVOkIDXIOnPY5WxbCgqpgDGeRz9L0=;
        b=vBwMB5DPeX6FwRDfEjyqtU30i5POPPVVi2qS4WrfErdQ1Xg5/yeD0uwdC4gfoqPj8j
         NaMjuUTCU/SaSOYfWWyhr5CJXuwBqQA9iLs0VOFN4r43amHRQ8gCKiXTx9YDTKU1Xm95
         bJKZVcfapUnPWSpJHfOkhxSb6zBxL3PDSAqY8kguOI0QtW4urL0x3X6EgNAZhi+9nUFl
         4uJzDJvPjGxylp8834pDvStUazZjUTKpOItpZRIdfI1VgyOPNhSpV8V6n2ydWm8sKP7Z
         i4rseO/N/K77B67AgOf6dfbvc9bniXaXm5Z7zHKLa/LFhLf+zWF7Sc7hBT2yycd9nd9F
         t0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvNEKfWYBZvFYpteGagxSU78MMsfESU1wPAcj907wGZSp5qHLjTce92kAC3SdOB26ucbHBBdreuS9Px3Q=@vger.kernel.org, AJvYcCXvizShC3YBWVld378vwLz6Uga/U3i/eT2XUdtKchh0iXT3qsMKmqX+CfKcWBMrrMTE6zBMEaBFoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcpSIFzsxz5DPjq5i/lRfhtYLpDpibZguv7qZWw50njzvxPYj
	lYF7uvF7hM7SrvyDUd9ndNU84HTOF3GNM4vQTWxD4enVYBGOqxtb5/qthyPc/D0pBtZe4Gy3yfJ
	JA/5Utfn3rbikiw1qAVoVwPvo4m+ZYwg=
X-Gm-Gg: ASbGncuUeA8LVXNHZk37PUnz4X35hdAfnqv56QQoj1YQJ6k6m5PJXoH0Ni5ZEKuyWEg
	DBGrPvpYrA2KF22dHcwBtpyI5CgsU607hIgR7m7LljgIPOAgSiHv7skTmTDUO4Nzcrwxyae/knp
	pKHg046k5nkFzTJe8FogZCxLok/LToJw0JGEkfTaNfFQet6oZkBRZsLgVgOLlKpJgatwteVUK1V
	GKgNio=
X-Google-Smtp-Source: AGHT+IFoMiKInwdd0hg3JJY73V0h+BUGXvs3ggHqv1k4lBkmnZcirbT0I6avok3Q2v80VWFW4l87r6UFEv7qPL0xDHs=
X-Received: by 2002:a17:90b:2705:b0:311:ad7f:329c with SMTP id
 98e67ed59e1d1-31e50816984mr12076486a91.18.1753383738711; Thu, 24 Jul 2025
 12:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723122304.911130-1-yuehaibing@huawei.com>
In-Reply-To: <20250723122304.911130-1-yuehaibing@huawei.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 15:02:06 -0400
X-Gm-Features: Ac12FXwr7U-uq5EVY40dkslJtrESW-f8aks9sZ5QU3dckRi2BiBs8NfQUVoeWTE
Message-ID: <CAEjxPJ4En_8wu8GP8kM+JOGUsC=oPuh7-TmVjLaN3TcQRAdz1A@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Remove unused function selinux_policycap_netif_wildcard()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 8:01=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> This is unused since commit a3d3043ef24a ("selinux: get netif_wildcard
> policycap from policy instead of cache").
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/include/security.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 8201e6a3ac0f..7f19972f7922 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -203,12 +203,6 @@ static inline bool selinux_policycap_netlink_xperm(v=
oid)
>                 selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
>  }
>
> -static inline bool selinux_policycap_netif_wildcard(void)
> -{
> -       return READ_ONCE(
> -               selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
> -}
> -
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> --
> 2.34.1
>
