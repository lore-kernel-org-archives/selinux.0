Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D825B0AB
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155739; cv=pass; b=P/LE3wFQyNu5QwrJs/H7yvOCEMxrR7reS4PsphysKKM6NZ9ViehVeUI1N+wNqA064mKzxw50wr4L0Dvc0ifyWOOeM4hFGI/7U9eRe1GR8+6CEJC8SIG1P71PgmmKBcN4q1MfpcBiUjrjqEuvMCsmR9+URXPXMVcX4DsxrkKZWaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155739; c=relaxed/simple;
	bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRD74NlUTNAN+QwX8UVGXnNW7gRd1KEdlf+V2CJ1KtkLaMMsusso9t03HlVQ/3nR8cybI7qopnKJRweRJoz5H9MxV2G6gAe3Po2m96zmDFnAOrblsiaXCaNvM29TW1W0uGjAJ6eyMJGkdQR9Srqf+1BV5ghtRB9T9vvx7qEzCc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fufsntC0; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fufsntC0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so3347632b3a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782155737; cv=none;
        d=google.com; s=arc-20240605;
        b=ViA8bil7PHlC25hHg3eIdWJP1IpJSEl4G3Mxg1P6YvhhoiQtQrfEiRk4bQxeblFpYQ
         P292KVvsx/EBuS91pg6US24sGf+Lq56UmF9k+hM/RF411SP1AyiFFTkjfoTkrQH9buxR
         wx0Nm5/clHtCT/pEbsCyL+FB14aGhQbkLpFxZHbdfse/r8Qckv3MBZf9TUsfFva/uhz5
         6QJ06ouqOCPLP2E1c7zWzdnW1wPXDrBSny4LwuWD5bj634cVur74viOBL4uM1ulAB/H/
         tUGiZwkN4/0jHL44mD7gc4ypzjsPlTRpdaTgCMXN4tTwC16B+T8XMleEXj4q2+JS9sLw
         v0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
        fh=iiyg0AkWiFoxZl1UzlUbOXwbFFTjjvR6EjaEzE4V9KQ=;
        b=Y5k32ZHTBueq4yYStkJBtVeUOIj4PIyAysTzeu00/X8A9HBPGJcniihdU0S/geCmBQ
         KkGQ+AIGhJY6RxBhZJTt9KK3JgL9pypxfsAn4nQ1Dn2DNiPBcSmASPwduHpDclDQoX5a
         EI2wr/klZ8OVrJPIbRQ4tVqQ0nL+iMWwyOnUOSDZb0d5wkgW6wXWz9nR0Den0vT/YNLe
         KRxV+5tgO8sy5CC51VWlUUCLkvl/e0CmFNzGsaXaxcc2ahIZ9eU9slBRzHQuqKH/y4Yi
         FqFN3fjIxT5c5jnixra8Lp1esTnCmOfw1fml9U7aTQqf6SCJ93sDm4NZgG3oVK8ocSVw
         4L5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155737; x=1782760537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
        b=fufsntC0X69189W+9/gfHpyISQwaReXqP6/xGtzNRax4vWdhqJ2atx3XrKJpIBbTv0
         ntakxsBGJ/Sb8T4orJQZ5H7HR6Rvt9HRwPxAcSWJXwe1SraQDWw1PW5YScYaE5a1/xfO
         xFUW/uI9s9PlRkRlg+v1GBn6dVcWQls8pdk8i6Cio+RGdB0P8sU5EIQgT7KNULnfBnKq
         HX3n9eA59tJIuoCLbuEtbqGuA6iZXoEK5gGgNQA44jP8BX1hk8UNvtl2/T8IPV/jR9Gj
         kZDKYW9TluHgvQrY46yzFjD2DDG+83sj2GLzg2wC1H2/VF3vsW6RuF3HAu7vuwj4Yef2
         7J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155737; x=1782760537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
        b=XtZpyZ968wM8pUafuPwgLbL8Jl6e+zm6ek0kdgd+plza6SculHMTUTb4NJ9c4JQFNw
         Z7QA8pF7/Ap9D1v6Um9f5m7mUBdZgjkCBxMQBLBbO8iwf0//U+kJvtjifooNyqm7YQlE
         /S2IyXo3VKZGuF79Ih4k9SMalP0kp2SoMsYEaJnOW+NRAIBW5WJBRlII/KFBS3pt3ykg
         LuuvN+JKBsrRcO5WOsKk6i7WJBYdCSL6bdqimjxR0nGCgMc1soEv5vrWPmhqGJR41KUF
         bbIx83haVGNICNSo7fW17CvTm58qZlZjbXAzfrA0f/fkFj1kg/gHjbuO/oJzF+kxhzVv
         uz8w==
