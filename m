Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0621CA0F
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128844; cv=none; b=J9Ic+ToXA3XZDoBcPlpESmDPyGcVzM5+44EjYiMtZcJAFNXtxEIt051DZQQo8I8sqa+dSk2X8ShmuYz2mELkaFE0rxFeQXHYD3V0Fsla+0JtmL5WQ0E7NCyuHNDCg1Tjxn6lM6m69w/Ph1+TTfxEv297pIVuDtWJu2ckcKUCe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128844; c=relaxed/simple;
	bh=PDKMcVj5zBhTbfPoKm/BsQn4NtXActcaangB8P8bbaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVylz6B/TizxYiJ9T3VfFn0yjnvthwpGUkVmc9CilAcwNc+f6SMLRzy+YOjQ3+0e4Wajw2Sc9R9k6UmAkKPdMYxfhQ310caKnn49N1KhFEI5TyUEvy5uTfFcwSlIIu2yr47zcqHdv+0/ic9urAeQGvI3U0aEYTzukOHfi+CSyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luLD/JG9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luLD/JG9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so5657054e87.2
        for <selinux@vger.kernel.org>; Tue, 13 May 2025 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747128840; x=1747733640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDKMcVj5zBhTbfPoKm/BsQn4NtXActcaangB8P8bbaY=;
        b=luLD/JG996nBZVs8y1MxCWtZENAhZMl/TAqO6PBv1K8C0atupEI+TRCj/I2ca44/Me
         OJ1HorQVlo9NGf6LrtWpVlCZItf8+TjdW1JROcRluXEAYs86DvE3asW8xrrtUIoUXgNG
         3ZspOT3+eQkPRz26H7/VgSDkTbcA6MICmj7Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128840; x=1747733640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDKMcVj5zBhTbfPoKm/BsQn4NtXActcaangB8P8bbaY=;
        b=uLL+bu6aIYgsIUU8xclQgkRxg4qT3OJxLVE23oIztjwS//zjO2BSvI+p8XYRpU+nIh
         N89EEUfQJnJqBAv4lRVOj4k+22jpoAyzUMhPG8tQzXNOdnHqkLdPhv2KdVdt0Y5WqqJo
         C34VF1z6kNkcuhGAxZ9Yo6UkBTu54soiJSc1LGKL0DcSwrP4MqRq16vluWbN7tuhsx8j
         zhM8K3b6imXyUwdTGFtGI8Jo46g1TedVJc25rOcJU2Cn2dLuW0ajDr37BIhfbMdjHm/i
         hJWlViC/2JSVYTmLHzOhv6ws0vbb3COC8p61acFTaZwHx4i5FOiomlK8ncxN7EyJnPKt
         CKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw3hCbkhTgnj1BcIpFm/j43egGKzZs3Bmw9lf5aTJyHIhh+kjLdRIDrEJaMlm3yhjoZU7sKHZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9/WKF4vdyDraIPiFk2By409BS/p2K903FeKFKweg4waAaFU7
	C/Wdj7+5SCUSqrF+uO3g81+yExdIymKmpJjlLRV6bRYIQaKeTSuuCQ+bCPyPfobfiup01xKBNom
	TEUkblOxMZJxyq+ML4dFjaPNG1iW3TUdDEZ4=
X-Gm-Gg: ASbGncsjqQ8J816254dN+UQI0ycs8RPeS532rn/fsHpL3PlgzK7AOE0poiGic0aTGAV
	/ymZjvx1+9WtnLlBXF3ThlcmQf2WF2LVayFJJrur9MlmpFw4Thmq/OeANbIzi0twoLcQ2Ok09ea
	2wp4ruIt/j/KkO18651whQ0GulPY8j8zZFlnlAjEuxxwTNZlz5hDZXu/K4n4/f
X-Google-Smtp-Source: AGHT+IHstSrInjO69VpbjgPx3OdBFjBoWbLCideZ6zAld/2dwIl022/FFuR0Fxyk2DBrHCw5z7xywlm51SXhi1PQmdQ=
X-Received: by 2002:a05:6512:1406:b0:54f:c6b0:4b67 with SMTP id
 2adb3069b0e04-54fc6b04b6bmr4674358e87.4.1747128840161; Tue, 13 May 2025
 02:34:00 -0700 (PDT)
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
 <CAP+JOzR24JyOWeKHDhi6+tYbd70V2Unkw5ppDkhrb7EK2A14=A@mail.gmail.com> <CA+QFDK=o3_xTWnEyLm6kTKzcGrz+mMKXy1kQLNqeqiBUBHBBvw@mail.gmail.com>
