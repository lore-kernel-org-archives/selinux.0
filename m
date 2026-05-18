Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50711E376C
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134309; cv=pass; b=LoSMKw2/c78LZLDiYpBn6WVCvbMlrL/18364gRI8CCliRcuK2mK25L8rsj6kqgD0r74i1f6WgVCmYpHWcaAMJMBhngJnp6D+lH5SAS/wOqzbVFNgRTdW8BOdT0g3p3EB18hJpCJsg62IayAFJqA2Jp4640JeEVMfXUQJ4PBqrMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134309; c=relaxed/simple;
	bh=/HL03g2vKshBc2YvMFn6wETSaJPRlosiy7ErAD4vREk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0VmN/CYNVVzsWB6ejwzl9lcOtvrONCFSls1ErlqXmlYKGzuXKxDjXumCyYLYgAUmjL09Gaa9ErtNksiFALafwiGm8ZlFcDPdAYe1I8/OCjBKMaIUivSsna5zJg7yunRqqfubjy6NenpYi62loMxeqIlqHoJcUZCTm7j+VfaO0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWg5fq/K; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWg5fq/K"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-369ee210febso551866a91.3
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134308; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFuQsowZeYReHJ+JZitPM77s97B10X49mzJ9RPtl6rs9BhlcTh40HScn1sN/wda57E
         HLUcsoNVakYT4u09x1AqzSbj6Ujoe93TBwplT69N2jaLWfu5kH9vKbhLuXBLoXOt+Cvg
         JGvaguRinHOOWEWDxNZIb77anVPc3mXzYL6EW8BsJc+BOwFpqOEF1+r9vxu7jTGXHNo8
         kEjViutXwZM+9pRd7mcL2Kakl5XfvQzVAM6sgmsDHLNGMxkzVkeqfBiwHc/tmZrdfivy
         MynRjtBGSAgew8ubsyvPkVI5EGLYMZeJRgon6oV1VvB1KP4AQJAt1OUqQijoLmk7t6To
         z+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ccOuDF08HfQECr2CuQ6npT3B/KJbMaWogYPLFGQB0wM=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=DKZJZ3X2m5BG0j/Palzz17MO47uLXNyROxMYoteUudeP9ks0DopUa8eR6Qez6mcWOc
         1VP5p+mPj4bqZsrcGVWDW0uoIynkMDNpc7+ZIDQKXoQEZCKJ5h5/Yc0JGEfwBnji4h7C
         P9SAoBYQP3GYY2yA1uproAKBUuuKrvPbfBbBFRs78k7QbXCA7GAebXXT+NbffTxLu5bq
         PvWLraaMaQRGww6Z/C/Z18pR++MwdXFPL4V+Y0pxBxEKeioBmF7amW02VlUCdGxt64i5
         zm4k0wdbgQjc9iKbZTMEZJmEDYechXdhRJhwxMRjgFBmvWleSMEd73V6OM5PWBVSo5WF
         94Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134308; x=1779739108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccOuDF08HfQECr2CuQ6npT3B/KJbMaWogYPLFGQB0wM=;
        b=sWg5fq/KnR331n3TJr41PhucxDAwGzImmmzJq+lRghZBBL08XsUDdrOoV1UaMupKCx
         S95QnAgnY6Nt1wHGofFizNFoEl+rV6xMbORyLoxfs9XSRG6yByioEs1kkTp9tl7YJxvC
         2iXovvZ1elTdqfLZaxEw+ZgGfy2PjGvfEpq0msFnSDTBTwo1/EYG2Ifw8z2X5WPFBhll
         DXgW+bRHCnEnNVLKRF/VcYz7KNS7RSf440noVQ6nG7OHgIJMSa/VD3AHvr9REmJH4yxX
         MXHnI3oVV7sEyBkPpYL/XROQi+AKYrDF8mETZIubDS9QdjmJ8SDXIyjQl/q3Ls0h0BG5
         jNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134308; x=1779739108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ccOuDF08HfQECr2CuQ6npT3B/KJbMaWogYPLFGQB0wM=;
        b=JvefgvRtiC1Fl8sHC5oivoRrVe7repRfBHYQirSa0FgNUTa6OdgdSS36YJPsRLrKY7
         gxHD/WujNHMfUgzC6s6kBTT6YyJ1mlto0ipy+wMBFZOJMgZltZxj5qgIPJ3ArLin9Upt
         7Rcdrsw+WWIdtVTB6Sph9shUZUYn1Bd2ODpRYxEEUTPqmzV50P3bAdZc/eDEct4GV9Yy
         UwgOxU5uc8P8j9mJ1SeAcPER+7JbBtcjS7PtDwWYWsEG0u0uVMhKrsMJcUy+8ORctNMy
         9qAo2jZyCQQ3/Sa6TKTVps2o1joh0HTV6Kp/teIADp5vjKa4n0ANZwiKTMsmT+J5Xpsf
         K4lQ==
X-Gm-Message-State: AOJu0YwbQd0QtDpSHsZMoeREoZ8jfx+Vpwp38GDxWuuRBCckgYIO0Wu/
	jUY01S56ltHeUsHJVqm9ELJwmz/2c4eaMm3GpW3fBATJc+GNlpQk/fBfy4MxbHh/2UZSJ74z4kB
	8kC7oEXON77sjBmYL5fRy9Vwoytu29GsIvw==
X-Gm-Gg: Acq92OFRizmqhS9QNeneZtZRGPvVR8QeEc9AGeVMA3h2XrAL7fzeVKH6+FGuLmq2PFT
	jhbtvAa2LMLm9C0M9BbM2KSA4k+5/gAsw0WeozbnJbfh3za4RjzqplrnoR0al6ecqg4u4bX97YY
	xR+xXCSY+enE8d86AhB9VB6UakKfC+lJK/YfoP7Ez5eCNTj9IqkCFyuLJb7IG88GWls2rEHBDGg
	UHwoODi+2m7uWNDOMfOt7O7VkWb571D4Xnxz+XbOWo8i26UWYu+AizfhAT8EZ07sJVUwnx1muYF
	vqbzxQpCEVYMUHZeiA==
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id
 98e67ed59e1d1-36951c9f53dmr17026782a91.25.1779134308142; Mon, 18 May 2026
 12:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513135908.37763-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513135908.37763-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:58:17 -0400
X-Gm-Features: AVHnY4JzpmJFC8zsWrY34cgTgVLiIUXK4HgMVRjqKtU5noOtcSLcKatz6-kyqHw
Message-ID: <CAEjxPJ69q8fWJk=ADbLqrpW-tafGaQ0orDHf26N_v5Ypcb993w@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: fix getopt flags
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> -k, -v, and -C do NOT accept an argument, and the optstring
> was not correct.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged.
