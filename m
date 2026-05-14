Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF12853FD
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760313; cv=pass; b=u0W9CGlaRYXwcbNdUqVnZPS9PzhH1kSsKLLQWSXc6+v0kSg5RiVME/r3rh1Atp/hXuqRteE0wjek9LiEDHhDfbU2E0FratqUW6urddClu88CukpFnCgfi/uHiQrdesau6GVLVMMtM2oWQS9zY47HDw8vWnO7DQofFiYO+8FYfak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760313; c=relaxed/simple;
	bh=9ekwBwHE65rw/E0K4ZU7kHNhY8fGcshQxlHOtVaqqr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLf1T4vi7GYJkao7krGz+Oo5hgWXZpy1Z1iV1cxfeEQc9JhebnCoc5WfJLpWYBHRYoMXjSyZMdd/8Rm53rbrKR2aLrAr9wILxy5ewkLfLpu0DCRJU8KS5BoFqG1tAMN6sIOAn/bXW6IAcRpkBGJ/VsEjjsGTn1PW/JXHUw+a3zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKcKfygH; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKcKfygH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36643b96b99so5647587a91.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 05:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778760311; cv=none;
        d=google.com; s=arc-20240605;
        b=aoRdwzfqdZf/SAMqVMbODDR5rjlb8GFJUPtK+zK3+jtqDxc6OvIUTmdgcJFTNYS4NA
         9dcxnEcoixM24F5R7jlm1Xi9lqHQiZVwmfePeUXYKB2i6u9qCwSzvb/j64hMczt4K/vI
         IgGN0c4ESMspCfsQ62M6ezBs9PCFYDsu0b7tpatceoBj1Vc4XHQFOU7JOs4tMtxs4PmS
         vrTOAygIK9R28E6gSMJtSs7gI9wSWVkKT3UZrLMUMYzSkhozcZ+M83UxvOcRiw0g1hiq
         dUHGfy8DxBkEC/7bg1AihZ/8WBjfjex4Ni7JmrczOavzdNoyyTIwmRujd8z0ZtufslHu
         z+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WqDerD32BGBd8EOkq354cV5/SpcxqMLFaLJ04ZNpal0=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=cVwR8xCVD+eNTw+fuD4+X1fdr+vkzXDpxiGPmOYbqMtzo8oqVyML/VQz9ijO7nskPF
         VFkTzunVhoJG7nRrgyvUIfdvtr85P7wX/E075juveAq3W4zHaQ5Rz0/vAJ8VaI/WllHM
         yGTwqLMMIgtw7LT+FkoT+sKdT1HFKpSS8o4X6thkbpAnj+DlfQt9ZFZj9odwMOvmgh4P
         dyA16i2mthy8xaVRWx1ytSOg463a03+4VVe2iqfiQMBAn8JXBcDMiSBjpc0Tnep+FWk2
         SzoKi8uhnN2FIzCschErr8h5cFkYTKpur4/+iGOEBVFIQi1rcliUTZm13ye1Sn4Twdc4
         tYEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778760311; x=1779365111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqDerD32BGBd8EOkq354cV5/SpcxqMLFaLJ04ZNpal0=;
        b=BKcKfygHR44l8t7a4tEuVW8TGecCYVuQPM3sl88O3skrmG3EcOplPRCGLAXfu9dbe1
         ctOpv1B4gW0brkbK0Xbn8VL9AP2DO1DcFCsCMZNWZz+7RhMbdGPUnbW/G7xPiDGGL4w9
         ypv+xLLdkYs/Ep9gpqKfcrywv6sUqlF9+zlzmpSKpJsT9tGDCJ1JGCaR4yp75bZBVuOO
         pH6EE5KqMWRs6GSZ56kaYF15IW0qfDHnbBr/u41f6rWxjfIxImxjkorPj4MGq+9hAfwK
         08KU0ueuSNILA2gPkAg8d518qe3OHOxITdhH4VK/sCVEbdHNk5eOV0wWU1T9xknfr3bu
         Bvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760311; x=1779365111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WqDerD32BGBd8EOkq354cV5/SpcxqMLFaLJ04ZNpal0=;
        b=qpXwX+hgwn4XTxUZHxQIKfX7e5GbAckYN3Y3dnwqDFDz/FZ23RGnM5MHJsE6a1Hn6k
         HLnIUyAwZlhF62n5XV5xEG+9JctHR+CnbEITqTKtsI7pbaQ9VY4oFDzBMuhflPVZAycI
         u6zf66c1pZl2Np2yx6XaBhww1TodGV58nE/7NB2HciE+D4GwtcW7EW4HmNnmzWPA+LzC
         IdVIh2BFODF6UOKKGFf1udWxFj/PWhnll69OIvisjo6YJSNNlNJNGbq4yjJ04HkvsrLB
         Xk5LOEoFxdJJzJUuxFJhAGnHaoGQ1ICGvalyQUijuKexfLvWYepNk8//4O3oZGnfrWBw
         3i9w==
