Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215E1487E3
	for <selinux@vger.kernel.org>; Fri,  1 Nov 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479364; cv=none; b=fDjKeyVVWZMJLTWMxd346C1evQ5J3C1fHSQHsZi0rHfi6oSokDMSw2VjrPsqXi7R8stXfmHEU7zqk+x8EX2gDSm6YpVtNdSimLWz4ycSeOsPIBBrCBDyh7xT9w9tE25o0nf/9IGpw9lSvusl8urAdxECoKeXU0o5d5jxEmfWajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479364; c=relaxed/simple;
	bh=bdl1QU1TO9smfZlcjavKeh83DDahAr/viN7jpcXBk5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwNsiJ6N52WEXRhv7aoiGODpW5D5LoMR76+fVzDpUpDbN6ylTRT+eX6aZmm/hBZs4cySRyZ8LhB+WcZ/m8x4kC8Xg8kyblQ+LyMD/UEb0GH05wEPXu3NxD6iYrvttHappUZcvbdv90332vknnQhw9zNKiStD/z9n8gkyC9yMb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VYfqtx9n; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VYfqtx9n"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2918664a3fso1868837276.0
        for <selinux@vger.kernel.org>; Fri, 01 Nov 2024 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730479361; x=1731084161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdl1QU1TO9smfZlcjavKeh83DDahAr/viN7jpcXBk5k=;
        b=VYfqtx9nPvwxjeNA2O+gya3m+TvMduWac+RbsuNMk22voUhZb7wMdf+xsxnfDZS3MP
         G7/QScRRGjcvFjhIsLiGKDytElrhns/2RnUJneUMzAoDe3b4uMxtxMmLs6Qa+AyQwbwn
         hFOXIZx+O4TdNyW/i9RCP/WLEYgf+qHjk2rglGBLuIVhyphy6ete2y6qou6+ZOzuKA4h
         GEBnu/qEarDy0rH8yeQQKtMBsqIm9hYHp0aLADN19qwJExWGNteC8HfumB8VYbqOasia
         YQ5TKINwYYkvzjqFEYeLqqN7NhY46d9dUPbGvSqB7zCYIrT94UynPJwoxEz3hryqbJfB
         RGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730479361; x=1731084161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdl1QU1TO9smfZlcjavKeh83DDahAr/viN7jpcXBk5k=;
        b=ikHUWjshiDPpqIGmpfcO82GykFR9/kYwAOqOVsbaqCypHHjpwiwdi8RQdlzEkbz+H+
         sstzR5qBrV1AHOynl7XFYQMVAETy7EUydN4Yzo/uPkvlizA1CQPcoObxUehmVcv7XB/+
         74W3ZAjkfq2HpQEHtLyAQLSZDji9bjcnYUs+Drhog38mmRjw9RrV0QF7QptpYMo0TaMA
         JMebMVepQsWN3wovbwIoQBS8F2a/btTuj5E/otAoH/9ZAippddNeM5QWMaICPQP/ZlLO
         8CDxdSAWjptLPwLa+JAjaR57rs5Tg7TCSuAPqjwVJIy/MQ9zEvg6ZRHeS0BkPZXQgYst
         zzrw==
X-Forwarded-Encrypted: i=1; AJvYcCW2cjFy3gLHIhdfbyEkA1VPXdAFHaOQ4iXRUHkmXRkl4mffdEUVzP2tRr3fTXKJkbKZ2SC6gBUM@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3sw1E02bvV5EsdZwGEVXf5wECnarg2mpdzcjuhUooXb2HZU3
	NN0UHaXZpzDMR73qy1PoNDfjxgmAUtyKoXQoQeKRcysPheyDbuvObdaRok0TRQn2fQXZ2XeEOw2
	qMmiQJneYTHCnXNz+ktTB/4ac8kbfzr4bRyag
X-Google-Smtp-Source: AGHT+IG9mMz1RBUHXYHb/KKXWnOdSpX/tW+Owz4me+P1+nRvR/UjY6v7IpSbecbnAja/zhUSQpxNQyrM8+BVM9tybAM=
X-Received: by 2002:a05:6902:641:b0:e30:c97d:2fd9 with SMTP id
 3f1490d57ef6-e3301836be1mr3682602276.24.1730479361585; Fri, 01 Nov 2024
 09:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-3-casey@schaufler-ca.com>
 <68a956fa44249434dedf7d13cd949b35@paul-moore.com> <ZyQPfFvPD72rx4ME@calendula>
 <ZyQRgL_jWdvKgRl-@calendula> <dd727620-9823-4701-aaf1-080b03fb6ccd@schaufler-ca.com>
 <ZySCeoe3kVqKTyUh@calendula> <6a405591-40c5-4db6-bed5-8133a80b55f7@schaufler-ca.com>
 <CAHC9VhRZg5ODurJrXWbZ+DaAdEGVJYn9MhNi+bV0f4Di12P5xA@mail.gmail.com>
In-Reply-To: <CAHC9VhRZg5ODurJrXWbZ+DaAdEGVJYn9MhNi+bV0f4Di12P5xA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 12:42:30 -0400
Message-ID: <CAHC9VhQ+ig=GY1CeVGj1OrsyZtMAMBwst03b-oZ+eC2mLnqjNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, 
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 1, 2024 at 12:14=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 11/1/2024 12:25 AM, Pablo Neira Ayuso wrote:
> > > On Thu, Oct 31, 2024 at 04:58:13PM -0700, Casey Schaufler wrote:
> > >> On 10/31/2024 4:23 PM, Pablo Neira Ayuso wrote:
> > >>> On Fri, Nov 01, 2024 at 12:15:16AM +0100, Pablo Neira Ayuso wrote:
> > >>>> Hi Paul,
> > >>>>
> > >>>> This patch breaks nf_conntrack_netlink, Casey mentioned that he wi=
ll
> > >>>> post another series.
> > >> I have a fix, it is pretty simple. How about I send a 6/5 patch for =
it?
> > > No idea. I don't know what is the status of this series. I would
> > > suggest to repost a new series.
> >
> > I will post v4 shortly. Thanks for the feedback.
>
> Please just post a fix against v2 using lsm/dev as a base.

That should have been "against *v3* using lsm/dev as a base".

Also, since I didn't explicitly mention it, if I don't see a fix by
dinner time tonight (US East Coast), I'll revert this patchset, but
I'd like to avoid that if possible.

Sorry for the screw-up on my end folks, I was trying to get things
done before Halloween kicked off and it looks like I was a bit too
hasty in my review/merging.

--=20
paul-moore.com
