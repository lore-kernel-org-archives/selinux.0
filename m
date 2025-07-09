Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47362D46C2
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074384; cv=none; b=O2RkmTHnzqppHmJl1q9mhFdimBhFB9HkGR476jeYbgRAvonRsS2sHXoHEH7ClzHCX8sk20TVXpiYLsYr2YdAPMW2Pk+tHW2N+He/aEwjDuT3ly07mu2jfIv0zr/z201hcy4xe5EcABIikMUhg6bNhXzLd9XhmJ5c3WpcX3eFjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074384; c=relaxed/simple;
	bh=jX5tGhwQ7UlQseFYx0r6Xq1z1pSzCZuykZeE/E6aZLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em1m2pJC+wx2QYplSccbnEQzMTYL5hNwTr6GQO9zdNfO7fXpENQgS7r20VM3PFfavHjiLoJVlCCELTFRtcZlp7T/BlmyRZPw1NcNX/mzCZJhRvHX246y3YBuasHFo49CHBPOa9vQaG64qhn5KCwi1YJ8GPzKhwNjH0cIYR8AgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PReXMYE9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PReXMYE9"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e897c8ca777so5536873276.2
        for <selinux@vger.kernel.org>; Wed, 09 Jul 2025 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752074382; x=1752679182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzEGonVmXproAomin5eIhv7ocY+0CXz52Ye0JGlwwtY=;
        b=PReXMYE9vxDaCblE0ryYjn329fImJCE4IW1XDWhk+ctbfYYeukIAD+qQDBPrQyV8fb
         mgGell5vdkvPLhx2roO83HBztkglI5Y1rOjxeEuwjX2HRHQi6L4GvfJD/95sba+VPg/U
         hMdnUlrGjNu7ov7hP+Gjrz7LZTDdThNIPEmhLPd/8vX0wwUrRvnfQxkmftAu1ZoduwuV
         5rM0qigpQhZzgH3EnBR0gKuV/NlKVfvxiodqgXjIVZLU5lJGm+9uxtdMXebLAL689M7Y
         ng1xu910hSOHK2S4c3L10Vb/X8Y2fxb4vis3B7Fve/ZY3mi+cpdx8vTovJA/ZypvxBmF
         7diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074382; x=1752679182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzEGonVmXproAomin5eIhv7ocY+0CXz52Ye0JGlwwtY=;
        b=DV/SqXWCtndgAHPdXmnTlqTyruUjahmYnGdvVk7jboyiSUfiynzjYEP2EAtxyc7toX
         4w96Go6vLn+Q0EdegDLIIMMDYr87r7Xm3m8vFbgzuai9ODJidczseENdHDbeDBLZNlAm
         3GibZt4e78qFz+cvyROaBI5yT6D60WLMU51hpDWHs4KPRQ1bboRfN8G52gyi588CJC67
         MaD/RdZnvnbDN138EMSWpzQwoceFRFQF+WhDECNIulxoOtIitmnh7Makmtdg6BB38TCv
         aEdLXoD5WsUE8XDnu5T/pzbQzitvvVDX8+v1HMDHhmiRmmb/ihmcBS2XuqekB6iIXwcc
         linQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjQ0dnw4BRkyq+CpNFlnY04wYwcSbJzqJi/YxbhQ+idm+Kgn+tTlQ5zUVqV265T73uiyB8uRCS@vger.kernel.org
X-Gm-Message-State: AOJu0YxMoZ6FNX3RulYv1o8TuGnMWEky5i3epJLBxXBK6y22Gc6ZA17s
	blo4Lp9cjweCb6V0YgHLoZJkqA9fWm1pAV44lJU/6WJOTVfFDtn1edSs+GUhksZNR94xEQROjbx
	lPAvavBddBLRH6XadwwljvuOK1LggKA+hCFoW/AXC
X-Gm-Gg: ASbGnctQb1EaeYWXCDxSA3ZEZume5AOiYIAYgweDx/uelFgE0eIjiaW8BusqHq45HRL
	ORKN8oQ01ryVH32aH2tJ2dH6B78G0Dj+4v6Bb/xJTc41NSU53GSM21TS+Ou5/Lm9ddHsTdKerLY
	BNhD7KY0bzqJ/7bz5EBirjxe/OlEKivk4hdNt8UVNcmjc=
X-Google-Smtp-Source: AGHT+IFjdm/SLcamSWISUQ66DrdwMnktjlqu7nOrNWg4Q3frFotVmkLuYoFvM0O8pXxaPwSx2wsTZlYITGZbRbzkEHs=
X-Received: by 2002:a05:690c:62c5:b0:70e:7706:8250 with SMTP id
 00721157ae682-717b17ace8cmr45883167b3.16.1752074381801; Wed, 09 Jul 2025
 08:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230504.3994335-1-song@kernel.org> <20250709102410.GU1880847@ZenIV>
In-Reply-To: <20250709102410.GU1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Jul 2025 11:19:30 -0400
X-Gm-Features: Ac12FXxwFg_uAGld7AFSlsXAxl6RXBEAoPyYFqRJUVoeSEfIzHaujAQ4qrD1sLk
Message-ID: <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling security_sb_mount
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org, 
	tomoyo-users_en@lists.sourceforge.net, tomoyo-users_ja@lists.sourceforge.net, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com, m@maowtm.org, john.johansen@canonical.com, 
	john@apparmor.net, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	enlightened@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:24=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Tue, Jul 08, 2025 at 04:05:04PM -0700, Song Liu wrote:
> > security_sb_mount handles multiple types of mounts: new mount, bind
> > mount, etc. When parameter dev_name is a path, it need to be parsed
> > with kern_path.

...

> security_sb_mount() is and had always been a mind-boggling trash of an AP=
I.
>
> It makes no sense in terms of operations being requested.  And any questi=
ons
> regarding its semantics had been consistently met with blanket "piss off,
> LSM gets to do whatever it wants to do, you are not to question the sanit=
y
> and you are not to request any kind of rules - give us the fucking syscal=
l
> arguments and let us at it".

I'm not going to comment on past remarks made by other devs, but I do
want to make it clear that I am interested in making sure we have LSM
hooks which satisfy both the needs of the existing in-tree LSMs while
also presenting a sane API to the kernel subsystems in which they are
placed.  I'm happy to revisit any of our existing LSM hooks to
restructure them to better fit these goals; simply send some patches
and let's discuss them.

> Come up with a saner API.  We are done accomodating that idiocy.  The onl=
y
> changes you get to make in fs/namespace.c are "here's our better-defined
> hooks, please call <this hook> when you do <that>".

I don't have the cycles to revisit the security_sb_mount() hook
myself, but perhaps Song Liu does with some suggestions/guidance from
you or Christian on what an improved LSM hook would look like from a
VFS perspective.

--=20
paul-moore.com
