Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326911;
	b=3IPgRNbIo53ODsMuQBXqVTAobN0QLWqlVu0PcHY+RC2CKxLqwya/qKKq8N/pjuC2kUvP
	 dLpZJX31UPVb3B4ruswaU856MhrLu+DiRWM+hIzTdwJYmRrVXECuAGbGjRM6ypJGwNE7w
	 WjbCssgnuLADwUpDdjBQ7PDRSTPLsOH1h+0/6SbmB/9gl6fkuOGOu8+j+JauxEl08nBWr
	 23kgLs62N+gc3vVkGetNz3Eh9Iw4GuWf9smbBKkiJ/YPdzSH5ujJnS1ju+DeVLUYuaKkQ
	 UkjxRpVtnY8cf3r8vVM+7U+/hGiUKgDXUrLXNE+pfu75KGsckcUWvt9iwd1LPysvDlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=khBmLoE5qgj63RIWykk7kGHWjckWVrfGWqCiBf3WZ2w=;
	b=IUc6rzWHuklbkfxaebZ9TG8Qc4AqWsc5OsBsCjsKNTH+nvcdF5aivKm5fA+rOwSjkVnO
	 hjDukyTAgYQQjUnxAfulN5dMAd/CI/vCaZ1kYHgDGBlO5z/cnPBFODTsiMDSo3JtLgqf9
	 VfOIFLmi3kAcRolz4eMSbIbwZGm0CZIdfDdouIKk/FqxKWJS4Vq0jIOyCo45IWLCj/Mj/
	 g8iL1U0E5wRfYlBvJNkiL/MixuZS13EAkTqn9nZDXGu1AeDvmVw6g+kn77Mhi88h07lNY
	 ub9bGkps0CSSlEzrPHLnOHF1thn4cVz+fXW/7uDIfjaBi82cRF09gUNZLgNurkdIV4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lb+zZV/x";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE32606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 16:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE32606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lb+zZV/x
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b336de3d38so16761437b3.2
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 08:08:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794326909; cv=none;
        d=google.com; s=arc-20260327;
        b=XC7FafVFUVarVABPqm6MydinwrKluGrlGcLZadLPxuXafLfwP05A1i7UCUD3He+Z/s
         OZnH4S2qWyCINNwNlnfZtPSqPyNcvXCxaGHy9DuLfFBNKNdl0eWI4B3phh93cgXdmDSx
         hApQSmM3O5XIaIf6s/0GoCoKwMecU1rTw1FT4CkU6QMFLb3BaMU/R8cMz35Qb9p7jFHD
         rsQOSoim+UlVqNlllA3OuU0a+ovhT9ihAFcswPcjMDQn+0oVMBhzEZDRWqxPHGD4uhpa
         FNrdzHztZg/5nSSjmgdBEb24c+ymzxY+BGTkmJYeEyLb3ETS901qi6XD9ChXbgI0UUx2
         5sIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=khBmLoE5qgj63RIWykk7kGHWjckWVrfGWqCiBf3WZ2w=;
        fh=ToJulpRw6GZ3GA6z8f1pnp29ZzkHKf2LKiC3hlgYas4=;
        b=Z9g4e0ex15suRjDwjjeviDbgZkW3Cqf4q5KcBd3wn1ZInVe9BYqILvLjbX10yMlmV3
         PQXUgs6/mH1aM+4wV0wnkzWxlPlvrWgEc7vsQHXZiOWbJu2SiPNrNwQJ98gzhX0/4NjE
         s+wfl9/F1xonKHn8RYBtpG4gSA/lyRcpv1yWh+tP0gNy4wei/msE65AEPdyBE2zvfkBB
         EfwsKDO3D3U622QoAAEjMp8YSWfkRhnpaprD+1S45CEdxFs23QDSnPuNIBNd6pdlJa4L
         0A3elxrErza4R+gxFnD1DePvHPpT/jGPbwAegJHvyxI/biTCnwQuW40wxuEVCLg3pWlz
         WnUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326909; x=1794931709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=khBmLoE5qgj63RIWykk7kGHWjckWVrfGWqCiBf3WZ2w=;
        b=lb+zZV/xtp4OhIbo/JY2lab3mk/FiZEnI3v4TPwMV1p+02XYJC6hGiBMPolc9lZJjF
         EetvmRChH391e/Ei+i1fIWpB0DGUuVi0VzlgQHMpzFaddXsfYl6r8S8btdKD694rUvvD
         yb0Qu6DwFerqVR1OOmvIPk6WcDDaFs/w7qd5MYZjcfu8EUzhZZR5aDfz3zEFXhQF4rnc
         /lcIbf1ljTi/VE2zgX9ieqYtjyBQnKAl+vM78yoD+Uyu5cmrCdglgNw4uEXtoe0K6O1G
         HHLYJG0KJDco3RNxIjGMtrpvFVd2rCbV9qxDnSX61IQ0vi3LsuAN4atTwLnavvkL1FZF
         ziIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326909; x=1794931709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khBmLoE5qgj63RIWykk7kGHWjckWVrfGWqCiBf3WZ2w=;
        b=G4xvhOnYvvX4DQnolS7DbnJdzar323RaX2Bpn2ip67BB+V/gjH9eKQn5CiimA50uMD
         Ghi8BoCyKRwAI7aK1PLAf66SrDsbjS6isuMFIrkHpyjCtmydUavfpYfmBcaGH/3QxI03
         LDreBGPfw5VsDmjLDbC+TTkGD742ohRjOY6QVSd2/hQi+l6+6gdJIB3gbbxoMaj6zeB1
         3GUVK4wsBO9e4/gtxhmgiqIDhwUIx9XIVXUHWNolvarmGDsbHsU+955xpQGX183CjuwU
         oTLcoO5hFcsht46TEoWKKsmgyu01CuRjIxwy3fU5GyBDTgvEqc1UqvoFqKI+/AGW+wzv
         43Iw==
