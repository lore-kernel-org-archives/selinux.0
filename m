Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F41946AA
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293554; cv=none; b=F9sahmi2lpAZPzec8CDbSG0LjpASAFw+RE5DBDQ6WDDUOYiYh0xoL0NIQ/VwZVahYcXOJi4jV5gwBIwgV96+1+g/rLQnTJsMCHRSqgYxQgsL6pWelhpZU11KjPlKOXpARapxklf82U7Wewl1Rw8NPWSxYAPe1NIPBtIwx/yljGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293554; c=relaxed/simple;
	bh=Sd95bGVJ2LCjq37iOwuj1kTAjMK/OSkpeyNFM77tCGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3nXKmqlTY7lVTzxVKOIVo2jYiGgH3ziy0CU8zeV83uzB9T/zf2adkG974//vNaGDqdmuo1EbMRuPxBggi0THyjNpwX1Nfmh2ld9Qn4o2HSobXpWvuCgot0Px0kU/u2iRR+bhJeGfmdb0qOus0xCRXhla0Ft3r770tD0tQ3h5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z/hhYEyk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z/hhYEyk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso3552972a12.1
        for <selinux@vger.kernel.org>; Sun, 07 Sep 2025 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757293552; x=1757898352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA/mHb5FEXGBYyWzdg/cHL2BkU3EdtpScaeOnQVTYug=;
        b=Z/hhYEykrl7L3ideEihKwJUW3fSuA2qnOdXMYR7ow5/mUfPfXGiGqWUc62dmsR5HeR
         LPRyKUsp9ZQHX56DxGOhBfcKir4Frlj3Ql14g6NbXjHvTkxlg4URDoWp4GZL6jAqotI4
         3GBoX6uKvDsZVyU49GTLpFp/+MiVu8fjByx1aNuiBWIkOqPnJ2Nd3hg0wcLeu7Te6sIg
         gscha/zkw2toEm96w0EcyPFM4srYRjxn0Ldv9vkNOK2c3xSN0fMgC6Xv5P13wunfL/PJ
         dMkN5TineK7QE1xGU5cBEAhH18Ky+AYJvh79XzwCOnYjH3PYDRo/7cFCc5f868guOFii
         zacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293552; x=1757898352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA/mHb5FEXGBYyWzdg/cHL2BkU3EdtpScaeOnQVTYug=;
        b=nbTeVQHFWp52uADSe+Q8RYwIvQVdShuh9VlbsuyG2+PPOh6gCNPh4K+eSOdmYHnDPW
         wHH0okDLfTGQNMgnUT9LUko7DxZ7tg3+y/zaOjEHEw5E/MPlH0BNQ3RylZdSTlN7+5Wg
         5IAytjEJhLeBQ8pQK3QjBAF9rwhcAU1v+Ck92TUCujUwE7EhYRjfe15YksxJxNOdP6Du
         EeDhkX9eAGKB/fFf9ytJmvtieebv4NR5Mk4x/GKXMd8iC4ADOd4KW5bJ3zhwUkhFAkQG
         Rjha68tgpyaO39PXPrkIIwVhw1LwcQWjNBYvi0PhPZ0DebvUmZnLAn6pdnb1ziwb5RFv
         96Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUpXfDALoL6FZtgvUbbBIIbjDc5PihKshPcKxlwswO7NMCCb5Um1RD/nh/lbNudR5n+L9w9EAD0@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOx9lWotMuAaDTbNMupZpr0yxIAdLthhgYTXcGDW7yhfjIiQQ
	rh6Fd2+UhkUzvkDUKwIqvGiSsiKOR8DKLaToWcssm3PXo69oB5yzfWOQizQPcGvADYrdA0j+Pg1
	hq/82/UYqhRrLyzFcWzIjlIbxqDv25OQXqpyonTkc
X-Gm-Gg: ASbGncvdbIrTpSFrHTZRMp/SH43gAtBM0iH703KRSJxbphYznUE1aa2FUunR+9KMkBH
	jSGK/U43qiems7G7es8G6+9WHSgtR4S/6fLlnxccWhxj1VrubDZJmzXKRbPGEFgwsJbxFLHy8xl
	xKF0or33CUO8RHUizrq/yNLf+hqUIzrEJCsYpitciDSTJelwJKPCQl2X80d2BgvbKI21me6bVM7
	9Lmiik=
X-Google-Smtp-Source: AGHT+IG+aeOfJIJg7q6C1HPAGnnZmf8Jq1DbPyXZdBJyagmM1kTQfUSAlMxoQvlmZG+P0sAC54ZqoQ4RlJkaLRQcLG8=
X-Received: by 2002:a05:6a20:3d86:b0:24a:b9e:4a6c with SMTP id
 adf61e73a8af0-2534557cb5fmr9050598637.44.1757293552578; Sun, 07 Sep 2025
 18:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-67-paul@paul-moore.com>
 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com> <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
In-Reply-To: <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Sep 2025 21:05:41 -0400
X-Gm-Features: Ac12FXzlaCoP5e2lQTx9u2iYMRLRExgUQtlxACtm-Ptm7fDXbrkhCv7k2Om7sR0
Message-ID: <CAHC9VhTJnQ3EggEXwbW5D8xOnb+Z_02yz-Dgb7QiAoArhw1ETg@mail.gmail.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 5:13=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Fri, 2025-08-22 at 16:45 -0400, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > > mechanism.  There was a minor challenge in this conversion that wasn'=
t
> > > seen when converting the other LSMs brought about by the resource
> > > sharing between the two related, yes independent IMA and EVM LSMs.
> > > This was resolved by registering the same initcalls for each LSM and
> > > including code in each registered initcall to ensure it only executes
> > > once during each boot.
> > >
> > > It is worth mentioning that this patch does not touch any of the
> > > "platform certs" code that lives in the security/integrity/platform_c=
erts
> > > directory as the IMA/EVM maintainers have assured me that this code i=
s
> > > unrelated to IMA/EVM, despite the location, and will be moved to a mo=
re
> > > relevant subsystem in the future.
>
> The "unrelated to IMA/EVM" wording misses the point.  An exception was ma=
de to
> load the pre-boot keys onto the .platform keyring in order for IMA/EVM to=
 verify
> the kexec kernel image appended signature.  This exception was subsequent=
ly
> extended to verifying the pesigned kexec kernel image signature.  (Other
> subsystems are abusing the keys on the .platform keyring to verify other
> signatures.)
>
> Instead of saying "unrelated to IMA/EVM", how about saying something alon=
g the
> lines of "IMA has a dependency on the platform and machine keyrings, but =
this
> dependency isn't limited to IMA/EVM."
>
> Paul, this patch set doesn't apply to cleanly to Linus's tree.  What is t=
he base
> commit?

It would have been based on the lsm/dev branch since the LSM tree is
the target, however, given the scope of the patchset and the fact that
it has been several weeks since it was originally posted, I wouldn't
be surprised it if needs some fuzzing when applied on top of lsm/dev
too.

--=20
paul-moore.com
