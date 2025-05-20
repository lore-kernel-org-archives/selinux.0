Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868725D55D
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776192; cv=none; b=Lypv5GysUcgCrtf/IG0Ke3EPpQ/z7GFcVWtzYyeg/TUzwSNUJkRqpfq/LvA8zQdDPbXV+2cjciA+JSxjiAdzklsKlJYsoMVdJYPSW5ua9cGQxmHScrmxFjLfdqu/VOodBtQ2ntaObPssDL/kTFtQqpXKJuewRArGW0y1XcIiJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776192; c=relaxed/simple;
	bh=Mwae0CfT3VtYHLh/i0+Hb2wG0hjHZi9ThFgdFrXq/ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sTE200CxIYCWqobKzqwGVFI5V1umFJS6E66h8oTV9mw0MxdTlnYYClNXVIN+ZLGGo92vmLa9q6er1pN1qZq11ljS1gs7Q+BcAgNNYlSPBng94USX4+g76LElsjN+HL0wewSYs9ldkrRb34b3Ae2ALYUrwI3CgEz7Zjfaspaahdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U87eKNyT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U87eKNyT"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70dec158cbcso8387457b3.2
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747776189; x=1748380989; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KLkiotveVnnRkJIbJRmr0cn3+/DEWjDCsoq58Yo/qY=;
        b=U87eKNyTjxO0a3q8AmfsZVxNeT4JA3C8toeczJpgCxGNl8rF2abJDphf7X4QVQJwwv
         I9/ipRtMvHvhdy+wOHHWnvt2q4ac0I4wY4qtBexA4PE75IwWYkjCJbZ/VC0Pa1XfOP06
         8LJjn6KO3/Vbl1KaUcbaFLqlkNvTgX7uAs5zBKAyqBGYApKgK8hUdf6YBg1oJLWXlzHp
         2/gcdKU748/5Q4/wY5vYIRdRZ07ScudZOtYMDaU7B1C/wOxRs2vZYit/RCCheQaTlud9
         L2AXsgMgopQo2LAIxBdHpXb/KuFRKC2osraekrjV/XMZGGb4ly/QU7p9Ro/e7y/hPJwf
         cgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776189; x=1748380989;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KLkiotveVnnRkJIbJRmr0cn3+/DEWjDCsoq58Yo/qY=;
        b=A/7u14SXStVDYoiT8JkGiEGwce7vSog2dr6YL5t4i2XnTkFA2k6Nx5lHdqwOoRTbjS
         RiRnny5a3/OyfIougfbYXMv2BwgFRHO97P2Hhi3D/XXgIq3GJn8RHphE+HmO2gc5xJbL
         HTrTlgl3o7NorhbFVwpgXseXaIXycv5/A3Q4ThQi2r20363lD28cdGB0VANy9A3koAYR
         8Gy4//bPxZ8PLsoBVNyDVuZ7VfGFj1PLRTCFOm9gh8a5Y2kJP+NqWwmWj0iLTQPkd9Zr
         IEoJZLvxnTxlR8+abHvRN78WyK2nCVnW8PL8AQmRLa9qZj+uyXgaObflTbujlit0lwB5
         +nkA==
X-Gm-Message-State: AOJu0Yxzy8sDsCaZFERGPtCep21IriIsNqfZNTt/bLcL70VRsEVhGAO3
	qcyVjeCKKN9ZyjM/ab8/AjiVK06i4L88gzYQJ/dopUr+mJwDC4P18jitT4TKwi5ZgHzzHz1B0DC
	IgOPCne97VKxG3fvuCYUHatJOx7w//ulolnncmAKBni8eRu1d+fI8/A==
X-Gm-Gg: ASbGncvwcp9lz71WFDyPKrEMOo0w6Q3ZJTpMgwwOik23djSmOwWyHV0nbWncshY8Qmd
	bHG0piCZp7yn1qWRJ7ti1F3XOg7x/65A7mVwX2QFC4gsBKuOjzgJQdfqS6nBIJYCjdHt4/0hZ17
	oI+5/kaPol7tVediuTlcVHcSXA+IbNGWIN
X-Google-Smtp-Source: AGHT+IG2vNRxTWgfrENc5pBRwD+LB9rk3EwkF7lIuDcvb9R8uzYeN7f7FhO2nEvqxtSS6wrCroszuevAmgsm2p0u+TA=
X-Received: by 2002:a05:690c:4b8a:b0:70c:9e2e:bb85 with SMTP id
 00721157ae682-70cab0bb47bmr252781957b3.29.1747776189695; Tue, 20 May 2025
 14:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501192347.189307-2-paul@paul-moore.com>
In-Reply-To: <20250501192347.189307-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 17:22:57 -0400
X-Gm-Features: AX0GCFug9D5TeyJsLNWipMT4tsA74UvKXzvA-yLMeHtX7SrX-lVjDsq8l8eGhgo
Message-ID: <CAHC9VhTD6Yw4dbHdmUfj+2muDMG9pdbW864m2SH8yH558kkE=g@mail.gmail.com>
Subject: Re: [PATCH] selinux: add a 5 second sleep to /sys/fs/selinux/user
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 3:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
> the deprecation process for /sys/fs/selinux/user:
>
>   The selinuxfs "user" node allows userspace to request a list
>   of security contexts that can be reached for a given SELinux
>   user from a given starting context. This was used by libselinux
>   when various login-style programs requested contexts for
>   users, but libselinux stopped using it in 2020.
>   Kernel support will be removed no sooner than Dec 2025.
>
> A pr_warn() message has been in place since Linux v6.13, this patch
> adds a five second sleep to /sys/fs/selinux/user to help make the
> deprecation and upcoming removal more noticeable.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/dev-staging with the expectation of moving this to
selinux/dev after the upcoming merge window.

--=20
paul-moore.com