X-Gm-Message-State: APuU4Z8mx0dcpQOEaVigCni87DvferL8pj6dGzrkaH+M6E8SoIkoLzgo
	NSCygKlR3nFvNz3GyZ9tIFho0zBfn0Rkf1Fxknv4FXVS29AIGcDafIR73NYyoX+6nafBfJISUx9
	0Gj++W5DmKcpxNEgK3zVv6+d07G7sQpA=
X-Gm-Gg: AYBFou1Qh5VZpXJJPEqoGWDCIRzq4xP2hPB9naQzPnP1ky10ThOP1ldX4mWGct6k4YS
	dwP+AqVvwCUvfXaRiXRzjvDvtrjxklRu2AfTG+6gAxlTqOaDGcKp72Y852M/IQfbySRIkjwawCP
	mIvdh1/BLSKlcpAtswoJBw06w51SjbCdyJRWyKEtLH3P09s3ZI/N5SGa/tPrzLCOkAfgz6iisJo
	A6E/4cDxXVC1GtCwOn4s7bUL/ynOm2Goun1vQUR0JobBFIvwMPgftTNQRGusJs1tH4dU6jc5q60
	WgdJYThgkvXYu5O7ibzSrPsRvJRIQXqyoLU1+V0CYoOQygTOh0dz/gcieag4tT22GQiejb2E56+
	rPWNGqV+HocRiLKcetU3wb08SSEwQJl1S4K2qMhKgiEG74ny6gz5P6PmnRdboPr2qO3kIrinHIb
	VDEKwVesVUFNeP+XuXDprBpwpBmQqk+tXYuLpCZpo3Mc5OXigpOAHvJ5i7xA==
X-Received: by 2002:a05:690e:c8b:b0:67c:b4e:315b with SMTP id
 956f58d0204a3-67c5677ef10mr1118000d50.56.1794326909317; Tue, 10 Nov 2026
 08:08:29 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110105906.58509-1-cgoettsche@seltendoof.de> <20261110105906.58509-8-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Nov 2026 11:08:18 -0500
X-Gm-Features: AclHuK8c7XVYbsAAZSgWhzklZD_z0fmxiyltjjFOiwPXE2sfqoyMCt887iaK6kg
Message-ID: <CAEjxPJ6bnNFCpeKQbkk0=aK83q-8kDKdO9BDLAMV6tQGDfgX7g@mail.gmail.com>
Subject: Re: [PATCH 1/7] libselinux: avoid NULL deref when serializing a
 cleared context
To: cgzones@googlemail.com, Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:04=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> context_str() and context_to_str() unconditionally stpcpy()'d component[0=
],
> but a component can be cleared via context_user_set(con, NULL) (and role/=
type)
> since set_comp() treats a NULL string as "remove".  Serializing such a co=
ntext
> dereferenced NULL.  Emit only the present components, joining with ':', w=
hich
> also keeps the allocation size exact for any combination of set component=
s.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Let me first just re-emphasize that we are in a release candidate
cycle now and therefore we want to prioritize bug fixes in the
following order:
1. security bugs (following SECURITY.md process),
2. non-security bugs first introduced in or after the 3.11 release
i.e. anything introduced after the 3.10 tag,
3. and only then do we care about non-security bugs that were already
in 3.10 or earlier (and only really ones that high or medium severity
IMHO).

At least that's my view; Petr or others are free to disagree.
And no new features/enhancements please until after the 3.12 release.

With regard to this particular patch. we do not want to silently drop
fields that are actually mandatory in SELinux security contexts i.e.
user:role:type.
I'd rather dereference NULL (fail noisily) or return an error with
EINVAL errno than allow such clearing.
Otherwise the later fields may be misinterpreted as earlier ones.
Someday I would like to actually make the user and/or role fields
fully optional in the kernel and policy (there is an open GitHub issue
to that effect) but that day is not yet here.
Until then, this patch gets a NAK.
