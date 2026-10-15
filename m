Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AF3B05AA
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073759; cv=pass; b=aBVYS9pNca1YrZF4a6CeIAd+M5u+uu6cH6FwdLT45rarpvO7Bm1nAlj4qrigV8cJHOqS14hPaU1YIqPPIhcUTCAUnwdlDU5R24C0Wp9CxK+4i9/z/I/h0H6PVvbi8R0E3cYnoKOHcAPAw3s8gPMV0Pr+JJhFsRTS9fj+KUv1KAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073759; c=relaxed/simple;
	bh=fn87/b5Ky83BSIEoKBvo4xM+uNCRsMrlz1X7LTnFDAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBMXXvnyJUNhWlR+mKh2syuqn2+zQzK5F1hEwAl+39l6dzeqd7Rgz/r1D7vSZeQSQchB0QSQL7A1jHnvt6yD1eFKktELSFFz6xDmUJM9F8As0TIqZ4/43BB1rwYl2Abm5u9mTJiQEjorpnfuZPYh7Wh5kujeOr0P/hNT53Qi7So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asmJNQBx; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asmJNQBx"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66fca0709caso1480909d50.1
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073757; cv=none;
        d=google.com; s=arc-20260327;
        b=jD/Qpss90i0LrGnKEhfEqZQcxyXg/JiYzwynvoGlVmupJ5yZfNQE4C4DODD9gwJOAH
         zMX2l7LrT+uM3gKZv5Q9j9x+mpatBtPh0lsx5JBgRr4yTLP3i2L6XFmMCwkUh6OMK40o
         RPoaITWWP28r6s2C7t7gcLhKriHhMoicn1iT6O3iP7/59zn5kwHkGWlxtwputeD6/1Z6
         DkOQl1ZbcrCfsrcxD6o6AsUA6JU+s3P7XnEHt+yXmEvoYopLXYcTxTN66Oj6fNKUyDqZ
         bwjAG405oGGvmlpxzM7FmpAZPDORsxIVIBmKfpBV4bIUxi+G9nJN6vDtqAvYm+q0Mtyh
         4m8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fn87/b5Ky83BSIEoKBvo4xM+uNCRsMrlz1X7LTnFDAc=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=r7EV4RV2YN8kY2myFYooTVM2PhSy6iNqfmbOU3bSdESDBJRP6/nicbit9DzSKARHOA
         r791na9qjcGXtwfW7RrrLO6q9a07PWeHz9h39157HhPwRiAJNnfKFeo9XHN9OgF7NPuP
         ChZmNd6BC/6HPnaIBeJdSgMG2jbPvZmNE/PSWfehMiUsu9N2zjtfz++46z21lgOD0Ily
         rEHca3CPZNqcd52dXoSz1uIPZzXu4YlwCLlgI4NDUums3TBkvDTH5kiQzkV7Hd/KJAjt
         SH7SDW1FpGXH5ny/o6EC9w6l1wqz5CARU34Nnd9KhfdlmpK8zM/CJEWt3CT3zY3qPKKw
         8mbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073757; x=1792678557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fn87/b5Ky83BSIEoKBvo4xM+uNCRsMrlz1X7LTnFDAc=;
        b=asmJNQBxRNFt2eV9lTmidu30VFZSttZhV/dVNkcNx4l3IMJ3lrW5vpSrDLGbAH1AWT
         gyTZ40QWGYAnOmsifJQ2Z2MUNpxrukq13eg6fALgf31fx1yyGHVEpZxd8I9Vk4sHAYgq
         NNnVQM3NFntz6jo4qnHKe09r5ihY07nBj+ykonJolQw8nPF5fEtlyz9DWm61NGgHqYLr
         1j1jAa1SMAxGvFcJqNpKJVLOZXGe7kfnIemrAk00tHEX4TxvBwTObDncu9ZcLvH/Dnte
         k4XOJ6JJC6BJP8ePULZ6GrQ4R0j/9msbUMDU7HajIbJU/8Gmre4ipWI+OmKO/q8Gv6VR
         e6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073757; x=1792678557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fn87/b5Ky83BSIEoKBvo4xM+uNCRsMrlz1X7LTnFDAc=;
        b=QH+dMgPch2UhErAkHLMoM37eKctMTZ6zrvjwQXSthiY5EPTKQoxkiMW0PYXwl/1ch8
         CO8KT5jg8/hLq0IIu3Jn65JmYmXK/TvS7eRK/V6O3nUXkiW/KclPz5Khk8kRFssGkfI/
         YdTZsz2KywCsvwIHjrQExKBdHUkYDmav/CDVq1hOjfgf4/VHISGft9i/FD1bmOXI3JWZ
         1/jlCQPcP3276Sd3Dlbs2y3mHKAkTfaKe1jB9ToO7HMg9/zoJu2fowSbv68JF7OnvWfp
         FxB0sdwXKt9WoaTMHmdhlJ7qnA6DRmHKia4sRRDWvPlXlDXyRB3se3NPDPr8Uwx9TDsa
         YglQ==
X-Gm-Message-State: AFq9FYJCo4RIXBfQeY35KMSZhX2RYW0O3HEHzEiJ9T5wyM0+vyTDLWg1
	muVgPb4+tYleGTr9wtbuxOST7/KaNERmGHlNylO0ISty5lCD9HdAeVHavgoqTgwr8lCXwa0UFEY
	dzFRVo5LXwqgcMkFTG9J2dAKbyO3mJv0=
X-Gm-Gg: AYBFou0uotQCHwqHWrEtiKRcrIjlZK9i2+0QCjXggLSfojyB5iCNGUumG86L1gwl7Fc
	7ggPyWLBL/k6hxg3OGpJhcVLsk1irVh4LIhfR3lYntTjNCZ5UkfJKdQnmFD3WHMGHOj/uhDbJGt
	NzfaWlJrTgMlgBdLDSqWiftLpjZQW3hfIQUW9na68y++ex9EP8jNLLjMCykD1A+xw86pbDt2b+v
	rimstgv9TDY5PytSv7NiWFwhcHC+KCJlHe1EjOa0Xb6XnmYfC5tHJlelUMCmSJFielelSawM800
	uVYlEIbnfe/4aB3Vt/l4LOesc3fIj7JUjW7D30KDDknf+Srl74vCUEE=
X-Received: by 2002:a05:690e:4847:b0:671:2832:efdb with SMTP id
 956f58d0204a3-6793627124amr5383830d50.25.1792073756967; Thu, 15 Oct 2026
 07:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054535.844874-1-omosnacek@gmail.com> <20261015054535.844874-2-omosnacek@gmail.com>
In-Reply-To: <20261015054535.844874-2-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:15:45 -0400
X-Gm-Features: AclHuK8Sby6O-LRCQNaAsIw1qI4N3TYOspU4ou-6JZkPIJ3gwfWcVs124NENeRo
Message-ID: <CAEjxPJ4_OXWWopq5787bUyuPUbmNxrgZ3oVpu1sqxZjamvb2DA@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/5] tmt: raise duration of the prepare-system
 test to 10 minutes
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:45=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> There is some issue with cloud-init on Rawhide Amazon VMs that causes
> every boot to hang for 5 minutes. Work around it by raising the duration
> limit for the test that reboots the machine.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
