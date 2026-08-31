Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9181CD1E4
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207285; cv=pass; b=Z5fFIsZR2d8BePrfw6ePzF2YlMYefH0XRW6VCzaxasdXNEa4vC+7ez9Emgx0drNgTRDR9rH9hfX45AJq7T67qMUMSu+r15t1BtxfvglgYiWCqCTb6ShLh9/t442JblA7PEZ0u5eoPPK+MYSBmWj3rv64dZsRvnY240MpuKT5Jyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207285; c=relaxed/simple;
	bh=CgGLHRvsKI6Fpof+GFlYxoCqQNh+6N7WiJ6wV8eTwug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcOAGhJUpB9a5axWINpRtWb8Cgi1at5MozD8Y8YIKB0287mtEADuBdsQBHOPu9uGMy7NaQVf5wBm1r1Afl+WecP9Efr4PcWuFb0AS26rPUbWEmhhh4op4En1rpy5dF/FYbeAn5vAU3Zfl/cst7viCWJyHY0q2qVUwvo+fvodRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIuQQZT9; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIuQQZT9"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso188161eaf.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207283; cv=none;
        d=google.com; s=arc-20260327;
        b=LdXPcAxAPMInaUOe5enAxO8VV8rWHw+qcj2KEVIsS3elaQWqa4eGivJDk0s6anlTwc
         SBvUL0sRO0QoNS2mngG6WPB+SUvX0V92iYrNDZT257l5C9E3YW9/85GTU7H/CnMmycFk
         6j+JfQba6KchVrKfWMI4k9vI4bMhNck8DKuLliQKPt0imUCGd1+pPAxEyUvuPrrn49dg
         8Ae/qDES9FxMigX1YPQV4wbfbQSzpnIFpLpoJg/2zndeQjKqGJ1gnROmdT7hGDzv4Df5
         5OTwKCohBfojc03anfVMNbgueIzC5qI9Cm0FdF6PVCCl1h7AEpvAGL9UAbulT7UT5d7a
         +R2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgGLHRvsKI6Fpof+GFlYxoCqQNh+6N7WiJ6wV8eTwug=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=lHtAl18qRZQxOaI+9fjYMptbbhV2fXiU4aSIQI71+Lk21CxDVpeemZnR/Mtr2WCC10
         sibTzb30+aT3rLFt1bfJILPphQ1sLbrGmaBVo9QmodwUnIVvsn9Lj6LYq+x0e1DE4QdE
         xhk+ixdt66mFqK4wJN2mKAOsmaa1XJNMN56b2ZGqaIJ9A4JjK5ZzU625DbW4zYk3XI/V
         F/8EoNT3fJnuj3CCBmDddSOOazBdvsN6IzkejpKS2Ne59oQIfSRsYp/FVpzvnCme0v4O
         MC+HijC8DNssSud6bKLIoWaczV01r8O70HFmx3YPIcC4/RYMaJ2u+36nHZDkaBRI6ngT
         hEHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207283; x=1788812083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgGLHRvsKI6Fpof+GFlYxoCqQNh+6N7WiJ6wV8eTwug=;
        b=HIuQQZT9QUWA4WJp4ocEuD9ZtGR9otuvWLVHFSjpcaZ8h70YezRBlhMsdwJMZCM/wz
         8KgSPASjDwNVEJrDxiBKs8qIJrtlmwAhUrFQGad0pZY+9LEiYEe4EpY8/ls4TK5O29CY
         x/fCphXbEJ5dJq57MlJplPeggdNiuTTlTzqWuqxkw5wm2c7/0fgDSgdqI5RKwcF6UqqP
         DLmghPcQGyvLCgHdDBkTrYx5MyIZoJiG4k0fOqCL2YENMlxRvLWV0zQrBSZvo6uTq93o
         Mw7sW9UT1K448DzDZrg+x8WPI5m1Pza+npXZjIDREETvDFO7Yyo4vb14yVI7aAifRSes
         micw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207283; x=1788812083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgGLHRvsKI6Fpof+GFlYxoCqQNh+6N7WiJ6wV8eTwug=;
        b=dUaQA+QEMtN/9Yjdxv8d/OV2lmL7UnN87K7eyMzrHqtAJSHKE/Zc6zxVzjMsbXDb8Y
         4ChTRo4MUHJFBbRQtK/3Opnd/QnCO8dH8fC8cnxoU3+7iprf5xMIjASEi6HLVjDYGJDe
         ehESD6H0pRY/5s45FuAmygGCvf3pGqWRa4Z+B02ElvaKBrCLn3fRDD0CUorcYxRRfaaU
         t0xCjWt+5f5ZaAE7ux85xvZkdvLxzVI/TH8Xip6DVrF1NF+6SPXZaoJZBMc0PMyh+Hv4
         1mGmClDemnahrQ6Mm6XISIwm5c/+5KOTOYeruvSEMBMcMDL7RWa0OF4aZw+NlBfO0gLH
         Iw5g==
X-Gm-Message-State: AFuF++mgNsQN9bYDMrKriKQky/3tVhx75TjrO+PLlNLBWE1JP6mjx9t1
	cRMWPzoiYqSfoBPY6l+pBX9AuyJ/xVt1AZPsIeE+1QXj6nkCcM5lasDkOhGRv5DZOwc8oCDzqU/
	b3xsN2VOPtA4uBJZSvrdsTocXngs4LczfyQ==
X-Gm-Gg: AR+sD11H4xzAOB5JPMl4UqZ6fNtj8Ym1j0PUa3oKrJ7kLtPxKKr+iozwWpgg/DWg/Rj
	LF72WWihxfGwm78CrTP+kY+NxrVhsXqV529QfX9EZgMTYE/yA5XWNnW/Jp9QtsIFU1nY4me9qCo
	BGkInfYseXWSAK3lwvdcvdkOz7gtKnBHmenWE/Pek2IVGxsoBOWoaeNifhKeOXKiijYXgj9JQ7V
	acwr5MR9eX3hq8HM4839xE4VR29ajGwkot9/n7uTQlwcwzh5SyVuB7zqccp1MDGBeVfW6YfPo6t
	jaSa9plrvfh2MwAdhPlma0B2g5K//7FhiJwIW3Hw+rBA
X-Received: by 2002:a05:6820:f010:b0:6b1:bfe7:ca9f with SMTP id
 006d021491bc7-6b1c6771104mr24913381eaf.23.1788207282899; Mon, 31 Aug 2026
 13:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831123902.3938-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260831123902.3938-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 16:14:30 -0400
X-Gm-Features: AcwNN1WY54sfTDl77lY39uH1Gv3cMvRtJV-qGNOgGAGuTayBEf7LB8J_GnKH8SM
Message-ID: <CAEjxPJ61LGzAvb97odVTm4fzpf2Ttmc1aZUXs8cZQv-1-zKsvQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not reject control characters in pathnames
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:39=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Pathnames can in fact include control characters and checkpolicy
> accepts them so we should not reject them in policydb_validate().
>
> Fixes: https://issues.oss-fuzz.com/issues/554550509
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
