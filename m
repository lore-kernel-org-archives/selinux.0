Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881218EFD4
	for <selinux@vger.kernel.org>; Mon, 12 May 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061257; cv=none; b=WJmTIrBAT2+iDsCLpOxE2OouyDf8cZznmtFZK5Zm0rW7+NMzCheYAQnaSTC4DyBo7Ea5alGXPsmsHvp+dQUVZDACWohGcSlmo3v2eHdWs8g9VHb5M+0ist+dSQ+s4rHxJGbx0j3rPGTw1ddKyb+aNNp2rmbqHKxtIoie9XVC0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061257; c=relaxed/simple;
	bh=3AGbNYwLNZUasCnCxIGh2s2oY539dbekO5cHQlm9n6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hum08NLk/BYNSt3JP87h2fdgxdLtLMb1QnXFwVkmuanYu1QBl+X2CtBfkTa55ZlEvsnxwrAGrgmuAquAoWrHGvMPAlO479iAOhJN4EFmhapyGZZR/A07eZ1jLlCz98k/Zl2TfoH1wzixrL7WZn5ILO/Q53Wf9YeBqM2MphYdpeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9X/k0+f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9X/k0+f"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so5175064a91.3
        for <selinux@vger.kernel.org>; Mon, 12 May 2025 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747061255; x=1747666055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AGbNYwLNZUasCnCxIGh2s2oY539dbekO5cHQlm9n6U=;
        b=F9X/k0+fd/Cj/u7v/tIcnypwzL2YSpAbObTjVrzc4e1YBJ5XRzvHKQHzEI3XIJneZH
         ujEd1KK36sU6f9rb9DOH7UDOBkctjVAxlOuo5CfAYiSGP1oheETpsGH4fGEgjxLBtfaf
         NqdcAvXGRuDP8gSldUpn4I/6WjYKOSnZfUWHfVOUMosuos3YrZMcyNDa6GYO6BzCzD0V
         0uGQrMAl9I63qgV6t190biClUI0DFTvX2jUtPHqb1w7KkEZg9qcBf8O82P7dyhp+mZPG
         pGEFG4pj0xem/nDo3NyBQ1lyJ742iT+CN6uxdOfJXlrh0kU/uw9jnQ8bSERSYiVj6lph
         8HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061255; x=1747666055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AGbNYwLNZUasCnCxIGh2s2oY539dbekO5cHQlm9n6U=;
        b=m59I3ayDsu3e8p9zgGA1T0hLCrf51CbOE2MLdzKl8QmsXDwB+RuMRfWZMwaxPAa+R+
         0Tn1+nHGq6shS/z5ZH4j4L0Q463vbzVYaDCAhlfxFjy9yZ0e4aNUkL9OkACPKq2JABwW
         XTDlsHKCsDBVqw11XgVawFWtsu25qpleWh0LjkUxJgjsvxL7EX/NL3uEyVq3VERSrs//
         Ze4eArIPGls3P9zMKU6/aH+x194gBHIVC/IzyjS/KxbJ4Cy3RuU9JrV1bJ4hhwOISjvZ
         5KZjsEnyk6nkGLeOmKeC0qK9t6npdncd0N8j2eyzWhJP48T+CdvKU57EB1Io6pviIMct
         IZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgxjdzPGTSS7pqOgg1+ydANpZPkUa0CBQx1pN9riv8r4op3Z61r2vAU1gbDHc/H0Tezox+UWQD@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEv/P6fg9Nvnxlvc3UwKSA6W+0FnR877A4TMsRDlmky/voM+6
	h1HZIgT5MLdk2JfgpWbAPwdNCNoU0qTO2DkitO7MBfCAStRqo3gNZsmbT1SA5r/AEmClUJu2pQ0
	GKjlhfSkNY6iztRRV/DrF5U/HlII=
X-Gm-Gg: ASbGncs3KwiLswnnqOU8P/zvSGafsXRD3aQm+3M3Q0B9tlcUWbpGZIv11XfeaCMbgld
	3QglQ77xHnUFnvcBlX64QIO1NgPsVey1hzEPJQKE9HPyUqLOO0uYYo2VZWBC5gJ5BiKyJbx9u2q
	uXen1fleCSsgbIG0+7pZovqFT9B+SvsOSy
