Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B3403F4
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688870; cv=pass; b=epl9HYLTTHiX+VFi/iUMSAwcSjC4knrSGwa+Nf+4KTXRJ1Iy1FJ1X06H4NWSN5chqohsKnp5pqYP3HfmxCMNq3IE+QL/o+fyyoqO40449QDwoOxAcE1nV8ytJlXFnDfFM43yP8PsHZiPfJbp35xwGyKbXVFI4iIl6yRmB9LyIW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688870; c=relaxed/simple;
	bh=5t4L7n19WFbkbOFICkoh2gjzgYIs3TDa/zz7rzgGTX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLoLb72D5eMnnHYQhL0YfuDFLCqwkgXMCICKELQkLHjNNgS+3KAmfUca/fepDZfbgV9N1yi0LnTJ+g8vgBBiU/7uiP8TwkaxhLl11qHToWf/lzocauO67OArs9eAQzHqZAywcefi2hnOaYOpLwjVMXoFHwhFeryfnECzS/1bf6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRZzkHSj; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRZzkHSj"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9ecd7216cso150226a34.3
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 13:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787688867; cv=none;
        d=google.com; s=arc-20260327;
        b=P3FY9zvFVwl2uEwt9vg+3JnneOX6I40L5ZtircUIrEyj1klz7TB/Gj35kEatvjbEL7
         QVh90NlUKqHzCgrcNSMuHZquMOn4ENS6Xp8A57iX5ciZjrL+Ujrh8gk+4fj34vOAwHga
         H+P8KUUpm5mGYhTHV6n0VvVC69R2Uzb32K2BjEvARLOGXQCSkNr1bGFg9ovCuIYr/nnJ
         fFU1RXC4YQ2AHzQxodYdQaA/NCrO2zfoZikyXZLiqO2YEmWGNPym0aeldpwBJvklZ36b
         tR30uRi6rcwIed4gheKZBoNMlJ/UFuCmXn19Pb81rorxaVN5TpFCMxi+Kv0A8gvf0sLt
         56nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5t4L7n19WFbkbOFICkoh2gjzgYIs3TDa/zz7rzgGTX4=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=YBA4PjsGiOxZN0/VuH2xAkQfS90VDRjEU3lMiLW4yAtB9Qua96xoDyUoK0Ck85OhuI
         tF3PiKs+xAA0cVVM4pgqBy5i0rLvYeTNZAVMsq7vxoiq4P9fe+HUCcpXUJGlweyhbeR4
         LJLM1JpBWQM0sV7w0uvTI1V7lM4/KB57ViYIsUIuxem1qNJMVBbisgYji1kbcLZvHNW3
         pPu09sN8xXb0iGvuTQ7iiy73xjXRrxuvtTsWeOulRf3uHsLqYEiKXgasts15e5FLs+tO
         ea5OXTYfzYwFU0TfBlma5w163SqLjMhzZkcMjH1d27zY+grKCPdYFVO9kXfXG1xba+wa
         pxtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688867; x=1788293667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5t4L7n19WFbkbOFICkoh2gjzgYIs3TDa/zz7rzgGTX4=;
        b=eRZzkHSjHJV83n+nhs1cmOw2oy2vPZRZ8BKcZCs4+mfiaJmvQZ/GpBS8YCrWG63enR
         GUhiO8/RqUjWO+eT9a6ZefhQ6pBTIixtWQo+MejTkfBPxLQMfn1+hzLBXFDUMKF+E6I2
         CPenyK7YsLYTb90qLuc742iwPUN62//nxMwqRHPJYoEb1tPSxLqjytMse6EpV8bMpCfp
         18wUWtNaCzQj/mVE0jZPzLfISaojLTDYITvbE3Ym76RkVfsW7KCE4bGM2lfiqS01SaPu
         616ylb1ZhE0UFyWBf21vYxxb+76NYDYlRRL884+iPXXL5DK7wG7AVZB3nL3bqMKUtjKO
         96eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688867; x=1788293667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5t4L7n19WFbkbOFICkoh2gjzgYIs3TDa/zz7rzgGTX4=;
        b=AmlM/gNhSE9xC0gf68A/BFWLMdNpRF487jgTT0IctiXEXvOFgFOIVI0vHtNOAzEQr6
         DxbWBH5iKgyCs37uOZEZ6gDMpxkyXWDerWXEH3eCUc1sPSp+XFFCBVqCL954WjXuCjdB
         /fgMRVe72pZBWOfpqMbAYtexBLyQ4OrK1OLOSahCWbjsvfDgXWtpqEukz3pS9BSNJlfN
         vLT5prVLU9daR2ieTeZVBRaXvfiklDqY4pI78paIkwLNClQCvibjg9oUDwmVnn1rfXdc
         6eys1ELDk/4XO4jrK33OhFQZrdJ5E6o8XzH5Rprsa1FIlNcE+IfyT//92syt6B2/YEUr
         8M1w==
X-Gm-Message-State: AFuF++ls0t/5sdGBl+UFlZ3m1kb3/JN/X+Mkj28giHEU4jdjRMDcXj7e
	gMsSDOcs9TMb7g/bfYqw2j8GfMN3RrCEki0IToUprapKbQKhTd5W7raUypXgBFejp5/jRUPP1kW
	2UZKjKM5zmSPskQL3dG8zOsiVifr9oRi4HNWf
X-Gm-Gg: AR+sD10YxZeXGgHYbZTBp1thib17v8mIq9rWGz96FAjTt4VIGqVdZ4M3NQpVj5BZocU
	X5YT3rFNbrROs9B0cO5kHgo7hG1t2Trqb+DadfPBhEbjv1jROq6RW+4AjKzuWg+f6ABDaRp669t
	SJvnqFBZU19cyv1I1U1Bz8l8NzVPCHerYW+ZbiW3UNM9UZa+fNmQdktl9fqhHtAw1Zqqlh4ANoO
	DPjEzFETRPaPuO5NzXfLFKmuD8bilrYN/IucSgU5kpXYiwZsXFuiVNlnxx5GDh2yQ2Zss4Sg/B5
	Yr9W3nrIb64D8E9cRcRki44P/X+gFDvuRyqBo3eGLo4I
X-Received: by 2002:a05:6820:7099:20b0:6b1:5180:bc73 with SMTP id
 006d021491bc7-6b1a0428b09mr1358659eaf.15.1787688867578; Tue, 25 Aug 2026
 13:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825194111.75602-1-jwcart2@gmail.com> <20260825194111.75602-2-jwcart2@gmail.com>
In-Reply-To: <20260825194111.75602-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 25 Aug 2026 16:14:16 -0400
X-Gm-Features: AcwNN1UrELXx-agCd_2QLUm3wG7734-SCbe2ze8GKxwNSRLZ7s0_irDQwVVTzUo
Message-ID: <CAEjxPJ49ErkJNPqKGxo8LviRitMrtDi16+t=Bg_8KGNAVofDHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Remove junk permissions before optimzing
 the policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:41=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> In older policy compilers, a wildcard or complement would cause
> all the bits higher than those corresponding to the class's declared
> permissions to be set. These junk bits must be removed before
> optimization is done to avoid a situation where the only bits left
> for an access vector are one or more of these junk bits. If a policy
> does not have at least one actual permission bit set, it will fail
> validation.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
