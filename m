Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391923EA83
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356504; cv=pass; b=PByfKNpzuhxBZ0ngYMtbx0lCGysO7kWu0Tg7YrxUfal4uG0RngD4WzQrUF5rbuIqyoj3Eqs4CeyHeSZLMoEInFVtArFEDl/7C11pllPQHWwx3AcIT0zHMrw84sGBGP440fyQO+eCpqveNkqnrrB5zY4s1KymFHM6TX+DLd9UCzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356504; c=relaxed/simple;
	bh=R9YbNrm37rDbyyn134YSwS13wDc5tswNjkChC9pkvHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3dV+8j3Z0uAhk1jSskyWgwXm2NSP7LhTrtLDABDH9eeBJx3gQvEOq7Tje2yHT8LCr9Q4uXPytPNuiLT3/P3yICujp6DHD/nDGohVehliKFKeHegJ6f1eFz/NzNllDA+KY0JG/ZesPixxJhHFbmRMzk2fd7xqTWfmM7IMwfN+hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5K1G2LJ; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5K1G2LJ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-45691990234so875689fac.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785356502; cv=none;
        d=google.com; s=arc-20260327;
        b=DVh+pqByijHLnlhdhFZ8MkdfVRy/O8Yb1TTlzEW5MjmUxfDf+Fzr2oIFWCmlMtPJ++
         Wjl1g0xnrLghVR7bUN3KTcKyP1Vj/48+vU5tOY0lboOyu7HIBPvN5D7+9OSnK1CuqmsR
         vxWLD9ZiuzlX7KbBZZA3xi5xrTjy0/XkMowCTNyDCTB62/txQy/RK5N9c7EW9R9wiwun
         2dXKf6dDoeAPhd5ghd9pWHwD7VQ3IxzaCxq+7npdQM2HLP8WkMc9U47Jf0xe8DsoSzAQ
         iktW4U7TzK4PVB3PcwtDCjDcKg98lhVmkP2UnRbxLKX6BT/F3oCp5Du7dPDLY8Wv6DzH
         VcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R9YbNrm37rDbyyn134YSwS13wDc5tswNjkChC9pkvHw=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=YHOgMSoplJYLsQqgUhF8TMc4VskiGvlmVrFc3Pi3nfTmCxbUBzBrg/3/Or0bE3XvC6
         gBcCKu13kW9xJItkmuIi4UG6HApGb/87y2szNlIgbZBOipiV4i/ESOy4rmD+FjhXfRSH
         yEsMlTTj6U+/7sf53OgkKcWqTPlnBiNpxins3lZa6rXWfkxdIbZCeV8V0EJK3q04BJ4h
         BpnkO6ZM4HOeUFPe/5oMIf8b86/QAfQlcD+crz/FEdbLnQUbuDPh6ULk4cNJFRQi2tgP
         1TLQNNkN1S+xlPLpmNNmJCVTWa7HjhOapHzc2DHSEf0tCglM85Tz5s000RgoW3L1nlPK
         OmJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356502; x=1785961302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R9YbNrm37rDbyyn134YSwS13wDc5tswNjkChC9pkvHw=;
        b=Z5K1G2LJBBxlWfj2C2AKaY74rs43LunR5blbkEV8tC8xraksO65p00+mXuX3QTzM/1
         c6A6dLi/M9f7SdW5y9weLNx+m9KTtGOTr1RikMhdM5AbJM6rdEdb//ccWZOO+o2BHPaU
         Jt6j5ZT5tmcbBgMBxMrfDZE+8KMttjbafcFxd+htz0TbT6yRXvwtO1fScJLcbDdx3fgO
         B1ld0d5OsVzNOHDvtCE0pBrQPI4++sn3/5YdaHD81XDe8X61oXSBCTEEEWbSH3eCDnLN
         G1j9kX/dzZsYaYbUD645eGCROQ6eYykiPhCSdFB4ZWsWsSFqqBUdhJJeGdO9dPeuBZCB
         +Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356502; x=1785961302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9YbNrm37rDbyyn134YSwS13wDc5tswNjkChC9pkvHw=;
        b=giyrGd1zpG4YrXE2P9203Fme4wpN2Z3qZmDfCBfTWYoX25XYpsxKleZXjD5Oh5rXS7
         oGPp0mOd+ud8yZ0Z1xicdRo4niaD9ra7MQ9TnetfYuLnsh93nXV3S4cvaZ3j3G16Z40E
         bkOVUysDAXeIwlbW5I1LI7VXR+a0umf2LqogtKKPiG0E7sr38C+/lhNZgnfCLlbMc/d7
         zvQv+FDePJqSBDQU3AdOEXSJ2xcV7eS06wHWyJ7m1feZaFUTUgsJLn17lNuGwCoRM/Ci
         Ughu+poKknvO2HdPfKfgBCoGVQlQxhWnpTDsAt4ZbwxEpG9qqrCYux0rpsKlroGqPmYh
         LJ3Q==
X-Gm-Message-State: AOJu0Yxd/ElhBdAjBK8gy6+osAJdPdqnbH0e4u6xm8HhrtY2RwrPQZqg
	dCf/L1ln7NGNf3M9WdIWS5d/qXI7cP0eMuIcmYFsW8do1VWGO/Ggf+YRk7kFqI0LB+jEIjrQuVW
	yTVIniPA9nqmg46lIz6HVo+km2Qt89pJ2Ug==
X-Gm-Gg: AR+sD11XM8MC/3Uev5n5iJgloyRdmuS/gvHY4brcvAx9gKV4bjkmsg93mkugbZjahS4
	zf6H/QrwvRXhRPPm1DXqtuW78nCeCpZwe49b73kxpdjk8DERWM+YzhctFwCoaXSYPhf8X3/iwN4
	y8tIUv3kVw17eURJIwB6ZMlXdVzezWx0RRYlxZsxJ2HGiXH4QTIZyFBo6rWOmc4Fmr3I2oP455P
	6j39Sug4f8q6b9LNSSInjPTV4TEnKtBY9hM8b1M5fFtoRZir1wkaA26V9jS3Y9M3aHe9Yixx4xx
	HVJBBXg5YhkWtCII9Za7eLo/lBguLI5zoI/3OYOMGqw4
X-Received: by 2002:a05:6871:2ee0:b0:451:b3af:400a with SMTP id
 586e51a60fabf-458bc6ae188mr126476fac.42.1785356502019; Wed, 29 Jul 2026
 13:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728131007.2588686-1-akkohli@redhat.com> <CAEjxPJ4aaSPxRHd+i76Kq9cMosJ37d0DdYebjUzBcxCG2-zYew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4aaSPxRHd+i76Kq9cMosJ37d0DdYebjUzBcxCG2-zYew@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:21:30 -0400
X-Gm-Features: AUfX_mz-0EXDAuWaHlBOtMcI6eDayMB16pQYAlmaaTm_tzlP9uFXbrLB05JMRp8
Message-ID: <CAEjxPJ7m2GX0mAG57URD6WkaSdpMd9H3uVD=y=e5F24N6H5tKg@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for sefcontext_compile
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 28, 2026 at 9:21=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> =
wrote:
> >
> > Extend the bad-data harness to validate file contexts after packaging:
> > wrong field count and NUL bytes are rejected by sefcontext_compile, inv=
alid
> > contexts are rejected with -p, and unpackage'd .pp file contexts are
> > checked the same way.
> >
> > Adds 7 sefcontext_compile test steps on top of the semodule_package
> > harness. Adds bad_mls.mod.fc fixture. Preserve errexit restoration
> > (set -e after rc=3D$?) in shared helpers.
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