X-Forwarded-Encrypted: i=1; AHgh+RqzcctGQxp+LPsBUU0IXfNQpQOQdwP3E89JCqE9o6ytNov+4xFbhVrMA7GrsaBz5vt01CN6a1h5@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTans4k2iFzQ+0Ji3SABhEEUst8ZggGFUUhQPpxLSDzQokWdy
	I9ElorPpc614VI/YudkrwYOB7V/APySXuBhSG1PznSPVSFYwHbr43c+jk8uP5ZoPJOtawR4iLva
	dVunoJOKh5w+OiDF4RC5olM4R5HWl7dU=
X-Gm-Gg: AfdE7clf5t07euufGx3qbBsGsxO3gOCDth8JQBV4rLXVACrDBjQWMPwiU7yCvilo+gp
	qxf2rEQ5B+POqv2VInYYhk08aawfYUX5PNvpCCP9AA4s7pJz5PiLDlruTl/ANGpB3WszDOaBzjg
	gxKLCHOhQpTFGzJJgWDNCb5simnrxmS54ZLF0gflDkYx1JcyqB83kt9GAovR0GZgWgrjmCLnqGz
	ynV0HnEtXcCeF4mbYWAaGbnsyKO2jiISWJjXW/xlskE+DGpcUID0LuJID01N63oCIXZSnHB3OuG
	1CSdipM=
X-Received: by 2002:aa7:9062:0:b0:842:4982:81c with SMTP id
 d2e1a72fcca58-845560b04d0mr17038645b3a.20.1782155737031; Mon, 22 Jun 2026
 12:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com> <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
 <178215477740.1641401.9370300196381074566@gmail.com>
In-Reply-To: <178215477740.1641401.9370300196381074566@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:15:25 -0400
X-Gm-Features: AVVi8Cc-vA_wYwpGNsHgXqsrUabXDiRVPaAt-UWVI9LkOiJj9jyeujf3StAkcW4
Message-ID: <CAEjxPJ6zrqBR1jXWgCJs0e+7qPnonhWHXUMomDT8gbz4Rm8yXg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:59=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> On 2026/06/22 10:12, Stephen Smalley wrote:
> > Is this sufficient, or can the sk_socket be freed under us after the
> > assignment?
>
> The assignment is safe. sock_orphan() only NULLs sk->sk_socket -- the
> struct socket is freed later in __sock_release(), after inet_release()
> returns. That path goes through sctp_close() -> lock_sock(), which
> serializes with the ASCONF softirq path (bh_lock_sock). So once we
> read a non-NULL pointer into the local variable, the socket is
> guaranteed to remain alive for the duration of the function.
>
> > Do different callers of this hook provide different guarantees
> > regarding sk_socket or are they all the same?
>
> They differ. The setsockopt callers (bindx, connectx, set_primary,
> sendmsg connect) run in process context with a file reference, so
> sk_socket is guaranteed non-NULL. The ASCONF softirq path
> (sctp_process_asconf) has no file reference and can race with socket
> close -- that is the only caller that can hit the NULL.

Thank you for clarifying. It might be good to add some or all of the
above to the patch description and/or
a comment in the code to make it clear going forward.
