Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF692F7F14
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860060; cv=pass; b=kJLQL52V6hYYZVpRSyVAypAl4Z9EYvMnZzsIOqUOUnibEWHQrIuxI/lpRBPKrVULhrJVp7XhbPd12ZrvmiItKNjdcL9UprkKPP5U81NbuqAcp6jC6NgnPnvI4IbRtGXQXEBfiCnbJ3fxK+pnvpw5YWnB3AS257QuUFsDoo+ioxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860060; c=relaxed/simple;
	bh=zn5iDPQraJg48MCYxViRlQ00d+oZEsZt6FNFyt/cMLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQDG2s4mqmSBKACWLLjH6xCARfG3TkPRZLLTp5w/f1A1aky6R77L6xL5zWoy6DLyglLnd++aAEPFT3Qhz0l4fE8lGm13hww5PNmX0T4WxKfJsQV++oDHVPCoez2BFSDW81NG6EgmhWxhqWSJqreLAIMQGNt8+iPm2mmL//mJuC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A1fpl/jp; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A1fpl/jp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso10548685ad.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 19:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784860058; cv=none;
        d=google.com; s=arc-20260327;
        b=POArnQ122CjOYF4bpywrowqm5yla5WvVWVj+Yv5oTiV4aLxl8T6J9y525LdtXufRsw
         wl8ILY6JM0kyPNX4fXkuqq6xQhkPTroD3WbERDNmvX55KdylWryEhS+bqf8Rn+SHDZVL
         V3NkYpwk2sYxsmCwGGNiR4SwRMVbG2IvYbLTReE75cmMECWQEsji/JfntGd8JLp92q1W
         yTKRmbPaEQJJ9ADd0S82XiAJyA0sLfzILyfa7PfmgXPvIN1crsPnfjZ0LnnmuEJESyII
         K/yDEq1zYpK7lVLqym6M1bE0TxEjvFuo2zOfev71BBznLAy8/4zUWglUBlpCIsfCKtnd
         X9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZ1OuHwDErw5fJ9qlVr/HATykXaamDSQTaPimUZT5Nw=;
        fh=m+oD9HSv74wqeSepfvDvQfZQDJQ0UdOQab3ljqyh1Eo=;
        b=FOy0vysQ6bBTecrdEm1H0DGIvWo1EP7QGrPnEd9ONpJ7KKn8/d38cDA12KlBoJaxT1
         nvZgZ6Wa4BBA2C1oTpiGsRRuT5rZf5+9lhFD92fF7gHhiPgmmCpLE/P7v9MqiqHy5dVG
         f0x4LjL+4+Jq8I8xCkMM7lVa/Othf981T3PoZ2NccjakN/d5hH8wc7NmQOI4ZD3Nmvm1
         ybyYzKguz/S0pwXnWOK2ovCU/gmrjjN7K+D8OoK9XDsf0i5oC4O4v3/oGN45UgupdVlS
         eYrzhd5OeWAhpYBuYPm3UMuiS+DbcigjfecBZV3djX+FgIbcZ6ggoihY6TXUTV54zyRn
         1BQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784860058; x=1785464858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZ1OuHwDErw5fJ9qlVr/HATykXaamDSQTaPimUZT5Nw=;
        b=A1fpl/jpY/57qQJ+ptX3r+7t5Id4ncEZJkB4VqrS6iMdjWqcpTpKhlqQEXUViHcXK+
         F6lmtW7uZROLAUqe1KAIVZa8vYFK1qdH3BDcGk+gi+MZdyCsy9oS+J+tNkBxIUuNu5bD
         8RF3HXk3DQgF0Is+IWbM21GrUwNCp0JNB8Ltq2iyVm0DXnzcXpBrdBjQ9i+H7E3E5HHd
         a+EwaO3ueDQdQVSIyTyqSQjuSEiTAwBxWyek7U5+sBoyDxWKxzujq7NY6x7F83yjkxkz
         rpvcypXt1+s/KbhjZYvjpO5oxkasSu0qcrHcIaMTP6KMQSiA0KZCmXR2icwMLJC6gOgq
         KHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784860058; x=1785464858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZ1OuHwDErw5fJ9qlVr/HATykXaamDSQTaPimUZT5Nw=;
        b=tKwixMqAyK+UUivIpesP24N4Puvlaaz5LTUPsCq98eH1nlWa+y97wF4XEu/xhe6csd
         A6z4ZafdZHR6dl3QvPRO7y3BeAtVp/foK+kUsMKdbPTMZECcdIM1KOkVlw2niN2cEtVi
         C8tmKO+tyiuxILeb9EgXmJrZvZAyzNz3dYxoX76i0460zFoVu59FH0kctMBv4reE96uL
         /jGgRNB/zG5eH/d+tGJSXQ99aEI0gW1u1ZyFjwgRnmqn2NRjRWMvc2bCcTwG5t9kqWV6
         YsgspHankGGuMWKi4sYRQlP8gA8OwB9XYB3CqQVJt9S2COU1MPFNVGjgudaNjXptGLq6
         gAfQ==
