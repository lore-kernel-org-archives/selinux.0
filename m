Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E053B19B1
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333084; cv=pass; b=G0A8uvHtBdw7a0+mp1MgALvpOSRB8eCwZy7US+NhB7KRWtG41YYGODie1YpTr/3t/68X4XuTGMJiUBEkh61ISTtoO346FnMAWibpB8VvhsJlUYWdZlR6JCVmUbyDQvDgk3A/gVnkE9LFPpFmJ4fox7bDG7R2LZuniWMQk2AyE3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333084; c=relaxed/simple;
	bh=CA6DCj4YtmqXIhAjKQs1+Pai93uu/QMNRBlRY59Bh3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt7wbyzTdBxg0kWWYGRMkqv4eQJCA0t6ttzXgism/zShxQ1RFc9PLoFctRcZZQKJTpUvEgQRNxZla9Z9UkyusNdcOCGLhcoPedw6hAUvOG/dHyPzIq1REKI/5wYPhxyIeeY4cmSkvhn3QJaJOoMXVbKLdAOAbyXdyyI+/2ZFnY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VOMlsLDf; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VOMlsLDf"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so4780631a12.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777333082; cv=none;
        d=google.com; s=arc-20240605;
        b=fbBStczaUgtQtKEgtdW/CNekFMZSQU6TEug7Kk5MlRFbyhc4lsf0rjm6QtQhBe0R8y
         Q4Si636P9g1Da+Bko64Q0m/4ISC1pR8kG+Qoy88YvYQhj3INItbnSk6/dbDY433FoJV2
         5JhDXkzWzw0KlyvOnEQFVGaq77a1RfTi7rVscZVBI61GLNq0e27s5tnEcMzWtN5cEa9R
         GT0PLGnAiBPcyGPLJ7+YmGUDIYGM8Jj+8DqlW084oDl8Ro3KhyDaXWkk/B+AsQVVaH7R
         vwNtD/1aMzvIDtA1xRpyhILa9BLk/meLlP3M9L5MXADtd1YBHMdmKEDtPtlf0ZGtXnVh
         uiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ug2yThFHifmkUqifjoqFxVvv0a3x/lsYcW5B8sgYAnw=;
        fh=lOev/QwE9DXSi83P/KluQ9UjJBSvfLYOVkCl5H1rM0Y=;
        b=CpJl9kKMWM+cr4G2U0BR10y0oY7JhCFksTqJr9ZDzGnBpdSpJNGtrCUF2wVxgWyuqa
         1jxv23EzUer1Y+wyQmoxusuQHqU02E0Uh45iyHHnnpmx2dk8HrPB0RicRo9IH+Qpg0rm
         SyarPgKzcOaOqd4AiUsODcL2JLX0zmLzWsxPYZ7Yf63CvSdIbidqNIdFu6ovjdUd64cd
         eVM7gXeG11odRlALxuQffA/Z5TAYx2hZ1WZYcO1r+XF9Dzbr31irFqzl3Jd1VmCGC0vP
         HLBmFHqwWiYaxMp86gIYKzNX6h19l8sZeCSJKt+8P0eMVaY40HV1bcWDCFwSQnMZFGrg
         46WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777333082; x=1777937882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug2yThFHifmkUqifjoqFxVvv0a3x/lsYcW5B8sgYAnw=;
        b=VOMlsLDfPuDcu1hD/YB/s6Xp9/ZfzsEakdop3FRq18w+74RChix5qgVGfwkB46lpdj
         nsmiAbxqJRF5T+XdCxIw0YnnVfBZT/S6hnre87zmH/FsWYk7tL76QPIZ6dSZd6Qnef2F
         oU/X4MZTBG6qFuOjF76DJctZamziMtezxVsM3NoRxY2uKQVSFd5HzUwUbTHtKAVS8BeO
         tlxYDfyizAcuwLmgNs9yCD6hnmxQ/bKRXKVWq9m5v0Xhc6WlFE4cRS3EUx/w8868+hfd
         NcsVt5+7qY81onhLY46HD1vqOecXti2jdzDZdzfuObf/njsnenJUENJeRmHyz/5lK42t
         yLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777333082; x=1777937882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ug2yThFHifmkUqifjoqFxVvv0a3x/lsYcW5B8sgYAnw=;
        b=pZW9uwq3bIB7miGjYs/Ycl2RSidr3kOFaZBuqnvYJHZFLRPTF5D0CsaWILQEoGVDmf
         UlFuFQ2xs/fnHCwYnAxhCGPUd4LCJucCDzyLfHZcCxxw7V+4/+dkK0GKMqqP9RBgNvWP
         2qWiWAePK3BUQnr+WuQRi7LVxIr7wNexM5yEM1bW4YuxgdZAKtVQK+HL1WZ4gL5xfs98
         rk1iAFEtZIq8KGxc5sNpRdEeuAQRibv3WxTKuw73St6Ozw1HvfI1aLCbiFeg3vL8w8j1
         xyNHBuDbqdj6MA80B2+st5y8cCYNfUyBPT37v8Bkaizy0HtAAqDwrYQ5vrSKFwhBtAvx
         HYHg==
