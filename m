Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772940C5DF
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550553; cv=pass; b=j7yDJ3ybTM5qXGaz4Nxm38RQjDX4qmA2ww6CcmceLX6FDyh3C2vabwSDV1Ns9NjuWaletq/x4ee6D+DueUA8++95M93uwKhDU+8XBi5y+X1AWnmIQxs/qnJk9C8LznSfNNIM5VGulapit7gz52tKCY0hv00NrLAvrG4H52uHZ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550553; c=relaxed/simple;
	bh=zEIVwThQkTmg7GZ461LKVcFPJ05mSLyKnbxGNZTf5zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2LVnnTPWD4x05BmwoOeStd2QoyY2U0grIcJkdd/V8o8UVJH1xHOPM+hNt7Q5PiFz1XmF6+NcPRfIKKVmu5CI6RBr+WjyQfNinavRCEpeWqB46ASge9EwUwlzGKywR+9O5UL+qRidXGxTeQVU9hyV/QQKinC1NkFXTU7iecovuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtSb16GT; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtSb16GT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848882fdb18so7219230b3a.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 05:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784550551; cv=none;
        d=google.com; s=arc-20260327;
        b=L+q9Mk6paIuqu9vSeULr6I4/GUraknsL0fm9ppFodReP6BEFLYJCt+GkLvUuO4bw/a
         fbYj4sX+14E9GLil4iagxelmITAIN5VOFiw0uQkjaRObY7L4GC2LAY7qzvtjVZLHMvRk
         JitJPdASoMaIuM33ZpP3LgpCJ547a3YublyJSU8Tfta+1lHw/jYkQvv01jGfraOPi+RG
         plIdA+/TWAJ2XeS2r8MINSxQfoVXMfmkh9Vgf+j9YNTuyfzVriF4KJ7cqPOxaxILiWEJ
         e81MGxRHFkm/IORX89zcEfE6oNwXlPwmvO+FXAWDsUiOWP2+uT5NpUXEtmf+pLpDIZ8s
         TYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJMCL/2lFjJ2czKue5/zwjHUjMCugTvCwmJYGKhiMbU=;
        fh=hC9qk6DCZ4OrCLwLtbI/rAfodZ774ekD92Zmkjw/UOM=;
        b=dDtCxfVlBNHqVEMxRa+CTnPjhGTfCpymdK3XuH2M44nn2AgOe6iHhficDGYVg8wvy5
         RodGF0jm8jVo+lkgOq2RBm2SeWtSlHLwv8921lVsaOiNqjxAQjG98OLqL/+iU/2np4dv
         AeZ5R039U9vF8CZtgWJHqEi5kWxoaak+9RRt9OCG7av50qoNhEUWCSMJTUvskUD2jQ1h
         7zTx0Yagh976L3G3dKRctj+bnw4VTjvItPj3kzAXvOZwcq4M66bb18vRIfZubJ/GORvm
         b8apY3aq5uZLRDiKzxFOcWanr4yBE5AegIO/BQ3Zik7YUm3TK9aHHl2BNA6XdKYhjf15
         7I6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784550551; x=1785155351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJMCL/2lFjJ2czKue5/zwjHUjMCugTvCwmJYGKhiMbU=;
        b=MtSb16GTfam5PFESiDHCBQKudXlftzXy221VgdCyKwIeIpKY3Kj728qcxypbuqcPZk
         Nk13tT7IoVMecta5cFxCMYUnXw5NXYZWZ+u/lz7eHM6tsyqJVmoNbDYc8ldBx8oc6TKQ
         k+cyT4I8ZvBNiuk3Lnmxe7/HyvqsKMbzfsB8MJCdK5sntZM/mthXYlVlIKAAD1AncEHr
         WuF8EudWOH/+uFrXv4EaPUU1YGA9VsPoa8ZhBX4lyInF5ekxB7/5ko0/fMNeJV5YpZdz
         20jLYaI4X8DM1GMfuDWlErfK6CYVn3oCOsgouHBHFGNcXc7/yKrucnha8mgvYpTwZLKl
         VwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550551; x=1785155351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJMCL/2lFjJ2czKue5/zwjHUjMCugTvCwmJYGKhiMbU=;
        b=Jja+9seH+X7ODKjfh1lLkkmYPY69lVmfilz80vylEkPI588RnyyD4bfLiB+BFI1Gue
         r8VrsMI3y1uzzaU/jG+syVyTudC/acUWHSIKX6nLkITyOUA186EJ+r42RcZnA3MSTlhw
         GeDBh7X7wZGBzvJt91kQvnI2LRBe3Wxm8E5UN0+bdMnfwTLcwEwAHtl1DWuOQGIoahAO
         16ICvVD21DatlC+yawagkOrp5ltAa4kbr5h1aIZ5+3YfSb8YW+vgurpsdkxAUN+hWKyI
         geDNV0lcuv6cX/rLRV1vCD2W6HQvfpzn+VOHyTvvy0UYV7mFThW5QXGde9Q6thJODuEH
         yoqA==
