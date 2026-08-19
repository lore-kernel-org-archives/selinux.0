Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D151440623
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164020; cv=pass; b=ACWAsyLHlDcrjiSTiEizjh5bCT7pDINelPdD8N8Yibg7sfnkx0A9iddujN26eXy8TIZvAubR55IMatgJhQvF0UCiWgmc3oFvUmG6FI87d6lfaB6OSpj2jRhY+X/wTKgqDU4WbqC7oFRwD9EGUAmD/OZlm2c1+WCfZZcqkad8cIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164020; c=relaxed/simple;
	bh=9sWVOYUVOxdvzX7+BTvj+cFJyPJwOXnGkPF6EMI0yTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lq/Denqc5ITMNj1gmKhBRlpkY/OE6lk0io9SKGdQHWV365nf6JLeiwlOJoY8t32ppyL02ch9bSPmi96U2hbLGfKtk4CTWPubDgYR4XkuQR6vUBvJwydXEfSEp5XSR13xfWEiNpX1c78RnWl7zlxt20Z9BcmxL4Ow0Xx597szcFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es4hS5Dn; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es4hS5Dn"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b0ab918216so886669eaf.3
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 11:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787164018; cv=none;
        d=google.com; s=arc-20260327;
        b=GE3WpNy2R9fokE9ytYsmFfRcz84xVtqycExwYI1XnDgFKVrMmJCkpsegxRvSIlQTyh
         44ouC2b4wO+1egaxHYcsnhpyOsK4Rcvx6SWPzqt+pmFcrI8NGT81pOReVkKwjNZCXNB+
         ZiQN9Ztfq6ZLVjdGDfanEncVEuLw62910KUfNFeU4K1NZHPMSHMGITvgfREAaLIaDu08
         EAg5W8m0eJlShMoxaH/DMIUGhFEOPotnJRV+G08Wr5yGfa9UCXmYQ404T2X/dhdXgess
         cRNJv2hnjHaUI5PHDsqYAR2HEoA3Eg03xakumXsQ7I321Cp9mXXhhs7ufuQ3objP4kFa
         0VXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wIEWfdzEhrBsO61h2U16+112QKHgVVZkwtHOyj2Rs3A=;
        fh=dZX3gADy6vUDwkYNwBGOKqxp1EPx2k+E5XAsnXMckxU=;
        b=XEGZmJJAhPeKUTThdo42gZK+2w3dZ5TuldhtBL5A3Tz1lvQcIsnjF1X5FaQ8iG746J
         Au3ZO2hWGhrfW4WhAfXq+wuc9mrEjYSPFqi7sef8bfijQsvXTTwwN/ar/EhTO2CLimAi
         cPlaY5Qaj98DgrZzOL4Y0XJiJlHdioay62/1jtktpKMccUJYT+uYPUUCn84WnJm2Vhhe
         gAqy7/p2VPIKGfL8nX3D4djy4QFuwWyzayEOfwys2any8J+pSZ/gHxT0bCOl8ydaNzne
         t8SQ4w8fId4s266bB1cN+KImZGTHam0gaVntZv4XoPHaRKvtVPDE2JOGWwDbrjfa1BTT
         oXyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787164018; x=1787768818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIEWfdzEhrBsO61h2U16+112QKHgVVZkwtHOyj2Rs3A=;
        b=es4hS5Dne7zYBtJYwp84ZKVjUFIKZkHoA4M0C2pebarZ/Ub3e+MA/3gg/CGIuMrf0a
         toX95EN8PGr6IQzjlgwUqUVzCmaZlEpJBJfCxQxrhnbBpt43+1sCFCSaxkeHFsMF0jAy
         xz5dM9KxUMVWoy+Ojjdid718L++YBcud2QCrSTzE+L1PoQH6Iwq/wtovjkwQmxoKrZ7r
         TU+t56GwYlJrLP9cIFGTU5S6i8rA+pj8ZsejETGrqlIGU4k/4LAoGgZ1RSBOK/9gsBf7
         4WiuL/rKyqz9Pjh63522RAr3JDAYKp/pGjSBD/DDFxId7dnkln1WU/jTQH/ClNgoVmwT
         xssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787164018; x=1787768818;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wIEWfdzEhrBsO61h2U16+112QKHgVVZkwtHOyj2Rs3A=;
        b=gimJ2+7wUfbiPy3yFz7SYZudHGR/ohzbGOmkjWFXVHuFjzw+dyjc3UzLJPCCoNTEbG
         UkEhjV7to05dFEUEGbEWD4KXapLxn5IAZJefYpODZnBhpdcuhWJbg5ftc9ZSMfuudmNk
         ckaGfGw8y6EweC5RO7u4ZTP8IO8KOk3+Pf2xPaOCQn3MKZMss4sV3P2YT1lvEyGXO3b1
         C7uAfIuuAukUGmRSJ/XhA0IWN2ruS1+l7Qpgu/9p54odbzUS2MYc/3MYGeWPznaDRB7G
         42Oq56xau4PzPWD4fjjI+zYVSdVY9un6aEEIJ2f3Ak4FsTJtghjJ1O0w5onw7z/xRiLy
         sOiA==
