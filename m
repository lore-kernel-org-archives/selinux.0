Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A64C6536
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360873; cv=pass; b=SZJPLSh1eD6WeNa3wrGCe+JUjG2GDQAiBBRGBVlPJnFlAtpTnF8MN/wuQw35tOvXmm0qaUvc+9gyCAijv1y6iaej660Ht3g23Xs4Th5Vn7JhEGezAM4fbcFGeYzjUAgoPk/a3qFaApUk2wPL47hyFKpCYMbcaMri0u9nLkHTHRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360873; c=relaxed/simple;
	bh=Otq2kHerkRoIJ/enkfOEYgh3hAa9t0UvVfIe94hI3nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nbw/qIXLzlVpANJIvAY+s7wAQquLfVl+rdyvKGZ8m2y09KUpWCG/cncQLXfS3+JcISlPv7ctPbgLAxxQtO2bMH+DFyEpdtYcAKO1InNUQYDgFaVUHXKncXdli6PGIz4cyg4WkpNPGWPMCuDZmIpoGas4qsf9FaGhkJdQduWD5M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5XSo87e; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5XSo87e"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85e68bdbcc1so9598047b3.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790360870; cv=none;
        d=google.com; s=arc-20260327;
        b=KhEk1x15Ym6F1WzHQk/FqRbvvWuCkCT+ikkPVryCMMaKqLjj8Sl+/HguOOl5K+FUld
         IzWOwuVixVyNbjg8d2YtxXv9rMkae8nENy03tI0SLizkQM0zCj8Ioh2k4hNir5s6PZFN
         4uiZZirW4XnUvP1/QGeFaVZylG0gcNklFnOVQZT/oVM9JzLvfHQFOQ0EWOO5ptry1Kdw
         V9xXnmoZWKJ62CBKs7f1nP9qeBR8DZy4KcVSXLk6h+w9qVjJQ7TzIdvUBZdlxQ7zyXC/
         99SXIrWzzRjLlitk+XMreYpWnadzeF/aC89GnyQzkBJ1fXha7NJ39jvRjaPw7Lwqs+TU
         kWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TdpPcE8VeVUIppKkbumxq6OxeLPpfet2E8IPpLf6wl0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=ad+tGYwrBQYgLZADAXlf4z8B7teFGqiqqFu8j2zWS8Orl66wdb+iXkPJ9u+R4AAXGZ
         apUOzVd+8so2zHfzRLgM9v+wXI+4lUKP6W3S4iwBviEBgxAdhMWUXUdZf6fl/rFljxPc
         J8OFOfxfe3uGZJl0fLvYm+kM7aMHC2hQd1IkWxgv0XPWt0Fx9OFV1taPa+O7BWVMx6DT
         GP+hhcBwrCg8X3gsqmefF6FaJwAtn4gQ9qAV2exlYa4kJPVxrCGohRwGsU5Jcgp74nWb
         N114ZL+mb1q+8vsRUCV/sDX9r5ipovyU6aVLVTjqQ6yAs27AQqPwUDXSThQRcRi7COwH
         TKbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360870; x=1790965670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TdpPcE8VeVUIppKkbumxq6OxeLPpfet2E8IPpLf6wl0=;
        b=L5XSo87en426Q2MxLURBUzdvI+G1hgAm8Fxk5kIrAI8YEdYTVLKuO3XgulXs2jajQq
         IF+iPpdhErXQ9TNmRuvwNgxmD+V0HapgGSCzZegMVSzkS204rJA0UGH21752MuUegT4c
         W5dC5851fABaOmf6MU/veq6SV0LAq4jlpPtV7AHCJfLRBwHgiMmyiGrCRrd2EiiSff/n
         QTFPKQn8FMYZMwh2JC3iq3qofRRN6AjTJ1xZoBW0Dsn/Th9G1H0PFiXC2noYEBcP+I48
         EqLuhVCPLVQsNgSAyyAR2qqbU3k0oVVorWsL/yNAZHyRvUJprrHINhQb06fhvJHNew/3
         yJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360870; x=1790965670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TdpPcE8VeVUIppKkbumxq6OxeLPpfet2E8IPpLf6wl0=;
        b=V3JEGwnN1bQOmMMsrjr3RZtSifSheEgQSRoy856qmMNsBiZVPR3n0NBsfn1aH1ImeJ
         EfsKhRST15xZ/xw09aaaEpHoFGVCWi174XURChpB01sYi+09DSbRyrs6eIpJWZzjR5st
         6jkQIKjNqmQ6vjL4CGy1uUm88pPhSM387BLbNPdLjZuqg0OEvff5kjyZO2urJkEIuecq
         osLtdEJsk8JGT5NcL9LzmMUzZZnGZkAVH8BlkoLBymju51eYS6FtukoIMiImKjAkzJe2
         eM2TvAj/oXpKws4o28SdfXK0DGmBf4MP36rSVJbufUaCIn0Dm3XcDkSwve5YO1E8e1Fm
         awdw==
