Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890C3B42C5
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676247; cv=pass; b=iFiu66ZNXIuV6gDb7Z/OeePqkEnCkqD5V3Ge1NRKRo/QnVDccYEErqzv7RreqdbcoUBuAhQhm8I4kOQL0mbpajs7a1WxCdWENdgeJ6FgwYs/5lfkKhzdf0wu1L3lXEBX3R/1hLUrbMFwKbtJ3HEwvH9Rhr6wXNJE0l5jeacgwoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676247; c=relaxed/simple;
	bh=6Y/SJYnrIFH0DoDTsctmvLbZ/aKCfF9EQZ0xLdXlJEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVa+dhSBe5h0DblVH2HSKZIVwKzrsJhomJ5L/oBQrhWMRLnHxEwOgXfggGDAGQtsBqRl7GwyBS/ZTPC2SoXfeFz6CVSgIGNB47DBUnSvyDllhUNpMsSekbtLHNWevgPY80OC3m6SCZ4V8MYDJZTcSdaFmtUyFmQN4iInHe0uIoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/DE0xPV; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/DE0xPV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c35980fdso21081545ad.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676245; cv=none;
        d=google.com; s=arc-20240605;
        b=argUqmM6Mi84JX8rhizbprSGpUafwEGwFaKlIgbdbGHeKJ4EjYPtDUCAgn8vZApEN/
         Y6IEwq7haCAI4VW4CzowUM6+K6Z89X1sayE3odRFJIARiAiyrQTg2bDwhdFdWcz7K1ca
         s2Fa7G803hwqgXL9pjYK6PfN86p349MH9U+AsfPrtqdpKMB4u3Gv7pSbpb497e3loKnQ
         ddh7Qi2LXTGAy9fn1Bxp1dBg56yHECsjTqq6ayeq5y1wRygpKmKVCswK01ajWADenoun
         tFVNrAq97dmyP5joRcGQr7hQiVXiNhyO5E3fmKjFhpYf/BX6PllZNr12zmBODoCGO2RX
         j96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1HsrFGEfogzfCJ/0WPDfYZkP55atL4B9LUHQetIzjeQ=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=WTOXc4wd3g9sOEFfqwP+QRRboNYvZilnfk7jCwJpi2RikD++9vbA5lcQs191os6jqN
         FTtB+CFRDt7DiSszvBsy6EWHsW8BnX2JZr4EO5pjFbYlo449nDlb/EmJNVQZD2PhoZLm
         mO32VCaSYVovmW11Z38E14rEt8FDB/dR2P8+NvIk6SEv+OiVHQgj+zCgYfB9NPvAdZ93
         CdYbtz0NOaJF2lBAS9SboG9E4L/FgALobTijYPYWbUUGJmSJ2UGH+81HK+h4719Zn+Gr
         nLVaHI7tqxtzeItmh6zsx9LGLxuQ2ZdTzEBofQwfPWdVOwS40mJibG1/VjL/kD1GCToS
         nMRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676245; x=1781281045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HsrFGEfogzfCJ/0WPDfYZkP55atL4B9LUHQetIzjeQ=;
        b=a/DE0xPVj/Nq/ACOKLhrNgutU2L8uu+3mm5u7Zt8db692VWCw6mRTcEZXn0PY68NMf
         /cV9H5gX9iAQGAZ9Y0iVMwbsL11Ar2hK6JdM/1S8scjbLYdBPYysJnqb8jsc6R6MXvcR
         IB0yhgTFizR+riZ1AZYgo0NH6UelOAue+c/J0uWKNI/nDwI4jdhymRheOmbRp8Ar7N7M
         IQoPRGvNwwUtEWe70rNE7/zKFXH0FlPbn7/1RqfXKV5vKOiEhWVfCQb5hvgUmfwFhVAt
         mLmUxt9vJpw0g+s07+0s96pot4iDGiGOLV/DjT33FlDBrtjr2PgY+4QUA8zkiLAQjRxt
         Hk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676245; x=1781281045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HsrFGEfogzfCJ/0WPDfYZkP55atL4B9LUHQetIzjeQ=;
        b=C3e0GjMj0tq4Glv/N2mWvkthXEfpDUClgS3gBJbUCfwd6cBJhZU5Fuc+4Uh53Pg+HD
         XFC+08zAQ4rqsMz+yunAmoKZJTMl/s3ScrpoVz44QdaKxDcsL3LTtfekmqlK9+014QUL
         /Eah8SCNQPBiSwqYSa8UU5Rwr5yUhgKCJ/yVu1WV8yiIpnsbiaf8eQFdfJdyHP8la+J4
         rXm02XvSzWpUMKCHjUn6d+LVpyn0dXNvcA//gEONB8I3GunYaGlK/IwaVFknVOBJgji4
         S5/lcsyrl9AJZoY4sdWYIRUREmlUshoX/E5V0/cZHoHPSyk05zy1TdyWfMVfBE2kM4+b
         Xl8w==
X-Gm-Message-State: AOJu0Yw6qHZUfdlB4Wl1qOr+KoCtijbWJSyJ7+fYErUtLJiCjSvH+8bJ
	khmsPildQsQVg6dIR7el6Zoi19vegLn+ldgl2OC5ffZ+10pjCAdgbLoUAp7bqfH4EJJrC6ysxSX
	rOj2X0eXCNVtRUCfQc/bm7K+byAqMuaVa0Q==
X-Gm-Gg: Acq92OE2zQbIZH0aaqLi7+rrQ8cVmNW1VJMSAKcxajrTNnM7wsSm+xik92FHe0FY1C+
	6WdTkM8oXfUQpm8B5Uu6QNd0gDVCXPenjSj6mtIWow+wOsdLGeOGnNYCEAYvmfqT8KLYsQeaTny
	SFZo3AiHe6qpqDc9KD2pnF0hWOAVOwNg/aMkui5LaQB5LFuMYUeQYboCskFAm3TXeg6m7kigI45
	KldEFo7QboZVN9PX2N25dcey83CBVlAc1sYG092w3seSGO/BpB6YJDMN9sTHCF08uQb/iSc2Kd7
	tpSq9JoLiCFNmNngNQ==
X-Received: by 2002:a17:903:90f:b0:2c1:1a22:7c43 with SMTP id
 d9443c01a7336-2c1e8495360mr53137895ad.24.1780676245327; Fri, 05 Jun 2026
 09:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604175258.264439-1-stephen.smalley.work@gmail.com> <20260604175258.264439-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604175258.264439-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:17:14 -0400
X-Gm-Features: AVHnY4IA4C5Y588H2q2sGXyguxQf4uc-qu_b54T-VmT2afDv_QTa23ZGOaz07hY
Message-ID: <CAEjxPJ4V+H5zNxq4rA5xycZUSZGUHfhvf4Z2TcNgVB51SSfdhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] restorecond: fix glob() error checking
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> glob(3) returns 0 on success, > 0 on various error conditions.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series was merged.

> ---
>  restorecond/watch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index b197bdc2..bfaf4f29 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -193,7 +193,7 @@ void watch_list_add(int fd, const char *path)
>         globbuf.gl_lstat =3D nofollow_lstat;
>         globbuf.gl_stat =3D nofollow_lstat; /* never follow symlinks */
>         if (glob(path, GLOB_TILDE | GLOB_PERIOD | GLOB_ALTDIRFUNC, NULL,
> -                &globbuf) >=3D 0) {
> +                &globbuf) =3D=3D 0) {
>                 for (i =3D 0; i < globbuf.gl_pathc; i++) {
>                         const char *p =3D globbuf.gl_pathv[i];
>
> --
> 2.54.0
>
