Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A366AAD
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186061; cv=none; b=YndYbpVSHAuU0b80f9Ppl6Dx+hlbnAtqchTx6/uI92X7fuQkmLFx1+V38dUERVc0Q6NQCDCVN3xBIHPzKYR+I02TLq5SiT141dCmiVr9RzS7N+ZH4HI/H5sa3M8ScW5CwVXXPSSdAiK7fUZ0ua9qDW/sU7lnAIHdshtQmMt2Ky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186061; c=relaxed/simple;
	bh=aioJPEYLjwl6mmsj92gk2rm4OkZIBzOu8hP6/IXGIa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wtq44wS8Oe56ObOSiOKYbm7kLVTYybAd1yGGlooh7z+389Bm2qH/daUaj73IdvFNbi79sHxehUjndm760s1Qko7CfbEWMrNmwGhX8fDgF8DFtq9n7+1QJO4KDnHcN6licRCZvdRzCQQ5v6TVHvZDr2rgRwzZU3zX39f01W6aWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9pHzKgP; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9pHzKgP"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de18437aeso274e87.1
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2024 16:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733186058; x=1733790858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGe6JsrNW4kBQuJtoX36qYbTj+oa7xQA2wBCWSf91Yc=;
        b=y9pHzKgPrb3YV0lrKg+Wu/OBD7ZkqY8nyVfT7AypFD0W+E5wMogm1eiB2V3VK2ELBi
         DjEeiJqC6bt8Rda8RyDEmlpU9IDTGyVbciXarNZmsfzdudy8wS2al9EiZ3gnD5eHlImx
         2DkPT/xAOv+MDFiQqSTK1xgkTIuUu4fJQiIPZV4TPUdM6FgEQP+IsUkvCOqQPCpZnS51
         8cEOSkRH+2CyKwrM5K5KDSWOfLHMEbGOK2cyCR004RGjSmJBLmAF9WpBfVFVlwGWcbHb
         w361YTw9Tt8bACeLJxTVo4zPoYS7GBbB8VC+Ysj5vvAbPGmBD/v9COsjfN7J35H5yyEh
         4HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733186058; x=1733790858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGe6JsrNW4kBQuJtoX36qYbTj+oa7xQA2wBCWSf91Yc=;
        b=JPIruuCg+AisrQIxQY9WIb4J9JH0Zdl2qH1pVYJTG/BrXN26DqWU+vQBqVOmNVZwpl
         SU4eaKXZcSj1cUS5RxGv0iR5OJsBdymgCgz5iHlyqYhfbZbTg4rC9U66/Gz576lDdzno
         9r0EVl0WOoepBKHHCIfZvIHHDUIhOMZ8/UOoClicP9KxknszX+pAzB0QmUcVjz8A9LZc
         qjkBVrr7JtKeO7sCnYbQvIBttPQEEZF0Aoi5t03hbRkuDcK575yVlyISZ0WjAaPwl4fH
         hlYh5TXCu+u6QTlJ961VVvD2FhaL+gwINqJBxcsNubxLRtUyXXjJ4LDOvqG/r9hjWX8y
         DT0w==
X-Gm-Message-State: AOJu0YxaeTcY+jYoGc6Tmzg9FpFfYFoiEP30zfwbB4J+ydoXTZV3Rmfm
	Zmj4umvDNy2o6870XzDR3idtf/JVtnMxZhBBSN8g4Cfx5Kzu6FjRqWXvY5NQ3L1A3vq9/BdK0jx
	4YrOKgoYtAtXMgdtvfQ43Ca8pfyorvR7snzz+
X-Gm-Gg: ASbGnctM/eJ6wGJ/CWirLiA4e8ncdgTVOll5uSEbzPmO06GvnwNXszQOHSNmGUzR2RL
	xn6wwTfqy+KbUspC3JTJ4fPs1QQgGEdw=
X-Google-Smtp-Source: AGHT+IGp9kTv0UwIBC5JRertTcn5PoqyN0fW9eFxxkLHz+7H9YP08c+Ns6nFaHhliVf/0mBt8IgohcWr3iQBt1ih/cY=
X-Received: by 2002:a05:6512:641a:b0:53d:be19:45a9 with SMTP id
 2adb3069b0e04-53e134ad4bcmr21671e87.1.1733186057903; Mon, 02 Dec 2024
 16:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115133619.114393-1-cgoettsche@seltendoof.de> <20241115133619.114393-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-11-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 3 Dec 2024 11:34:00 +1100
Message-ID: <CA+zpnLdkeMnakS_pP_F1xLd45BOmWfQqUGqqJT34OB4E+kkE9w@mail.gmail.com>
Subject: Re: [RFC PATCH 11/22] selinux: more strict policy parsing
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	GUO Zihua <guozihua@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 12:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Be more strict during parsing of policies and reject invalid values.
>
> Add some error messages in the case of policy parse failures, to
> enhance debugging, either on a malformed policy or a too strict check.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---

Thanks for the patch.

> +               switch (xperms.specified) {
> +               case AVTAB_XPERMS_IOCTLFUNCTION:
> +               case AVTAB_XPERMS_IOCTLDRIVER:
> +               case AVTAB_XPERMS_NLMSG:
> +                       break;
> +               default:
> +                       pr_err("SELinux: avtab: invalid xperm specifier %=
#x\n", xperms.specified);
> +                       return -EINVAL;
> +               }
>                 rc =3D next_entry(&xperms.driver, fp, sizeof(u8));

I think this is too restrictive. We should be able to add extended
permissions in a future policy and this should be gracefully handled
by the kernel. You could use a pr_info instead, similarly to what is
done in selinux_set_mapping for unknown permissions.
