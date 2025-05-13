Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94885243376
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141706; cv=none; b=Uo28WpSyUNH8goDwWAff1fwYiGTZ+1g9vEzuLsLYzRbwFapnpd02s/7i4ELvWYX5v1kssRhUGy55Rb8HSzDm0QIdftgVuYmwXf5FGR8Ke1xEAbRAxVSznJlWYMcXl6Qaz7eTz3zf9+Dw/kVGUz6+9MGVatYDSwAq4x3J0HTbM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141706; c=relaxed/simple;
	bh=pnq+MJ7uQWh77hLE75l7uMgCFSOv933tLTmCZgkPNDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2Fq04UEImeu5llKw4jQX5JhyMYxlFpbXz726q5nHgrJ56nZ2AaepCGrYg9TbgZfwqIgVu+ldnUclrpXGqTBCFhasJezlv6oWHd+9DexBlr7gmz5kqKDuNttmF3q4Yl+b42r3C4U1tMzHkgCDHwWY6/TQXcp9I4LG9JBLKHjDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgonpITm; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgonpITm"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f9832f798aso4354003b6e.2
        for <selinux@vger.kernel.org>; Tue, 13 May 2025 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747141703; x=1747746503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnq+MJ7uQWh77hLE75l7uMgCFSOv933tLTmCZgkPNDQ=;
        b=JgonpITmts5iRLu8azwfR0kKhrVmJXo0ueVAuDXouT4Rl95+02mdFX51iFbmm7/KNY
         A4JMdJNl6OJ6fIGgpwtNxnyAchqcRxGOyA65LKRZPcUL8h60rTOehfgBQmPKpOI+g9P0
         Ef2e/mvWU6F8uY2yJ48cBXTXAgRQCnksY2MzF/gJcJc34hhE0O+5K2lx1Q6PtXMw7Yi5
         HKqnDUVutP0HeMRNSStWXnj/k7l66iQg6qLgHy+PztTk6h2JhjQ9WZIragQKBrRmwTKY
         s3s6SHU6833zpJRJsymO8sqb1j7cNSB/y6abs3Heihb2cbfZpbb2po2wrvGHIsATjG1l
         wQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747141703; x=1747746503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnq+MJ7uQWh77hLE75l7uMgCFSOv933tLTmCZgkPNDQ=;
        b=Kh7jUsbQWcsjmYRdQ1ZV/lrMaylhxPJVGRWbvqjQM4Y7X0EyuRBWBglg5fwa3tv3VT
         XxKmey0Gm5BoswiaiOj1IoRYzZEVJfEAY7B0Yy1yhSQ0YrLVIDT/Zp66IYu/mwtZY7mF
         l/d53jApE+cSe1Pd+HhlsB+J+SCGB9f51xjP6B9MCJnDGmP9v97JpfTMNkaD1DDtsAFH
         cT8kuoRw7PIxMQDsHlFPbvhA1KWBzka46yv6XMxNJfRXf+9cngMST21XDyqwxFeTdli1
         c9Nrt3cTDYX6eZIViUQPBCyzhQk2fvuVNQ9FNZcpS/q7UbyuLlNuRw/J/RQDefNnLT84
         2LCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXDwt2IOSL0rmLB09qvXVr1bE33TCPmFgMLJofJYxz9PdJey1mwqhFZl28QVInAnP9rCuTvp+P@vger.kernel.org
X-Gm-Message-State: AOJu0YxBb1uDegQtnuIstFfCbabu/EeuC8PLo0WHfr5KElcy9DupOKnT
	ZjEITgAPPWqG9Y1IEJINvKmRgZFUj5HS5it5MXBsYjiIR7di8kKxirCsz3v/skes2N+e4js6kdN
	16etdNATbDk+QFf8/CBsMr3OIOTY=
X-Gm-Gg: ASbGncvfPvkYvkRAJaBX0dckyaUCi4kgZXQcmEZlV8f9CW2SoWL328UzVtvE7Pxithb
	yZPiBlJ+6bFwekXMu5fdSPlXJ8N180BHtXcJAAI/quodv4XRU7yM3JOOglYRqo74WxhDZYo1wOi
	pN+cRhdP85pJNBuBWy62uXI1eX5W0cHQ==
X-Google-Smtp-Source: AGHT+IGktlytDzAqr/BJwdNr1GdNtCSRFPBBu0KXsfqwJBDM5HVi2TK2GUPJeOGtg3uElKQFwilQmyr4jmNtqnKVroI=
X-Received: by 2002:a05:6808:1587:b0:3f3:f90b:f19d with SMTP id
 5614622812f47-4037fec54f1mr9935301b6e.33.1747141703363; Tue, 13 May 2025
 06:08:23 -0700 (PDT)
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
 <CA+QFDK=o3_xTWnEyLm6kTKzcGrz+mMKXy1kQLNqeqiBUBHBBvw@mail.gmail.com> <CAH9xa6cSNsiDx5Wq+nhZQwkkAPxh3bcy5mpBBbYTbaGnoZ3smg@mail.gmail.com>
In-Reply-To: <CAH9xa6cSNsiDx5Wq+nhZQwkkAPxh3bcy5mpBBbYTbaGnoZ3smg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 May 2025 09:08:11 -0400
X-Gm-Features: AX0GCFvx5s82ngLi48CGCxS-ZDucT70Tn0cw2KdVj5YisUeV3XillyfGvBzI3pk
Message-ID: <CAP+JOzSPjmdigKyA6T+2Wibj6v=SPdsEJ7i59jpNoS08GYYpYw@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: Takaya Saeki <takayas@chromium.org>
Cc: Inseob Kim <inseob@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Junichi Uekawa <uekawa@chromium.org>, 
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 5:34=E2=80=AFAM Takaya Saeki <takayas@chromium.org>=
 wrote:
>
> On Tue, May 13, 2025 at 5:44=E2=80=AFPM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > On Tue, May 13, 2025 at 1:57=E2=80=AFAM James Carter <jwcart2@gmail.com=
> wrote:
> > >
> > > On Mon, May 12, 2025 at 10:47=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Mon, May 12, 2025 at 10:31=E2=80=AFAM James Carter <jwcart2@gmai=
l.com> wrote:
> > > > >
> > > > > On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@c=
hromium.org> wrote:
> > > > > > >
> > > > > > > Hello Stephen, Paul, and all libselinux maintainers.
> > > > > > >
> > > > > > > I'd like to ask your opinions about an idea to keep the seman=
tics of genfs in
> > > > > > > the userspace, before sending a patch to expose the new genfs=
_seclabel_wildcard
> > > > > > > kernel capability to libselinux users in polcaps.h as
> > > > > > > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> > > > > > >
> > > > > > > As a background, we introduced the genfs wildcard feature to =
the kernel selinux
> > > > > > > in https://lore.kernel.org/selinux/20250318083139.1515253-1-t=
akayas@chromium.org/
> > > > > > > (Thank you for your help and reviews!)
> > > > > > > That enabled libselinux to use wildcards in genfs rules. Ther=
e we changed the
> > > > > > > semantics of genfs with the capability enabled in the kernel =
space from prefix
> > > > > > > match to exact match with wildcards for kernel implementation=
 simplicity.
> > > > > > >
> > > > > > > I'm wondering whether we can keep the user-facing semantics o=
f (genfscon ...)
> > > > > > > statements in CIL files in the following way.
> > > > > > >
> > > > > > > When secilc compiles a (genfscon ...) statement to the kernel=
 binary format, it
> > > > > > > adds a following `*` to the compiled kernel genfscon statemen=
t if the input has
> > > > > > > (policycap genfs_seclabel_wildcard). If the input doesn't hav=
e one, secilc does
> > > > > > > not add any following `*`. That keeps the behavior of (genfsc=
on ...) in CIL
> > > > > > > from the user perspective with and without the new wildcard c=
apability. This is
> > > > > > > similar to what our first kernel patch did, but done in the u=
serspace by secilc
> > > > > > > this time. So, the (genfscon ...) keeps the backward compatib=
ility of prefix
> > > > > > > match for libselinux users, while keeping the kernel implemen=
tation simple.
> > > > > > > That would allow users to keep existing rules without modific=
ation.
> > > > > > >
> > > > > > > I'd like to hear your opinions.
> > > > > >
> > > > >
> > > > > I agree with this approach. It should only be adding it when writ=
ing
> > > > > the kernel binary policy.
> > > > >
> > > > > > (added James to cc for the secilc question)
> > > > > >
> > > > > > I'm assuming you mean libsepol rather than libselinux. I could =
be
>
> Yes, thanks for the correction.
>
> > > > > > wrong, but I believe that in general policy capabilities are on=
ly
> > > > > > declared once in the policy and typically in the base module, a=
nd
> > > > > > those settings are then applied globally to all policy modules.=
 While
> > > > > > you can put one in a non-base module, it still has a global eff=
ect on
> > > > > > the final policy. Putting a policycap statement into every CIL =
module
> > > > > > that wants this behavior would possibly trigger an error (not s=
ure
> > > > > > how/if libsepol/secilc handles duplicate policycap statements) =
and
> > > > > > regardless would enable it for the entire policy.
> >
> > We keep backward compatibility of (genfscon ...) so they'll always be
> > prefix-matched. For example, (policycap genfs_seclabel_wildcard) in
> > ./vendor/etc/selinux/vendor_sepolicy.cil won't affect how genfscon
> > statements in /system/etc/selinux/plat_sepolicy.cil work.
> >
> > > > >
> > > > > The policy capability can only be declared once. It will give an =
error
> > > > > if there is a duplicate.
> > > > >
> > > > > But since the CIL modules are not compiled individually, it doesn=
't
> > > > > matter where the policy capability is declared. CIL doesn't have =
the
> > > > > concept of a base module, all modules are equal. Since Refpolicy
> > > > > modules are converted to CIL in the policy infrastructure, there =
is a
> > > > > base module, but that is because Refpolicy has the concept of a b=
ase
> > > > > module, not because CIL does.
> > > >
> > > > I think the problem is that there are multiple CIL modules shipped =
in
> > > > Android (e.g. vendor, platform, oem, ...) and more than one of them
> > > > might contain this policycap statement to indicate that its genfsco=
n
> > > > statements should be interpreted in this manner. So the final combi=
ned
> > > > policy that is fed to secilc could end up with duplicates unless th=
ey
> > > > filter them out, or secilc is modified to ignore dups.
> > >
> > > I don't think it would be a problem to ignore duplicate policycap
> > > statements. It should be a fairly small patch.
> > > Jim
> >
> > So, simply supporting this (allowing duplicated policycap statements)
> > will be enough even for the Android case.
> >
> > --
> > Inseob Kim | Software Engineer | inseob@google.com
>
> Thank you all, so I think the idea seems acceptable from both perspective=
s of
> Refpolicy and Android. I'd like to ask whether we have any path to genera=
te a
> kernel binary policy that does not involve .cil intermediates and secilc =
in
> practical environments. Is patching secilc (libsepol, to be precise)
> sufficient? We know it's enough for Android, but is also true for Refpoli=
cy
> environments? There are a lot of se.* tools and I'm not sure if secilc al=
ways
> plays the role.

checkpolicy is the other way to generate a kernel binary policy, but
if you patch libsepol (specifically, genfs_write() in write.c) you'll
take care of both at the same time.
Jim
