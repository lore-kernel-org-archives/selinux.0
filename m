Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE83C3F6A
	for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067757; cv=pass; b=Wixb3pgjxiSfrhSzKyO2hzh7lt9Vhk/K7s2mUW+tUHPDRxAtdJANWNxCg+wn/ugcfR/y+zZjMqMsV42iVEA92xhtWx91yRncPny/oor0UMPQYg2Z0K+npLfnNo8gbTQ2HqdtASCyPl4C4kVEdQYPZMzm/eoYN38uF8aPp15MX3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067757; c=relaxed/simple;
	bh=l0IiW3gL+asifMn15tBQ++N/lW+Iw+nxycQMmHFdLxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk3aUDaNCD1Dl7axFIhTh2g3RVNmvBkVyyDobjNeve7Yohc5kPlbwQoeoEB1G3CP9p3d41+CzZudlVR17yyzyaqpM8gUjdqUW9BrG7O6nA6Wydc9qyVurfwky1ok/ndZmhjetEd9wU1+v/QLVUTzivJD3/4YISw6bg/Bwe1EOVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIF3HLKq; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIF3HLKq"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b28d7c729fso162108b6e.0
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 12:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789067754; cv=none;
        d=google.com; s=arc-20260327;
        b=EBPZyK7B6/uLlHFFlVnAEduyc5EqKv2Fbj28xPcX86dij4h/6CKlgIr11oCGOpPu3a
         PgNGm6vGMB9/6ZcZ+KTc+dFEW3eBSmzemuWTodHmR0PSll2NREyYtZB37SvmV8ALJNQi
         hGuA21y2PYGZsFzvZ39ij9O5IkXclDIR4KzhuDa6aLLmI3RA4bo5smbPL+7Zcl0dg/tD
         doW0h5yVdx8iy3SFaNyed+ZQ7nSgjdMku6bt83YvCdXaylTl4iGuPQMDv4JBu5Tdnfyk
         Yb6Gp3NZzs2CeFbZXOcImaGuMxgm2A0pBjKEbqXfyY0R/yWYbTRKlaY2IcWSeoXiwx44
         gfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0IiW3gL+asifMn15tBQ++N/lW+Iw+nxycQMmHFdLxc=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=bVWMx+IUgFf2Fvmx58efpJXzrOGW7cF/gocZc3RrU3/mCTwli7XMw18xnNAjQcF2+U
         fmjqjrkhMTaepsXKVRG72CMt4CNFySmgATPKxyzMAzejcCSbOa0GKFu0nF1Q5+BRvB5Y
         NjCE/8g2HWJwlK55jsfEicw1tyNn/UFObpaPnIaI3Ko1tlGFd1Isqn5hjT0MD/GdhNbU
         FQ2R+dwuvoODv40ILsKFUC3Ys/3f9DGT+3YAyIsuxykeTOFvdnfvq1ljWIonfqfNVuXc
         YDFKC3/WEYCtGAlktPHGXPpGWoAdDolRQMhi6hD1YcmZzUDjrhSw3HnoJkaLo1Od5Usi
         0AHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067754; x=1789672554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l0IiW3gL+asifMn15tBQ++N/lW+Iw+nxycQMmHFdLxc=;
        b=FIF3HLKq6JXUcX659QsIzf8LEHKmu4YaBwx6rZ5BfvMYnGlqCWeUZHlzC4KzKBPkWW
         slPIAvhhnF2mV1zHEGT+kjQI7SFoCnD4sTUhHMAgiJf22CzaCaISNuUN6UQE+y0EB49S
         4qxf62uAOmaFX/wotVrgw7RKF+6pabmNrcZw7tyrUP6/tl1KzbNT8NPySer3Wg+Nx4TQ
         FjAeRiJnWil6PSTF5Dj+enhbbBwolgqU+MtX0Scg05C+Kh11kdDACPW1yr2JW7H/Bzfz
         9ufc31+9zkv2NVUqbaqyftyBkAiw0RHsoznJM5Jl0l9m4aPed4uS+rCVApO+IYt+Rn66
         ZjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067754; x=1789672554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0IiW3gL+asifMn15tBQ++N/lW+Iw+nxycQMmHFdLxc=;
        b=LoRQpIzMBomnrOX7n5DHMcUazoGCqQNBXNRJPlloG7h2bbGEzLJ5SI+54hllxW6O/R
         BYRdxiria8Uj4dFvjfZ0EM4oaU/D1iaRExRhOJBoN61nO9brtzGi0+2Rfs3UfKIpgUs/
         vTz5orZgO6Trgm3jyXToEMV2HUhvwPHgbQgDTM8WX/G6u6skFETcoLxxSgEGtS42lNiY
         Cle3Vh85QG2bcm1WIPGearR96QqblBdeOpR4Y7ht+c+ileWknUc+iRl51cK6A50NvVy7
         kqEYhslEJFb5NAFu/lhMSMFnX4/aUJZAm/bSwtrqAjGmpjYLRw6j8yvQu8g5Ug1W0LxZ
         8fmA==
