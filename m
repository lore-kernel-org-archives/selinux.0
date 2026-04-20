Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143263BFE4C
	for <selinux@vger.kernel.org>; Mon, 20 Apr 2026 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712431; cv=pass; b=SClDKvUKCCWLGUQwjD8wk+FYeTlY15Yio/lnBZfp9JpMy0MsnOnJeIpspKQQvOCMbSEMkZoCyjKpK8quxb3WGhjEKfLE5Ed4kfAj6DWzoDxDcEi+QoUXen+dsdgeuriOrp6pol0aGC/ecmHzQkGjP+bGDms2KX3WAtq1AK+UJg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712431; c=relaxed/simple;
	bh=6XrUTyBrOXjBXUlmaa4CjfWuCMlMFVQi65AlYMPIWcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoYVTRM7Uqf5ewbpV6eg6yYv0c7kQXLcL9VsUqWdvj4WQ6uZbRYNmeSe2XxrYQBlIPO1JJPrTuKW41oAbKfY9RDzIERNeQ42CKZsd1TkJMw/gcVbcsgGwlODCs+LhnHMucGj2j0AXOVeork2FyZPugVBV0u5Y3ftStAusvrqzIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2poIBUh; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2poIBUh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2925354a91.0
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2026 12:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776712427; cv=none;
        d=google.com; s=arc-20240605;
        b=IzTEz+jnbuHsq8PJtosDMFqEfQEUfRxCR6ae+e80M+A/fJqPZF+juwny+85bRiJdmW
         jniZ02TkIpDO4ziuLMytA5KLBW51Lgd8/VMt7Pq9lxPhSIh33GLOjqSWsZYNEAHoXowP
         U3PkN1fiTuRVBOwOnBxfBCa+XPI3ShStAAvHEwjjtKetrnj//T8BsL/JNaWEWEoJBdo7
         XWzkzBpUlRuQC7HcMfF1gzEj+ouMJS5YYVkkpULJIRkx0ZQYX0925oXbXhEHFbDqz1iE
         se6T1pcXNy1h98bjLbq8ARSBPVK1Y8nHoMZCV016WhjdzlxYctdr5AqFRYLpDRgHII/p
         2EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSo8vX2qikE52zM6FzGP6h93z6La62XsOeyMxjd3Vvo=;
        fh=K0P3yueWX+9wvznQ61j7DXol8naVFvlsq/Ek+LAYujo=;
        b=cqdnxkqsW1OtQ0f+0MhbxvhX44gWtIxSBRzv7zx9bgfa6dKJb0sjYPppxicmzp3MP2
         V3TN6iyWJX6JqkLgoUP+qEGB+JUiMqzlNGPhGc+UkOktKBuGaHCxPfmtFc7Y2Ris0Ccb
         +Y2m87kuoCFcSY0z6M07KPXN9TQBo/KCtzeYtdbnVVS80yubRB+3x6L5fg4NKgRNCEWE
         7Ovsm1mxoMPy137Dj97uFSgqNAiUVdm5US0p/A9aS0nIg7CEbnSr/yDkUlYFCAsKPlQk
         tnLZDbm9gatNrsSAYX89q7XB8fraERFDfHfno4/Q8Q+tQNeZY2l5hV6w7J8Lld0Stgjg
         YsNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776712427; x=1777317227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSo8vX2qikE52zM6FzGP6h93z6La62XsOeyMxjd3Vvo=;
        b=h2poIBUhMoq/u507QxMEItD63SLy42WI+koKguYziVE7VbT7cNMQkw8xsJRACcwDqT
         bKyNSJdsXPaiyDYeDiNP16noJLkvTFrplVkddDSskHc8gpSfWHn/lcUVFX+qLKN2QjFL
         t8MiHgID5iruQa22ICflHCULd4StTy7dSN+4cyQgKhkJ/PeORWfpti/uKTGH+hAZaLiy
         B2zHSCKS3+ny7gRO8YB6lcVmYddXDx465owa53YtskTlAzhM3tt+Ac3MVOzFUwMEmzTp
         7kOSDmnq8fEVf++C+SvHtzgAA97PrsyW2euxz+E82Az82vvgeYJKb0yChi3GanjLF49D
         gOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712427; x=1777317227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSo8vX2qikE52zM6FzGP6h93z6La62XsOeyMxjd3Vvo=;
        b=etZUI0Xs4LcNuQdtBDPiTocycxVB5kqYTJ9LRy2V9IOhDGC4bHMa/iQBvkZzss82B6
         hjOjLapYl4qGcSAkbOPalJxbQNuAy/fwVpCw56TZMkWGShwxEVCyJpiwWsHgNKmj2O2M
         YDmgmFnSCDjB53amhAnH0/1vzEt8iCrvXV6oWjUzUl+MUHvC4dRdAJL/LLHz2p6PmNhG
         UO1ZpFBCrVfFuZabeuZVdE2NP53gRVzCpRdmibqnl1wuXyIAKw//8/YOVJfW9kKJ03p8
         cKJRf0wFmmFDe72E/Ip+lboSIkTE1YrQiRtWAeVUdxOOi4DGpQfZy96KIcZ034VQCLXo
         bxeA==