X-Gm-Message-State: AOJu0Ywv+vbHtuNvJ/5bHaWiZ6dCF0pUf57cTyfPT9SlsytGkL/Ax/NI
	jEd/q06DJWC5o0MAQNhP02gIA9B6K8v+Q3g0j3aZxq+pS5E7hOqSVGSYWyqJhdLuBj9dlqemsWG
	Tn7Un4xf7IzrZilnoYwuTK20aFMoYmeY=
X-Gm-Gg: Acq92OE8fiNZQaiP1jdvm3JEvkPt8/HLPDUGRCzhz0xrajQGXS0CyiiBNleXdV6DYki
	MyS/ZOBFXKqK0Stq9ch7qfXZk+uwm2BN9ieIUjj5by5751BJp5MZHLBFoBIMQ/1UKbiSKf5mZzK
	fZWEhwYQio1N2JYwmnWzvsYyYhnqiEn3qd637Qa8Wpzs4JIcvmWwOl0qH5yTzL4l4E71ZHYZAsb
	zoc5EFRTxyxkMZCRPVpRjtV2mM3ucA9HgBhdjiLLyVviUKF2Ph0C7d2yu3MfxG3xggclq58cn0s
	PLSU7JIHLyQfCkuvvkwcXuEPI7e1
X-Received: by 2002:a17:90b:3d44:b0:365:7e4d:bcb8 with SMTP id
 98e67ed59e1d1-368f77f1013mr6840478a91.1.1778760311381; Thu, 14 May 2026
 05:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512183402.751341-1-stephen.smalley.work@gmail.com> <CAP+JOzSJc926t7oSXyRc=TKtmtr643tLBmv1HgwR2405Mi3nHA@mail.gmail.com>
In-Reply-To: <CAP+JOzSJc926t7oSXyRc=TKtmtr643tLBmv1HgwR2405Mi3nHA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 14 May 2026 08:04:59 -0400
X-Gm-Features: AVHnY4Jd5JSoU8hipk-I8Jx5d0GL2b2FDCB8sSw_jv43TA1btb678MKAPOIpLoM
Message-ID: <CAEjxPJ5xA+2VfTX-Yf1S9jtbYm5LZpOfBz__QduWHFAHdx1WVg@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: pass O_NOFOLLOW to openat()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, May 12, 2026 at 2:34=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > We do not want to follow symlinks here.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.

>
> > ---
> >  sandbox/seunshare.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 2512a18c..4e441b3c 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -428,7 +428,7 @@ static bool rm_rf(int targetfd, const char *path) {
> >         }
> >
> >         if (S_ISDIR(statbuf.st_mode)) {
> > -               const int newfd =3D openat(targetfd, path, O_RDONLY | O=
_DIRECTORY | O_CLOEXEC);
> > +               const int newfd =3D openat(targetfd, path, O_RDONLY | O=
_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
> >                 if (newfd < 0) {
> >                         perror("openat");
> >                         return false;
> > --
> > 2.54.0
> >