X-Google-Smtp-Source: AGHT+IGegz2TQTe4dq+frwedwYw72BmYBhwsQYcC1eLfGLS54dPyr0FdgQzkUJcN2OiTsvcUhJoodS+ydDWVJnZH7I4=
X-Received: by 2002:a17:90b:268a:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-30c3d646aa1mr20577091a91.28.1747061255130; Mon, 12 May 2025
 07:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
 <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com> <CAP+JOzR-UyYGwizSBnHjmJj8ERweZdiJi2cWExi64W9BGa+nNg@mail.gmail.com>
In-Reply-To: <CAP+JOzR-UyYGwizSBnHjmJj8ERweZdiJi2cWExi64W9BGa+nNg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 12 May 2025 10:47:22 -0400
X-Gm-Features: AX0GCFvwM6c8YFVtojIdsOprZ4WJCq7RoL3sS5KBEaxJRuNdNZWZw_g_gHhrZMc
Message-ID: <CAEjxPJ6XxLoN5ECTOxADAQAFLYpjL1ieN6bLQ1NKTtUkRpWziQ@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: James Carter <jwcart2@gmail.com>
Cc: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Inseob Kim <inseob@google.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Junichi Uekawa <uekawa@chromium.org>, Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:31=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@chromium.=
org> wrote:
> > >
> > > Hello Stephen, Paul, and all libselinux maintainers.
> > >
> > > I'd like to ask your opinions about an idea to keep the semantics of =
genfs in
> > > the userspace, before sending a patch to expose the new genfs_seclabe=
l_wildcard
> > > kernel capability to libselinux users in polcaps.h as
> > > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> > >
> > > As a background, we introduced the genfs wildcard feature to the kern=
el selinux
> > > in https://lore.kernel.org/selinux/20250318083139.1515253-1-takayas@c=
hromium.org/
> > > (Thank you for your help and reviews!)
> > > That enabled libselinux to use wildcards in genfs rules. There we cha=
nged the
> > > semantics of genfs with the capability enabled in the kernel space fr=
om prefix
> > > match to exact match with wildcards for kernel implementation simplic=
ity.
> > >
> > > I'm wondering whether we can keep the user-facing semantics of (genfs=
con ...)
> > > statements in CIL files in the following way.
> > >
> > > When secilc compiles a (genfscon ...) statement to the kernel binary =
format, it
> > > adds a following `*` to the compiled kernel genfscon statement if the=
 input has
> > > (policycap genfs_seclabel_wildcard). If the input doesn't have one, s=
ecilc does
> > > not add any following `*`. That keeps the behavior of (genfscon ...) =
in CIL
> > > from the user perspective with and without the new wildcard capabilit=
y. This is
> > > similar to what our first kernel patch did, but done in the userspace=
 by secilc
> > > this time. So, the (genfscon ...) keeps the backward compatibility of=
 prefix
> > > match for libselinux users, while keeping the kernel implementation s=
imple.
> > > That would allow users to keep existing rules without modification.
> > >
> > > I'd like to hear your opinions.
> >
>
> I agree with this approach. It should only be adding it when writing
> the kernel binary policy.
>
> > (added James to cc for the secilc question)
> >
> > I'm assuming you mean libsepol rather than libselinux. I could be
> > wrong, but I believe that in general policy capabilities are only
> > declared once in the policy and typically in the base module, and
> > those settings are then applied globally to all policy modules. While
> > you can put one in a non-base module, it still has a global effect on
> > the final policy. Putting a policycap statement into every CIL module
> > that wants this behavior would possibly trigger an error (not sure
> > how/if libsepol/secilc handles duplicate policycap statements) and
> > regardless would enable it for the entire policy.
>
> The policy capability can only be declared once. It will give an error
> if there is a duplicate.
>
> But since the CIL modules are not compiled individually, it doesn't
> matter where the policy capability is declared. CIL doesn't have the
> concept of a base module, all modules are equal. Since Refpolicy
> modules are converted to CIL in the policy infrastructure, there is a
> base module, but that is because Refpolicy has the concept of a base
> module, not because CIL does.

I think the problem is that there are multiple CIL modules shipped in
Android (e.g. vendor, platform, oem, ...) and more than one of them
might contain this policycap statement to indicate that its genfscon
statements should be interpreted in this manner. So the final combined
policy that is fed to secilc could end up with duplicates unless they
filter them out, or secilc is modified to ignore dups.
