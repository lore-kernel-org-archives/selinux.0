Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0850155743
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472421; cv=none; b=Oac5lAGp9KVRVeej0FqS0LNQ9B7XMtUUt3v+X2Eo4UEiVsVuEGCiDQ5wJXM1L2tTcgCismgVG8NSTrAyWlGsTrVwCX8WVJOFl8qz8/fDBP+1rPSykcHqbwJBEuJ3uBH2YiSAdPw3b7+/qzn7cpUaqAzglTapEyMcucVuPWR5SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472421; c=relaxed/simple;
	bh=sdI/ISxVjK/eqE/Q09eBG9/3N1ZV3dPsc/AtrjMArBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MXd8tlcFXlk4MmF1cwr8OXVnCadKJUqK+NEsRMLmKmTUg86I49NJ6yyqBfdj/9NRkmbyeX3xvvO5K5xXXqwFYp1W0AidVDG6ISICxtHnhu2t/FAkyxbU5/8GlNC7mBYZEN4NgYSTLOIPaOd/rIdE4vw7MbPqgCWpQrB4AzBvTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ukd1f8Zi; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ukd1f8Zi"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e461015fbd4so2511473276.2
        for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744472418; x=1745077218; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2urZlZB+LgTURg50OYfTUE71/ExXK9/SCuFmlaa7FUI=;
        b=Ukd1f8Zi3FbdnJ7RMqTbPkdhTIP8kxDB0Ct7V1jucDk6Uz6rOZngClqfZ+u5UJZ9fR
         H+9VC1HxjwXNFclpvcXNcOVL3ljWMZAEDEpMdp1/LwtyKOutvXJ6fMQyG4F9qvUxeGTk
         diSEtoj9mMLxzE0FvCjhbKcbQMZnNcZR0+WWTODw6cbZnwD7se3xfIal9GWlfb6triyB
         5ZlGIa9RMSvYi5YGn4jH9qZ7NpqMSpOPZ3Ms+hZyvo4qVOmGzi/Oye/KiEZ8ajzzQ8Z2
         d3AV1BE/QJgW8D4LSzcRkx0BfMoekHOWe+S3aQ9dcUEFRhyP5OpN1GXCMsnUvPN6tszk
         /hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744472418; x=1745077218;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2urZlZB+LgTURg50OYfTUE71/ExXK9/SCuFmlaa7FUI=;
        b=A+i8cP5N4baRNQ5SsKduFnZM+shuM3XaHTdpfjd6fP/anRWYSBluc6MH7Tqg3aNkgV
         7pHsg4LwRMCHv63ZZmUL/q/KBUMAG6tc1z8vg1gXUx+CyazHAvL7z6mPZo3e0tj+ncN1
         3y11AvZ82l8TtTxV073GQ7coWHO38DBk6PIei0I6zSLS6EkPHYHCcJT6XEmvnH7Vt8SR
         eVXMDjr6/XBD7Y3HeCCLRRQfKcuXkSgxrZ0x0m+3OwpnMWYHlSOZLPpTq0EG4lYIT1ZI
         Fdsg+wxXpES5ctytKzVQl7DYyhoWmOcnScGp1DWSJ73OCvA87XFlO5YbOvZrfM9/skmD
         d/5w==
X-Gm-Message-State: AOJu0Yyk6jf8MVH3KOg/tFMtkT3qQjTp6/dPopCYehkxg3fw6iho7fbV
	+tDzXqXJDBpSgfObe8y1l4BaAhTjYndAQvZV2CbjmjEAwTtxtSaaAiyjNSo7+Q3Xz2CcJ2hiqQg
	1tyQiQxOXQBERN99Q6EGKRhlnUrJbg1JfTVUUeOCnl0ZkB2Xwnw==
X-Gm-Gg: ASbGncudeKTAQuh5h8mOlGBUwxsje1xTGUyAAci2FQkmNbdOl282oyQ63IZDDIfFx29
	nVOj4AU9jq1xfdzd3iubqR35WlYT5GtL6R0FxCEdzG/tAbTbonKB6rDWF8oFgyfLcsFjMv60gzT
	k8vzmaW5xlSfaTVltK3O++pg==
X-Google-Smtp-Source: AGHT+IGdUDzlnFj0lC0oV+3lPnyqsWgBJzJb9btrbJukQouyDt+OMThO+fJZPB1hO8NkVZpnAHuy8TKRU9MEdkXtH4Q=
X-Received: by 2002:a05:690c:6a11:b0:6f6:ca9a:e9da with SMTP id
 00721157ae682-7055997dddamr109174437b3.4.1744472418313; Sat, 12 Apr 2025
 08:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412153736.27881-2-paul@paul-moore.com>
In-Reply-To: <20250412153736.27881-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 12 Apr 2025 11:40:07 -0400
X-Gm-Features: ATxdqUGNaS62wz56_fhnD9r2YaHr59jJRKmlde0QwYn0FD7xMa8zq8lTbv601Oo
Message-ID: <CAHC9VhRBYSkqrjpifJG-xdELvT-sHQd=DEi9y0RN_xpxMyzi9A@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix the kdoc header for task_avdcache_update
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> The kdoc header incorrectly references an older parameter, update it
> to reference what is currently used in the function.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504122308.Ch8PzJdD-lkp@i=
ntel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev.

--=20
paul-moore.com
