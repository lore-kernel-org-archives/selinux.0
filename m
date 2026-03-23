Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABF3D891C
	for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294315; cv=pass; b=E7WLjQYiKrRlAjfRRvoCbXYe0q/9cJuY3T3dnMAqTJlWHD5jOQZasUIuKQz4CzlN8Okdn5zEZ5L58EPbJSGjsvKHrcmLSzCGBAUxHs9gQZAAIye5lWiXOZibCfxQbQvwE98b4BaB4mUPO49ZlV2Hq9aRIyejRjhfpbV5pxkjCDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294315; c=relaxed/simple;
	bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhjhRN9jBmKR6cV8p1OwmOLSzLf+UhQCpevzAcznAvqcmKGXLuCKJj6yYFRFLjaB5pGLFurTEYggrc/LLs7nj7YGmCKSDGce/A/dKXHkQEtlNj6rKJL8qa0rmsoGPSNACuEQmWmkFw2L/PZFZNleUOZmSfNrWPzH5l66sUgSV/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dau72Gt3; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dau72Gt3"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 62NHGsrW612308
	for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=; b=dau72Gt3dvQN
	Jbl5OSdTRlLie7gsjtUOOGmFwPdNDx2OdKuFIEHt8cZz0kC//nK7765yvsXTEi5l
	tpAHkjjgzsZKqXlOzQVJRY6FG+Qw2rdPOXZ+dZcwhQlI68qFAS3dmH1GKyLm0I4j
	TrfOtFZgU4WHizGxN+QnfN60+hdV58LEK7ei3jrXaADUY+5MxzwOupKP52n3IBzy
	dnWRPzWGgUCw8OWMRHWFHvqb1R2HIL6IrXdaBfkvvASEXPxUTHQPbY5vKkvlrpWB
	vQHjyWNNttoIT+uPLz71hulmTcfnNhKnW/7afG5Dk8LCfa1w4UdrwIfYWQRyMv0J
	t3A9GTFdrg==
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	by m0089730.ppops.net (PPS) with ESMTPS id 4d39bc2s86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700 (PDT)
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38b05f4c330so17185901fa.3
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294310; cv=none;
        d=google.com; s=arc-20240605;
        b=KUgJ9HVsyReuVirWMmDU5IIYTN0yK0X5DHv/Z/04KomBNWEWsajW3o8sN+Yu5dCJpM
         Q/knfpsBPBMNC8H54h9bMcMYjWUglcLFsLw4iuQoMhg7kxfIXRJyoVfB/rhOGMt1zk07
         CP3B4/O8cyk1yZgTLS7uOshQEwxMOSndPSdRd7+LUd5X7P/RqklkCEkADOPSorQHYzjm
         b2upU/m3WKLXjWEiuu7Zp8+mleX4pcw6AwqXQ1YbvmvyP0HeSATD03g0aJt6TsksvOYq
         OmaSzMmZ2CzxDxFO7WGwA7wmlEQz0mVKmKcFgFDrXVovhMk7do7OBJw8fYvtJQgc79/P
         DNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
        fh=5vypxYtQFLAOI5pIeqrmNRI7PoRCBbuJ0DCaf0YtxWQ=;
        b=ajFbc1F/KEGB2sqig6j2NZpTuhcvoXk4Y1cd4wTGtgd4qMXW91DwoVNlfpw5rzDZF0
         B6piOyceBTokpzCp+QGknYSpSiuAHlJ9Vgn10kwX3TRBtD7HLXMBF/1pRMBIEUXJuMiI
         EeT0KR7OmqUdqIqYRq09qu4cdyiIkNnXqTaymqbMomdYrW1zozEnU1F8F7KinifHZAx6
         nRH1s2JBivUhYLHttfqlkLDkZYOlaFYq7ioLlHV29SJqPixxDC/joPerkB5pcVbeNz1J
         L86HO1r0Q92IRxbCha/Z8aEspcBX/BH7YzuYgPzCwJm7aG2kOrKV4iXtCBzf4voxYLwJ
         zvug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294310; x=1774899110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
        b=pU5rO9cVd/G1cmHWTD2UTbSYahqPZ90pPBIxa0SwI653Hlhok1wbGpd44sHrcXFoZ9
         sz28EmOTw2BRlXhiCVVn1tX9k1vmlNuKq0I5BxcbOMZfmgvCKTrF/u6Y/qK2L2pO8aqG
         wAqvo9MW+ktIbsQy1sD9ZdKbsFZr0T2DRK65nqzQO2Z+v3O/27khZTpu3tU3shG/Zusj
         7sA1V0PMDKI83qAEt3IqTcl6mZeX37brAGfOobbiSxn/YwZTUAfiRj8EhRIIEq7mAzU2
         PL2iMwjNQKATFqTeTz2SUHa0ykPPwFxv330oP6l4TE8GIaOIrOZMc0C2C2hQz7LuRjP0
         6qgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ36XcVPYuF1j+NN8ccGmotUNmkO4i5pVwYlE1A7zl23Fdy8h6x42ftwucHrRsGo10+iDZmgXO@vger.kernel.org
X-Gm-Message-State: AOJu0YxmauSlZI4qdWlOMOVR5LYClR28XCjafEyUm+VwtwPYCfKUMSwx
	UND5SJ4FxmbEKFL3M+SaeQMymAn4NOOMlj0WUWYLhPoyIxQ2Y4FF5x9L2OhAFa2oIFli2Nl8kDA
	YfJsmGaI+nep+HkwgAXj9b1BncXCi30M42s1YysvFLkBBDovqBa31eyXbghEv/xEeRXHL3M9e6e
	/jFmfTRu2CqVSsVVw+NCNMY2c6O7ETQRxM
