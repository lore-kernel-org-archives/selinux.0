Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF66195FE5
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962490; cv=none; b=YSUmI9h3s8VGEDvzAdUNVJ5ws5pWwxS4RkMxZhOzNXyupDqX3uN+Dg1Tab+jE0c8VgnNYDVkAI0JeBdszTKfJomrIOcc+OtuoIc5ybuxLqX0oUlPlISwIwEq7i7i3/466EvyBrfzT8EChi54ms7lS9R/kMA1tOqyo0ndFj81hY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962490; c=relaxed/simple;
	bh=x4PjRcSTAz8U4yoXItZIQeJ62WrickMQTRbayYUX1xU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hqTTLn4DG9e/cs5Ufs3bSfayH25YTdsXy02dzIPuf4BCQVu9p+HeBps2Xw0DEjYL4wzLDIjqUBu9QjIhzFz6a4/5DbzgyHTCg5E595CiRTTWdP8AWOPCKUMC5N4BzQ9sQfmRd/797eKJFIIUHNL/OaR/0yT7ghaoJw5vSelKavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KB0BMpp+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KB0BMpp+"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e1a41935c3so33573946d6.3
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2025 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738962487; x=1739567287; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0Xjf6jPRcSnNW8Db/JrDhnGcIogxUW9iGBHTcTzC2M=;
        b=KB0BMpp+gz+IJ6sq5wBOlNBHvRYk+9dh0vCMMnTGNsj/1wjzWeaMJM6evN6b0byLT8
         bpYm+3CNMPHl8S3mYwO6ZbMX5JP8fsH9whBwA5dWbVrFrIZgqn++AJ/ozBWyB7QvcVDr
         fIUjBOYr/KIqwfrE0hSVEe5VmeRMI6ALJtnPGM0xFAQZF7E2wC4XdyPG/mjopAUUuJmq
         /GUT16QonkPdjSmTfUoepizfITsv7EFAknHMxrhB6YCOENT05Il5sP5WgLyL8Wg2b710
         ald7qL9j5sQg87JvMR7fWiU2QaunrBLnLiqJK55xRvqF/OqSUifkj9jeK0kq3kWjFa52
         j+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738962487; x=1739567287;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0Xjf6jPRcSnNW8Db/JrDhnGcIogxUW9iGBHTcTzC2M=;
        b=MViWKMRQf5v6NOSn5eap4+UqhH53kpOqc5nFo4vzS5wRGwlKEYXbvjOwIwsuyPrNns
         uoZm0/+KAyhssCJKKs2DDs/7tMzVkl8NtcPSbUXmgmMyegyLDFuoEMGnj4nsu7CSvl+D
         Rx7Ryld4BxpEZpzWHxJsH2C1sMzhSsvjf5dbhwo1gFOQFs89eE+r9wi0zRTOyZMVFGWe
         5ticanCalgFr6aag9B4S7dTz1DMW27MEkHMN78fP01azl7j3ZEo6RyoMRuNB0eMVC1Su
         Fcnc08HIwMh8ykZ4SMCotzad3LP3zXBUuj/SrylLqai0j53Jy/i5QWKrGYsC9RQqo7xZ
         L/oA==
X-Forwarded-Encrypted: i=1; AJvYcCVB6jDpSIm+t0O2sMN4zJr9O1LPdW2glY7s0ddGa5jZ/obQFm2+D1ntXR5aqMI1OZ4gV1FC0kQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8SR3p0CmXvc5Fn5Jv0IKDPQ9tw1IEXNROPl4Whva8tfmJ2TF
	WtKMJcien1lxbDVhmIXRgSTdxKpRrnQw6UkebCZluL98XPVmOKuw4G3BrYscOQ==
