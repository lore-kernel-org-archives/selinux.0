Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361527FD74
	for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211176; cv=none; b=RVaTBj7TlHZZGoh87FHqKwUl13Yp7cZXhIgWehJSZCXQuCprWX2YAxN8mDDPsBp6u9i5BrI9rdoSY6XvxZxYPuApTbmNBc2Dx8pfnn0/Rvw6eBw2ufFDdwlenmyTUXnCRnd9UktqkiU8VmdCIXUrTjOJ+ZgJOj9JaTe3v3HzV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211176; c=relaxed/simple;
	bh=3Zgk9PB7g3jS9AkE+8UVaqFMWSWQDlNUjVrFHAo7ilA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llDk9BJvfLCZcybPncGi43k89KFzpGsEGLHx3cLxwCel0HCpRw+DD8SLY+qRxi2xWNrSIpRju7yTBB1ZH6H5sjl8KeOoVRlX7hwz5b1yMomu7rqTyNVarHwTUIsLInc7AOaD/kjiRlFjw8cQab1nu/2tel5usuT4OR7EOfSaulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsPrXGgw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsPrXGgw"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso4852491a91.2
        for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753211174; x=1753815974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/jm0W2/towWQl6Jj3aKY1MEsBmMYdlqGfR8T4eK4NM=;
        b=SsPrXGgw1S2SVHpnsAbljDNyN++j5IYoBKylqonvb5AuNkaKH0GmC0Zty9ijj2y0at
         7ua+ZGo0lywKWUyU0K3vW8T5E2j8bqp49Z3dPMB82qtvjy63ofQ6Bc2gJQKDot5S+m3M
         C7N9R/qRl94hstsgxSKlCSUpvpDIozslTJD2SPogJ4fKEmBLxj3ag0TET9DnMQX2XnZN
         2uAkNd9z4xc+2fxYJ0iZtKatl0H2rm9lxo2DZOPbiYOIu+YSTy3wuW907z/7PYtv83w2
         y0LNsmlS6+EbjuccKYeAJXQiEBkHYHnpFFb2rHF3nqT3cwSV5DotvjSTRItfBBCZtLkv
         gaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211174; x=1753815974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/jm0W2/towWQl6Jj3aKY1MEsBmMYdlqGfR8T4eK4NM=;
        b=uHZbwKvQrbrs82o1EJucPvFLpLZ5ScgRVYYdbn1F0kjfEp2PpA3uPn4RhP37itS8Yi
         J4YTmjIub3aaMdh2pjF/JxyzhS68uBke4SAQO25LevxLlAeo1XceH+f8942bNAf5OWOK
         jJMgANpkHjpmMZOYf+R/Lz/0zKjDiAzQtVPLp3uZuIOFxy2QSEamOfkNVOlzia6t8kvi
         kRqs2mkMniPk6l3DH8CBR7KORzv1cVVLEgzW5ihqnRih11mizX8hRyNjbOh42l/V9NCn
         OSpU/okLFgSxOj9Vcs5lcL7/e5XJYHtsvElzXi0q5eqtKMOtEQ3bOC70gPZsN4kG0LKQ
         IAJQ==
X-Gm-Message-State: AOJu0Yy/ZSBnbAmZJfw8zAUuh8tiRzYfR6aa43gjSJYeBbWbloBsYdRK
	B25K8ClFEnh5OVAvwoM08JKYnG0BssuUZfQUNqL3GWPJikIKM8GRNkyEAdvr4wDSi6dV5tUyhah
	Bd3oHabOFxB/OyMWsjTy2KvHo/aAljZI3rw==
X-Gm-Gg: ASbGnctCwrCYaAJ21dgkWJ4fnhRvFmoyRwQooGhtT4McwOFdlGMPWSDDE+d0D3VTddx
	GXktydr0hPPfdR5BjqnV3XgNyQQY9PoW7ViDCM8VZ33/4Wj56w/NYKCXsqZwda9I9uX5u21U4x8
	qCqWbHE1cHwtZUvNzbr/fYrotXX599DpB1uS6rXvrPSryGB3pR5ZNfhupfA9zR37783oBSkfVn8
	GA4uMI=
X-Google-Smtp-Source: AGHT+IFVICnCnrPf0D84WGuJz5MhSrwOXYZqDnF2ayOrObcTExO9hltqTgn5IXegSPMbPJtBU995zyTBOGcetQTiEhI=
X-Received: by 2002:a17:90b:4b83:b0:315:fefe:bebf with SMTP id
 98e67ed59e1d1-31e506ef890mr571021a91.13.1753211174348; Tue, 22 Jul 2025
 12:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jz42dj60.fsf@defensec.nl>
In-Reply-To: <87jz42dj60.fsf@defensec.nl>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Jul 2025 15:06:02 -0400
X-Gm-Features: Ac12FXyDXFdZJtAshboyQiNS36NhoA-r36gVDakF7rfHJnSrlfRgbKW9QlXu2vY
Message-ID: <CAEjxPJ7dcbX+gUQ5UGnM5+zCA2qKZMdxJ0QqBFnbPe12WyKMuw@mail.gmail.com>
Subject: Re: systemd.exec(5) PAMName= with libselinux
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:53=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> systemd has an identity directive called PAMName=3D which allows you to
> run a unit with a specified PAM stack. The issue here is that in this
> case the "session leader" is always systemd.
>
> Thus you get into issues with pam_selinux because since systemd is for
> example always associated with "init_t" you can't really specify log
> SELinux identity foo_u in with foo_r:foo_t:s0 if this PAM stack is used
> and log SELinux identity foo_u in with bar_r:bar_t:s0 if that PAM stack
> is used.
>
> This previously was not a big issue since this feature is pretty niche
> but with the advent of `run0` it became an issue since that relies on
> PAMName=3D
>
> The problem is that pam_selinux is often already used to start the
> systemd --user instance, for example:
>
> /etc/selinux/TYPE/contexts/users/foo_u (/etc/pam.d/systemd-user):
> system_r:init_t:s0 foo_r:foo_systemd_user_instance_t:s0
>
> So you can't add the following because it would conflict
>
> /etc/selinux/TYPE/contexts/user/foo_u (/etc/pam.d/run0):
> system_r:init_t:s0 foo_r:foo_shell_t:s0
>
> Ideas? Suggestions?

I probably don't understand your question, but systemd --user
instances on my Fedora system are running in the user's context, not
in init_t. If you have two processes with the same context logging in
as the same user, then there isn't any way to distinguish and it is
unclear on what basis you would distinguish.

>
> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
>