X-Gm-Message-State: AOJu0YxNR0voVcKhgPRgdiMCKD2NJn0qpbgBzBhxlBPoKIt6j8nMRFos
	dxG1Jgw5hCDgMnVYYfAc7FEqVBb+aHZQ6nNbe+kZuYJCjUcBO5onCPq/y43/y7CKUaXP91/DX3w
	CdQ7tNszIx6N8VdhBOzXZQotk3nR6EsIzd67Z
X-Gm-Gg: AeBDiethzThAwTpnaBrCt50LwyIX6ISSqrQ03zmx6jTRnF52N6FRtWiO7jBOQKO5XyQ
	E6BuBeZHhF4cQRQiyM2wo9g9VtLYdweOOf5hKKu/yKgu1o23s36M3pv1l+V81+HzEUuqt+4cO71
	jJke4h6n0iWIKarUo4Lbxvy1x2qMJaOs8msb/jGxzQ+tsEYcUTCOk74bKfwKq+48m6nOAvb7ro5
	meK/yZ7BtDnUHXN/UrWGhYaAaIbYjSDhu0cXwZNG8p4clvk+SL0RWScCR1XvCBDaGAOpO+/hqOi
	KNKzxdnDhk9e2MsRYLmrzBlRIIZM
X-Received: by 2002:a17:90b:3d01:b0:35f:b75e:fff5 with SMTP id
 98e67ed59e1d1-3614048b7admr16602269a91.22.1776712427043; Mon, 20 Apr 2026
 12:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410192949.16542-2-stephen.smalley.work@gmail.com> <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Apr 2026 15:13:35 -0400
X-Gm-Features: AQROBzBwNKzXApQyLBG1S8WjxynHR-8mvYehppHp3p_iUjjqDf8V8eEg9kHcfN0
Message-ID: <CAEjxPJ4fPyXO6MWef7kA=gM3HTDhYjvhEbZNRoU=AG__K6havw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix avdcache auditing
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Apr 10, 2026 at 3:32=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The per-task avdcache was incorrectly saving and reusing the
> > audited vector computed by avc_audit_required() rather than
> > recomputing based on the currently requested permissions and
> > distinguishing the denied versus allowed cases. As a result,
> > some permission checks were not being audited, e.g.
> > directory write checks after a previously cached directory
> > search check.
> >
> > Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security stru=
ct")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v4 changes struct avdc_entry to contain a complete struct av_decision
> > rather than individual fields copied from it. This allows the use
> > of avc_audit_required() for both the cache hit and miss cases.
>
> Entirely up to you whether you want to proceed with v3 or v4 (or
> something else altogether).
> Just offering up options. Shouldn't be any behavioral difference, just
> a question of whether we want
> to keep the change as minimal and streamlined in the cache hit case
> (v3) or prioritize ease of
> maintenance of the logic (v4).

Here is some perf data, using default Fedora kconfig:
v7.0, unmodified:
   2.03%  [k] __d_lookup_rcu
   0.80%  [k] selinux_inode_permission
Ratio: 39%

v7.0 with v3 patch:
   1.95%  [k] __d_lookup_rcu
   0.81%  [k] selinux_inode_permission
Ratio: 41%

v7.0 with v4 patch:
   1.89%  [k] __d_lookup_rcu
   0.92%  [k] selinux_inode_permission
Ratio: 49%

I only compared the percentage spent in selinux_inode_permission to
__d_lookup_rcu since the changes were localized to
selinux_inode_permission. Aside from the fact that v4 is measurably
worse than v3, I also noticed that even the baseline seems measurably
worse than the selinux_inode_permission() percentages reported in
earlier commit messages, although I guess we didn't re-measure when we
switched from the per-cred cache to the per-task cache (but that was
necessary regardless).
