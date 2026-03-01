Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CE3093DD
	for <selinux@vger.kernel.org>; Sun,  1 Mar 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772376999; cv=none; b=bBqv8IDCjXuvmBSbGaPzRlxW/1bf9jsL9p+106RaD6n2r/cc12jU3qX89J2iWQlWgfbv+YFudgSyLey992yVv6HFd9AKpOQw1pSMHlVaYiQZPeO03JagUaZlNu9RUGOurWBZhOjkAVfhjxhtY296p4e36NNi4SK1cfZGLUvHVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772376999; c=relaxed/simple;
	bh=ZJ60hk3W7oiFCeVzRzHrfxgk3H3Cz5Zfv9Fvf2olsOc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y/8im0ke1uQBitbfxxOozla2D6AjeUBrYG3TIiyx25ViTdavn0Kzf3sDMMziuajDHmDLImb2BtfcQ/Fmv0FCIcYGCQM+OkoGWx9WBgGOC/Czd9wJdx/GSQif8nN1/WD5Msl0FqiJv47AAKloPbISoQF0daNN/KnLZ0QI1SW4gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=fail smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LVxeh0bY; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LVxeh0bY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772376980; x=1772636180;
	bh=ZJ60hk3W7oiFCeVzRzHrfxgk3H3Cz5Zfv9Fvf2olsOc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LVxeh0bYvdxAJOJ2Hbitve8RnlBzmEWGNTpFRCH3Hp7cxt3JUOgHTmRHa7Pj/F1FF
	 2FGnv/qjks98u83YqJ1JlY3uFcZrjZkxFreCdt7MLm4VZA5xPSX8OvMIWJLi1V2U5l
	 1yaOf3E4GH7eo51TXs0z1Ytq7GamiQLPb7svzddH0dNrZxJEjoTuupzoTCllKqZCs1
	 LDbdfxTWNRLcQtWb0xn7wVgoT11pXOxD7Hoa85kP79RS+e6juXC1NY4Bl+Yt22DOIW
	 DrLRTFOLSH1lPNZUJnOjN9Iu1r2CFKUlh7nPxEX6v4ZzY426Fk5sfqiYAEokMI+far
	 bRzdacq0pAKaw==
Date: Sun, 01 Mar 2026 14:56:17 +0000
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Government hackers changed my video title in my primary / main / master Youtube account recently
Message-ID: <ZdT3tsHsdO0Rg1AiDVraY90RsHw0Yk_4I3Zi2xnky4YjUrcvffBLWkjPpHrSpMY2Cc1geGNGLxCMC1ZHWdrRXJ4r8-F482nVJ4hfa-wT87A=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 70e594b48e4b433ff4e58612fcb7bf19312e6d58
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Government hackers changed my video title in my primary / main / m=
aster Youtube account recently

Good day from Singapore,

My primary / main / master YouTube account is protected by two-factor secon=
d-factor authentication aka 2FA MFA. Yet government hackers were able to ch=
ange the title of my YouTube video easily.

My Youtube video title will usually match the video filename on my computer=
, 99.9% of the time.

On 4 Feb 2026 Wednesday, I had uploaded a video to Youtube.

The video filename on my computer is:

=E9=83=91=E5=B7=A7=E5=84=BF Jayner Teh Getai Performance 4 Feb 2026 Wednesd=
ay.mp4

However, a few days later, I noticed that my YouTube video title appeared t=
o have changed.

Government hackers had changed my Youtube video title to:

Jayner Teh Getai Performance, February 4, 2026, Wednesday

Yesterday 28 Feb 2026 Saturday at 6.14 PM, I made a verification check.

The Youtube video title does not match the video filename on my computer. I=
ndeed!

Immediately I know government hackers must have changed my Youtube video ti=
tle.

For the past 19 years since 2007, I know government hackers have control ov=
er my Android (Linux) phones, laptops, desktop computers, servers, and onli=
ne accounts.

This is because government hackers regularly love to purposely and delibera=
tely show off they can hack into my devices and accounts for the past 19 ye=
ars.

Recently, government hackers purposely and deliberately show off they are a=
ble to change my Youtube video title, when my primary / main / master Youtu=
be account is protected by 2FA MFA.

What are the motives and objectives of the government hackers in repeatedly=
 and regularly showing me they have access to my devices and accounts, purp=
osely and deliberately?

Government hackers could have chosen NOT to let me know they have hacked in=
to my devices and accounts for the past 19 years. They could have done it s=
ilently and stealthily. Why are they doing it so obviously?

Why? Is it to distract me from something else?

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical/Mental Problems/Poverty
1st March 2026 Sunday 10.31 PM Singapore Time

PS. A few minutes after making the above report, my vivo X100 Pro 5G Androi=
d (Linux) smartphone started playing music by itself without me doing anyth=
ing.



