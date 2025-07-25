Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C54341AA
	for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403182; cv=none; b=HbMsYlEHn3NrnBy6ZxtOmB5hZlQyFAVXGL0rCFB32aAfpBXSZwXaKuAAxUTvsOTqbOY2vy93S2WSg3f2l7j8larU3c+0jb08huOYxCnOltrk5eShWfVuTfCi/ETdhwUnV5CiEbIrVu8srVjlcGUDDLxVFPuEveuvsQ/V6Ie4Dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403182; c=relaxed/simple;
	bh=l6KU0Ym47gpo/4+gkXeck9uuSdoJ+qGh859kPbrOGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6RQ0EdRgNKA4cWUMWeGwjlZ+TYZYvkEYlSXumf0xV3J4nD9XccDFS7w2E/aaUd89hcWG6+0Hz+4O1O2Tl0Q3GvzbJyV/zceJHp5YQUH9kEyC6uaS927o8Ic3Bw3IgDwqCaUYt4ChTLpIGic3FS3xSJdXtYsXqlO9JQmqUNtJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QL95pT9n; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QL95pT9n"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bc1258b2eso1110534276.2
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753403179; x=1754007979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBJLs/PJJpZNnfbuzOicwNBmKO4/LfqUB+w9NcUKQoI=;
        b=QL95pT9nNEUuLj5YIn8J968lin62mEs8NsAxep0uc80xD58yjg+QAEu0hyVdff3bTy
         2V+TuRY/rDd8wCtME6VGwi++mN5YN8mdlqF2yhJwHsB9pej45Mksj1JdjPGFzQqwt+xp
         GZFjNl6++t+OD/gKZdk8ZLSLMKKIDDMAMZ5ugpO6n3j/AXc9h1/1NyN7PLJMtaKWpezX
         QyhWbS5TSEEDlidavpE0MMKwQfZ3ZKBJuosFgjAjePOUNSMM31MQvFRPDDjiN34kRRvB
         Rmt5LJpNbDTTwOiyQaiUmWvwjiPWGTIUKjhiG8tXsEZeEy5/Hq7R0FAwQIyrYSdR1ljO
         17cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753403179; x=1754007979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBJLs/PJJpZNnfbuzOicwNBmKO4/LfqUB+w9NcUKQoI=;
        b=VTTyiHPih3Jlz+1vI+117nEpwo0rwwFdjNUM/p1B73EsR9J+RpfDd1tad7EreXWqMv
         38p7ciXZxGrN2u4I2FIMmNut1nxllZgui7g9DYMVuCVabeyknE91N5nmKw9K1iN76WQv
         F4nA14WHkyM9N/M2LkIhbY8pLPWDNA7I4AavDe8G7Bp+l7yQTpJl1s92L3PPAeKhgpF8
         /4LjdKMZEMVpRbq4EYKKdWpLSpG+BnSMvRI9FokQjexR/Fo69/wnbfUs6t/7i7FNa4Uk
         seFtRevXVXEMcipCZlaYL7d4vUHbNw3R2HefphG5zizsHkxzkCxFphM7742Ky5tbhYhM
         f6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVk2SXbBdQfsvZKzph9bSyI2tL0asHsZoXuWexJPpRQDx4I1gPj/GGlRFh7cyg+W5p98d+uOAq5@vger.kernel.org
X-Gm-Message-State: AOJu0YzXci62hQddmYj5WvDthvFbshapbAJjCKpaUoOO88+bp9iPAYro
	vuBAvAzWPo7iwxzlv7CHF9SxK3tbbIS++QqbYOyQyt0gtA53iSnoLHtONK2GEf9LlCUiafIBNkp
	wPD4R/eBXw85q4aaobECu+Lzgtn5mq3Lvp6VfM82J
X-Gm-Gg: ASbGncuibvrog75ZusxQlyuS/kx7iH3oxa/u9gTuB3tdAP/+TBYVqEuHdFe0ROl/xSR
	dYvY/mIgZc3mJoTp4OrJHPHIDy2dTZRuzGr02M92B3Ab1w3kvhk28qA4ucJB+F26C4uIwbfWZjY
	V7OOxjhXaZPE1qRijFfBjHu5bv8d/0lOXFJXWY8cgRrMxqGiwiNhICsmLms95OAHakeSmtLPL8o
	xTfpio=
X-Google-Smtp-Source: AGHT+IG4xX28wZoJE5JbFJ1OTlVa2IhSG6LUzyalZVXihO1W5jvkr82mHUzmVqX4OTGOr9Xttp4WAF0/MiDAQgFmyD0=
X-Received: by 2002:a05:6902:13ca:b0:e8d:ed1b:3186 with SMTP id
 3f1490d57ef6-e8ded1b3c48mr1253952276.39.1753403178849; Thu, 24 Jul 2025
 17:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-46-paul@paul-moore.com>
 <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
In-Reply-To: <4ad43ad6-97b9-462f-af17-6d6db8ba3bf6@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 20:26:07 -0400
X-Gm-Features: Ac12FXxzx9eoUQimi8ooqCkQhXmAgNy1LksHgxSM-xb0VeXwFZGGkkiSgXURJwg
Message-ID: <CAHC9VhSV=e6aM1raofn-WWRJLS8aMYxi9kEsmL4BuTWLxXWLvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:34=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/21/2025 4:21 PM, Paul Moore wrote:
> > Move the LSM active count and lsm_id list declarations out of a header
> > that is visible across the kernel and into a header that is limited to
> > the LSM framework.  This not only helps keep the include/linux headers
> > smaller and cleaner, it helps prevent misuse of these variables.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>

...

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index cbdfac31ede4..03d3e140e0b1 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
> >  static __initdata const char *lsm_order_legacy;
> >
> >  /* Ordered list of LSMs to initialize. */
> > -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> >  static __initdata struct lsm_info *lsm_exclusive;
> > +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>
> I can't see there's a good reason for the reordering. I'm not
> objecting to it, but it's curious.

I'm pretty sure this is one of those things that came about while I
was upset with the state of this code and was going through it with a
hatchet; a lot of code was ripped out and put back, so it's likely
just an artifact of that.  I'll flip it back around.

--=20
paul-moore.com
