Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225A13AD27
	for <selinux@vger.kernel.org>; Wed,  3 Jul 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047671; cv=none; b=iJPbGR84RzcZCVVrH0frsgEtwXj1OIp7Eq8ksFkuDmm5jqyPPMNrN9jCCFQfW9N7W1RgVWiVOigIvN9TMjBDpdfpRgIH9giL7fm9WB0k9cOEbQXAQaqdax0xkC/zN+tKbQWBv6LlwQe5pAYOm6mbeaFZgnmUaycHYzxu/Wicq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047671; c=relaxed/simple;
	bh=bUTbTvzj82LJV3RkK+LQb2gR0EFbWiO3r4bl0COLezw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Quh7nEbNjX3He079AAZFrvWP7xcj/BWZYeLqxZb3eJjvv1E7SD2wAMVjYb2rGE5PbY36lfRRCsmCqZHmoc+CO7fS17jXvyMVgxuRKigSO7kdkLr7qhPaxlDzFYqwphGp6GEGjxFOX001kQXDqeMO4HZJoJtIATsQZXtSCjv9jtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SFwr8sac; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SFwr8sac"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df481bf6680so25586276.3
        for <selinux@vger.kernel.org>; Wed, 03 Jul 2024 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720047668; x=1720652468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6juE3uWpR8vi0HecVzx6BeVrOtW6clnNJqbZGyj11g=;
        b=SFwr8sac2DGIwD8MAYPXnX/ihb19SoiznR6UYrPlyn6aAZyteWIqknjhI3k7L6xGn9
         HxmK8K4PDcfm2XZmAVmY1MZ//9JW9nh9Ri05jw3/7KqtZojNcJgDpBfsOCtC+fmWtF2S
         FbvYLS3tOeWP9Uk7ZrE5enPbhoOXl8ht2XHM5IXw1fZFZUCU1nC9YAJYvbmUNQkJmvPv
         KrQjFgLnfgSgyFH4I1HIW+9UVUuZiMq1S2yFCMaMXLqZAR4MgWfPf/vQL+Z0amQe5VEO
         mta+GsgZKj7gDEfXh7utMTM6oHxcUsmq4yoMVc3mi4lEyhwGNN9h812f+gt/YKleZMFo
         XZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047668; x=1720652468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6juE3uWpR8vi0HecVzx6BeVrOtW6clnNJqbZGyj11g=;
        b=LpITV79h9ThgcYIRiiI8K3BQbUS11wwOXJDgJpEGlSeVZdk5TfBCP9fVA2u4McE3uJ
         tQxwQOCPLLw/EcwBMfLI309UsEa1mK/ikWzLP9JNI3wIiXj/Egyf+SlU9bc0j+FcJgY4
         z/u6MRd7tzNi80R/KW/Bxnr/uMuR95bRp7wBf6AvxuI2tHPZUwseSzSrJvou29nDWudq
         vCPFhqONbFWkZJItAnZ8+NL3BjkkbyQj/JGST9DThSbEpiTRUlLcRIoNUyfStV53UP1G
         24F957H+u4T91966OoX26jo+03iv/LGMuwgMdSM1Nx+0tGOeIGKfD6gczTfYIPL9Z+2I
         hcZw==
X-Forwarded-Encrypted: i=1; AJvYcCVyeyUlYgWnKvgKvQGBAcUGrGB6AdSro3+IeTIf1MDfxE0bZCaXocuf1HdnKqazbb/wMZPIXTBA2487v/JJeA7XPBwz8CT97Q==
X-Gm-Message-State: AOJu0Yx/h/czaueQ5b8rrOyxrqj+jtmXjCY+NMEchAqzA/DFODK7ucdj
	WzjdZ3DwSZKaoUrHC3+hcKulq8xvYIkiVxA60LgKn6zM0NTp98anWWGvkhWYGDYXn6uIynqMnBm
	NNRkHS8oNK8BZS0AMIZNqb8T70vTmdn1W87qv
X-Google-Smtp-Source: AGHT+IHlw5TKJf6IMqAed1Vi2Ai3i8Ur7WHChBmTXeHOEhRKNmzxeBjFEpH88VIG0Rp7pZvbfI94DImgAdCx+5A6J+U=
X-Received: by 2002:a5b:f0a:0:b0:de5:5693:4e96 with SMTP id
 3f1490d57ef6-e036eb67f53mr13564734276.27.1720047668247; Wed, 03 Jul 2024
 16:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703211134.349950-2-paul@paul-moore.com> <CAHC9VhTA5tUUH7DAYx9k6X2L4eTzJ1a-ETaJ5+sMZrxKqjKOKA@mail.gmail.com>
 <30fe42db-461c-4716-8874-ff78baf4b14b@schaufler-ca.com>
In-Reply-To: <30fe42db-461c-4716-8874-ff78baf4b14b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 19:00:57 -0400
Message-ID: <CAHC9VhR0Dt9_HO_Ym3oJa9FqBoP3Av73Rwtj_Y-U8YhhkR5pVw@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:55=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/3/2024 2:14 PM, Paul Moore wrote:
> > On Wed, Jul 3, 2024 at 5:11=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >> Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> >> moved the responsibility of doing the inode xattr capability checking
> >> out of the individual LSMs and into the LSM framework itself.
> >> Unfortunately, while the original commit added the capability checks
> >> to both the setxattr and removexattr code in the LSM framework, it
> >> only removed the setxattr capability checks from the individual LSMs,
> >> leaving duplicated removexattr capability checks in both the SELinux
> >> and Smack code.
> >>
> >> This patch removes the duplicated code from SELinux and Smack.
> >>
> >> Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/selinux/hooks.c   | 10 ++--------
> >>  security/smack/smack_lsm.c |  3 +--
> >>  2 files changed, 3 insertions(+), 10 deletions(-)
> > FYI, this is still untested as my test kernel is compiling now, but I
> > wanted to get this out onto the list before the holiday in the US for
> > folks (/me looks at Casey for the Smack bits)
>
> Let me know how your test goes, and then I'll have a closer look.

It looks good - my SELinux test system booted up, appears to be
running normally, and all of the selinux-testsuite tests pass.

--=20
paul-moore.com
