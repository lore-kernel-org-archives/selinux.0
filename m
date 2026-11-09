Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247685;
	b=fnoxwzvPywJmfKRtCKGduTjw6WR2cdtaP/IdSk1pOG3WDmwKtiRE+lyzbb7auALYlZy1
	 7YnuUy2qYG0aMWWCIbshk36KponjzBparK74bQchC2hIYzPr2PyKheyU6Np81kqPSC8F+
	 629mmQSDw1+ZSE0YLOSn1ktwiSWFN+yvBuKKpb9hEPKUjPH1V+8AvS18/usuDrjZZLYD+
	 fGm1z2WVMb0AOI60bRdQYinFAjsMnouzlZe9UMI5ZOob6WvUZj/21qb23mHsrImeqIG4q
	 Y3tMAOB9oCbI+/f/n145eJ/SeULb1t5/LAiaoKPgDv0+UhylcjK17EcjHmTlYSePkZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fdj2N8GZ4VsXMhwo0kjls2qzOx53r0J+J3qksZ4cHqc=;
	b=iCZ+mcdAjgoo/rcq9D/kVyuGehL6eInOQKDmu0qCr0uY/bPmIhTkFgmqHOmu+jum2x3x
	 ZppeAmbvga6NQV5EuHuHXN7YMRKsJZTgF8++XAC6+SqFnq06SH8Zr1a0z4EDlVwtgovwP
	 NNiJs8MQzm5vu9JIhRNmLWTChCCA2aQ1DpYzcS11bBUvY6FQCk/q/x5TD6Yp0THeCJs8w
	 z5HV0J+yNSkkQ8ahtrSHvOauPrlzOQdNHMKqyB+kPPhwubIeUVfCWp1fzb5vayL3slrWK
	 9vTI9sDVEZmE5p57O7UwUXX7MmLEqy0fidJd1k3HEnbAk+Nhg4xdadrPszvEKgP45fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHSy4o+g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D85606A332
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 18:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D85606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHSy4o+g
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b349d21fd1so8385307b3.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 10:08:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794247684; cv=none;
        d=google.com; s=arc-20260327;
        b=KfmYlf/kco5fZyjoqOs5ujjZQWGIyC1zE333olmgU6RJCmN9z1MyLYVRAEtDJyqn8b
         G4GcNGtFAefLCiqQuUBhwnOjBEIy8smAd+g0rKRSuGRZdYHQOHa4VNSVw7BSm11QNLAv
         mPQSBxqmVcrSQ3HbTuANwYTtOtEhKVLXXhRoSbSRfReZyMoc8K73om9r1FVpX9qNgvF9
         VhGsA6h3j4Kp8Ni8Nk3gOVlG+aYx/R5GIgfPumff7r0/S+OWOJ9nFEeTXi0th7d2FGpd
         ExQMtaLQ7G4aWI3YzzPCAZ1lbwVDCAmbomd7T3vwh04eOpWQB+mvAKCxq9RgPQM2Caal
         f6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdj2N8GZ4VsXMhwo0kjls2qzOx53r0J+J3qksZ4cHqc=;
        fh=BVG+R+ZBzwo8aqszPIHno4GP27O2unLSWAmgs7erR/w=;
        b=A/XFztPE4NINPY2OFkgn+Mxiuo9lWXLlSUdWOyw7ej2PbpGlhdS/aViLm2Dgj3s6LX
         SIywLiNeDAOFOXa+NTzG3htjav/AaVUVB8z5H6UJvJdI46/HSMnL5hBApffVy39OLncC
         g0Dhe3JjO/gLyss4TfT15DWIBeFPPL6EBE6nj1YhoQwk6x+ZXafOcO0J+w1RFLVhWnte
         ZQzpmrkxzd8Db9IEIUtOUEEPz3SqSz9hzHyKhRGVysREfeZK7y19xBrRhyMAS8jJP7TI
         QIi2KJSN3IUKgVgtx3C+8AMA5fTMF2EMFsqejGHgEbJ/s6oYoaOYkMQIMsARbuduJumz
         JhEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794247684; x=1794852484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdj2N8GZ4VsXMhwo0kjls2qzOx53r0J+J3qksZ4cHqc=;
        b=hHSy4o+gdAT2w2tEUaEbOvU1nuKiL+nX4nRm+AiJdKDgnK/d8F2WfbQqG1cJo1VEyG
         PAgxFrF2z3h+xB7Y8NEfAAF0uNC6CrR85f5VO2QnQF5Ujs6KtqmP5Y344d3mN9ljnGfi
         OixbEwfXpH2bHCH+oiSzpEXDksMI1l0LOUvMRyKs6w9gV9SKVJMEGVf1H/DER8vGyDfD
         AAYByQhCEoF+htyVin6barVCTgdqG43g0+usqq4vV+X+CpkIoxrA352/Hm3502ssiLxg
         Vo1RpoEVV74AK0LrUIX2xKk4li+HATFNQvRBRU95vwc6F249TnzqsXdXRct2qtzeWMkL
         60oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247684; x=1794852484;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdj2N8GZ4VsXMhwo0kjls2qzOx53r0J+J3qksZ4cHqc=;
        b=kG0wwwiyFyjv88SQOAYJ0BanDXWU0kLukNJOBfWeC7ViLVUlCwQlFCPlm69WplLeMs
         CF+2K/3h6XiANfFF9+TDr+6nsri2LQDPi1lgGFFYkBGl2Tz/3chYKrsipJ5yBMCuiMOp
         vEZKGYCCLVinJGy810wgNO0s8B9vIp2AG1xpcaf5sgoRPlGERePXTz3cdVcVrnLsohZY
         7dh7hfuQgwoxQH6c+9NKnocrA5nsSXHaIWGjfw1eEBtld54UyHH3zDhgD+bAAcldSfj5
         8NBU8h5XeuCMYjL7xGmMNGNiuLkCKuZ2A7ZeA5F+oVQeDf452oCJZSZOaaobX68TLjOl
         GObA==
