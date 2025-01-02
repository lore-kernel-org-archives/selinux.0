Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB9367
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735825650; cv=none; b=a7ExTocK/OekwO6Zhcm6K9NL9az7Z2X4OzaxtYrHPYdiRymLWD8lwFhsMcCZKe+nabCogFvkJlthJOUQfE+1PoEt17cL1EciH+nXEYRoA6ojkSNnrRjOOPUAIsXia7YENV/r4URKoQ538FRUidsytTddJab8QNOFevEQ2eBn+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735825650; c=relaxed/simple;
	bh=qzUqWtQVSoaLgwNz4sVHJlynWXI00cVbxDts4YtKCgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwbcEBC7uVTv8LptOwz9bHuCu8/r5YQIH6EMZjo/2r1f/E+aY3HK927O4C9Dxv9dvPT+1rQ6OqIcTRVrZExqmwUHJGTYvAQSAOcC07GPhpVzI8F+r8EVtzPizaeMONBf/qkgcndYf++mA6wCAWM6119EB4l8ax8QbCY7968pIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7Jpxz++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7Jpxz++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735825647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJwEQInCF7+OzVrp/eHnQB5hz7vloRmYHfbK30oz+6c=;
	b=Q7Jpxz++8syo7CfX1LJoNY/UQe6WnMsgwEnaG4woMbH86KFFtjon0dSs6AQS3XrCfDdmoz
	sOe+KgEpkeq5+bfONCAnvEAH7wzc5TcPCbv8H519CET9GrgyUyPDblelzlhJuHEbiHwu75
	bSzXKRgyz/SL8vmYjr+Il9w6Th1c6dQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-4rsFsM9yOrCp1WpKPYvw0Q-1; Thu, 02 Jan 2025 08:47:26 -0500
X-MC-Unique: 4rsFsM9yOrCp1WpKPYvw0Q-1
X-Mimecast-MFC-AGG-ID: 4rsFsM9yOrCp1WpKPYvw0Q
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eedd15c29eso15092685a91.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 05:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735825644; x=1736430444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJwEQInCF7+OzVrp/eHnQB5hz7vloRmYHfbK30oz+6c=;
        b=Ob2y5xaQw3HFEQJOvO8ync7pj+mnk1jGT5NUMAUFe09PWtX3KQ3v5FPQRjWIsBlPXF
         TVpERzAiecQDmtmIQ/WkH5HNKGtQ+uHCWq69QhC+4PgwlVHJiyqinvAhhRHSwfdi50vJ
         sG0FRIAiSeYX0VVbZ1JCR4snhlFozVVPPEPeqwHWRTxBgu5nntfk2jqu4wFvRjK9ZlOY
         1Z8n/CA7x6e88YuHYuRi+zzQAfYS2pLeab7TphYRpUm0QCyiQ9OLDDwuZ3tp5K8HXCX2
         U2/65Dz6JGJx/lfqi4CJF3hdeYcgcCQnvJsFW8thEgdonm+K3kjc+RiRsQhBR3CxmwKI
         Aukw==
X-Gm-Message-State: AOJu0YzLGA5boqqVmXtNw+FSTD9C/AN//lTCpEfXk10IDbkrmvRd9cls
	cGfpvpyy1SU/PXrhaOT9MP6Fy5laj8PyBNATH4LVvVNBhelu/1YhXlivHogl54AGRDMZTZiTqmY
	18msrlniEXVCm74/jGVCrO3Ea7xVONeH/JEeoUpesRjxHkbA6nxTBZ0MuLCPY02YddEcH7Fx+Ir
	xI4r3el+8TRMmQ6R0+g9vDGN4QH1oTDglDxF1gqkBV
X-Gm-Gg: ASbGnctbBhtwoBZIf6xLbl9bAXKyrMdDzv4b5xsMJCiK5mS5oNq7bJOQOgYopP+RdoQ
	s6Lp1jrtMokNrkAmcv2ZnP3Rbv9INvJiL4NxDAJjThc2DDDIYFtIF/Iqi+II/OuEeTmTFUC0=
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id 98e67ed59e1d1-2f452eed773mr61305746a91.32.1735825644536;
        Thu, 02 Jan 2025 05:47:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQw+xywn7KDxQR4m53pX61eTtILtRdGLT8losgIn6o4LYcwdoYfdD701ho4yJ6xgSxxavj8MUCsXNt0jcgeig=
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f452eed773mr61305730a91.32.1735825644243; Thu, 02 Jan 2025
 05:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024182424.138616-1-paul@paul-moore.com>
In-Reply-To: <20241024182424.138616-1-paul@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 2 Jan 2025 14:47:13 +0100
Message-ID: <CAFqZXNug_wX_d_qB=gkegoTwkQSM71b29Fxw7d09yZMTE+PbNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] check-syntax: update arguments for astyle v3.2
 (possibly earlier)
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 8:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Update the astyle arguments in tools/check-syntax to work with modern
> version of astyle.
>
> It is worth mentioning that astyle v3.6.3 appears to have a problem
> with aligning/indenting continuation lines, preferring blind
> indentation over alignment.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tools/check-syntax | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/check-syntax b/tools/check-syntax
> index 2115a7960dd5..2775eb46c6c4 100755
> --- a/tools/check-syntax
> +++ b/tools/check-syntax
> @@ -57,10 +57,9 @@ function tool_c_style() {
>         astyle --options=3Dnone --lineend=3Dlinux --mode=3Dc \
>                 --style=3Dlinux \
>                 --indent=3Dforce-tab=3D8 \
> -               --indent-preprocessor \
>                 --indent-col1-comments \
>                 --min-conditional-indent=3D0 \
> -               --max-instatement-indent=3D80 \
> +               --max-continuation-indent=3D80 \
>                 --pad-oper \
>                 --align-pointer=3Dname \
>                 --align-reference=3Dname \
> --
> 2.47.0
>
>

Thanks! I applied these with some changes:
1. I dropped patch 2 because I don't like the idea of filtering out
known bad versions.
2. I updated patch 3 with what astyle 3.6.6 enforces (this version is
now in Fedora 41 and it finally doesn't have buggy behavior with the
testsuite's inputs).

The style-check job now passes successfully.

https://github.com/SELinuxProject/selinux-testsuite/commit/0f3dec2ab35e8739=
bb31bab8e6fcae51010c557c
https://github.com/SELinuxProject/selinux-testsuite/commit/68ff0417fd8ac0e5=
c9c5897a31dd3c7d17201306

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

