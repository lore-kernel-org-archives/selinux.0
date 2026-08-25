Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD881283FD9
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688839; cv=pass; b=t56qh5rx5okzwcyWLeKBcvpIxF2S4NHbTo5kMkYDPDjwIWv1E+Py67yMhpvyDB9eLOwnazufFIj1FnzaIuL1G86URMDIXndGH+5ADauEaddN86q1CNATeqr4to2Q+yDZYRcpGR+5v3/71UR9jrPQwBRmwnUBqcJfa/5iq4XVYrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688839; c=relaxed/simple;
	bh=MJTbj+OQG02iNKXsTQT3P7pGtOq9nUh8BS4R3q+4JGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSe3RjWoNasv2cmC+tTURi+sWE68njn6R9Lqcem95ZquB6HjTI48XchM5oP73jdNrfYDIKuVRBA3Iz293b4G1jahvEsGYOj6dW53jyGieXvhRuY9XgTfgch4mKirmNoatuizdwj6oJtsdkk7IvZT/If76vD4UjbZfzfhHyVEcxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJnNUS2t; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJnNUS2t"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-462df62f872so1349012fac.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 13:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787688836; cv=none;
        d=google.com; s=arc-20260327;
        b=bNyTiC8dZ39v75bihP3E837BnC8HgXXL2MvGvGRqmnQvFSvpGQ4gWHZ8bPSPSoiRH8
         iXaafs8l9HX7M+vXLjjVPnpAIHlHogGuYRZnwT7a6LO1RP0KtlZCZwFgK9uXX7lsM/M7
         vZJx66UoMr2PcTgirUSKuTNjZsx84xjQX4NOtrXlRqawsDNOrEKHBTCBnaQAKTQVkqc6
         mvndsK8MBeTH/pKEo+Jym+4e+zINu+f1RlkoZ6rYUYsoNwXPNqppwKbLr2to1IZECPOQ
         4UopHj5rA/JfaYfJIYggwTEsQUwn/enM2BV6xAA1b0rPAmAJIIFvvMZ8XtkGtJK9HEnc
         ek7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJTbj+OQG02iNKXsTQT3P7pGtOq9nUh8BS4R3q+4JGY=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Dy0a0X/1ET4WILjoOyZtjPmliD9aoCn29SfIpC8qIz/XeDJV44k9qtLwTB9vcMszGW
         aFQKOd0U5AC8C3GbFdMXFGjBlbRSJE9GWK2bjnM0h+tFAYJHtSxc3Su107yf2uNyGX12
         g+E1TVQbtEdfTGbkgDEfJjKms9Ka5BFdLEUAw820xu/4eE2EnBCqEBi4qIUugqJJdy+L
         kBNLdD800UzLI81PlcM36rpkLQEe6WrF4z+c51x7ivSmsyowsjyg6HD9K45u4SL1fYQf
         DR8gl0fi5iEUSCo7yfJ1ayVhWrvSpjCDIEH145+2EMAbLoo9mZwFb9GrjkhRR53V9hZs
         TRmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688836; x=1788293636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJTbj+OQG02iNKXsTQT3P7pGtOq9nUh8BS4R3q+4JGY=;
        b=NJnNUS2tkhQVYEUoiOz8VVsSfEkWTMZeBPO/hRvd/qiCwjwg9wzZGtzSXp4Tj9Vz9n
         3D1So2Y5p/UdVE9RLrsKhXfiAzLtcgLEXVWkhqK/uQx49k4PO+QfxWjEzTwjN42hQ0Fg
         CeA2HsmYjdOY8XaGFW43p6USGvcvKA8XENLrwq7FtVARwOTQxvel5vJVfzwNCGQfbeGA
         dHlROuH1hs/kPKbMmb6n2tBfFZNRSwcT8EieEKHqZ7zGqY2rSxZ+J50cL9yurgbb4nWd
         GfN5okJ47o3HN2NJQk+r99VKelwlcpdWPVZtGKNz3rCWtA9NfzQJbLV8YdsYgtwtdGS7
         jSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688836; x=1788293636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJTbj+OQG02iNKXsTQT3P7pGtOq9nUh8BS4R3q+4JGY=;
        b=kzOhzCYncTLfp6M7VBmabVo6bYhFnEmjIg5Jljl09PjpX8DHPtCIF5mXKLN0gbSkzA
         YaAPjEfwENBy3QGVMz1ryAE0jDptYa6DfvbYScsmxPUyM9T61F2rNvKS/lZSE0aEFbMo
         Vz6yuEE9j7XpskcSOITDOMG0DrPjA991v7xesT+nkMGF/NRWakJy80SZO6zWDDKpJCQW
         5i80t7FJjDt/6AaAvtxAQGgXjJDvrEorJs1qcY4kq5A3ckVnHtLoGnCq8NpXxojO9pqJ
         CQvfTYBi5k8Xypj84pABz8tLsHwTQv2a74C7m9XmK6PXgU/3ak8CDNjMkarPRlT/EJ4I
         gZaA==
X-Gm-Message-State: AFuF++nWZIKe8FARdqRpNi2r5tQjMCfDZqEYLaPehFx0HnnMc0i4Gjay
	XVtPJa7dtdNusHTLIZrOm+lEL6Itu2uJ6N0Bpagg1r8FdN34lXQtkU5k9mnJyrIDnJ4WE/tpqhO
	W6jZakwM0Xbjuddx/FgEVCGka/ODKUSk=
X-Gm-Gg: AR+sD12FC+jzYMqVMgdCQSVWEdt/22XuiZJmOMtUOMBh6hFDKy4io1NgO6vJgpFp8bG
	2NbuoubSe+Ad6DansdbGwUOVzeKnZp1vm96NRNrmbE/PjgfTTe8pvJKSpRlplGQPm3hdLlCiylY
	L19RxbbRV/JnnYC7RaZVVuvDXthVNud8kEyHJ/zFHewpiZ1pPZuxjdKf4CGEOKDuGvHl4vxgJdf
	gSBmE0EdrR2O5vsmABiHDo0bEkI0NnQHLnV+D4i42sBsCeLYCvg+poaN9Xf28/pwTeYXaIDm9qF
	5czqddZVzoxO1B6rcBR7D/SlJm1mPcmbtlgxVhjLzwaM
X-Received: by 2002:a05:6820:2011:b0:6b0:31d0:5fc9 with SMTP id
 006d021491bc7-6b18faaf10cmr7408500eaf.7.1787688836605; Tue, 25 Aug 2026
 13:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825194111.75602-1-jwcart2@gmail.com>
In-Reply-To: <20260825194111.75602-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 25 Aug 2026 16:13:45 -0400
X-Gm-Features: AcwNN1WR_l-UUt65ljeaqiy8H_1IUl_QL9qM2aLr_UeKbxiz2xtr7ntf_m5XyJg
Message-ID: <CAEjxPJ7Sn26wH_QqhXTSVj1vDLAuRJZ7-CJo5=G-vxZpULyewQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Move the PERMISSION_MASK macro to private.h
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:41=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Move the PERMISSION_MASK macro from policydb_validate.c to
> private.h so that it can be used in other places.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
