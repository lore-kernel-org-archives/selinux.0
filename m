Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C68F6E
	for <selinux@vger.kernel.org>; Wed, 14 May 2025 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187765; cv=none; b=SE6Usx1M9DeUoT6xY4ObMumdCXwnk4szCEJ5mEmEJTEX7XU1ZiuFz2g9AWUv7lvnTAZ2/T8cLwwvqSDCYB8d9cXpHOX3DZ1/MCEzwdSiAUA2+PT/1JQYXjsZoBUBZcUhLvXDIEb0iXsLPSfbt6tGrvOpxNx1NRTl4ReMP2K8nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187765; c=relaxed/simple;
	bh=xYoeRX9F5aX2RLXSN2xjCx5PuCrxlo1Q+3ikIWJmDXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7MF+6DwNWdxbNNdOy+oTwEe7OXktX1kFbaBWqeRNa7Vr4fWcVbMQhmPtZ5dv0bWxhtmQjVz5C2CwfPMv4NwaNhYbzJ9DbV9CyR4JeDPADebi01eF+uzmFyKFXQ3hVZf4Su4EklEFmkaMRvIn4P7YVqaDYNBEcEJRy5TS05pDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HOUDuOTb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOUDuOTb"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d98aa5981so10050116e87.0
        for <selinux@vger.kernel.org>; Tue, 13 May 2025 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747187762; x=1747792562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYoeRX9F5aX2RLXSN2xjCx5PuCrxlo1Q+3ikIWJmDXA=;
        b=HOUDuOTb/l9XGViVSDVRSweBycExzjAoWf5LBcaW2ufApn0bTZ+41WHHa5awh8/dgN
         1ihfAfnArpcXm8w4CZdXWGn9Q+/T54v6OHnqdfgiuJZwsgYxUXtwLc6ZywHhlSIrClpy
         ygyGEq7NExUWhNnCtgehGZf3zprRsvp0yfQaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747187762; x=1747792562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYoeRX9F5aX2RLXSN2xjCx5PuCrxlo1Q+3ikIWJmDXA=;
        b=HVjMoKM/t/xQ75HfS5XWajJMIDFiezlQncfjK+vBYhSBWs1tSce1aDy8OIBatbuUO6
         Q076Sc76YLnl9QK0dmfBRtClUNNnjpieBenYvAJ5eo6vVfa5U8d52PGcfPXlaqL8eAym
         ixnwf86Yqi7+xt53S7W30SMrS9sMSHBpMIFpsLdeUvHuSiW51lOyf0Q81Dgh47SrvxlB
         G3AhDYlbt3CBjgO2sA0Jw4/vMkRJ+lxE0vrrRpeyCwbZ88rCVbWIPMPaa61Jr2JSAEb4
         x0oIbaig+YQTwV6G8rr6SUk/XVHKtZNSXggoH8Nb9/x4MP7AtBQlsf7s64VJigvT5WOV
         5Isw==
X-Forwarded-Encrypted: i=1; AJvYcCUkAvruI/G46dxMhnzLEJsItdBPfDqdkjpWSo7rX1fmpcoMZBQ3gEBWJ+avxyuz9AyCvoQuybxt@vger.kernel.org
X-Gm-Message-State: AOJu0YxST7vJLdI6nYaqiHEEM1s9mPiUMUFFvSYFNRh5chVYkK759ljL
	tYIqa3EwnU+8bc9Flfs4ZLqzoqHm4/1dyPcZi91oLOcbQy11fHFJjReEuaJRLin1YWZXfI+Bwaw
	52KA/HzOrV80/Cw0ug0qe3X/ziI9/h9hvRFk=
X-Gm-Gg: ASbGncuFSXWSdpdhCfY/SCHa+LMmlgitjnpYURIP/ecFpoWke9wUNb5skRhWazmcELi
	gKYC0ha9nayt54uzd/FGscQew6vMGUwDpA/DNDI0wUk5mCx0rrsLrybXaaBVaNojxyVwhcKSmT2
	eatApzcC3WFZ5z58pC6mQaPcpX1rbeceJ2wNSse18gTjJyda4vT5El6vjq6fXKMA==