X-Gm-Message-State: APuU4Z+Hl65XSPupl4G60qIe0TpRJB94M5+pG7uWVKVMROo670ewU/iG
	3hRvKk2NgmnvHO2RqZmMNz8nK5D1KgOGF1WQ1dKtFHcF/zm9ortjP8FdDcrWvtzmwklvcXpJgyh
	2URXE9/nPQcaY/yHJ+90C4lTAMsjuu49YCZ4s
X-Gm-Gg: AYBFou2v8SP+vUUhR509Vhp/pLeFQ6glei5B/gBli2SOrqsgamoBC8U9TPP4NPTyiRo
	dUbpULbtLDCzTYa8o0AAQsXHLy6bZ8OUWnF8Y4Nx0HrK5RqoZctRxXv12SroP6USwCL1E36w+kk
	p8CikQ5ltiOQo2u4JmqC218jzPi2Jss3px0ZEHrdD4rpZ3lOxGxci8PoM2uloObhjtG1KDd1jSk
	ibHRIz4a1zyNXXKyUlehDZN3diC0j+iaqncsnhRNxdwRxJAMYIm2Kgk8jvqENiH21InJ+7UoVLu
	zRkoK0HyJM2G2zMWrMsZBgs9NbwdRyLzFDSo0W49yfA21vz4x2XLqjow+ksbRpqauRuZnV/QrTj
	k9opgf1tdlcr05eW8fjTbkqyQ/w+o+3e3zkNsdss/UfZ95i3TtCGFGOt1j6/JTU8vwxvR9UBS1J
	zRiahMScZrogSSHBhRDz9e7i3NPI7ulMyp5yS9pyglpXb+hFG0/25JtKdaCdJRGbsnuC2g04KNG
	BqsF/o=
X-Received: by 2002:a05:690c:f16:b0:873:5ddf:d872 with SMTP id
 00721157ae682-8b392c09e05mr893357b3.61.1794247684383; Mon, 09 Nov 2026
 10:08:04 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
 <auxhNtTcQa-6TS35@suse.com> <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
 <CAEjxPJ6ihzVO32+RAah_g9vo7vbFQTK5EGybgvJhow9u6tzMbg@mail.gmail.com>
 <auyV4UaYWjPiDZdD@suse.com> <CAEjxPJ6p+wGhq+Cjpg+J8HGZ=4x6e2o5AZ1OYHK4CCqVjd5GZw@mail.gmail.com>
 <avH1bZb2poB7aO-U@suse.com>
In-Reply-To: <avH1bZb2poB7aO-U@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 13:07:53 -0500
X-Gm-Features: AclHuK-gZKaEpCaCEq0XdbGWhLYCrDFrUVo0l5KwqIY15u3miFDIoX9-mGLRDdY
Message-ID: <CAEjxPJ5FUCG4_+mji6ej5U7x1d-uDHnxmChV-02cnPzgKDyMbg@mail.gmail.com>
Subject: Re: Question about libselinux *_with_level functions
To: selinux@vger.kernel.org, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:44=E2=80=AFAM Filippo Bonazzi <fbonazzi@suse.de> =
wrote:
>
> On 2026-11-09 11:14 (UTC -0500), Stephen Smalley wrote:
> >A fix has been posted and merged, please test:
> >https://github.com/SELinuxProject/selinux/commit/fb81f2f56990fccae2c67d4=
1ade5ad4abaa6944d
>
> (already replied in the patch thread before seeing this)
>
> Hi, I can confirm that this fixes the issue we originally reported on ope=
nSUSE
> Tumbleweed. Thank you very much for the fix, and please keep me in the lo=
op
> when this will be published in a proper release.

This will be included in the 3.12 release, which is currently at -rc1
(prior to this fix being merged) and anticipated to be final by
mid-December or early January depending on how things go.
