Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FA2D8DDB
	for <selinux@vger.kernel.org>; Wed,  7 Jan 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817116; cv=none; b=DQq+YuFraS75Z32Fk9wuBoaaCTu/2y5CNGokw46YYweINsmPbWj/OXtkz1qzBOhLl/bYXU1U7SlDrm6gNi6PHwfnJeYsnpUQfAYkX/mOpiICW6faUzc4kR2RhOuMlvzQN35ufbXa4C2DKg8s1JoM29Rb+m7TRz+OffWIRcemAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817116; c=relaxed/simple;
	bh=LITJIvzlUoSepgp0116YDWtwsZrhUArZIoWelRmVdY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjmWrX4DZsu431N+8uVQs5jzAoCCcktls9grw966jnsdJPvLBYN3nlTtZkpgcKsagV6XBNTOYJxRfuIV0mK0RuyWyJtgxrW66p57WPS6tmmuL2IYZRsHchCqlnQw13RM7u+WMgrA6ctx/1v2eHX7vcKOPfWL8yBtB8lEElSqmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BQReuzPd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BQReuzPd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c20ee83dso24425475ad.2
        for <selinux@vger.kernel.org>; Wed, 07 Jan 2026 12:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767817112; x=1768421912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjRjWdW/CE0Ik0VFH4WSRSpLDlAMxMjzwqvx0se0l78=;
        b=BQReuzPdTiv5A3c2Pm9JBnFZBhT/jYxIOQW/pzT4TqxEuM+IQF2FX97PKB7wdQqwH+
         kQ34cSNfhAsKJp0xWHCatuK2Fc6XeckzfaZUuU7kRgFZ4AvoBb8N7UZi/wvWZKpZ+RV2
         Fx3k4wGHlDEnFbcEIu5yLQORWlyLIPKL7XeUOf1sA3h7cPIdq3N3nRDhJmzPwmTkZbQ6
         dpNvF5AIxe4x6ryLmoYtQ5BJTHFbb34fqRFOZeLBA6lU04La8RsUCDZpp5E4LAx4BYMY
         QgxxmIr7yzXMH0zQxkWz7uwqnf4pyvQTG3fR8mBdYvW9nVcsZav+DRm7UlQQJHIJpEO4
         xMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817112; x=1768421912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjRjWdW/CE0Ik0VFH4WSRSpLDlAMxMjzwqvx0se0l78=;
        b=qqP83Czt8bPf/a1U0NewE+L9d6OEtA5RIe1O/XaUjqYtQ0PhXqFGYMtYgdg3e+JFkK
         glDmNk1vPpf+1zDnToURZwxhseGRgIDSBmQgoH/+DV50s89sanLaHCID8mgMvpx3hVns
         GN87LO7o5MtnpfriuJiP/Fw/xQJfwHvpBWezP/llm8lx4bcylNdvstp8SP1Ay1QtbnLO
         hNijzhKyTL5/7JFxTNBM1E/f/iQmwpvm7bexRPDHNgfIgN9rPq2MvW1VxqfboVDOlsw2
         XElG/ttxYIIU76PcCHh4/X+MNmcC6iK6pVf2NYxzOIputEif4Y4EVAiGUmFSolsc1C97
         c4JA==
X-Gm-Message-State: AOJu0YwqnlkCy7Sl++Ah07mw8cur0/J9JxdpuZEuxWVewsECUYWDQfNj
	Dluipsj6ZNQESI2Z07t77Eo3Yth7YvJv5pAcw5uvLDwMpxP7GFH/oZLbuESPScfU7PB6EW+TdaZ
	KrERvSrjtoW4i2zcyQJGR2OvMBhCWFNmUe3c4iLJPcRVCsXZCBC2ijw==
X-Gm-Gg: AY/fxX7zAtJ8sCM4GyhJZuk7WfTFy4dBy9TyCzelCX8MFelgKcwjjFbEx6KQ4YdRPnp
	+U18W95ssF4Rhj+yQYBLAiew3cEIeErJ8lbCRSbZyd9bO8yMG2zXjKa5O10u66ERFCAnX0Thokr
	ZmJPyVxfI0nwaM0iot5VHH1Ayqf9rdJ0xqq8HfqYj/qr523N44cmoo1s0NfDFqQmfBtK197/mJ7
	XlhP9kdD7+Qhs9mFx0Uy1puLv/3eQGCIqQvABjLN+hH9QVNX2zpWimfBiGqMnuL8ECks7U=
X-Google-Smtp-Source: AGHT+IEpbARaeCau/hGcB8V4yi20aUnU1g7AIb/m9pTkcERVucR8ZZT9XNOR6m0vkTOxt+wQKm4fHdkVBJdlW0LwKpM=
X-Received: by 2002:a17:90b:164d:b0:340:c64d:38d3 with SMTP id
 98e67ed59e1d1-34f68b9a10amr3732052a91.12.1767817112422; Wed, 07 Jan 2026
 12:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com> <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com>
In-Reply-To: <87h5sxvd52.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Jan 2026 15:18:20 -0500
X-Gm-Features: AQt7F2p5BGF9U06Mnm8rlwVVwTjo2nPm7BpkBeH9oVfZrze1SZspEqJjF8TTEPY
Message-ID: <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:08=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> >>
> >> The key is available at:
> >> https://github.com/bachradsusi.gpg
> >> https://plautrba.fedorapeople.org/lautrbach@redhat.com.gpg
> >>
> >> Also update the email address
> >>
> >> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >> ---
> >>  SECURITY.md | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/SECURITY.md b/SECURITY.md
> >> index 2a7ce5b317a7..faa060ccff03 100644
> >> --- a/SECURITY.md
> >> +++ b/SECURITY.md
> >> @@ -24,7 +24,8 @@ list is below. We typically request at most a 90 day=
 time period to address
> >>  the issue before it is made public, but we will make every effort to =
address
> >>  the issue as quickly as possible and shorten the disclosure window.
> >>
> >> -* Petr Lautrbach, plautrba@redhat.com
> >> +* Petr Lautrbach, lautrbach@redhat.com
> >> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 =
C13E
> >
> > I think you may want to list the fingerprint of your primary key and
> > not a subkey, as the primary key is what carries the signatures and
> > helps verify trust.
> >
>
> I guess I need help then:
>
> $ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg

You want to use the key fingerprint which displays when you run 'gpg
--fingerprint <email>'.  Assuming you have the keys for the other devs
in your keyring, you'll notice that command can be used to reproduce
the other fingerprints in the file.

%  gpg --fingerprint plautrba@redhat.com
pub   rsa4096 2012-04-03 [SC]
     E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
uid           [  full  ] Petr Lautrbach <plautrba@redhat.com>
sub   rsa4096 2012-04-03 [E]
sub   rsa4096 2017-12-05 [S]
sub   rsa4096 2017-12-05 [A]
%  gpg --fingerprint paul@paul-moore.com
pub   rsa4096 2011-10-10 [SC]
     7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
uid           [ultimate] Paul Moore <paul@paul-moore.com>
uid           [ultimate] Paul Moore <pcmoore@umich.edu>
sub   rsa4096 2018-10-15 [E]
sub   rsa4096 2018-10-15 [S]
sub   rsa4096 2020-06-19 [A]

> >>  * Nicolas Iooss, nicolas.iooss@m4x.org
> >>    *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 =
C5EB
> >>  * Jeffrey Vander Stoep, jeffv@google.com
> >> --
> >> 2.52.0

--=20
paul-moore.com