X-Gm-Gg: ASbGncvBPVHR2xDAqOnhchwMihLK+uDLd7iuKAq6gs1t0pNq814X+JojfH+3rlauIX1
	s62I2vISqfuDc6ff9E1aQhfOCwXnvwZCVfk91r6ymp+/Wx43NDA7hDyH0bEs9c6u6iUL8pnLn0R
	//FIXkfttVVKy4b7FmBN0iN0GKC15+JnT1s3zVGB7RhxxOyiJIzWR5QQOG3QCX0BOkImr1IhDZm
	SNkiOvfu9AicY0tU1BVHJEypSDNxYiQ5CoRO1NnuG1OHHxVByhZlrTXnDwIcek8l++ZojxEK+ik
	zxAlHIdLTw==
X-Google-Smtp-Source: AGHT+IH7BJ3T+xtxB6GM1dC9Ubqq86VhWwzWHGDxE/qt8Uf0uhehvUHVbYG0uLR12Rtu1mCQ8vW+bg==
X-Received: by 2002:a05:6214:194b:b0:6e4:2e88:c0e3 with SMTP id 6a1803df08f44-6e4455f6688mr80121656d6.13.1738962487327;
        Fri, 07 Feb 2025 13:08:07 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e444eaa762sm13101686d6.90.2025.02.07.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:08:06 -0800 (PST)
Date: Fri, 07 Feb 2025 16:08:06 -0500
Message-ID: <1e88f4bd89d4fa90e890877ff6ded21b@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250207_1530/pstg-lib:20250206_1624/pstg-pwork:20250207_1530
From: Paul Moore <paul@paul-moore.com>
To: kippndavis.work@gmx.com, selinux@vger.kernel.org
Cc: omosnace@redhat.com, stephen.smalley.work@gmail.com
Subject: Re: [PATCH] selinux: add permission checks for loading other kinds of  kernel files
References: <20250205205909.19515-1-kippndavis.work@gmx.com>
In-Reply-To: <20250205205909.19515-1-kippndavis.work@gmx.com>

On Feb  5, 2025 kippndavis.work@gmx.com wrote:
> 
> Although the LSM hooks for loading kernel modules were later generalized
> to cover loading other kinds of files, SELinux didn't implement
> corresponding permission checks, leaving only the module case covered.
> Define and add new permission checks for these other cases.
> 
> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
> ---
>  security/selinux/hooks.c            | 54 ++++++++++++++++++++++++-----
>  security/selinux/include/classmap.h |  4 ++-
>  2 files changed, 49 insertions(+), 9 deletions(-)

Thanks for putting this patch together, and double thank you for the
tests too!  If you've got the time, it would be great if you could
submit a patch/PR to update notebook too:

 * https://github.com/SELinuxProject/selinux-notebook

Some small comments below ...
 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..e96ade50c137 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4133,10 +4130,33 @@ static int selinux_kernel_read_file(struct file *file,
>  	int rc = 0;
> 
>  	switch (id) {
> +	case READING_FIRMWARE:
> +		rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +				SYSTEM__FIRMWARE_LOAD);
> +		break;
>  	case READING_MODULE:
> -		rc = selinux_kernel_module_from_file(contents ? file : NULL);
> +		rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +				SYSTEM__MODULE_LOAD);
> +		break;
> +	case READING_KEXEC_IMAGE:
> +		rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +				SYSTEM__KEXEC_IMAGE_LOAD);
> +		break;
> +	case READING_KEXEC_INITRAMFS:
> +		rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +				SYSTEM__KEXEC_INITRAMFS_LOAD);
> +		break;
> +	case READING_POLICY:
> +		rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +				SYSTEM__POLICY_LOAD);
> +		break;
> +	case READING_X509_CERTIFICATE:
> +		rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +				SYSTEM__X509_CERTIFICATE_LOAD);
>  		break;
>  	default:
> +		pr_err("SELinux:  kernel_read_file_id unknown");
> +		rc = -EACCES;

If we can't come up with a way to catch new READING_XXX entries at
compile time, e.g. socket address families or capabilities (grep for
"#error" in security/selinux/hooks.c), I'm not sure we want to return an
error here, both because we haven't previously and it ignores the
loaded policy's UNK_PERMS setting.

This also applies to selinux_kernel_load_data().

>  		break;
>  	}

--
paul-moore.com