X-Gm-Message-State: AOJu0YzIGifCBBDvgVErbn2nGzL2sxWVBeg6nX/UmVR9D66AgF7Ofd0d
	JOev6K3CBRFIwuvtkS41rLwAs+wSr3Izm8rMCfRdMR100Jm8VXugH/HxbfDgYTjAwgUEKClPFFc
	rUCGzD4jZ/it9pa+uuz+/AJqXdxlX3Iu7s2C7BYLj
X-Gm-Gg: AeBDietDO7gFDTEOtyTUHIxypVbCtoVApdmKCwKDH/iZNAY/VCpxPttjaaI+Bttiqmw
	G9rcAFzatBPO8EOUpv2WuU0xtozSPzQmtHdiEUdMt9a4hcB9FL2GeR1q4Gc6Kl8k+n07gbGNL6p
	Dm6c4puwllqL8oksO01NNPI3aHMItYPDRI7niWY0ueDfmWEnYFkVI7USxc7HIT8wVfAPI3n2KtJ
	PlzhUUZutIFlV7L/BCRbo4DeGfgJxOmgu0jH7YurtjN4ft+PvzfuHfGCL0r+gGJK01WWE4R+ql5
	JheBIT5Z60GlZCitCQ==
X-Received: by 2002:a05:6a21:6da7:b0:398:837a:7af0 with SMTP id
 adf61e73a8af0-3a39c272283mr824502637.30.1777333082236; Mon, 27 Apr 2026
 16:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com>
 <CAEjxPJ4fPyXO6MWef7kA=gM3HTDhYjvhEbZNRoU=AG__K6havw@mail.gmail.com> <CAEjxPJ7ASrJSLOMrryvHGQT7R7rTvfZdfdTPu6z9SmCRUX_wDQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ASrJSLOMrryvHGQT7R7rTvfZdfdTPu6z9SmCRUX_wDQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 19:37:50 -0400
X-Gm-Features: AVHnY4IwajvzCi9VI9J_MEFElr3B0LxLuj19KVmjdE0Au1P3PGU1VQ6hB8l6vPY
Message-ID: <CAHC9VhSDYr60mZSasYR+_0rGJ7_SNfL_O3FJmB_nFPQciVQ64g@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix avdcache auditing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 12:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 20, 2026 at 3:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Here is some perf data, using default Fedora kconfig:
> > v7.0, unmodified:
> >    2.03%  [k] __d_lookup_rcu
> >    0.80%  [k] selinux_inode_permission
> > Ratio: 39%
> >
> > v7.0 with v3 patch:
> >    1.95%  [k] __d_lookup_rcu
> >    0.81%  [k] selinux_inode_permission
> > Ratio: 41%
> >
> > v7.0 with v4 patch:
> >    1.89%  [k] __d_lookup_rcu
> >    0.92%  [k] selinux_inode_permission
> > Ratio: 49%
> >
> > I only compared the percentage spent in selinux_inode_permission to
> > __d_lookup_rcu since the changes were localized to
> > selinux_inode_permission. Aside from the fact that v4 is measurably
> > worse than v3, I also noticed that even the baseline seems measurably
> > worse than the selinux_inode_permission() percentages reported in
> > earlier commit messages, although I guess we didn't re-measure when we
> > switched from the per-cred cache to the per-task cache (but that was
> > necessary regardless).
>
> Actually, re-running the perf commands on the older commits show
> similar results for selinux_inode_permission() as I am seeing now, so
> something else must have changed in my VM or the kconfig.

To clarify, are you now seeing similar results with both v7.0+v3 and v7.0+v=
4?

(v7.0+v3 looks pretty much like noise when compared to v7.0)

--=20
paul-moore.com