X-Google-Smtp-Source: AGHT+IG1Cwv9Pc/0XvrIpEisCgoHCruJWmXryckXlmk2rgH8zvf7jUgMpfqFJofX6vsKm3FjsjoHmYdu5S7VMET4U+c=
X-Received: by 2002:a05:6512:660b:b0:54e:8194:9a72 with SMTP id
 2adb3069b0e04-550d5fb891fmr427996e87.28.1747187761806; Tue, 13 May 2025
 18:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
 <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com>
 <CAP+JOzR-UyYGwizSBnHjmJj8ERweZdiJi2cWExi64W9BGa+nNg@mail.gmail.com>
 <CAEjxPJ6XxLoN5ECTOxADAQAFLYpjL1ieN6bLQ1NKTtUkRpWziQ@mail.gmail.com>
 <CAP+JOzR24JyOWeKHDhi6+tYbd70V2Unkw5ppDkhrb7EK2A14=A@mail.gmail.com>
 <CA+QFDK=o3_xTWnEyLm6kTKzcGrz+mMKXy1kQLNqeqiBUBHBBvw@mail.gmail.com>
 <CAH9xa6cSNsiDx5Wq+nhZQwkkAPxh3bcy5mpBBbYTbaGnoZ3smg@mail.gmail.com> <CAP+JOzSPjmdigKyA6T+2Wibj6v=SPdsEJ7i59jpNoS08GYYpYw@mail.gmail.com>
In-Reply-To: <CAP+JOzSPjmdigKyA6T+2Wibj6v=SPdsEJ7i59jpNoS08GYYpYw@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 14 May 2025 10:55:50 +0900
X-Gm-Features: AX0GCFt5NKPRTtau8cI_M5EqSF32Al1cvFTSXbGBVVLaZ1b5rWmk6EmrLxnKMzk
Message-ID: <CAH9xa6eKP6w55B33HMKJU8HbVso7sm-1mTvQ_9QjGnfcA7=rCw@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: James Carter <jwcart2@gmail.com>
Cc: Inseob Kim <inseob@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Junichi Uekawa <uekawa@chromium.org>, 
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:08=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, May 13, 2025 at 5:34=E2=80=AFAM Takaya Saeki <takayas@chromium.or=
g> wrote:
> >
> > On Tue, May 13, 2025 at 5:44=E2=80=AFPM Inseob Kim <inseob@google.com> =
wrote:
> > >
> > > On Tue, May 13, 2025 at 1:57=E2=80=AFAM James Carter <jwcart2@gmail.c=
om> wrote:
> > > >
> > > > On Mon, May 12, 2025 at 10:47=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 12, 2025 at 10:31=E2=80=AFAM James Carter <jwcart2@gm=
ail.com> wrote:
> > > > > >
> > > > > > On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas=
@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hello Stephen, Paul, and all libselinux maintainers.
> > > > > > > >
> > > > > > > > I'd like to ask your opinions about an idea to keep the sem=
antics of genfs in
> > > > > > > > the userspace, before sending a patch to expose the new gen=
fs_seclabel_wildcard
> > > > > > > > kernel capability to libselinux users in polcaps.h as
> > > > > > > > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> > > > > > > >
> > > > > > > > As a background, we introduced the genfs wildcard feature t=
o the kernel selinux
> > > > > > > > in https://lore.kernel.org/selinux/20250318083139.1515253-1=
-takayas@chromium.org/
> > > > > > > > (Thank you for your help and reviews!)
> > > > > > > > That enabled libselinux to use wildcards in genfs rules. Th=
ere we changed the
> > > > > > > > semantics of genfs with the capability enabled in the kerne=
l space from prefix
> > > > > > > > match to exact match with wildcards for kernel implementati=
on simplicity.
> > > > > > > >
> > > > > > > > I'm wondering whether we can keep the user-facing semantics=
 of (genfscon ...)
