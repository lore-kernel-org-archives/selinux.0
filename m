Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360B12BF0A
	for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632297; cv=none; b=f+V7eMVZH4CR7pAEmkqNUPF3yifShNm1kedpP6MQh5km2QlQylpg3Z1pFNlJbQpJL+k9hJs8Hjt6sn6rVSlZDR9NgXkAv8wV8Q1byFuCGqU34R8w2Xi1pEp77/IU26NZzbEd2KbrUUZziZVZ5/0uI/1U5HUIYGPcIa8b9pWAfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632297; c=relaxed/simple;
	bh=U+vTvlpPOwmcb8yUMXMasEMGjaeo9Qvrr3LqVSpNKoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti4XpTDv6o8g8/PilNwBw3sQmrmSXxLslRYdTXZOOJG07aYpmrhP+Asbsf3YEItbo1XCUwuJP2vflib2uF2Zf3CNf6V3OhzRi17DMGGr8WnQyCiVlfgLq0jOGZ7dobaOC5o5yIbK9eHtstQ0cC4ne0quMn+m0zQADh59MuAD0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VJEIMLQB; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VJEIMLQB"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4021141276.1
        for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706632294; x=1707237094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4Lc9dljOgIafn1VdrpT93N9oxheEeV9tkkPI5gMmwc=;
        b=VJEIMLQBPHS2dmGN7IiKmFREeGoY1/i33zB7DDLjgWRVsRjLZZPeiwADXAFCku8RYO
         6RXp5S2liupX7/tBYC5Vxag16arDpBxgBZRCWObMeWEWddsDEJkYA4STyqgJo68DIP7s
         EAxGheOWW2mrEBjCd2PIXWDwnqGQDElLVEgURP8/+uW6NCvOp4fALHOdejPzfbEs3mW6
         6jN/2nD2U8SbZ9V4wdjM+zzAPwC6MW21qFekjf9w86SYxu4cgdbO0/lgcLSzVnmYu8q3
         Hgasx7RF3SxOgXjDSwDYd26ieSg2Rj69N5lggafW6m4FNTQyulngsmtlI5n6HOt3gTJ3
         RKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632294; x=1707237094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4Lc9dljOgIafn1VdrpT93N9oxheEeV9tkkPI5gMmwc=;
        b=tkIKqoU1Krr/I0SuPHXV2guiFX7oN5FVIRTZZGVQG+3xb5/yU6oiw5DN6ijdwVYLQ+
         Aa7ug2fwP5CyyZyzar9IlQp9GGowIrGiPBZMWGQv0k3Ru+ukhO+PGIuk1UQNGMdl1i9H
         aSyRcikHQ8UqBxTeNXWM9UDVKz0ARczjY4pnyjuNJoKq98Hzd7Ka8t+nK8EuYcngGc39
         UdHf2FWBdoMLpg2rftVx89c1AvmIh4yXyxJrvcmhbcXu0UDUuFslixwwzHUKCNEftbOu
         rdNEHuYQ4/5ytQCbAnPRIcyP9DDPhDsMHcda6zJ2LkzQ1nvlJhShef8FBMvanFBu44XR
         wUWg==
X-Gm-Message-State: AOJu0YwrpM4NRLFwB8x0K2Tfo8mqFAZqXLxqpkARnGIRw4u2ABFtxbwT
	jLyQCSXSRWAlwvo7i35lI2on89dCXEfyfZXnngAe/BTsq95qizjnzPmjAzHMr6wWxD7+EMCNq5b
	GjatB1qQmEb7ueyRQYFoeh18VZphJsxgOo0QvH/7KD0SU3ng=
X-Google-Smtp-Source: AGHT+IEbF99ycGQ1UzMdKRBfSy6XcIvLl71vSotFaoB69GX6QRpTZ6ZSCDn24A+7SlE2aDLsVZuMaxn2IMm/TYfxNFs=
X-Received: by 2002:a25:e303:0:b0:dc6:cf1:deea with SMTP id
 z3-20020a25e303000000b00dc60cf1deeamr1054722ybd.3.1706632294513; Tue, 30 Jan
 2024 08:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
 <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com>
 <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com>
 <CAHC9VhSG14u5UUYiU6kUDt8jGMPkHAs67F_kc5Xt+w_P_zEovw@mail.gmail.com> <CAEjxPJ4bUoJNhjGAdrPAuHQr3DvK-hLRwt8xUS1tuZgqx3sJVw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4bUoJNhjGAdrPAuHQr3DvK-hLRwt8xUS1tuZgqx3sJVw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2024 11:31:23 -0500
Message-ID: <CAHC9VhQ5rbeejGQa5G_Qw0X5oM89Z60kRaSFOuqOhquidZ6GFg@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Jan 29, 2024 at 4:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Jan 29, 2024 at 2:49=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > unix_socket test is failing because type_transition rule is not being
> > > applied to newly created server socket, leading to a denial when the
> > > client tries to connect. I believe that once worked; will see if I ca=
n
> > > find the last working kernel.
> >
> > If we had a socket type transition on new connections I think it would
> > have been a *long* time ago.  I don't recall us supporting that, but
> > it's possible I've simply forgotten.
> >
> > That isn't to say I wouldn't support something like that, it could be
> > interesting, but we would want to make sure it applies to all
> > connection based sockets and not just AF_UNIX.  Although for the vast
> > majority of users it would probably only be useful for AF_UNIX as you
> > would need a valid peer label to do a meaningful transition.
>
> Sorry, I probably wasn't clear. I mean that the Unix socket files are
> NOT being labeled in accordance with the type_transition rules in
> policy. Which does work on local file systems and used to work on NFS,
> so this is a regression at some point (but not new to Ondrej's patch).

Ah, gotcha.

I guess I'm not too surprised, the sock/socket/inode labeling and
duplication has always been very awkward and it wouldn't surprise me
if we inadvertently broke something over the years.  Tracking down the
source of the breakage is good, but if that is taking too long (I can
only imagine how long that might take), I would be happy with a fix
with a number of comment additions warning future devs against
changing the relevant code.

--=20
paul-moore.com
