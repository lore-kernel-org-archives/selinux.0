Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE295226B8
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761813; cv=pass; b=lVs4GYhePFSXYQ2XYeFdH8Cs26eub4S7bY7lwzAIm4ox9JwAPvOKjhA6bxRs/qKfPiujRPGCOTz1mfS+EJlIjklRCxSvLxkJslj+mX9YJuHnRZhqpA6cYVoDeS9Ozd+AxJAxEOjECIXldRj3NrQ6xw2IDVV1YivgpPtA4cwFXqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761813; c=relaxed/simple;
	bh=4uENM0GPWR0waMAnNIjQqLjVo6flbWlAfFqICbybo+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb6xpvvYr/NJvhgV2B0snGbKRlqDsrOVBnrl78RrD/hZPO9c7Wo6levgGBNj0GCRjEvkeQVljEegiRbl1PGTHjcSM0HMUh6Z2+Li8aglrU9l8fQxTnGhbWJtUOayk/hh0Lst1vkYXdL9gCgyZiRPPwgrsZleaejWR12r/w1tfgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS+xYeHd; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS+xYeHd"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46a63c34533so1293233fac.1
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 13:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789761808; cv=none;
        d=google.com; s=arc-20260327;
        b=c1fxeftMbB/yOU0sIBDUHg6Zry2ucbuNSUKBXjMQwwganVPdVV+hs+Urdg08DBtLwQ
         Xd9/LFvCgFjdjva9wPvZgnBr+tuKBy8cuI8A7FuYHKV3ulqmpWR6/k9RMv3/chN59z+d
         kePpEsvKl7kopTjCAe7JSNZ5mOgwDB2VoOgyskM1b/jEZPVqDTMNVYHlJ7EdaMhWW8cI
         tuwfe3+KBSy5+LlEwQMdBsRBr6G7Av4H6hvCnnVNZC7W13BP9116ANb9scK8MDLTUvSz
         UFh1mmp65m34pvWBQRY2ibX62zK38gZ/ZmV9iZp7YqQNKeYUGUSv8h4CFa1FqFc0CAvX
         lhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4uENM0GPWR0waMAnNIjQqLjVo6flbWlAfFqICbybo+k=;
        fh=KcNbqYfh5/rp+3O/oy/Rn1Jlbpp64wJ640nU1xb/jaw=;
        b=hL/bQ4uhZcqQQSh/U3QlG+Wka9tBvvBfhixoOD77SVNgaVPpNXVyUluMZFHdFQupri
         0TTLLuXNt8lb6sxmF9DsoVjGspxtM4ZB8S/OfrqzHKADdE9dOQ2F/RGVnyIFHNpU/Vn8
         7dXnyfE6xZjPRzsMki7/r1ty3eQrDbP2bLto+bJLPFIUPMcIA8192esVjLSHtAJWRmG6
         sqEykZ2/Wdtjkv6jCqZhcakPf399AMcYMTJi5bDTQldwG1Q5Iqtst8Q8vT91UIauopQJ
         klkaOhmjBa0pA0Y+r2teBUQU4wUHShDZXnSMiv0J8rBGH9WpRcfJ+SYLm3qV+OstU4PJ
         2Q4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789761808; x=1790366608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4uENM0GPWR0waMAnNIjQqLjVo6flbWlAfFqICbybo+k=;
        b=FS+xYeHdorOQdVFlnaLyFlSjnUtjQOu5FhIe4nsY/iEFSZtR7XRVa0fFcuu4NRI6Lc
         C0593IXRVsutzNRNdYzrFBGS+EjdutTsIv6d+e/WDTsJt4eA4WckTdLt8yevMAsCwzuC
         ZTOzwZMjyXswlDLwIcCvGFvnCE25Xhi3fKBKRdRWniAbsFf/FgKTvCogJJPl6VLh2BGl
         TuM1mU87S+b1mew0XnEPz+/WJG1Ak8f/Hx++fnEN2HcbbqDq2CZs1Puhi8PsUk1lxUmV
         E0IHi2RhYD4lMna1ve6PBvOR/clQpWLIM+To2HFWUl42MXqiSu66yJoMYs4ZiZ6QGnE2
         zNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789761808; x=1790366608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uENM0GPWR0waMAnNIjQqLjVo6flbWlAfFqICbybo+k=;
        b=Kd6nQq1LsUCgEeuFthUKRp0W3WzIM5xuLZwlXXoDlKm9CUs36nPkDIz5MeUeuEoNdv
         HlgAd6Vg2mY0YEXUjGfb0YyD5QC8/4dyXHmGaUdm15EcSAORK1d68rdfHJmX0nPWKL25
         xnifCFo+GXNiWdZfO4WZ55/dxBxJ5xt42XabUw3FSyYycj8wUy525KugeGTMCbzYGLwh
         0Pa/3WzEwJ0sg2pBZABo8kr1YAo6Q5sfWwJ0KgMDT1sdm0FAwk5iFbJsYsC164ChPJTf
         GMRivb+0i7MEUTozseGEQdOdaqls1+pimW2mEBm8DyFnFywnHhhrqNQGw1/0PvcuChVv
         0VzQ==
X-Gm-Message-State: AFuF++nDX6uRurDtEOmvIhWtrn/5KZEsCUt+7OhGZX8RGAaoMw3be3Ly
	+89ps32z+2AvgOqT5uGllHokSvHxUGWY5lYx5DH1fTsd5J/XneEzO1N97svU0J7hlSuj1vN0Njo
	A2AqMaUoTo+pKf2CcATOBzghZOgB9Ek/0Fw==
X-Gm-Gg: AYBFou265Fztcse5SdxTQHpYkZdtb3ouZGKwNlFKxwUB7Accv3R9RndCdd62kqI6MKo
	h/iD+nrgeuLlom/PTzMXU8nA9OAQizoqIYMBZCul90RQd92qu11sRasUvAaIP71zE5AbHmmGjCl
	ztsT/UDodMiPezJlh0rIIX9nvbB6FsaKA8Q800EENPmJMcq0ps3PbNGJJjx15mh7qoT43JhLlUc
	6F6b9OrWvja5tvpFVfHuEkd6n1+kobtda8Nl63yDcI2FtyBYR7VW9b1Z3m0ViHjbCtFv5rJy+2t
	kra2saKL/HAH9Nz7inEFMgIPxjNDScNpEMDRkyB2pVkKWcprxsI1EeY=
X-Received: by 2002:a05:6871:c8d6:b0:47d:4a10:7303 with SMTP id
 586e51a60fabf-486e7513063mr3483067fac.31.1789761808517; Fri, 18 Sep 2026
 13:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918161928.21194-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260918161928.21194-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 16:03:17 -0400
X-Gm-Features: AcwNN1XuYqZUhP8fKR0QlztwFB_YgCzlUknQ1dg9F68GxxpIpD39eA0-LvNoMbA
Message-ID: <CAEjxPJ6JzSdrOqmKXCTqro=5Fo7sFRX0UPYRJ=O-tPmayPvoMg@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: update semanage-fcontext.8 for fixed
 regex anchoring
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:19=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Commit c42116d304b6 ("libselinux: fix incorrect regexp anchoring")
> fixed #544 for libselinux but did not update the semanage-fcontext.8
> manual page to reflect the updated logic and flags. Update it
> accordingly.
>
> Reported-by: Stephane Chazelas (@stephane-chazelas)
> Suggested-by: Stephane Chazelas (@stephane-chazelas)
> Fixes: https://github.com/SELinuxProject/selinux/issues/544
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
