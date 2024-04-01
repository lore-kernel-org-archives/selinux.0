Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779644E1D5
	for <selinux@vger.kernel.org>; Mon,  1 Apr 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990347; cv=none; b=VtspxNmtV8W3A7gyalmWyz9R2G/J4eCYKVdqIbyVW9KNfNgCxFYcDsgo49GadFdU0bq9+Q8+OBhNDVv0c5cXzLqCu9RTkwlfUb1ZW4lMi7VXQvagQD2qJyNghZwsLUqTVJRqqQr93DQfVFV90wJVV7hInzGJp1bPHOFT+wyMZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990347; c=relaxed/simple;
	bh=fMzBeJZspaBaS+VO/OhO/AaRhd4TiODjmXNONPHY0+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3+HFuqxtwpDMVSAzOgnwGN0bZh/fgcf3PN+XNBA2o6sdUHiJFFemwvYV6O97xqEakR26hu+qXZv9gmZMwLzrxYJS1SP36tFM7cN/efZIJdLCJQQJldbEx9lsrO/DvPstaUxN4+gnSuPDgRpvAMYBEpCvox1S6ZLJPHLNtfCqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzNSK4b5; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzNSK4b5"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e31fd5553dso1190533241.0
        for <selinux@vger.kernel.org>; Mon, 01 Apr 2024 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711990344; x=1712595144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHxLhh0dBl9gG/GyBGY2li8Tzowl2oMWrWEZqkSG1gU=;
        b=HzNSK4b5byivWfwz4agmH5C7MLtFtPzv7QR//oYREg+4PzHvxQg5Ve2ynl6Hz/Md7N
         QLmls1fKfExXne5rxM4hXa7k2Hocn2bXiE2XvIdMaEfeuR7rZG7cEO4eaIVpEpvLtOR3
         gS0UgYYgCluoaqRa+m9c68wRRLhiMjuv7DRsiVSFD8hX58S0nii9hfX4DaWSYrvwB9Ha
         sdmlh3/diiqlPrdUTkgtrHesf+zjBRgkTvu6hl7ZhIEkxt8ce+cH7egspbnYQXpu81Qv
         qER/Kn21xHA/5CIdpqC/jntci7/fBk7ZIqt32l8DKpwW9Yc/piRe3gsyvKbGtQptGbC2
         4xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990344; x=1712595144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHxLhh0dBl9gG/GyBGY2li8Tzowl2oMWrWEZqkSG1gU=;
        b=Q9Wn1Cb9OZ7cM0Ag5muNXHec6SBaxJFp0pdvW6cWv0Isy0TnyM2LAzQ68LWXlwNgeT
         eux14KYJWxeRHCf5hzqJuM4iBxC8QvmKhgTLGimtRvDIURVPJdXGc81Yb3S+KJMaDK2d
         jgDqphrbE//mMdEz2xODnlHfn8ZCM06pxYtaW+gl01C/jyqGRbGgO3QRwuFA5Br3qB+0
         7ZkOn001JGYUnMfRMfgT7uUcJXwMq3M3q1TJtoS2V73FtOEiCP5QPe+uSa+M0MbPegjo
         D3kpT2tMjVD0MKCewdE7/pOZAjcKMdnk/4t7jO7OeMwct+hTZz5U4oUQoVYSMv2BQujm
         TT2A==
X-Gm-Message-State: AOJu0YyW9ghAgMS4+aBBI8bsNuNLldckfeeNSjYEZau3c95+5UFXfXid
	RXBRDLw1Q7MQ4Dxf6HVnluk+YILB83pGTmp2WkeWEgiWWSf4ZE8GMWOTY5SsTWy52qXo85KStSx
	omJt8m6859hB/vFutLBZOU1DsUgE=
X-Google-Smtp-Source: AGHT+IGtpT0lijQrpmAX8iGX1TL3ki/CHBXfzD6v4DVZE4tR66G9Yie/1kLpoI4bXn9xAwH3CgXnSm4hW7swfxei6XU=
X-Received: by 2002:a67:e455:0:b0:478:45b1:5d0a with SMTP id
 n21-20020a67e455000000b0047845b15d0amr7433760vsm.27.1711990344373; Mon, 01
 Apr 2024 09:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330133502.72795-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240330133502.72795-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 1 Apr 2024 12:52:13 -0400
Message-ID: <CAP+JOzSbXFWTTft7+pM+WueX+rx+SH9hJ6Y150QEdadYJC4i0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: free identifiers on invalid typebounds
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 9:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Free the two identifiers on an invalid typebounds in the error branch,
> similar to the success branch.
>
> Reported-by: oss-fuzz (issue 67700)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 0cf938ea..92d1e5f2 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1477,8 +1477,12 @@ int define_typebounds(void)
>         }
>
>         while ((id =3D queue_remove(id_queue))) {
> -               if (define_typebounds_helper(bounds, id))
> +               if (define_typebounds_helper(bounds, id)) {
> +                       free(bounds);
> +                       free(id);
>                         return -1;
> +               }
> +
>                 free(id);
>         }
>         free(bounds);
> --
> 2.43.0
>
>
