Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDD219EB
	for <selinux@vger.kernel.org>; Sat, 10 Jan 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016083; cv=none; b=nHeXREzmkTiCvu1aBli3kVbb8mLpphiuAOobUzKgcVJcEjr6ocxRwUbLwTg1avXFMTEcPSQHXM8fgajRKInBRQAVgd7KH6x9Pho/rQ9t/EBhCWoiKglVvzxNAb7GyXAb4sYyBQMuQOsUUNEoRaFkKQPrwR5vmvJVmKyVsZVX5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016083; c=relaxed/simple;
	bh=OEr0ad+kk/DUul1b9Ed8ArnuMUOLXvzM0aSP6KugqQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJSH+hO2SEIsn8mFLBk0BtUAZoTMWNrStJoi25L0ZTiXpPkMc4JPWdwo09g4xGfvtJ2lvt4EkEiyu2ZyZvUpdA5Fj+DT+uY5If3qONpcgGLXsbmdvb4/gs3Zh1FQel9Y31NcVWh1X+DWzlWIEif3BhfaBdY46WWFQ7B26KNlWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XVOl6MUx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XVOl6MUx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a12ed4d205so31614995ad.0
        for <selinux@vger.kernel.org>; Fri, 09 Jan 2026 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768016081; x=1768620881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQx01GVf5Qo2jNJI0Kgavs6+heHTeuLfMaH6Hp2Uz50=;
        b=XVOl6MUxa2hFwm4eGac8d83G61HbKJ0RzeeFM3l1cJKnr+tEAAYb5XKxJpKngY+gCt
         9LJ3ggjFDak943vA6waKwlPQUGZ3rpX6lbsg1Vymm+BXS6QsUj+DZAivWKeLKMXCaiu6
         H5/fQzyU5Hu2XGvVKll+P/i2ufYxvPtxgDA28q94okxkTtoI96Jq7R3mwCteMiASbEOe
         NiYOahZt9LB4V5I8Xu8CnVxPHpA85Tc9QZVQJmKljnaLdrkNtHoAgfd9QlnOAgtpWaAj
         lKgwrPmvyPsRpi3hsIwJoK1hkUldOCBV/JDzXPIyPbdexZvFuABKAhRlJ74XCYp9btkI
         nObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768016081; x=1768620881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQx01GVf5Qo2jNJI0Kgavs6+heHTeuLfMaH6Hp2Uz50=;
        b=b6kKfGEFEOgHj2xVpkwW33GTqURG7m3vKwkIyePxFE2dz+pl3Do4Yc4NywZcnwsCd7
         LyyBxIO8U0qKeVwBVd1yJ+g4gmmDC2PvDDe3qYzJAntq3HMcDZtLIu8HcVbL+5qoNrGp
         CmkVcVPXxN+QuflHr2GMKjxVMPmKDa67GVlpheAEziLij1FV2EbT3g1Pax0GaghrAVCx
         ICXuC4awQKXB745SXXUXBp4AB98jFKoVAyG6MDPrXqmHwG2bt6+r2HDSzTKzoZnW/OZH
         qYz9VP6RqoEBYiSZEFlcMErlX3VqCvJHpj9Z2hhGg5Cu1NFf90H/avO6mvp12ZMwl8d/
         EMCw==
X-Forwarded-Encrypted: i=1; AJvYcCVio2uWV6QWmRnPMDmYCh7Oa6Me3UhvLElnnZriW/BigWl5c63U6TIVOYxcTJGe2yRlJlA3CaJ5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9q1ohHDqP+17pERv3w690mPvuC34OIUVOsmB4QQPJvs3W/frZ
	coHr0oTKXEipbPcQQ9/75vuqtCl64QkG1m1HCDQOMECrTfO6nRwJmPoEia0TJyVw/GI04yk0OiG
	m1EifJ5idmOC2Kukyh50+0iSHazchv71k0UxjDL4JhSAjxvpl8MY=
X-Gm-Gg: AY/fxX4Z3Aa0imClK24X/O/sHiD+YXutWa28tzlF2bg/HeyS/oFoZC9X1WBcCCyDsYU
	EXOs8bYD52CkyTCP7wqn3CFGqHbOiQ/i959m/DT2scfSniW8H4vZJRn+bL543P/StF7vkR8CgKt
	A5MGgnmxbiWCZAxZXW7l0zFlSXfoopRzdK0k6apQlerthtBpWDYnH7OuEGmrhIaieC4L7oCM9dz
	eg8rMuwFHAz3r0a5F/XE084wvLj6uzgQnEQDI6kDYlSXi5L6Tm6UFnFRuoX4wkhmOvCLI0=
