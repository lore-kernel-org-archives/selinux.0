Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDB155743
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472403; cv=none; b=p54dJHt2aMkh0JPqR3smtrbTy9s9Fw/5Uk46yWwP9d11UOZ1RreWe4aNdE+bmIG/u4XwHUN9DUFZ9uWF1vf5N5CzMFuzWR4nEgSu/eFbtteGR5z2p92v0Peq8el8e0LLAZuCmeB3r+H8D/uwyMX02wbJfDc/mPVBcmXukDvPpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472403; c=relaxed/simple;
	bh=D1NwulsRRrNdWSV+i3hrGzRKABDpAmIvqXqHXgR/X64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CFVEWSQgOpJvo+LiPs8IHsjoEHGDARaRc/KzUbVgjqkB4NUFsfV6KWl4SXZix0BhHLHBdEh8J9jZg3yPu94eJsYu5C0UEEdJ6pZUDfUJa+PqlPoaODWL6DXmisjztVMVca11kwcw3x+5hjJJ3EBd/CDO9o74WvCuE8aTwwSA4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b3PbaEfp; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b3PbaEfp"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fda22908d9so21827697b3.1
        for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744472400; x=1745077200; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/S0yQsqo4xbDqeTP+WOrNhmYe3/d2ppzLqVHA6jkw0=;
        b=b3PbaEfpESG8K6kbAeXr5XuEvzh9yvWk/M3+0/mhqNpYntUPMYNVlq0Y2ZFxgvT/eL
         KSCKqN35YKuZpas9OqLG/j03yqElC5SyqFd6k2cskkyH8hdMECSKhB0W6jc/4RFxS3Wx
         436LON2Vw1o+Ftt9+3q8eIUgDc9c0vEU5+CFd8g9RGOZsJn9Yu0A2Yy37MZzP29rMtm4
         EX5QdfyFZ7fJqTU2QfKLZBjus5gOtrSIn6wR72X6rO7PKhTbmMVLWA7jb29sphB9yS/y
         SWi1EBRZWQQPINj33XA9Vo3EYqzsp4QO9EZi9xX3V/EWqNeTgXL/jMj/BcXqUOTQsNC0
         jZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744472400; x=1745077200;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/S0yQsqo4xbDqeTP+WOrNhmYe3/d2ppzLqVHA6jkw0=;
        b=YdqrU1GueteUookhcQdDEHujnQ0lgDLd29Aa6bCyRPpspxNtCJJu7s7GSH3UYknvCS
         UMOPwI7QWBGE/eorP6TajgT7GgN+fuLLriYHax11EYNs3W0V+Xg4OPGeaOfLpqYrCHIw
         n2GsWVlzjL0ZPYILSNQiH3zJUczgkhuWk0eSdbx7th+i2OonVQMge2kV+iQhSYkk+88p
         St6zK+ni0CbqzGeI6/M0C8CExNU27UGk0qO81rBeCLLywzfTuaNJ3Ze0uK79ObNcClnC
         j3MKNRUs2dS2iscDfvzt6+MrKgtMfjTtAe4zSxSyc4f62nsBqdGk+ntzqqjLM+3GMbU7
         NGIA==
X-Gm-Message-State: AOJu0Yyn+EJJJf9EmpiA9qegzn8lZ6MF8XEBBzU6vs8zNMQxsJ0+ZnoN
	O4Wai+ZXHKzWu38TjMf4uMwMBZZ/WiQ6+1jvut5ZcFvuoMSneyDbHBRftjfckByjqhO4IAiDpeJ
	t6PvjrbMLBF6KrVFdYDHj28MpXKapsONiDjWQWpXHyGZAMc+8RA==
X-Gm-Gg: ASbGnctQmiUpLGwPy98v0+TxG/Z2X8vGahLvP5ppL3l7O2MWNucSCNIUVOLWhktHLiW
	vtI5ElJMbkOv6wHQ9Iq68leQ7Yi5wd8NtcHy0cU+62ig0KF5MxbOQRWyOrPyGH9pf9tAXagm2pm
	UFX0Q7bPBQDt4ui5c1hcASKA==
X-Google-Smtp-Source: AGHT+IEGfOkXB9Fw4LDi3ryEytxA1Ns1iW88IY6EkGQDfqR6u28eK2lWhoBCCFR8D1k5upJ1kYPgMEnYOkU7PKas8b8=
X-Received: by 2002:a05:690c:45c4:b0:6ef:4fba:8137 with SMTP id
 00721157ae682-70559980d18mr113513387b3.6.1744472400319; Sat, 12 Apr 2025
 08:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412153234.23169-2-paul@paul-moore.com>
In-Reply-To: <20250412153234.23169-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 12 Apr 2025 11:39:49 -0400
X-Gm-Features: ATxdqUGgoRj9mB9lNBNRNwW_Et0aZo5zU3Q-ap2NjbBb6WL6M6jv8t3_7q8MoWY
Message-ID: <CAHC9VhT3=_7LznREEM3-6dN095BqsxL8JLYYYAC1utbJ9DS_JQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove a duplicated include
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 11:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> The "linux/parser.h" header was included twice, we only need it once.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504121945.Q0GDD0sG-lkp@i=
ntel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/services.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/dev.

--=20
paul-moore.com
