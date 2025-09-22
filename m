Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C328B7CC
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577988; cv=none; b=VIGu98eX/72tMMruSumEMI5tIaDvJ3kOS4Z2CEfeXANs6nnth1VX+BQPJJYWNz4p+1+iD7OzUAReaVJiah4+w6LObgjqXfDupomwA6VnK0FbpV4rY/GtnCgFR8pEQTRYbzvuhqakoiR5SjCVxCtfz9gM7ROcSjiHjtaqCCBL9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577988; c=relaxed/simple;
	bh=NrxcGV9SRKTH90U9r9TiQBRjMm9wgcBgK/JoZCvLbI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpwihThjMQlGh5PaD+bkkwJ+Lim4ASowDVsB6xDX6gqXYXA+iroxNhRS0KcsFUN9Lyio46yPV2VnvX/4ihhSHqjLJE99k8jzVbDQcQdWBKjjbcQOAV5QHpFH/ABG4BKOU5yRlF7HJDlv44cm62MS0kEQUNUAlVAzbbFIbJoA7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MpKMTw3m; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MpKMTw3m"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2449091a91.1
        for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758577986; x=1759182786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBCpPhJ55NBZXeBegJaYDf1Vz3ukosPuvPoKyErH30U=;
        b=MpKMTw3mB8cS+wLKmM8B/FN/L+1iE0pQQmRWOZVXGS4mSCm0K1pU1gDJEVuXtxVxXo
         uuMqijoX2yPKTU1SBmZueh5b+sdLN7pZhuv3kLaRjZKGkXSOAC9C6ESuyUwF7clq173b
         yJ5+EDg9rdkHiJpIiH2w8y83fZllQkrhUxph1nzJ6HHpN1IXyUdfWT5KaRdNq89s93H/
         s4E3t3++vYp9s4hsJ7Gfua+d6FrHIhfJh5A1HbKlOc0yW2LG5bobwoUgQN7S0HOCniAv
         j8qU/IC82212UsrQDCFGVWpN80TV1jKgkAsCMjorxmHvBUCWKKFn8l6dizk8iES8rIOW
         zlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577986; x=1759182786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBCpPhJ55NBZXeBegJaYDf1Vz3ukosPuvPoKyErH30U=;
        b=LZeHkIMdLaBdZYCIZ70FTfZM1/sN9JKnYcyNB1hHGUOw4xSYjat6NOYWh1YBjWCto5
         rPAVsme/JbbOALm0nfqj5QbCC/TQ/4JhVsJM7VP8X+f9QzVS/Y4XVtCctWauHagh3rAk
         zfcJ6ZbUR4d7Mz3Q6Q8JqA5mZfFfh3Yo+GXNpc5xLOqFwxCunPPVeyGzk+d4CfjiO2CF
         setT4wVjAehYVneYJgvueiuKNUYjdvGeLHHpjsLEE2gKZdjUf1kRVJsT7nbFAwhM2bIl
         SqGUHfb5IEA4fzbl5dGSdUdaRO1aosmG3i2V1+T9eUs5pUPXb1h1qswEF6ZM7euCtof/
         TGJg==
X-Forwarded-Encrypted: i=1; AJvYcCWxyhofR0vx5VI3Cevc+U9pT8qyV8Dslr7DUvTPkIOzwtkbfmZZiQaaRiyPcPC8zprzzgMZSp3w@vger.kernel.org
X-Gm-Message-State: AOJu0YyGv+bWDqvjlGgW4dmotO95hqCYV7KDH5w8w5NBA0orfxIluvYb
	3LE2DTUvX8ZeZpHNYbg+2VhuZBfDpMyJjoC04mSngVRPUKhLwt8o4K4t44mVA+ikKqpQLOwALi9
	cGr2aiLmZbnp4+xb1ngelVhCfdUzq2P5UyC8/4CCS
X-Gm-Gg: ASbGncsi04QBZDuPIYWur3CPKRXsjcqbbK3OlMYgFq6h6sjgYNu8DYmJrYk8ZxyrI7R
	aEnENrvbz0VEo02gEEpTgeCrncsuSHM9BvyO9ClkjXTUyzLseRRelnRyymtU2wasUu0pPNAczd4
	HCtzZixLR/7kqqdMH5ZmfcSBmZ0DvePGbFtIBLJbmacwU1FIaWeLsbOVGqg0A5TOAgS5YyF4gB6
	FM1oO0=
X-Google-Smtp-Source: AGHT+IEIQWA5rKW43P5Fcmt7zmtt/MYBDfabS+vBWJKdvNBhoSvEK2C+yUTl6EB3o0bQhS1oiKlOiaKg1oXWzn0OcwI=
X-Received: by 2002:a17:90b:540f:b0:327:734a:ae7a with SMTP id
 98e67ed59e1d1-332a92da6ebmr455889a91.11.1758577986004; Mon, 22 Sep 2025
 14:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-47-paul@paul-moore.com>
 <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
 <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com> <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
In-Reply-To: <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 17:52:54 -0400
X-Gm-Features: AS18NWCouzv17lHS4hgSMPjWiUR_MwHmSY1fDXCtAlsYtCf1VWHhUgu34JpGZtw
Message-ID: <CAHC9VhR94kuqcwP6DcdG+QpcruU8dMnP55CmTXiQ-k+u5yOT1Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:53=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Sun, 2025-09-21 at 15:23 -0400, Paul Moore wrote:
> > On Fri, Sep 19, 2025 at 3:16=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > >
> > > On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > > > The LSM currently has a lot of code to maintain a list of the curre=
ntly
> > > > active LSMs in a human readable string, with the only user being th=
e
> > > > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > > > generate the string on first use and then cache it for subsequent u=
se.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > FYI, checkpatch.pl complains of unbalanced braces, otherwise
> >
> > Looks good to me?
> >
> > % stg export --stdout lsm-lsm_names_cleanup | ./scripts/checkpatch.pl -
> > total: 0 errors, 0 warnings, 139 lines checked
> >
> > Your patch has no obvious style problems and is ready for submission.
>
> Try adding "--strict", which enforces
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-b=
races-and-spaces

Ah, yes, sure.  FWIW, I view checkpatch's findings mostly as
"advisory"; oftentimes it can help catch important things, other times
I think it's kinda silly (and no, I don't have a list of each, so
please don't ask).  I often tell people new to kernel development that
it is generally better to follow checkpatch's suggestions if you are
uncertain, however don't be surprised if a maintainer prefers
something slightly different.

For those reasons I don't ever bother with the "strict" checkpatch mode.

--=20
paul-moore.com