X-Google-Smtp-Source: AGHT+IGMI96XFaClf14x+HJW7TmQZftqsnQIJonju98zAEpsCZLmuBcnkyNixBl0r6vcOv+Sa2+sR5XzZllzZu9nKoQ=
X-Received: by 2002:a17:903:2b05:b0:29f:1738:348e with SMTP id
 d9443c01a7336-2a3ee433c46mr114649385ad.15.1768016081256; Fri, 09 Jan 2026
 19:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205024259.704-1-ericsu@linux.microsoft.com>
 <caeaa280-ffa3-415f-bf39-340f66ee45fa@linux.microsoft.com> <CAKrb_fG=OdXSydv0GV8XmtXv2ptfNN=U0ebht_3CTu+oe-wskA@mail.gmail.com>
In-Reply-To: <CAKrb_fG=OdXSydv0GV8XmtXv2ptfNN=U0ebht_3CTu+oe-wskA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jan 2026 22:34:29 -0500
X-Gm-Features: AQt7F2oBrEC1Wo-Z4d3Jw3ovwtRFBXRBV_yU6TYvSUiIKclOEqI3PJ1Y26-dStY
Message-ID: <CAHC9VhRcZb5KKT9yqrqw4odFWgiXgv_-U+KoR=qrtepE5zt-bQ@mail.gmail.com>
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 12:37=E2=80=AFPM Daniel Durning
<danieldurning.work@gmail.com> wrote:
> On Thu, Dec 4, 2025 at 10:12=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> > On 12/4/2025 6:42 PM, Eric Suen wrote:
> >
> > I need to mention that this patch is based on v6.17. Ran into few
> > Hyper-V VM/testing issues with the latest kernel (v6.18) that I have no=
t
> > yet been able to resolve. I believe the issues are related to HYPERV
> > configs, but troubleshooting will take some time. In the meantime, I
> > would like to get this patch reviewed early.
> > > BPF token support was introduced to allow a privileged process to del=
egate
> > > limited BPF functionality=E2=80=94such as map creation and program lo=
ading=E2=80=94to
> > > an unprivileged process:
> > >    https://lore.kernel.org/linux-security-module/20231130185229.26889=
56-1-andrii@kernel.org/
> > >
> > > This patch adds SELinux support for controlling BPF token access. Wit=
h
> > > this change, SELinux policies can now enforce constraints on BPF toke=
n
> > > usage based on both the delegating (privileged) process and the recip=
ient
> > > (unprivileged) process.
> > >
> > > Supported operations currently include:
> > >    - map_create
> > >    - prog_load
> > >
> > > High-level workflow:
> > >    1. An unprivileged process creates a VFS context via `fsopen()` an=
d
> > >       obtains a file descriptor.
> > >    2. This descriptor is passed to a privileged process, which config=
ures
> > >       BPF token delegation options and mounts a BPF filesystem.
> > >    3. SELinux records the `creator_sid` of the privileged process dur=
ing
> > >       mount setup.
> > >    4. The unprivileged process then uses this BPF fs mount to create =
a
> > >       token and attach it to subsequent BPF syscalls.
> > >    5. During verification of `map_create` and `prog_load`, SELinux us=
es
> > >       `creator_sid` and the current SID to check policy permissions v=
ia:
> > >         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> > >                      BPF__MAP_CREATE, NULL);
> > >
> > > The implementation introduces two new permissions:
> > >    - map_create_as
> > >    - prog_load_as
> > >
> > > At token creation time, SELinux verifies that the current process has=
 the
> > > appropriate `*_as` permission (depending on the `allowed_cmds` value =
in
> > > the bpf_token) to act on behalf of the `creator_sid`.
> > >
> > > Example SELinux policy:
> > >    allow test_bpf_t self:bpf {
> > >        map_create map_read map_write prog_load prog_run
> > >        map_create_as prog_load_as
> > >    };
> > >
> > > Additionally, a new policy capability bpf_token_perms is added to ens=
ure
> > > backward compatibility. If disabled, previous behavior ((checks based=
 on
> > > current process SID)) is preserved.
> > >
> > > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>

Thanks Eric and Daniel!  The v7 revision looks pretty good to me, does
anyone have any other issues or concerns with this patch?

--=20
paul-moore.com