X-Gm-Message-State: AOJu0Yznlv6xWC18BdZ0945hP4lD3+hkACxieD2xdxvagAcrGnihfW/x
	aKdlodme28qgv0R4frjVZYpyLupqZQJHeL7jKnrxgix9Z/xGikAXEoJZ2hICKcWt4CLKzoRWJkv
	xSMyJXd/q44L574qhBkC1inQf1vVbFoo=
X-Gm-Gg: AfdE7ck9AGdv//cC56gGuHACD3H2+hPeuRpkpwV49JF5mrY7ez/638AvX0vDwBr+b8P
	4C8dFAm1P/pp+/u3g4RTWeNgxpbbW9Vh8oHNUxfQ/btF/rG3ExV7f80S7MEpp6ueUc/EMkg8nh4
	JRYtEirSvxWGBWNgwsQOp+lzj3sJ/y1BqPbpoTpmtQLhknu6Wr5PPB0edqHwvn8aa7BtCZXLOhb
	ZZPVqbivgYfcEDy0D0ACqyl2NxpVOarPhFRiiAE6dwfRwIvI0ecq4kF2xQllQ==
X-Received: by 2002:a05:6a00:1d87:b0:848:6dd5:f61 with SMTP id
 d2e1a72fcca58-84c2946f01cmr12817646b3a.44.1784550551379; Mon, 20 Jul 2026
 05:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
 <20260706143155.36629-2-stephen.smalley.work@gmail.com> <CAP+JOzRA48R83Bb6=OXMCqjizYftiRbdGbZKFWbYPuS3+YtFNw@mail.gmail.com>
In-Reply-To: <CAP+JOzRA48R83Bb6=OXMCqjizYftiRbdGbZKFWbYPuS3+YtFNw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Jul 2026 08:29:00 -0400
X-Gm-Features: AUfX_mxkylNsqE5KhTWziEKdXf_EcaD_KaiK6NFLuQeC1eFQ8teg8VXqxRU35Eo
Message-ID: <CAEjxPJ4sG=8sp2HSKeSw4MzJHX7ULfLS8WE8hkdJK0xyCaZNRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] libselinux: avc: use pthread mutexes by default
 when no lock callbacks set
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	Seth Moore <sethmo@google.com>, 
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 2:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jul 6, 2026 at 10:32=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The AVC has a set of locking calls but defaults to no locking, and
> > only the deprecated avc_init() allowed applications to set their own
> > locking callbacks. Since selinux_check_access() is now commonly used
> > by applications implementing userspace SELinux permission checks and
> > it uses avc_open() internally, such calls are currently not
> > thread-safe.  Provide fallbacks to using pthread mutexes by
> > default. Single-threaded programs that do not link -lpthread will be
> > unaffected due to the existing __pthread_mutex() helpers. Applications
> > that explicitly specify locking callbacks via the deprecated
> > avc_init() will also be unaffected.
> >
> > This is the first step toward a thread-safe selinux_check_access();
> > the class-string cache and status-page transition handling are
> > addressed in follow-up changes.
> >
> > Fixes: #287 #335 #336
> > Link: https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLH=
RWcCaDaH4LOn=3Dzm+Zw@mail.gmail.com/
> > Link: https://lore.kernel.org/selinux/20220120073329.15234-1-purushotta=
mchoudhary29@gmail.com/
> > Reported-by: Seth Moore <sethmo@google.com>
> > Reported-by: Purushottam Choudhary <purushottamchoudhary29@gmail.com>
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For these five patches:
> Acked-by: James Carter <jwcart2@gmail.com>

All five merged.
