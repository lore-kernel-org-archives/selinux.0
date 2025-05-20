Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55832528F3
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775389; cv=none; b=Q15DtfS2RAyjebn4c1cKmmNuvswBxmjkXdxELsqmIw29Dm11Lrvj74hjst51RGpyERc2FPMyhUgUGr+Uf069AGBBwB6Bpzz1EDZBmDI8tMQy5APkxx49H2UZUbXOGhj4QWP+GgfTm0AyrBUgOfeHYuzPg/EgbPhiCdHtvN+Z7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775389; c=relaxed/simple;
	bh=+5SNG3Yvej6lGoDZ1n37aC4gcnvTVOUVfNd8IuytXYs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZryOm/y5ILaxKP5mOXiSabSA9LdkSpVqigGbVhjtG66UaCM6k+GaQHvX2r+NU4nSfjiKq0hwPEOz0V5MPwK5gH+aOBcCwnpBGSoTaV2/wkBANfZcYEG9PbA9QDjNU/TSqtB5tzQ2YlAmKPzxzWxNHRb6TH7ZSHQiX+MSiJi+v3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KwJYoC0Q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KwJYoC0Q"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774d68c670so91057341cf.0
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747775386; x=1748380186; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdHU9NAnIZSNyB1gPfdJ7lBAFUVsOw0YgwN3CBHTzFg=;
        b=KwJYoC0Qcj3mGkQ9jHRuvwuOavDRjpARYpIT0h5Sp//QrMeAbhGWz6omlKWdrcNNGu
         YhplWO8S6iw1JHFAtymWlkLEJz87DAE5r5q8K7OlhC9QH9J1kltkKvVsnQF85QI8i7Y8
         aqc6vCsAWDvYLFbb+vnjPmTvxcQ/LA9a5I1KLjXC10DvSYqFvshvr+cOVNc3g19Z1DqN
         XMrFfpbj+mumsgBgRNbbODQVe7zXRn7scRo9dPao4gL6eB4rezmbQ0qcKjmTX5UCJHWg
         Yd1h2m3NvO2iuRU7/d0O6QBCY8NrgzjqAr2haVe1/Vb7qGvF6hxgE4+d/Fyb1GAF9Bn2
         rVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775386; x=1748380186;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LdHU9NAnIZSNyB1gPfdJ7lBAFUVsOw0YgwN3CBHTzFg=;
        b=TvoU8z5c8VjNHPHi+RVWQJU8H4m4tj85hvsHfm95KtVU8jcvcbVr2pyvHQR9qEso6G
         h4qVkGY4s+qHuMJjua7xBR3pjWXKjshqKsWJKeaj3Po0sbgmbn7aW9vW7bFtXIXYYbGA
         4nbKL4FFY2MJNUDLQpWLugDEHKcKBGNry+vNsQ3LnmsNwZedJhhA8TsV45mwbRRFzFyG
         NKlVwHVqOPLGa4JhuBb6goUX2r2LOd9W1wxVSChxKSY+wuF9hlldNSzkppZIecaYaXAR
         s+/m9U5gLWBnykbru34D4bg79pihuV+W9S0VCEXOO2Pw0uKAHSLTPhXVIdi4t5QnM8js
         y88g==
X-Forwarded-Encrypted: i=1; AJvYcCUYF8qDveaEN8GZKl6OIi1wCJ2pifA/lxgxEkEXSCsGlFsQHrG9mfUCmXhQPy4IOCgFhvccbV8u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bJjUliFU/L0MA7rR98eeyB3kP1cRjsotgTlK141k8p3WySy9
	sQI3NMex/1LWKr05ebcdbAynfPJ3h/RfZKsCDTgrs31fzxIZAf7QXd80kxW0Mh8nfQ==
X-Gm-Gg: ASbGnct91O5PGuExq8KzflPEqFCOnHlG7hL5ZvUFBD2yoRh9yYASQYRK9hyCZQzCPyn
	IHnUFUNizSLc5f6cMUkfdsORHHyQuP2a2PADVpbX6fc7XrmjKnZB8Mgigl1/bIqYQYUC3YQMlak
	bYFnXFGBjd9D53GHrFg6CoGfjhNZZD83H2quYDGyCsJsehkvyVl45xFKjeMjKnmd0jk2ZaserVs
	gblwHGP84Vrcj0Cbnxry0FBH/KL2HNS0Ykoi+cmTvF68qVIiXTHSu2LS0mqlnvdlhwT5lyU0lM2
	be1zeHA8w3j6F21wfE2dgq4/qwgKjA9/FnGunsSA77R8sno9nClfNL8+KiKh9I08dDvR5CfPFR+
	h+471Q6+ueQT/qebyb9uG
X-Google-Smtp-Source: AGHT+IEPCw01sIbuF5SmngYqGtpHeiqojHH7hAJQaj8XDvszrqolVTvZ5tPwSh7SKcyuBpsl/vgcbQ==
X-Received: by 2002:a05:622a:1891:b0:49b:464a:3f6 with SMTP id d75a77b69052e-49b464a0469mr32816631cf.4.1747775386599;
        Tue, 20 May 2025 14:09:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae40023asm75509301cf.32.2025.05.20.14.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:09:46 -0700 (PDT)
Date: Tue, 20 May 2025 17:09:45 -0400
Message-ID: <81d0fd707b7c7811411a9dc1caa42516@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250520_1533/pstg-lib:20250520_1521/pstg-pwork:20250520_1533
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] selinux: improve network lookup failure warnings
References: <20250318083422.21489-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-3-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Rate limit the warnings and include additional available information.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netif.c   | 8 ++++----
>  security/selinux/netnode.c | 4 ++--
>  security/selinux/netport.c | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)

My apologies that it took so long to get back to this, comments below ...
 
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 8bb456d80dd5..76cf531af110 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -228,8 +228,8 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
>  
>  	spin_unlock_bh(&sel_netnode_lock);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
> -			__func__);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network node label (%d):  %d\n",
> +				    __func__, family, ret);

Let's leave the message as it is currently written.  I don't believe the
address family is going to be very helpful, and @ret will likely always
be -EINVAL in the error case.

If you wanted to add something to the error message, you could consider
displaying the offending IP address, so long as we can use the pI4/pI6
printk format specifiers to do it; I don't want to have to have a lot of
code in the error path simply to properly format IP addresses.

>  	return ret;
>  }
>  
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 7d2207384d40..dadf14984fb4 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -162,8 +162,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  out:
>  	spin_unlock_bh(&sel_netport_lock);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
> -			__func__);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network port label (%d:%d):  %d\n",
> +				    __func__, protocol, pnum, ret);

Let's drop @ret from here too as really the only thing an admin can do is
ensure the policy has a definition for the port, the reason for the
lookup failure likely isn't very helpful (and looks to be mostly
transient, e.g. ENOMEM and similar).

--
paul-moore.com