X-Gm-Message-State: AFuF++lYLHZB2ZtMaRVx5W3Ofi7a6+cBosZFbWE4T3JSaFeZTw7wEQ4H
	nWEN8VzL45+LSa6gNe4DZM3NhE4ngBuotxFR14od8Xrf8zUnZ0Vt3WQBb6lOpc71mvBQSobyjBh
	cHNuCNzMRomaKCP7oJf6S0l5juPBvU3gwNQ==
X-Gm-Gg: AYBFou1HGoQ9K4EwHVWV/MYw13viE3Hf8RWE4t8bucZ6iPwjqCvbVameUmoFwUInx9E
	5iwGIftNAi9lUpZXdJ3imfU3GlbcH1tLuCzxRpVE+7q8G8RmEZH/sxM3Qc7hGuQcm4hjxu65+CB
	3MqIgXxt+oVf5diuA/EtWpmYMbw5VRZXZBvXOg94KEkDxvex553jVTA0sfLcDVNNZW6iTU9hBfO
	mZ+x+J70dmMp+6kl7xTghAUazaW9bhSqKKHVauqN+Z6ETuGALu24G/M7T/Aq2ZCCnCQNUOVUPwO
	yFwSuMYf2Qx9JUwOKrqJPzh3495EeyIDgqoZM4fvU2IFNyTHE90lzka5RJE/Yvtc6g==
X-Received: by 2002:a05:690c:6d84:b0:8a8:8456:a966 with SMTP id
 00721157ae682-8a88456be4dmr11058637b3.31.1790360870394; Fri, 25 Sep 2026
 11:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-20-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-20-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:27:38 -0400
X-Gm-Features: AclHuK8nt6pw0sKly1S5JSu31h92Y7ElLRsJ6EyHj-Vrhb5JYOLddqPHzZIi3Dg
Message-ID: <CAEjxPJ6Kuxfn=-ShTD3r6FKS1exVV19XgE9a2HW1YELgToRZUw@mail.gmail.com>
Subject: Re: [PATCH 21/21] tests: drop headers from Makefile dependencies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Clang does not support header files included in the compile command:
>
>     clang -g -O2 -Werror -Wall -Wextra -Wno-error=3Dunused-parameter -D_G=
NU_SOURCE -DHAVE_BPF -DHAVE_FS_WATCH_PERM -DHAVE_BPF    bpf_test.c bpf_comm=
on.c bpf_common.h  -lselinux -lbpf -o bpf_test
>     clang: error: cannot specify -o when generating multiple output files

This also drops the rebuild-on-header-change dependency (make's
builtin %: %.c rule uses $^, which is why the .h ended up on the
compile line in the first place).
For this tree that's fine, just flagging it so nobody adds them back
for the rebuild trigger.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
