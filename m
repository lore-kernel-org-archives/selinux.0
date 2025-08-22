Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4B1B4156
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827978; cv=none; b=EVB+rjwf/32y+sfaoVqRWsJ0BHXuAmDQ1wBOP0af4r53hSP4p0E1kMejxfrgQqjuTyuGnreAn7voxd7MJnPAAuMO6Ojmo/ssbNVqp+XMrB+PSpCQRJoQYLYRXVTfVJc6gsWXb5uE32WYcwR8UdKwL7ZT8TI3SKk8g8WCepFD/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827978; c=relaxed/simple;
	bh=TsNvDlSM3gTmQZlPmCWdbzWUbbUcf6kgb6BjCZfXKWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRu757NsYBR9XudYcN70j+QeeldaGEI8Y0xV7BZeNRp6YkucC4jHrKsFqxZaIb59mTI19nLFn+Lecl18dbIQuwJDZbwylkptGt70awEY/ZZ0Yt15C2Io1U+cEEAfUlNfqA4C3xu7/Zuqi6FWNp4xjdtffjNfYJF7IglcSn+0q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MERo+fdJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MERo+fdJ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e434a0118so2143238b3a.0
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755827977; x=1756432777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsNvDlSM3gTmQZlPmCWdbzWUbbUcf6kgb6BjCZfXKWU=;
        b=MERo+fdJcSrwdNWzlgZXn2nqkb/atm+apeRvsEPfNXHeWjYCGlYLuZGh3Jy+Hg3NRY
         7yC/9bZBiYGn0+0kiU/UYBYnxJR30TwOSZz6x4jy9cQTKVxn8NY1RM93vTA0abMlmLRG
         9/LcYKJAvDIBN7ii5507YK8yRPLhCid+u1/jWcBgqR6kXi2MpimY1GODT36m3oewPpFX
         Dyyj8kZ1bMlL07n1Z3T8ju6nk1U8MGv9kjHe/52IgIPlrakewaIx3d+QwetXxGCCbTfv
         Qxg1dw5Bo+ctyW1q+cwhPggxUd9ZzZkXSQzDAPEfcRAft7+i054+dJ7gfS/1Fl+21Ld1
         aB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827977; x=1756432777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsNvDlSM3gTmQZlPmCWdbzWUbbUcf6kgb6BjCZfXKWU=;
        b=DjpfsQjnTvCLyAwFOlzyXZrFjHbKUH2qWUw/UX5NYu73U3U8h8iIGhfWe0adypFRzF
         CkIdI/GwV87W0HbYG6W+v42JubXHscFl7orZ1LcGtCEx93D4YqT0d3LifGDHlIxG19kr
         skdTgzv0jjj6u/RppvepKbhxekeMQ5h8IOnXpmGzm3vi3utmYmCgKM98+czSFGzV0cL6
         a4L5A8Hq5zM3wXv33lyNXC4jPelG3ciTha9dIMQV+wvpF7owt4prb0h8pnHvAzKKandA
         d9gVjPf7Cpq4KQqEACNK7CHlpQ5eLosMUGthMGO+YDDx99OMv7/1LvtzVZSaU8JVlcmn
         Rzfw==
X-Forwarded-Encrypted: i=1; AJvYcCVYC2p9aqq8oyi8fDA5aqbKyLXZNzcZ0y88Ub0Q2vqQ5J5bQyP/ou6e2kxEWW/v0o+8+dI8M8X6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6h0ikFoRqISp2M1yEYteATY33r8GSagWob6gOdJ8ElNACZVQl
	fE2LsSc1ukUTPwZQnVk4WnbjfpL2GuswvsJdWOKS7wBwJYy/R98u6e8Ohtbue/INT/iTKRX7aw/
	rkGCjOIWcDWokc1zsMnkeRMBaoUmIPlV1Axk6bMAQQhiSPAOyuWo=
X-Gm-Gg: ASbGncu6vH9AEGH3gW0Ft0CgODnP1B1Ch7ZuiFPW46cC5oO+cX5r2bBKMcsYbfKlknq
	YSmiQZzVQXP5d1Uqpg5hVz3TFAxSgBcpONdgUNG3s21/V7hoYgLgQ1N+Ca9yH/fQFcmF3Z+nGwE
	ymmYjORReno0nyw/SNeS7gqiQjIA88OCHh5/emJcu6PxqviGNg+0qTuU4faGKbRRJWw9S2tU1yP
	55Yc2M=
X-Google-Smtp-Source: AGHT+IHGNO4iEBDmIi3DVZcy3lafa7NWsHIA6a9tO/5Ie7EVox8OrGnAGwKfGuYi3Oa7zqhlrzLYPlyi8GEij6RXFk8=
X-Received: by 2002:a05:6a20:549d:b0:240:1090:76f2 with SMTP id
 adf61e73a8af0-24340ccf1d4mr1803058637.23.1755827976647; Thu, 21 Aug 2025
 18:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com> <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
In-Reply-To: <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 21:59:24 -0400
X-Gm-Features: Ac12FXwauI7eA7Trf3V22GYm2aQdDEQlqqrtcS1pjjrc1NspBpwZU8gWgWLTUaQ
Message-ID: <CAHC9VhQ1hR4Yowf0a2X9jvY=CobcXVa=4uCwa+qwvktBGReUUw@mail.gmail.com>
Subject: Re: LSM namespacing API
To: John Johansen <john.johansen@canonical.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:46=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/19/25 10:47, Stephen Smalley wrote:

...

> > This is handled for other Linux namespaces by opening a pseudo file
> > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > do it.
>
> That is a possible interface, not one that I like, so I would like to
> explore other options first.

Fair enough, suggestions are definitely welcome :)

--=20
paul-moore.com