X-Gm-Message-State: AFuF++n2OJPEJScsLgJguVS1J0JqTisQ3uILEVoBBbLbc8/imZZa49wC
	qzmLRtdOe8UyUOwIxrsVc/TBilg7G/bH7RIq/gUBo6jlb8RREbdJoE79aLIPzaAZdqbLbeN+Ruv
	cm62YkRAUiNInLziRjIkBLkUfdTtbXBqWAAx2
X-Gm-Gg: AYBFou109vOmtqEvAcWJr63XLGCQaYN3G60YP9s/YhNELD4cuCfIK+p6KmIoIN1g61t
	fgN/Bs95ghM+aJ9iN3TXNTnB/Xw1IQAmqu2IHxdRsqbgbkEC141euZ8zhFKMTUYSoQNO0Ux87aa
	L1aKzB6VvCPn/QAQtAnheqx9yi+yhYdHBIGPo8hRCYiBrPq5CcAeImY2D3V3br1f63jyeaeR+jx
	jaOWr2FbphTSwQ8033I7VGG1/OP82j6WoUzUlPu/xbY1SzVYmesm4rI487f6RFVixu5vfhG6kTi
	tTEVaZFub7p8P1xHVQccMtIbH+PXe7zsDczzaePWfeUZD7/5ik+RtmQ=
X-Received: by 2002:a05:6808:ece:b0:4b9:e65b:8c2e with SMTP id
 5614622812f47-4c31bde9ec1mr387601b6e.28.1789067753825; Thu, 10 Sep 2026
 12:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910132421.40144-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260910132421.40144-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 10 Sep 2026 15:15:42 -0400
X-Gm-Features: AcwNN1XAOVrpTBfzauhBnbPKH6NPgcn6kmr8x-6qkQ3W1s9iq9cIpUwOXwHopbs
Message-ID: <CAEjxPJ6e5A2Wp2owQ33B5QfdpLwOWWUuiavnnqvU9pTjThv2qg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: restore basic validation for path/component names
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 9:24=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Commit 2360a8a12b99 ("libsepol: do not reject control characters in
> pathnames") dropped the validate_string_field() calls for
> path/component names because validate_string_field() prohibits control
> characters which are legal in pathnames. Commit 069ccd7a497b
> ("libsepol: validate genfs_seclabel_wildcard paths") restored basic
> validation for genfscon paths by checking that they are not NULL or
> the empty string as well as further validating that they end in a
> wildcard ("*") if the genfs_seclabel_wildcard policy capability is
> enabled. Restore basic validation for the other two path/component
> names to ensure that they also are not NULL or the empty string.
> Further path and component name validation is of course possible but
> if we added it, we would want to make it consistently enforced by the
> compiler frontends as well.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
