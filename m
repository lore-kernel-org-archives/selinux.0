Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141ED3AB29D
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442496; cv=none; b=DjfQFd8VyabNdrRwo6rnNqC26e36CuIcL7eAfvgST23q3TVnzj4uPxxoBE0hspa7Jhsdmu01S7kp1xTxD3T9VKdwrekvKdlNXJRFYz2VPZYPOWi8HnsEF9IXGGrH95JCud+Lm4Y+HsbnDCnHktaIVPavkcXMzis/f0eFCG/9vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442496; c=relaxed/simple;
	bh=x8TKZ9jYhyzM1a5fwTtEIh8i1mL6sRUGtu3z26RYxqU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=L2ljx0GETurxBeybM/2FhXGTJqYXOqvO0ZYDh/ZO4QbNuPH6sNYCBpTtVaATtXzDh49TNmUlHFfhBjG3QOEbkj6cKttTdBii60jk2g3N2gtM9L4jqil37rh78MKvwc03JNysXYc1+jQVIjrAQrxlq9mBUCaFwW79mt3HNeQZDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cjvtZ5nG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cjvtZ5nG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c5382806fso1870561cf.2
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785442488; x=1786047288; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ErFUHOiSRMdlTPbbaHxtbkT76Bk1OAXPP0xUjronXc0=;
        b=cjvtZ5nGpQLOJ+ecv/bj68vtgxsPuoMFastpvGyH1BgqsrNVcjCkWXoVKtK0w6hXuY
         maoATqA1SErlppyIuJaJXSekyK89+sZwTyeipKwu1H2N2688DyxJXkqVp9vk187eaBPf
         uxCcns+gPqVvR219qLjjOVGOcW7zclNIqWImUsGITMMvSJnjlh+hxGUvMc3ifLwQOlzm
         Sglf0qtWuwg5ml5lCiG4r6PS7JU4SY75t9MpgubG0LIoyTrOhw/+vS1rDP7v0TDQPWRc
         ZamSHEPn2xUy3dhBEe7N9zVfvRGWyG7woPhBwQq5eNmCWEaOurFTsioeU8MEWTA2SEbU
         ljoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442488; x=1786047288;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ErFUHOiSRMdlTPbbaHxtbkT76Bk1OAXPP0xUjronXc0=;
        b=AX2EyCaW34GjRqGhxOy/CM8lnMFcFQPrsjC6xhgwWXzKbj06XB83MA9Ttkz3gObb3Y
         AjSHu2pRVBMcYpI1HRvpQdqed3fLTLBWcs/2zcmdQyf1VFNzuHG+yb6wWiW6cTO5kYcg
         Oi77Crh2TjOzKhPlBGUvO+YM36jUIfiMqwUs4QLS3WEYnZpiBIF9DRGUPFbjAe4GEGND
         AfcJTuayCq+KrUJI5AaF0I15z6ehF/5k+JIEhRbsxGXMLeuXCjgH38UEisuF6ZcY0JSX
         zi+qgd05BUAfiLohRk/ekt9E/DYW/n82lmatvGSPiuxrghRVibfA8okL280iqXRcxGHl
         XBhA==
X-Forwarded-Encrypted: i=1; AHgh+RrHE11wZhdbBM2uv0nBJ36Go/1qcrQ9u1J+1xrnffOB5PszpNkm7R75y6R0FAqzkJzm4mvyu6u9@vger.kernel.org
X-Gm-Message-State: AOJu0Yysu0AH2ybWPX4nrzqKbBa6EnrU/8a52zb0TQK3tjOaQhDXBKtr
	T8n/qGMhRb/37HJQDaLOQoGErWpouZXjhuRNAH7BjDHNpeAR7K3g+l4SDXdHosDn8A==
X-Gm-Gg: AR+sD13NSp21nCl14QCfCrJRXPZEwECv0a1H9D0fwo02z07Daho3l0uD2PNGLa0Xnbm
	UosLA5nbEnbrbZmZNMkrX4Suo+z4seVHwBrFenNCxGikJVn81FuJLiZZgGLelhoTZCxRKXaQ1Th
	Wg5Xmcm4XkKFZQI9EA1D8IKY/wdN2iqUkMCVRvj69mXDMQf9WbuTQtYokF+h5mwR+W0uW0AaYbX
	ESq1i7hHeE88bhpa7HFP4PCAc2yAr2GVA5c4beA1rnDO0pq4miIyRWzHZYRnxX1kB1iXvF9tFEG
	3c2q39O7rtGTTXFTh1MeX59JqqA4UBTQUTAsRho4G3d32kAOL/mSGwmBUi0M3APLWJJcNugqGLn
	tiWZFs9IgLjhIpkbWkLch5Ms+2u6RgnbrqvzKXbqmQv++a4WgGxMwetzeNdxNaWjfpxQLvf6rCC
	Zyk0TXI3AA5hRuDOGeXzIB/8mb3R5j1HCGhd1bdqjn+Kb5UtqX9dezL/8nstdvayMU6s9rqrtkZ
	6N1YoVPKhywrJuaPzAg9u3yK8waVYVq3x4hrtikECJ0DA==
X-Received: by 2002:ac8:5f91:0:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-52b38378d06mr41052831cf.11.1785442488016;
        Thu, 30 Jul 2026 13:14:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908325186b7sm25096636d6.43.2026.07.30.13.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:14:47 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:14:46 -0400
Message-ID: <d6fd17490c9c229998f1d553da088433@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260729_1758/pstg-lib:20260730_1437/pstg-pwork:20260729_1758
From: Paul Moore <paul@paul-moore.com>
To: Bryam Vargas <hexlabsecurity@proton.me>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selinux: reject a permission value exceeding the  class permission count
References: <20260727-b4-disp-eed1276a-v2-1-82d58cf5f882@proton.me>
In-Reply-To: <20260727-b4-disp-eed1276a-v2-1-82d58cf5f882@proton.me>

On Jul 27, 2026 Bryam Vargas <hexlabsecurity@proton.me> wrote:
> 
> perm_read() bounds a permission value by SEL_VEC_MAX but never by the
> nprim of the owning class or common, which is taken verbatim from the
> policy image.  security_get_permissions() then writes perms[value - 1]
> into an nprim-sized kcalloc() array, so a class declaring fewer
> permissions than its largest permission value drives an out-of-bounds
> heap write.  The top-level symbol tables are validated this way; the
> nested per-class permission table is not.
> 
> Reject a permission whose value exceeds nprim, which is already set when
> perm_read() runs.  Well-formed policies are unaffected.
> 
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 3 +++
>  1 file changed, 3 insertions(+)

Merged into selinux/stable-7.2, thanks!

--
paul-moore.com
