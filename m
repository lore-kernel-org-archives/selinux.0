Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD93DD86F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356648; cv=pass; b=DLJZ0PBPaOznQj/LolEGViuzgG+HcoiUubDkeoe0l+EKXlxQI046Q/y7AMk6EX9rmlnCz33O4w0hphqF1wLv2g/gJaxLccHCUNeY6HWa0FjOD/QItymTv7ex2JsrhLtmKtbD0IjipLgddkuL4a+tNiRIham18tjvWiX4iwNKQFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356648; c=relaxed/simple;
	bh=jzl3701BxbyLEZNQBXjKpyOzgwLCKkrgTD2roSfUOP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQDkISNF+viTr2o1eHRSw4qCOax2P/6kok/iR9e8Xc4I6zytjVDf5y9xB6wgT9d35uUIVqixa4PV47hQeJNfsvmW9z3o/kBc50fPPcDVeUbKqiGPiZa1FNLJRSnPVx/vXpAK5P1IDE8vtSaREXsMZtdawEjcrFDfFma0kZc/1wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBZvLyIb; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBZvLyIb"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-456395f4e7bso1044984fac.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785356642; cv=none;
        d=google.com; s=arc-20260327;
        b=lkuZqhklCa9RdVVDNuuMgM2trqh2Hgdp0nh2mZvFu4u3HYN3Rm5HXLCHLu4ucNAr46
         ocM8FHPnjDfUIsGMJUFvIzB9bcSesLMLZFq/q2rGInaE/h7+szUm7vcDkGEDK9OQExFP
         jTLcYc3Pr91rKXKD6G7y2us8b5tvq3jlVR54OOBPN9dWLiKeZWrZkJqP9H4JSZz4u7U1
         hZbO6dZVAdL5ZX0wFXGScKzO3VdvqevzyEK3+qChZkv//pLMlv5tvWmclGb8fGzkX47s
         RjLo3+zn2wo4t/+XySQhCLijiZaFLyNHWR7u3VQUoLFUk/NkhZpULwAepYic/lur1+hL
         ygJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jzl3701BxbyLEZNQBXjKpyOzgwLCKkrgTD2roSfUOP4=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=jS9GHreaC9SzkSmqxR2WBy7kBZfcx38ggPJDsLkdhv1i/Bt73Jdjn17gpwrNLJbI64
         QaLESdzK5ULKcTr7LS5Iys6aFVqxUl2eFMW3pi0m+ZW7atGAbKT2WhDE7q50V0RT9M9d
         PjwowpdzaVq+OLpN6H8L40LxuJrRmwJqtmjT+iWDRtn0mjXoqTryqqyUEJ+110U9pHk8
         T4rOnLRKy5xOTGw7fjMqJlLkMUyk8tVW8VrNMEcta2fJ6n3CHQ2+vq3lKk0OPk3miGHd
         eitWBhAGZ/HssjpTuCV0NRwn9oaCo1cvbpTt8Nd+m0R6xtjSYoAKLyo2MSuHQEEOzekx
         3HCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356642; x=1785961442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jzl3701BxbyLEZNQBXjKpyOzgwLCKkrgTD2roSfUOP4=;
        b=HBZvLyIbZjA/nOqwVdWi342Zxv7c0t5FY5GiOdgJ0D0fdgg9lUpTu6Yl7RcN6qYhmP
         tJux37lWP/Qhd0sDW9cOoT0sxSUmfb3NZbC/qSKVnBWJm9XWiCE/hRoTAvqEPNyUWAqn
         EIuekNn8gpZKTsLbTzl0k4nOaLvBZpseAyYuPVN1tit5p3/vgeN9jl9OnQM2ovsVzzqJ
         F6KvFOah8o2aHbY+HC6H4EeWmuyMgsVg+DehA6gz0Jr//6b/bqHfxncdrSL6+1vU31Zk
         L1E9i4GQTzwTDt5VqP3zpKuLha38cbiAUxP8GSpWTcO/HppPll5cOm3TaQaEvVFTWVk8
         1Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356642; x=1785961442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzl3701BxbyLEZNQBXjKpyOzgwLCKkrgTD2roSfUOP4=;
        b=ALdMtS98Y2CESWaX3ST01Sx3QHdfSn4y8EAZpQyG7WuYiZQRRaBoywmdy3EWx34M1j
         V4NxsF1f2tuXGBk71YQgco4v4xlDH3DlAIboRSfPcu3sLNwkM6kvIsTBY1jxET+nCs7N
         4/1PbfLmGvlAdtWNDl9is8eEyDvJhOJWktyGe7OIgnogx+89Cw1Q6VCrlIIZ3Fcifxwi
         6Nx0qAyP7+p7JnV3H/D0KcAl0Qn4s5o2/CHAMUgrUNeRw38skMBhY9IXc9SQlcglAgMl
         o3Ax/n439bDQPquzzQMqzPiDBV63/q2CnocgeRO+zTriNrtO3UoSUIR9PC8VxzsyqE+9
         NIlQ==
X-Gm-Message-State: AOJu0Yww6owqGeQhAiqidmYcFXjEDLKqP170rhlEPpH13GJF+9vCAnOi
	F3yaXMeCTh2t5sHQBryb4R9TJ0PePVFGygMxFQIqeV4n+dsxmn379RzUNiE5aFw2grnKVnvZuuZ
	JVPxY+vOr0fHsneYCL73WpOngTFmfgmCYfQ==
X-Gm-Gg: AR+sD11tGI/NciCjOVoQKiODHfGvD+gFFbMZtz9AFo5npzlxO8q6oxV5ErvXEgUVOd4
	D5DjiXvDJ9qKrSGF6qOrdflqn5YfITWK7FXB6qJBefUJhZybQCZFugznDeNKy579mkj6VpIOxHa
	pFKcbMOPr6nE5qykUTW/L4vvW1R0fIExew/5g5SAc+MJkeihzdjHGdddelHAQC7N7XNjzdn8iJD
	vNL1X4wtg3zet4WewhtgPM2+vvYPx5tQpmIQmtycEKA6vVY2LHX9N/FHBrFpBc+utHdYczgt4cL
	CGYYRQVN8izm1SqCyXdtZPoomfXPitSWhgwJzUtwzq5b
X-Received: by 2002:a05:6870:b4a1:b0:448:ac35:605f with SMTP id
 586e51a60fabf-458bc1df2e3mr169433fac.7.1785356641868; Wed, 29 Jul 2026
 13:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729154323.14694-1-jwcart2@gmail.com> <CAEjxPJ4H1z2EZWN2hp3E0ff7HMQZRvpgRfE8yNgFkdpeM4A2Bw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4H1z2EZWN2hp3E0ff7HMQZRvpgRfE8yNgFkdpeM4A2Bw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:23:51 -0400
X-Gm-Features: AUfX_mzZ6jywrONs-0CV9naLgTJ7tbjBCc3I_rX_Yd0lI1wFGzTS4l_py3D2n_Y
Message-ID: <CAEjxPJ4DzDD65qb485L29v_eZRi6YZLR-oB8TPQMRrzfpZYfcA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for invalid categories when expanding
 semantic levels
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 29, 2026 at 11:43=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > The function mls_semantic_level_expand() is used before the policy
> > has been validated. A maliciously crafted policy might have gaps in
> > the categories, so a check must be done to verify that the categories
> > referred to actually exist.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