X-Gm-Gg: ATEYQzx81RpTV9+s0D8emDD0W0rBaxfboazVbUUtny7obstznFM3UsfoMFD8p/syxOs
	EMD+KYNQb3HhX4phfO7yjT5FhKjsgv/pqqt0DVtAZ8o8TQLSiLUh0uMuFYNVXSmNk+3/RIi4IeK
	Vz1W/i4/vz+nBLILQOUFjjQ/HpWwqy3R3aqEqEN9sIOgMm0ewoh5sHzfKCUFSexga84w/gxOsY3
	A3eaZqqJF9/xnJRU33n4g==
X-Received: by 2002:a05:651c:418e:b0:387:1ba5:99bd with SMTP id 38308e7fff4ca-38bf972b0e5mr41075471fa.27.1774294309952;
        Mon, 23 Mar 2026 12:31:49 -0700 (PDT)
X-Received: by 2002:a05:651c:418e:b0:387:1ba5:99bd with SMTP id
 38308e7fff4ca-38bf972b0e5mr41075301fa.27.1774294309455; Mon, 23 Mar 2026
 12:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
 <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com> <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
 <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com> <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
 <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
In-Reply-To: <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
From: Song Liu <songliubraving@meta.com>
Date: Mon, 23 Mar 2026 12:31:38 -0700
X-Gm-Features: AQROBzBKFBxWkFKdSZb6aDqln1iqdiuNWYNqj8Bk3Aj5pcgV1TsyMg6HDo5_J7A
Message-ID: <CAAeYb7k+TWArOKyOomkLZ8fwqUPjha9iORpJaj4nMyN=o4ZRQg@mail.gmail.com>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Song Liu <song@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>, "jack@suse.cz" <jack@suse.cz>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com" <omosnace@redhat.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "herton@canonical.com" <herton@canonical.com>,
        Kernel Team <kernel-team@meta.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: NP8sV37jqPkSeceBExGgSUq6tmpVbngm
X-Proofpoint-ORIG-GUID: NP8sV37jqPkSeceBExGgSUq6tmpVbngm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NCBTYWx0ZWRfX7MiHF7TygfdM
 Ect12zx1DdqF72xvMgQWIHCY+a6zxNLLb/7UKTvKX1jJezoFZWOGj/cRBecnv4gB1t2GzVcskKM
 4bq+jiDV7wxCiN7YY0aQ36IbVJJIWPnysn7U8sQz1tzTAgnHmGV/sDcKHo4hXQmG4PnaaObeat5
 NHF36PgQ1qu7AsGaJVqWnhFTtPpGdmver5zGK+zEWb8KSil5M/8Yf6H7inOVgXQ11WxJ2TcdWAl
 EVuuFVVyxKGbqXKwE/0R8BbeBpvwSNXNAe4bLtnpzoKxxh25ac/u2chG4PsQJwtpqAv8d4SPDJw
 943sw5nSOuWvJiPMRIOsuUKncxXnFRzRS8veZPadluBc3Y9+3C3LsSIjCdNYnzHZWnu6R69IWgp
 eCqUBqnKarwFWpJLc3z4RYsG53EJjoOtkvO5nkQVGewCGfQtCXpRSdV8e2/x+tErS5s4ebxW7bl
 zmtkdG31ksn8eIEYlGw==
X-Authority-Analysis: v=2.4 cv=Y4z1cxeN c=1 sm=1 tr=0 ts=69c19527 cx=c_pps
 a=/zUzjrEyDQOchHorqPmRvg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=BqB2_f_Oa2Tj43kevx4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01

On Mon, Mar 23, 2026 at 3:33=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/03/23 19:16, Christian Brauner wrote:
> >>> Since not all filesystems need to resolve dev_name argument, conversi=
on from dev_name
> >>> to "struct path" is up to individual filesystem. If we can use a flag=
 like FS_REQUIRES_DEV
> >>> that tells whether that filesystem will resolve dev_name argument, I =
think we can resolve
> >>> the dev_name argument before security_mount_new() is called (and can =
avoid TOCTOU).
> >>
>
> I was expecting that "struct file_system_type"->fs_flags containing FS_RE=
QUIRES_DEV
> is a sign that the dev_name argument is a pathname. But it seems that suc=
h assumption
> no longer holds true. For example, cramfs started treating dev_name like =
"mtd$num"
> as if /dev/mtdblock$num since 4.15. So, current TOMOYO logic causes mount=
 request of
> cramfs with dev_name like "mtd0" to fail.
>
> >> I guess we can add dev_path to fs_context?
> >
> > No, when and how the path is resolved is entirely up to the individual
> > filesystem and we're not hoisting the block-based specific path lookup
> > up into the VFS while leaving the other stuff per-filesystem. And it's
> > not as trivial as you want it to be either.
>
> Then, how can LSM modules know that how the requested filesystem resolves
> the dev_name argument, without embedding filesystem specific resolution
> logic into individual LSM module?

IIUC, if an LSM cares about the dev_name of a new mount, it will have to lo=
ok
into each individual filesystem. We can add a LSM hook for the filesystems =
to
call. But this will require changes to individual filesystem code. OTOH,
dev_name can probably bridge the gap as we change filesystems.

Would this work?

Thanks,
Song