> > > > > > > > statements in CIL files in the following way.
> > > > > > > >
> > > > > > > > When secilc compiles a (genfscon ...) statement to the kern=
el binary format, it
> > > > > > > > adds a following `*` to the compiled kernel genfscon statem=
ent if the input has
> > > > > > > > (policycap genfs_seclabel_wildcard). If the input doesn't h=
ave one, secilc does
> > > > > > > > not add any following `*`. That keeps the behavior of (genf=
scon ...) in CIL
> > > > > > > > from the user perspective with and without the new wildcard=
 capability. This is
> > > > > > > > similar to what our first kernel patch did, but done in the=
 userspace by secilc
> > > > > > > > this time. So, the (genfscon ...) keeps the backward compat=
ibility of prefix
> > > > > > > > match for libselinux users, while keeping the kernel implem=
entation simple.
> > > > > > > > That would allow users to keep existing rules without modif=
ication.
> > > > > > > >
> > > > > > > > I'd like to hear your opinions.
> > > > > > >
> > > > > >
> > > > > > I agree with this approach. It should only be adding it when wr=
iting
> > > > > > the kernel binary policy.
> > > > > >
> > > > > > > (added James to cc for the secilc question)
> > > > > > >
> > > > > > > I'm assuming you mean libsepol rather than libselinux. I coul=
d be
> >
> > Yes, thanks for the correction.
> >
> > > > > > > wrong, but I believe that in general policy capabilities are =
only
> > > > > > > declared once in the policy and typically in the base module,=
 and
> > > > > > > those settings are then applied globally to all policy module=
s. While
> > > > > > > you can put one in a non-base module, it still has a global e=
ffect on
> > > > > > > the final policy. Putting a policycap statement into every CI=
L module
> > > > > > > that wants this behavior would possibly trigger an error (not=
 sure
> > > > > > > how/if libsepol/secilc handles duplicate policycap statements=
) and
> > > > > > > regardless would enable it for the entire policy.
> > >
> > > We keep backward compatibility of (genfscon ...) so they'll always be
> > > prefix-matched. For example, (policycap genfs_seclabel_wildcard) in
> > > ./vendor/etc/selinux/vendor_sepolicy.cil won't affect how genfscon
> > > statements in /system/etc/selinux/plat_sepolicy.cil work.
> > >
> > > > > >
> > > > > > The policy capability can only be declared once. It will give a=
n error
> > > > > > if there is a duplicate.
> > > > > >
> > > > > > But since the CIL modules are not compiled individually, it doe=
sn't
> > > > > > matter where the policy capability is declared. CIL doesn't hav=
e the
> > > > > > concept of a base module, all modules are equal. Since Refpolic=
y
> > > > > > modules are converted to CIL in the policy infrastructure, ther=
e is a
> > > > > > base module, but that is because Refpolicy has the concept of a=
 base
> > > > > > module, not because CIL does.
> > > > >
> > > > > I think the problem is that there are multiple CIL modules shippe=
d in
> > > > > Android (e.g. vendor, platform, oem, ...) and more than one of th=
em
> > > > > might contain this policycap statement to indicate that its genfs=
con
> > > > > statements should be interpreted in this manner. So the final com=
bined
> > > > > policy that is fed to secilc could end up with duplicates unless =
they
> > > > > filter them out, or secilc is modified to ignore dups.
> > > >
> > > > I don't think it would be a problem to ignore duplicate policycap
> > > > statements. It should be a fairly small patch.
> > > > Jim
> > >
> > > So, simply supporting this (allowing duplicated policycap statements)
> > > will be enough even for the Android case.
> > >
> > > --
> > > Inseob Kim | Software Engineer | inseob@google.com
> >
> > Thank you all, so I think the idea seems acceptable from both perspecti=
ves of
> > Refpolicy and Android. I'd like to ask whether we have any path to gene=
rate a
> > kernel binary policy that does not involve .cil intermediates and secil=
c in
> > practical environments. Is patching secilc (libsepol, to be precise)
> > sufficient? We know it's enough for Android, but is also true for Refpo=
licy
> > environments? There are a lot of se.* tools and I'm not sure if secilc =
always
> > plays the role.
>
> checkpolicy is the other way to generate a kernel binary policy, but
> if you patch libsepol (specifically, genfs_write() in write.c) you'll
> take care of both at the same time.
> Jim

Great, then we will send actual patches soon. Thank you all for your
valuable input!
