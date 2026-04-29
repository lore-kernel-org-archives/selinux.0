Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C321DDC1D
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484852; cv=pass; b=OhcwjpOganhux6K4GkW6ZgQln5DobnSNHH4/qFZLaumYciYSNQqr6fAsKCMxZFacm9ZmgiBGIJKmidfIinYZDAIGZ5RSMbUiNK7c7q1dY3l5KqfZWj/KbdCt897MRahCihLPd6n0VdKyH23hynyUnhzSH/5qNxmlDDz7z1IBQyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484852; c=relaxed/simple;
	bh=xi2diBI3TaUo11u/mf5EbVZaA3DxhUq4tG6Ay4Yqn6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCTHk3JR8KKg1L3oVHiZqN1TKWzNFOTgB0YjkpvRmDV4vsirOAeDOCo77cqA0N7eYhrg1kxdRsLLqMJ6EzHDqDVBpPOup06OKJIvsxcx2CCJNY7CXm3w2Zb4JwQRfXUUprcuI1GP1Cm/7BBBmCd+N3AIICiU3TUSUbf7RGsCYuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHTRWj9K; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHTRWj9K"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-386b553c70eso448221fa.0
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 10:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777484849; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9URwq4nZ4fWmO/P67O4nTBz8DGxipJ9+dmyM8sDm0vnbWy9iC6QxhprQ4FDnuByDD
         EZJZh0+/gmCkArl55I+OdRCpZc/8PlHtdd/mmOEMvPIxv8Ej7JdXtSKLIf4ttYAyzygF
         RvGiJOQjJLRIEELShaZ+f3dENmyLS/fKY9JNSUI5vbfjly2LcobCsSmPgGyrbBbw8a5N
         F0Ir3dyc4p87wyXp9ANXT6K4aI9SYTZKWCBj4fZg4AMbLE+Ck7MRFjGLFy+839pQlywz
         oHM6gcMR/h71rDXdfii29Z6T964g8kf2SgHHG9chmypE4opEln5VLnP+jTNWhSxiNfYI
         s89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMiWKCjgNPyZemGeGOv6kyt330EBbReFMOp5OuxOquE=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=k3s23Mmilhtallrue8U+7pOpQKp2EhZGils7QkJP9lYFAs7eu/BqvmoSpzXWW9mApW
         E6zBI/w1N5EFuvOoZbTSxW/X/Md/21ffuVRl5L1mNLxZVQYkRaxRtuy7crr3jyIcisKw
         c9aPQiWpCvRVUy+1Bl99J5phmgP1K3iAtW9HpEP4DpkKFDO4C03Pmcwmaj1wntqZezTz
         +8eJdUnxwhWtrov4m/w4IuNgKUxY2QKEBYSJdwxpI4kAHcF6sS0cRorQmQl8U3ASdLq3
         NcRIfYj7/ix+d9DJi52ha+GKCQApSdG5oaBy/KchzT+wWZBo7dW38V3xxHWSsOTrqqMa
         FldQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777484849; x=1778089649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMiWKCjgNPyZemGeGOv6kyt330EBbReFMOp5OuxOquE=;
        b=qHTRWj9KF2zlNmQJLZ7C3N+Tx3RmF4/isjamQhKqpQGzixIdfuHVNcQ46IjOfxq88z
         KZYJ7RZzYCOLOFMf0fmJ/sL0ttCmbZ4W4NwBLnTbdDpqYINy/vqGci4ma/y5uXu2uqES
         2OYk+eFR7Se0TWn3BWic+zDoLp9QRnd2SdxRAIDvjmmaTwwRPKGpEDrBeTugtetS1ytP
         maUAMkQQraSaTY4m2VBZwDWsiFgq9tpVR1gE+b7rVPv71WLH1QyXJzEWZlLpAhs3ECCy
         73YLZ21hi9dt3afijbOtHNlmM6wavNcWfegPhcWBkwmPWkLS6lC/QfBfzBHAYWSi2wV0
         /AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484849; x=1778089649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMiWKCjgNPyZemGeGOv6kyt330EBbReFMOp5OuxOquE=;
        b=rY8VDUcyCy8F74IZD57RULCHMxGj+IoonrF7pw0SUiwDbgmoNdXwpULwqR7/qwHIHp
         de18T6CR8eaRmWsz/UdhsJNrQ7aAOgDh25NNnSTi7LOKiYPSGe8F6S6ZvHRPuwrt2kl8
         4SacDB8yFK4b3p2XxOn5eFb0sYfpkJKJ+EZevClVD/fyGmbRwMr9AB38imZt4SpwjluI
         dhL5MpsKbjhZ67mp50ZC2Zmx8c2tSov7tSK03l5IhWErefhAvnrBech390U+WxzJYnX0
         im796+gyEqEoBIjH02Hm80bpKaeH8gIUhnnzcJ1QI/wdRc0MdZKvORxPV9gh/h2XKx+m
         nDRA==
