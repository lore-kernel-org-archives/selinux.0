Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657C151990
	for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322887; cv=none; b=JHZnv4fElFxlSfetkEg6MugW9Pe+oUp2RIJsJ++FfYuyhmj3iE5+pEe70bzltn5G4xr9bmLP8u8l57BHyIWCWYX4xxqacDehJ9h7p5oarB290jraoqPDc3yzg4m6cc0yZ6gnzpY9vcFf3D4iD13i3Y/ByB4tnQECKYkc9N61ED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322887; c=relaxed/simple;
	bh=+1KaMyvFYtE7dU50t7t9783/KIcZ0Z1Kaeb+F4fEVnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgxMvqqb4xNG/nY8ZUEYLGLoM5Hnfxx2GmVqnwogZad466bC+yoKqWm1Nhtt50ESZEln2tVhzb8ssefIraEwufR9S4I7ED1kYFckw40VVMAZp+OujfCGIYMv1vwDc9AK5iTveGCCc4vg5DeaZ9aJQ2ij3EirzpHvn0Nlh/If6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpelwFSj; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpelwFSj"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240317b3e0so2206994e0c.0
        for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322880; x=1742927680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouqn1Uc0qMmwT8aBozq5DsU9p/pzzmhe5qFaLn/F2n4=;
        b=IpelwFSjwS+YM1vJP2LiSGtUQsN4es/187WBqWwqKwmkUkxAJvWCEqJ6vT5U3XNs+u
         rEKFv6dne5rqHxrUCXVTaN/x4haOvz1ddKiZgYzOQkJzW+dxs8Mwr82TrcJDHcmwqkH3
         gkt7Yfxb0Yd1k0570XZtkAnctNNCKRn4uL9eGG56OJQYUYuzm8lxIK52/CHkFUM5g5Kg
         r5Mr8rZPH844KtjZdtgNAXqaupv2e0ai0alpRv6OfUrEa3liNgfgfTx+8k+09Qt6vIae
         ITtTNoqwDD7svca5CV4CHcgbPqjCuxRtORlCIJI4E2icf9ayfKmjB71IJVy9llAGaB/x
         NI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322880; x=1742927680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouqn1Uc0qMmwT8aBozq5DsU9p/pzzmhe5qFaLn/F2n4=;
        b=XzvJ7KqtEVyQLr1v4zJMFuV0pE50PatdGhz1R1jdQ4jg/yn+/LUa9wwTK0mXBbi3hg
         TEUf24ga6enLtFnrlI1vzA0sf8ZZfk1VQw6t7t/I9DQPlX+YbS5dXgVJDCWEoG/3d8IS
         Xv0gcEsm1wjL82VZI3xuuUccF3gRVtau/VVyrszHrVyYj+FdGFSfkVgaMgF/cm7eFaTE
         pD7tvewlu3lVdHzN+9U1sf7xcQ1eAok/3x1thffJF7lJB06n/TeMGlJKYDYQqI9DzkN/
         fdph1ymAls8oLPFAr0tD0eF8LiH/KOsly/yVpBUtD9kGMmCpW8SrYNXiqb3U8no14TnP
         uS2w==
X-Gm-Message-State: AOJu0Ywm02Nl0H1bsWuK6if+RT9LW5x6GPu66Qwxv4AbptAaeB/6+aU+
	E/mqGZCkoz2yMQIVis/UVzOYpZf0hi/+AWd+AF2+m5aW7p2NG3WLwJD82hb+/HS1WEb6AvGW9GP
	AR6IxyeH8JLp0qOfaG16PBEWlfUst/CRr88U=
X-Gm-Gg: ASbGncuSV7H9xQsHtvEqUD/+jO5KnvubLGVkfYTL5+8TYNNDwnE2tJ5xy2s24GPVG3d
	kP+0EKPjOOiluT8oVYYeka6s+DcCVLAC/bGKIKlbe0mZuq+gnDko85YreioZYUkZW8SVrfcooUA
	dVRe1OloBRF9xa4efI5xj8Z9Y=
X-Google-Smtp-Source: AGHT+IGB2x/UAN3GIXTlCh60Os6r+z5GZzbokJhqWHXUNHF4LsIl0t5You5nMB48zzANIeEXt2b1ZPB+Dt1LdFpmP4Y=
X-Received: by 2002:a05:6122:3718:b0:520:51a4:b81c with SMTP id
 71dfb90a1353d-524499aaad3mr13271912e0c.6.1742322880118; Tue, 18 Mar 2025
 11:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314131751.28289-1-cgoettsche@seltendoof.de> <20250314131751.28289-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250314131751.28289-4-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 18 Mar 2025 14:34:29 -0400
X-Gm-Features: AQ5f1JqSDI6vyOu-xHo4vw9-eWDHd1HgrZyhO0M2Y7kZZD1VVpm3oqwj8X1-iJk
Message-ID: <CAP+JOzRSKsrx_Q+2GRGUvzaxUaQCZ2W1guwvg6z0NLtDb8+k1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] libselinux: constify global strings
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 9:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Declare the read-only encode table const.
> Drop the only once used global variable selinux_rootpath.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/compute_create.c | 2 +-
>  libselinux/src/selinux_config.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_cre=
ate.c
> index d19baa0b..ff8553bc 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -33,7 +33,7 @@ static int object_name_encode(const char *objname, char=
 *buffer, size_t buflen)
>                                 return -1;
>                         buffer[offset++] =3D '+';
>                 } else {
> -                       static const char *table =3D "0123456789ABCDEF";
> +                       static const char *const table =3D "0123456789ABC=
DEF";
>                         int     l =3D (code & 0x0f);
>                         int     h =3D (code & 0xf0) >> 4;
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index 1d8cfb71..75db14ba 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -153,7 +153,6 @@ static int setpolicytype(const char *type)
>  }
>
>  static char *selinux_policyroot =3D NULL;
> -static const char *selinux_rootpath =3D SELINUXDIR;
>
>  static void init_selinux_config(void)
>  {
> @@ -312,7 +311,7 @@ int selinux_set_policy_root(const char *path)
>
>  const char *selinux_path(void)
>  {
> -       return selinux_rootpath;
> +       return SELINUXDIR;
>  }
>
>
> --
> 2.47.2
>
>