In-Reply-To: <CA+QFDK=o3_xTWnEyLm6kTKzcGrz+mMKXy1kQLNqeqiBUBHBBvw@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 13 May 2025 18:33:48 +0900
X-Gm-Features: AX0GCFvftQwQWpkwj0alt3uZNkdQFp-fF8--d37KOym4hZhJmxkdwboh7fGcSCk
Message-ID: <CAH9xa6cSNsiDx5Wq+nhZQwkkAPxh3bcy5mpBBbYTbaGnoZ3smg@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: Inseob Kim <inseob@google.com>
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Junichi Uekawa <uekawa@chromium.org>, 
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 5:44=E2=80=AFPM Inseob Kim <inseob@google.com> wrot=
e:
>
> On Tue, May 13, 2025 at 1:57=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > On Mon, May 12, 2025 at 10:47=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, May 12, 2025 at 10:31=E2=80=AFAM James Carter <jwcart2@gmail.=
com> wrote:
> > > >
> > > > On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@chr=
omium.org> wrote:
> > > > > >
> > > > > > Hello Stephen, Paul, and all libselinux maintainers.
> > > > > >
> > > > > > I'd like to ask your opinions about an idea to keep the semanti=
cs of genfs in
> > > > > > the userspace, before sending a patch to expose the new genfs_s=
eclabel_wildcard
> > > > > > kernel capability to libselinux users in polcaps.h as
> > > > > > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> > > > > >
> > > > > > As a background, we introduced the genfs wildcard feature to th=
e kernel selinux
> > > > > > in https://lore.kernel.org/selinux/20250318083139.1515253-1-tak=
ayas@chromium.org/
> > > > > > (Thank you for your help and reviews!)
> > > > > > That enabled libselinux to use wildcards in genfs rules. There =
we changed the
> > > > > > semantics of genfs with the capability enabled in the kernel sp=
ace from prefix
> > > > > > match to exact match with wildcards for kernel implementation s=
implicity.
> > > > > >
> > > > > > I'm wondering whether we can keep the user-facing semantics of =
(genfscon ...)
> > > > > > statements in CIL files in the following way.
> > > > > >
> > > > > > When secilc compiles a (genfscon ...) statement to the kernel b=
inary format, it
> > > > > > adds a following `*` to the compiled kernel genfscon statement =
if the input has
> > > > > > (policycap genfs_seclabel_wildcard). If the input doesn't have =
one, secilc does
> > > > > > not add any following `*`. That keeps the behavior of (genfscon=
 ...) in CIL
> > > > > > from the user perspective with and without the new wildcard cap=
ability. This is
> > > > > > similar to what our first kernel patch did, but done in the use=
rspace by secilc
> > > > > > this time. So, the (genfscon ...) keeps the backward compatibil=
ity of prefix
> > > > > > match for libselinux users, while keeping the kernel implementa=
tion simple.
> > > > > > That would allow users to keep existing rules without modificat=
ion.
> > > > > >
> > > > > > I'd like to hear your opinions.
> > > > >
> > > >
> > > > I agree with this approach. It should only be adding it when writin=
g
> > > > the kernel binary policy.
> > > >
> > > > > (added James to cc for the secilc question)
> > > > >
> > > > > I'm assuming you mean libsepol rather than libselinux. I could be

Yes, thanks for the correction.

> > > > > wrong, but I believe that in general policy capabilities are only
> > > > > declared once in the policy and typically in the base module, and
> > > > > those settings are then applied globally to all policy modules. W=
hile
> > > > > you can put one in a non-base module, it still has a global effec=
t on
> > > > > the final policy. Putting a policycap statement into every CIL mo=
dule
> > > > > that wants this behavior would possibly trigger an error (not sur=
e
> > > > > how/if libsepol/secilc handles duplicate policycap statements) an=
d
> > > > > regardless would enable it for the entire policy.
>
> We keep backward compatibility of (genfscon ...) so they'll always be
> prefix-matched. For example, (policycap genfs_seclabel_wildcard) in
> ./vendor/etc/selinux/vendor_sepolicy.cil won't affect how genfscon
> statements in /system/etc/selinux/plat_sepolicy.cil work.
>
> > > >
> > > > The policy capability can only be declared once. It will give an er=
ror
> > > > if there is a duplicate.
> > > >
> > > > But since the CIL modules are not compiled individually, it doesn't
> > > > matter where the policy capability is declared. CIL doesn't have th=
e
> > > > concept of a base module, all modules are equal. Since Refpolicy
> > > > modules are converted to CIL in the policy infrastructure, there is=
 a
> > > > base module, but that is because Refpolicy has the concept of a bas=
e
> > > > module, not because CIL does.
> > >
> > > I think the problem is that there are multiple CIL modules shipped in
> > > Android (e.g. vendor, platform, oem, ...) and more than one of them
> > > might contain this policycap statement to indicate that its genfscon
> > > statements should be interpreted in this manner. So the final combine=
d
> > > policy that is fed to secilc could end up with duplicates unless they
> > > filter them out, or secilc is modified to ignore dups.
> >
> > I don't think it would be a problem to ignore duplicate policycap
> > statements. It should be a fairly small patch.
> > Jim
>
> So, simply supporting this (allowing duplicated policycap statements)
> will be enough even for the Android case.
>
> --
> Inseob Kim | Software Engineer | inseob@google.com

Thank you all, so I think the idea seems acceptable from both perspectives =
of
Refpolicy and Android. I'd like to ask whether we have any path to generate=
 a
kernel binary policy that does not involve .cil intermediates and secilc in
practical environments. Is patching secilc (libsepol, to be precise)
sufficient? We know it's enough for Android, but is also true for Refpolicy
environments? There are a lot of se.* tools and I'm not sure if secilc alwa=
ys
plays the role.
