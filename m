Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB13ABD8F
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948022; cv=pass; b=Y3E+nqX86uS0dVesqROiSJuya538iojkeX4/dc0s/m/OwhmoHEeSTkAyQjKvKP9PjaIL+pqQPb6/PVKiGXk6CqBn6IbsowH5PtbUxG2BkCr1UljxT695CqemWSgd9HjWR9nUt0FBCs7E+dzUaZMAZ4UYSfBCLg3nhsyhRcjNbIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948022; c=relaxed/simple;
	bh=sMwWeZAtm5Z1FwUN9BV4j39Xu9KHxMKs425TLvb5Ztg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvZv9ozs+YjlfJ65e7gBgWBBQylW1JPIrJ/rrxk1/0m+J0RF6WQhg2LCsUfbYVDrDTkbclGeS4XIjhCX9wGBG35QP5ls6iKN4/HwkorORhlmH59FjiT6U7eygzbMIPBtrUwtKTLSKir3kEDxFdvNyBAMuu24eFEsshDH5vWyDAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeDtAv24; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeDtAv24"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1585779fac.3
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787948020; cv=none;
        d=google.com; s=arc-20260327;
        b=McFKcZKBui3Rt2HzpLC8BAlfdPoBB1V6d6i/6Nsp5ESScCCvz7bXcXM+pO+FCPKN02
         ewCoi8zcNRdyKm1s7v869a6jPCN5LSyQcl6hsbEIlHou0Fia1ZkZbvqhsr/h5JBc+7XU
         T0YWiWDV9uVFSar20nrRPJM3P2UsCvPcA40iT3IXKd3FBo1ov0wfoEFr4gOr8Vl2AnRX
         ucfPT+33Xbtr1gjhaL3KYuYGBezz6NTKE8Y98JAcE6j9tfq6toZhZyG4uWNt/8rszrkA
         vGnKA71x4kt8ernhbwXAkIJ7h8rx3H4mBuzo2H/hcbUp6Y2czg1RPPKM333k/jEAP4UI
         6iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMwWeZAtm5Z1FwUN9BV4j39Xu9KHxMKs425TLvb5Ztg=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=L4BpxqGpx9GRjpcpboLhacW0fvQ36emT36+jN8/hh9GCa5JuXSsyrLqROkvcg+kS4v
         VrUNw7WGLy4lnUmSscuNvr0rMTkfgihFRByyOONMEof/KOpIg6IYVyKvtj4sqQ39CjLi
         08mnvrvbeHcMFywfWAFH89A0/FsynM86lDiuKtQb5QgCfyvI8I1bcJHhLJfswXCnDTpO
         hxeoHJ0SK5zuFyVYBGb3UBLcq+j3jbGJw9XrqOE6DjZVPj4ibxxMrj3nAT75WyGK8mmD
         xd9MG+ZbYig9lQT3DkG0zTd9daAO512kk62lhNblIEk+bgx4vy6TnJEBHPFtETsdS2II
         egsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787948020; x=1788552820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMwWeZAtm5Z1FwUN9BV4j39Xu9KHxMKs425TLvb5Ztg=;
        b=WeDtAv24PRSvyTiJIbo5zGnR9ejWlgLGhnp/+1d3yC56+qM9mahRr5y0AHNl4tVAcN
         7vCITdcDNOFVvuGvFVLHWCyWwgfhyj3IQmLcGn+IBQuCv5pVh1zqBW3J4WecqS2zWSGi
         kxiA7m9q9ojzGuakrnFAveKL5wEdpvsLqX68M2Hq2YR1Nkvv/cDO972J75vNrOXol/cd
         zPjhZNwAicpGe1wHPXUx6XLNea6oV5xgiQZHHIFEDZjFQZxm1RpK2LGbz1ViM6OhHj7t
         cID0d16TUHVWEUqlNRPJn49IEA4K4/fyRnOvSw+Ds+5k0igbh7BipSwQGNivNR5DuGWM
         llVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787948020; x=1788552820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMwWeZAtm5Z1FwUN9BV4j39Xu9KHxMKs425TLvb5Ztg=;
        b=Dw6HuJmXxhVEu3nNtsG/G+VkIi4Gsqv67bmbkDJQRGk883x4Bgh1cve7vvAxWDXYo9
         NpTOVP3nfkUjK8UYilR/StYToUKFVQ2DbOl+O0CHWM1LTt7Y/oUyc5ypto6kGplVnLCm
         J0mwJ8fCpzRW2Z/1qEn+FqU3rytai56WLwRmIXLEEDpY+LsintU6LnB/qaZa2bRqIuls
         iBUmmaKdeqBxNmbNZlJEvXySApwIpQ3VRDDcViJL9kMt07sj+nlQB+JI5qLxAAxswZSj
         qnGUANHTIMvKQNOL6UlKdk7aETAfBnXKkqYwvJ7vYJq59mQ8ha8hOjJ8JjP7HVf3p1ge
         lEFw==