X-Forwarded-Encrypted: i=1; AHgh+Roi6Gvy3tY6lvwmazityaUJirjsM+8vUjSvqQuVH6FC4yfGkJWnPmGo4mwApKwb4Fews3ZQtFKj@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVRuX2SHELM7yyOAkJ4vRrkaxbuw6GLUjaadTIlNB17rzykEh
	/7+CPu82qyH311DAlX7myD6bw6EcD8czu3kG/tyA75ZG7sM/mnt6/hS6IHe5HDN3f1s64mpOQOM
	L+0OXtLwfXIDRhnHNLhdbfPTt2W0YVomF8qDPsXv6
X-Gm-Gg: AR+sD12+VEvHMyyhnmrdksuFuzBGtV3x9FS8YxMIotYojvs54DYfiabBZDL94xE/bDG
	O1BTUnF027pr29UUIF8BmcoIvjWdvqY3WBVlLNzbISKCEgmptTnjXx4CpMVTcxnUlbxQNar2gLe
	bjHcpq5oHK66VShJgHgIyTdLyNJH79lCO7RNzzkPR8m+Y4KZQ1UHZxI11d16fZaHNFFCJWuDVhi
	+JZCREd7gSC28hgnmmETKRJZvXp3aenCcHB5ix68aqjuB/i2+YUdq7f6o0DUw==
X-Received: by 2002:a17:902:ea06:b0:2cc:85a7:36ee with SMTP id
 d9443c01a7336-2cfa6c71839mr65800875ad.32.1784860058432; Thu, 23 Jul 2026
 19:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
 <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com> <CA+zpnLdz-s+yQg4EnpFXZA5XGxN4mF66cuXLFXu7AB8Bie2tHg@mail.gmail.com>
In-Reply-To: <CA+zpnLdz-s+yQg4EnpFXZA5XGxN4mF66cuXLFXu7AB8Bie2tHg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 22:27:26 -0400
X-Gm-Features: AUfX_my_uakEN7tSuATaIRuLvCXSbjt94CUvNFG8B4WaWQHS0LNZFfITvlDfa6k
Message-ID: <CAHC9VhRu=UjYoDxwiAfN29t5iUqFtu1oOQoSEMJaN=4K-5M=1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] SECURITY.md: Update security contacts
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Jason Zaman <jason@perfinion.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:24=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
> On Fri, Jul 24, 2026 at 3:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jul 23, 2026 at 9:42=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Jul 23, 2026 at 2:24=E2=80=AFAM Jason Zaman <jason@perfinion.=
com> wrote:
> > > >
> > > > Part of the annual cleanup of security contacts, drop people that a=
re
> > > > not as active committers currently. Thanks for all the work over th=
e
> > > > years!
> > > >
> > > > Signed-off-by: Jason Zaman <jason@perfinion.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> It would be great if Android could still be included here. I'd like to
> propose myself for inclusion, if that's possible. Thanks.

I believe the goal was to limit the number of people who receive
vulnerability reports to active maintainers.  Unfortunately, none of
the Google/Android folks currently listed are active contributors
which is why I believe the patch removes them (and others) from the
contact list.  Like almost all Open Source projects, the best way to
stay informed of these things is to establish yourself as an active
contributor over a period of time.  I can't speak to how the userspace
maintainers view your activity thus far, however, from my perspective
you have made some nice contributions but only over a limited period
of time.  I would like to see you demonstrate a continued involvement
over a longer period (historically this has been an issue for Google
contributors).

I also know there has been some discussion regarding notifying distros
prior to a wider, public security advisory release, although I'm not
certain of the current status of that idea.

--
paul-moore.com