X-Gm-Message-State: AOJu0Yxm1EsW4V2+mYlMp321POoVJ+l+hWjW1sPquV0rWc/KPEnM93tb
	64uJ+q1kNZqarzNSFy8RMjhQp1lAFO8J3dBTrny8FSHXr+0jOIrQp0v9pmBijWg5sAlvGByo72L
	wH6drAwe/zBSxvk2l0IzmCbQ/Z5mPgVKB+0m+
X-Gm-Gg: AeBDies3xuBX9vJJbPZhAFKPl8r12xZ/t1qwHAymNDc0fAFnyGSLcbBaMJcfgk6DROg
	iZSbP8pPrhUcrJxPGerlriuJkMpJTJ2kJ6o20LCKcl0Fpgn1wlTPdwUBWOVWsChk/CwB/EVTnGx
	QoKOZrcm2t1Ny6tO+8BeAgmcvc3P5wS6oGxwn7oExksO8WJ1rI4QqGPWdeAo0pNgcel3xfnd8fu
	ij19lqCJibyjT7VKxeH8YiU1W9mMRNYnz35Afm/Q7hPmVaHyizQT2oqA/I2YTQOjzBH0zYq/QMS
	3plstLvfEQx0KYs=
X-Received: by 2002:a05:651c:3244:b0:38e:203f:bbb6 with SMTP id
 38308e7fff4ca-39240cac94cmr32767561fa.4.1777484849128; Wed, 29 Apr 2026
 10:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309165432.3137132-1-lautrbach@redhat.com>
In-Reply-To: <20260309165432.3137132-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 29 Apr 2026 13:47:17 -0400
X-Gm-Features: AVHnY4IELxfc3f_3WE-DRsMRljDq3R3A0hQGxj13zjyNoeRANvtA_8oljJ4eKFU
Message-ID: <CAP+JOzTPFyYRK40QFfS2Yur3r0ZnGy05zH1BDU8fQzo2hUpm9Q@mail.gmail.com>
Subject: Re: [PATCH v2] semanage-fcontext(8): improve -e documentation
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 1:02=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Document that substitution based on another substitution does not work
> in semanage-fcontext(8) man page
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/semanage/semanage-fcontext.8 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semana=
ge-fcontext.8
> index a29b74994763..b037491e3394 100644
> --- a/python/semanage/semanage-fcontext.8
> +++ b/python/semanage/semanage-fcontext.8
> @@ -67,7 +67,7 @@ Extract customizable commands, for use within a transac=
tion
>  Remove all local customizations
>  .TP
>  .I   \-e TARGET_PATH, \-\-equal TARGET_PATH
> -Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is use=
d with fcontext. Requires source and target path arguments to be path prefi=
xes and does not support regular expressions. The context labeling for the =
target subtree is made equivalent to that defined for the source.
> +Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is use=
d with fcontext. Requires source and target path arguments to be path prefi=
xes and does not support regular expressions. The context labeling for the =
target subtree is made equivalent to that defined for the source. Note that=
 substitution based on another substitution does not work.
>  .TP
>  .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
>  File Type. This is used with fcontext. Requires a file type as shown in =
the mode field by ls, e.g. use 'd' to match only directories or 'f' to matc=
h only regular files. The following file type options can be passed: f (reg=
ular file),d (directory),c (character device), b (block device),s (socket),=
l (symbolic link),p (named pipe).  If you do not specify a file type, the f=
ile type will default to "all files".
> @@ -94,6 +94,10 @@ i.e. label everything under /home1 the same way /home =
is labeled
>  # semanage fcontext \-a \-e /home /home1
>  # restorecon \-R \-v /home1
>
> +If you substitute /home2 with /home1 from the example above it will not =
work. You must use direct substitution
> +# semanage fcontext \-a \-e /home /home2
> +# restorecon \-R \-v /home2
> +
>  For home directories under top level directory, for example /disk6/home,
>  execute the following commands.
>  # semanage fcontext \-a \-t home_root_t "/disk6"
> --
> 2.53.0
>
>