X-Forwarded-Encrypted: i=1; AHgh+RrRdhqlNTl7I3SVO84OW28klP3r7us/caXz+liqi6zi3pxDWJnJCipdEqaPrcfgZ6TeEvfxBxBE@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPf8VMuxwM0dWSbvupOKXyDUp7+NgeqNkGzVVJwQ9AVrUB2hA
	hj+oj3/+VjqkBLuvO66WX3LPtYH0RxZOElSWvCvRzW/YU54P3QN/7SCDtoI9IN6I6k2ttmvEu2U
	3cKrB1tw2Q0RUU2WeP3ryTMYzoWVFB1M=
X-Gm-Gg: AR+sD10N1qrNpUtobHeJLpgwUTokfGSU7pmLeERANHPR8y9ed8IofJxeUrqDH3CFqZ8
	sr5KJlxorrbb+om/JZblVmAM1K/DnKn9yhQX029JzmHKXFoKB/94SWtHFhjCFpFDJMf7zrKRhup
	N65+/uCicsrnzRo5snq4J4ApWkDy8cV5Z6inLeP5ElWbhwYAx0qnuNccyt3XgWcvGpnjlln07Ea
	VNuRdy1V9tXUP8duvH0ritIRYcj7x9H+rB2YBTpPQPzPnvTD5fXhU9E09WzAvVUlAW8FgcFGrMm
	h18Rf8M3fLcpnGoJdtJZr8O0aS9xclhqmJbEb4ijP7lR
X-Received: by 2002:a05:6820:6aea:b0:6ae:42c7:ef88 with SMTP id
 006d021491bc7-6b13c2b8758mr7056109eaf.7.1787164017735; Wed, 19 Aug 2026
 11:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW8bFEJ6NCXWerrSvvYA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW8bFEJ6NCXWerrSvvYA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 14:26:46 -0400
X-Gm-Features: AcwNN1V4kqdv5f7ZztYjyNoQRqrxSMP-8ZOK5WlF04j7GEg_0iXEymze_SLpapE
Message-ID: <CAEjxPJ4cvbu-JRQX+zivNX5i++guHGcwLBbvL-gCrVpSgZ1k3A@mail.gmail.com>
Subject: Re: selinux:selabel_file_text-fuzzer: Null-dereference READ in selabel_file_text-fuzzer
To: Petr Matyas <p.matyas13@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, James Carter <jwcart2@gmail.com>, 
	Jason Zaman <jason@perfinion.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 2:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This is oss-fuzz issue 547975134. Crash stacktrace below and
> reproducer attached.

Here is a more useful stack trace along with the fuzzer input header
information decoded (\s is a whitespace character of some form):
find_all
mode
fcontext_data_len=3D16 fcontext=3D(|(?0(1)))++c|\s?
len=3D1 key=3D\s
*** stack smashing detected ***: terminated
=3D=3D4287=3D=3D
=3D=3D4287=3D=3D Process terminating with default action of signal 6
(SIGABRT): dumping core
=3D=3D4287=3D=3D    at 0x48E3CCC: __pthread_kill_implementation (pthread_ki=
ll.c:44)
=3D=3D4287=3D=3D    by 0x4888E8D: raise (raise.c:26)
=3D=3D4287=3D=3D    by 0x48707B2: abort (abort.c:77)
=3D=3D4287=3D=3D    by 0x4871803: __libc_message_impl.cold (libc_fatal.c:13=
8)
=3D=3D4287=3D=3D    by 0x4970F8F: __libc_message_wrapper (stdio.h:203)
=3D=3D4287=3D=3D    by 0x4970F8F: __fortify_fail (fortify_fail.c:24)
=3D=3D4287=3D=3D    by 0x4972343: __stack_chk_fail (stack_chk_fail.c:24)
=3D=3D4287=3D=3D    by 0x42E1BA: jit_machine_stack_exec (pcre2_jit_match_in=
c.h:64)
=3D=3D4287=3D=3D    by 0x46772F: pcre2_jit_match_8 (pcre2_jit_match_inc.h:1=
73)
=3D=3D4287=3D=3D    by 0x47D034: pcre2_match_8 (pcre2_match.c:7204)
=3D=3D4287=3D=3D    by 0x40FA51: regex_match (regex.c:295)
=3D=3D4287=3D=3D    by 0x409D52: lookup_check_node (label_file.c:2013)
=3D=3D4287=3D=3D    by 0x40A4FA: lookup_all (label_file.c:2278)