X-Gm-Message-State: AFuF++nMsdf0NMW0FcaYyo4pDldbNbpQUZ4BmtaS6zcnR0HaBO+d7rzZ
	DUUWRFKYY1bQAIY0wsv87Hu+4gFsvWJHkoTb8HICghg50it0bC7GD8Ez6lq2wrheNgrZpAidrSM
	fybwEFVtzy9DFiYrBxPLjGi4bc6acrhpCDw==
X-Gm-Gg: AR+sD12zeYNEqhdLWtlo5p1+V1Nb4XGi9csI6eFI0iHiUCWsfKZch3d0JTNixcFogYH
	dNti+NL0xWR2784GJ4w62O4Sq4aqf6s2HZxYnDGwZAEGHP+VbdfxgxS0PtmK7wDmTaDhpn8Ka8H
	TpXEVgF+1uUp4FwzWMAUbU0DtN+/kBDtydKA9zD3wTs9rldTMzhz0UwbvcE/UFjsqkxKNFcOsUu
	vZq52h7g5xNLPLVz3vr60OczSL6nIQ+HTfAdDOaEtI/nCEyV26bqPu0eydw5d/zKTKbpqFMhy0B
	NcOWHEmnJW7XUTyuzPHuEpdYNoCvndUCGLOzhwLS/DbQ
X-Received: by 2002:a05:6870:511a:b0:448:9a86:aff9 with SMTP id
 586e51a60fabf-46837337502mr12610715fac.15.1787948019893; Fri, 28 Aug 2026
 13:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828175314.38256-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260828175314.38256-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 16:13:28 -0400
X-Gm-Features: AcwNN1Wep_XBs4HWcljWEL15SqbuClSaZcbH6jbOrx9vCe9bm693MmzVHypDr1A
Message-ID: <CAEjxPJ459i7Q0UcFJQ8wYmg9ZaeASX_XXi7RL2fbBQUOwf+g=Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add include/sepol/cil symlink for in-tree builds
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 1:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> secilc-fuzzer, secilc, libsemanage, and policycoreutils/semodule all
> include <sepol/cil/cil.h>, which only exists in the installed header
> layout. The source tree has libsepol/include/sepol and
> libsepol/cil/include/cil, and the libsepol/include/Makefile installs
> the latter to include/sepol/cil.
>
> Add an include/sepol/cil symlink so that -Ilibsepol/include resolves
> <sepol/cil/cil.h> against the source tree. This lets the standalone
> libsepol/fuzz/Makefile build secilc-fuzzer without a system
> libsepol-devel and against the source tree's header rather than the
> system one, and more generally lets any in-tree consume of the CIL API
> compile without a DESTDIR install first.
>
> The install target is unaffected; it globs sepol/*.h which does not
> match the symlink and copies cil/include/cil/*.h into $(INCDIR)/cil as
> before.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This is now merged.
