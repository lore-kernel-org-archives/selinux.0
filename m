Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C828E607
	for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777829; cv=none; b=R0z0BdTpF3oaD6m0Hl1WuzZvcomjS1pVSIDTeKTbevV1l6bkGmQI35bbnA76kELeMfPoYXjemoLx7Rkuym6P3TkXnBonalcogpwhO15hB/H2x4znPgLnZt17M5m88w/uOOIcRNmC/o7jU+qBFvAhaTqPHYH7fpZuFltM18O5nY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777829; c=relaxed/simple;
	bh=QHVT2HV9be9dt/brYmFwEDkRHBFdJOFm0jsWMimVtLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7dCSZPDLRdFJ2tyw004OihTsV6h41aahIEjzUQ5JD8AFIJNuof674qLrRZy3Bvz3j5AwvIplNgJaUnLvhd5e2Xp38a/Iw2VvkQgI9EYqjcxfVGsTfnu0T63H5WcJI2/Pk62kdXjj4BIeARKst9x4jwMSjgkYXPZ1YCp5CX1mVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFYBLl5B; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFYBLl5B"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a76ea97cefso59844921cf.2
        for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750777826; x=1751382626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alQF5DGLh67CMz7tHRjQe1AUpL2L6/hoC1Wkzr5ozdk=;
        b=BFYBLl5B/3ltGhLT0mlqE+WjjIgW01NvCI3Pt+ELjxjgR5lk9XaAhObvHZBOnBMkSr
         9vL8bsAC8xnrQtCwt4Po7QXzaxHKPr/56Q7f8YXc2OgeOX7AB1m8C1U+enMZot4jct64
         Q9yNFXZMZbK4sk74ORFluLpE8EiOBStu6Fpwn8ky9dyEwVhPrAzJJ7KBlbZ4LVQzfW8x
         El/gCmXiuM7y8Yq5ZkELHf0ZDzd1kTF4GQ1acfoKDxfCE11G+NbqJqLkbEC5U+WGSzUl
         P4OPpV+LtPVKVy6+aji+9z2PWDl/wQ2Q/u2CqRs7jbU5Ld5Jt+a2q9g5ZHMOTVZGGQ4D
         rqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777826; x=1751382626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alQF5DGLh67CMz7tHRjQe1AUpL2L6/hoC1Wkzr5ozdk=;
        b=TisNqgPXuZg3JXgddoQZPoVIdswXKZ8Oin6piuxw6TLZUoSMwf80Szo/pYTlko/R8q
         dKm1u/gmFO1zyY6gcYggSprkeE/YK7bSsdcbohZkAlnG6VMIKMi+voRCy6xRaRIgWZL5
         UIoZGynP7Kuo+PEEDourTVmPY1x4XtQrtxNJFBRlCPBbJc0zxbXTpUrmytsh5/25aaSU
         Mxj0NjwP361oCf+PSbRbOQ9Sv//79c1MnLYF8KD0Js3PJkb2Ru70IeYWJPuJnG7Y32R9
         QNU+pjP94dJMjXZyWP3/3N/r4KaSvNdKah7AHauwNt02AGCSPThr04vZoRGmkBhfESe7
         NKvA==
X-Forwarded-Encrypted: i=1; AJvYcCWvBVMJ3JrkNauenbvS0p0ei6oOd8tGjp3gjtTEvBZb4a4sYb3w1uxwWm06+fj40e2ila76s9bU@vger.kernel.org
X-Gm-Message-State: AOJu0YwzELZkXaFdEzAJ6p+CKZOy/ov40Kcg4waytXrTlNwCyauirmtX
	qL7IhX1LofErS6WrdNaDrJd6QqDboa8m5gaD+D7Lu096FwoLm8mI1gyori6Em/PDm8zlw+tnAza
	/BvPtzgTP1AGTB92k1x9PPaRbbxdcwXM=
X-Gm-Gg: ASbGncvVPUu/JCrNOcAmPPiP7/GgGBSZ11CfC00WyyJCvpBwjiNokPJgnLSlnV43bWd
	X1NycPNqt0Yg58DDUCub5fC7CSD+pSLaqwbTJua7epA5CX+ppOLQjg/u7UZqNRNRw/ib7muQPHx
	uDCU8asGcNWQMh2fPBFxoz33y7zFBZ4yAuDZsiFOSS
X-Google-Smtp-Source: AGHT+IHXyhWWgmGGDB4/+chKYIECQAwdjtToyfvejcaXF5u/JX5Ke/kh4w3aJy6jK5xthL39LbLwD48VgTpAmFKKEbI=
X-Received: by 2002:a05:620a:269b:b0:7c5:4738:8a0f with SMTP id
 af79cd13be357-7d3f98dfdc9mr2130836585a.15.1750777826280; Tue, 24 Jun 2025
 08:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611070248.2669186-1-tweek@google.com>
In-Reply-To: <20250611070248.2669186-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 24 Jun 2025 11:10:13 -0400
X-Gm-Features: Ac12FXzfMrFPhIBWJe9FUKBQTXxEbpmnkT7gx8CpRCZUDABowcoXzFX2CA26IAA
Message-ID: <CAP+JOzQbrL94Cow5L+SaUhCJNAA_eUu_pkO=VkP1vUfuUQs+ew@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Document thread caveat for security_compute_av.3
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Seth Moore <sethmo@google.com>, selinux@vger.kernel.org, 
	Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:04=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Move a similar paragraph for selinux_status_open.3 to a CAVEATS section.
>
> See discussion at https://github.com/SELinuxProject/selinux/issues/287
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man3/security_compute_av.3 | 5 +++++
>  libselinux/man/man3/selinux_status_open.3 | 9 +++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/m=
an3/security_compute_av.3
> index 6c82eca5..af8797b5 100644
> --- a/libselinux/man/man3/security_compute_av.3
> +++ b/libselinux/man/man3/security_compute_av.3
> @@ -181,6 +181,11 @@ function.
>  .SH "RETURN VALUE"
>  Returns zero on success or \-1 on error.
>  .
> +.SH "CAVEATS"
> +.sp
> +These functions are not thread-safe, you have to protect them from
> +concurrent calls using exclusive locks when multiple threads are executi=
ng.
> +.
>  .SH "SEE ALSO"
>  .BR string_to_security_class (3),
>  .BR string_to_av_perm (3),
> diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/m=
an3/selinux_status_open.3
> index 5c9da2f6..5592487f 100644
> --- a/libselinux/man/man3/selinux_status_open.3
> +++ b/libselinux/man/man3/selinux_status_open.3
> @@ -82,10 +82,6 @@ Thus, don't use this value to know actual times of pol=
icy reloaded.
>  .BR selinux_status_deny_unknown ()
>  returns 0 if SELinux treats policy queries on undefined object classes o=
r
>  permissions as being allowed, 1 if such queries are denied, or \-1 on er=
ror.
> -.sp
> -Also note that these interfaces are not thread-safe, so you have to prot=
ect
> -them from concurrent calls using exclusive locks when multiple threads a=
re
> -performing.
>  .
>  .SH "RETURN VALUE"
>  .BR selinux_status_open ()
> @@ -96,6 +92,11 @@ On error, \-1 shall be returned.
>  Any other functions with a return value shall return its characteristic
>  value as described above, or \-1 on errors.
>  .
> +.SH "CAVEATS"
> +.sp
> +These functions are not thread-safe, you have to protect them from
> +concurrent calls using exclusive locks when multiple threads are executi=
ng.
> +.
>  .SH "SEE ALSO"
>  .ad l
>  .nh
> --
> 2.50.0.rc0.642.g800a2b2222-goog
>
>
