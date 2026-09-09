Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD83AB299
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983010; cv=pass; b=lMFEgD+EiEKB7DV2aNM2dcyiUe12ApfKyFZMBPl2wyX3FFh39GS2g7eKj7x4eI/rMjujc7u4ywkkJ99AJVk7r1tyroOXIdUu3/7QT5O5ZfRLoKGAlfEayzqlJ7KcJQ5cc+yDfuiRzULef1NZwgAd0vTDBZAycx0wJLpOBy+NI7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983010; c=relaxed/simple;
	bh=bd/jblgCsGCR+XhPR7tcLqBmFBvbndwDT3I6OWSiGOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJkLP2zZLSo5YMVCSo8UKwnItaIcNKlXeH5NDL9JL2aQ8BeWH3OmQ/fsYkoxer/auPjOnUdk5QVxRBRWQ8yYH+orvsKkamgSP3hxkm3FEUqZJd8aCLgTcRCDTyDBXIW8shuntMDqvHXKKSXfmUOz7p+vuyWxTOl1tXodEr0dTNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFT47uI4; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFT47uI4"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-46ad7304688so204982fac.0
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 12:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788983008; cv=none;
        d=google.com; s=arc-20260327;
        b=gHuKU9NBLPeJLYY82ZHzIkCs2m+o9jIpOhaSceyTf9LNCNxuGmW+6EkullINqoUxfy
         Pk3mVDJ0N9mRl/mIQ7Romh/7P+Q9vQ0J0qbKNzH3VAKmUtp55f4rEdCWEZOVADzd0UaJ
         E+9Yr5i6syBZTf8wEYGLzz685xDlngU5LAY6TaLh319l9ZpKp9zu7ZWD9ogYeGrR+BFR
         b/wEmSbe4YXSV7+EcMTUHYpCnbUOVCKrGftfqjjbe9agBFME+eDBNSQjHejsbHDfRjYg
         re0OxQVqX4M4Xs2x0jypBLKuwEo2ri2QtSjDpGtdim3Mg0d0ZkOnKvwQ626LCEKRCCKz
         q0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bd/jblgCsGCR+XhPR7tcLqBmFBvbndwDT3I6OWSiGOA=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=OIJ3+DSU7m57btDIi1osIzPo7ygaFwiiA6w5tfuqsZyyIt6JQbgCj2DLvH/iDinvFI
         vD5TOV0btlaSnkVnfgYeYbiyriY3fwJGUHpvD26Fd0AykO/x5lWIXMn5YgEHpwv3PLp9
         8Xkiy+nLiclL5He4XueALPrFPtEnrDpH4srHCx1ekkEckaYH8yi4lCRRCd5+FI7RelTA
         YBiU6FBknEdjOqOaXgF8tuV+cSAbYXEXgVtH4Hp8vbNkdKnSyze2h/9YjzmetNMdd898
         dWnFQyJG64KX0i4uE7yRYqaz7JnRBQqPvkZslFVm9CNYMk/0+b/JAo6F4e+4RiQX5stq
         Wfmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983008; x=1789587808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bd/jblgCsGCR+XhPR7tcLqBmFBvbndwDT3I6OWSiGOA=;
        b=TFT47uI44Lc9TnCFR8rxOfCHRsedrpR8UbuukVzuCoxyAcArIVP6o1QblLr+cTMari
         5uMkXP+MnvFugffqrLbF1DSc6UstbdYTflASyBY52tHgkyoZ3exRy1pnT//rxVs9Rdwz
         qxz1yl2wWJhUwDKDlDA374IXUTa3J54gkN8mu6pivN65z21QuFW1FJWDoNCPymucGR/+
         PC4odf8TB7Aonz8OigYiUuEzINtAjsYrCa7KPSWoEL65qCRb7dEZAYqxXVubSxOPdYw7
         jNtNZBlj1RqvYVGIYdA3U1J9P1DWUJrlDPD5zPS4fVhtj4UN8g9aTDQqerZCKoFs+oWr
         Azww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983008; x=1789587808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bd/jblgCsGCR+XhPR7tcLqBmFBvbndwDT3I6OWSiGOA=;
        b=IveIUuQrUst7Uk6+X4gYHQ8Jtz1UVSow8MsPd5wEP7N2RXJJIvJcUqwB6GS57nIozK
         VDNLUvLTSg0hCVpmsp1CFImSo6VT3E/SZuLuSFLv8Wiz8rwqd9ADa3/8HfxmDRZELHFN
         saZPCIhR/ZEB0Ku8S1lM6/Q+vWbxyaBqkkB1J4tlqW8r1A+t85F6/hhaGPm37CVj7ryA
         gcdi9D+AWZzikDqw2Fotk8PlrrSHSGUiw52Okph3iA+taWrJGHe6rxUw8Wm6WFeeUscv
         AmlJbJroo34G3E8LsIUmb80xLc6KpHZpNnn8/I77LEpMCpwmi830wpeyB1wv+Wl2ltlP
         WfMQ==
X-Gm-Message-State: AFuF++n024v700XtJ/28c+p4rYJfvW3J453a3DbUvRcd4Pm9ofBwW3oU
	l/U2CRb++J1eyqpn2r0QLfsGYEXKjHOShYZqs0azCz6W0oIxVSKy7I9uy/aB2Hpddsl9A8Jv3Ti
	xmZe8KXRD5AZDK3WDPCNRd4jfDXN5Qw4fig==
X-Gm-Gg: AYBFou3vv9yye54uSg3ipGQ0edo4S0poKGd9xdXFfs95A9e+EYVDThC0ukBQUbkIpYR
	qvHhV1ZGClHNiYOLcG5R43ye2XK8yUvpfY209i9D4EkYqZ98RVeBDcZ55Hrako+72+iznzISvRh
	Qc3AgrhTXq0eosYzTZwQVip3rPyxAZQ9dkYs/sXD368F25C4H4XdnUHk+AmcVGBt9fFl8sKee5x
	Wnt669tIvXJvvXNFwKj+f2ZwHNsY9KnTO4iXg9a39WGhRtz4clNUSyScqHFPW3NU9RpjrfnWNJR
	gqwrLhZtSoGtlJwNYC/hm5E4TzELl1MjTIT1mILJHGsWGSxGBss6f98=
X-Received: by 2002:a05:6870:700a:b0:470:e97e:8f88 with SMTP id
 586e51a60fabf-47c9997c03fmr568504fac.24.1788983007630; Wed, 09 Sep 2026
 12:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 9 Sep 2026 15:43:16 -0400
X-Gm-Features: AcwNN1UKXN2rX6p_PZGlZpnPCtueCSqdGssrx3lpEALL7tng-AtDqQkOIbkEs0U
Message-ID: <CAEjxPJ6Ghqm8Dve1vADXkXS2pv5PXzObrGfmruD_Z+KcNDFwaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: validate portcon protocol values
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:27=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> validate_ocontexts() sanity checks the port range but does not check
> the protocol field. kernel_to_conf, kernel_to_cil, and module_to_cil
> all reject a portcon whose protocol is not one of tcp, udp, dccp, or
> sctp, so a binary policy with any other value passes read+validate but
> cannot be decompiled.
>
> checkpolicy and secilc only ever emit these four protocols and there
> is no source syntax for a numeric protocol, so bound the protocol at
> validate time to the same set. The kernel additionally bounds protocol
> to U8_MAX at load time, which this covers.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
