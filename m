Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F85253B66
	for <selinux@vger.kernel.org>; Mon, 12 May 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069025; cv=none; b=RCYITcWqM6ArubSluaH/2GV/IFP2KKZ/IvK41vHbfevype29IZvLdGjuG51SbQKReMm91Wc8zoi6mHPZS/aFUyVGkQug1RQh+fG/nHSQxHPNMFQ/72d6ICW6suvv6W1XhCnzRepRatzXGLnFCzPl/IwN/Bp8aLn7wBpn+qfDRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069025; c=relaxed/simple;
	bh=t+aLC32KjycENNNSOYIU2zEtc6X1IxVGJkGQVTldMvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guxWbchpXjtdfiHwmFNfGZFNdQR74uC9cQ0bnaBT6IMQUz0+MKB8fV/khmtTP9hkY5DyTWddPe51nmH+lYbm4X5XQnn4iL7EeOR7/YLc1VK6Jc3YDL2T1yDCI6eVK39rARtD8Aqi+pRWVIq99amEQ2/DAmgxdZXvZgrcg7xZNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUmaruYK; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUmaruYK"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4def6435699so1100714137.2
        for <selinux@vger.kernel.org>; Mon, 12 May 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747069022; x=1747673822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+aLC32KjycENNNSOYIU2zEtc6X1IxVGJkGQVTldMvY=;
        b=RUmaruYK5+fi2mNX0tIuFwGUbBpxt8RWag3mlzHioJc5Yh2kF7n1dGk0yDeY0lSish
         zBvvM/fxQwkyI/iJ7fUj1lNDvE79Npi0AXsHWq2BbwkVe3jSiEXLP8oQ7CIOxTq7V+Qb
         /rHnB2dNZkrXw+mRmuc9z8yi2KRIiy4pwdf9QCDryI+nQZWeScz0bl/S5WV0ufRaBB6Q
         YUD2h15KFCerSp0J193wyvXZ6+leNHwNUI4G+C9UonlftSXOBnbmDw8HK+yZ/3fuN9iR
         6forlZfyWHKRJUo2GIarKfti8+B80NHy/NCeWuoqOyV0n00CWqmey5FIFpEwst9hhDw6
         wj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747069022; x=1747673822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+aLC32KjycENNNSOYIU2zEtc6X1IxVGJkGQVTldMvY=;
        b=kLjR0/tgECW6UbEXcnYI1hWugP5zb/SPUCz3LZ2mlq0XmOyMDl1kGEvPGZZK4uUOPW
         YKe4P7nP6XzEdGnkSpVO1V8JdeDOdHTat7Wk/imBf4U//HDGABonmMNyNAtS5KTEhZT4
         ldRGdNW4DoP+te82d8zsfL3t+wU7t2mk3V4dQGCsyTAwu7o3GkXkJwRwRILqDfzyaIYx
         UFUnIVw9/IL3Q99aNv1aN1zKEUeIxTVpTLTGZ6SlBrR/EQRZAZhdeYFNgLJeJsd0demm
         xXLX3hhW1MaJsQpD3rpS0KUU2qJLuBVUCW3ojim1CgFANKn1vkTWk6j5XhEQhsXjKoHx
         Q2xA==
X-Forwarded-Encrypted: i=1; AJvYcCUARcawVBMvtyP6HcUZ+jBjaO3EQGst02o+ozhC9q1lf7Frr2qKTf604DaJluyA+FdnwB6ojPDn@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrNkviAjj4MYQV96GZPpAKnY+hxGhSFB2pGRXqS/+I3fJ32RF
	NstTLvqUCEMZhyEo+fvoH/tWSalCHIVKped73d2PRv+6wyKc5hPUMqPglanjaoDx1qNiGONspra
	fVdK1AmjVZUhNlE4F5Kv0oNRTKuw=
X-Gm-Gg: ASbGnct8C8RXdjlRDKY3l7g8XDPPOrB+ccc3yYndGy5lX1+FU6RpunHUqi57KG6nBzG
	Qqtnxl5bWhGgtBmPpA+Gn8qLQTQ7JUzbePDT9K08Dcnu4mNSheWrl7EkE+N9EzoutTp/9oA2g13
	Swzm/Am2guQOhkkhm9ssm23uWtji+ddg==
X-Google-Smtp-Source: AGHT+IHhb+GrRQO4zniGwHwPn1Yj01xdgo9AX19R/qQGBq5bDnkzqhCO88j/cR33ZJynXJka/Of9cDHX8K+8cMW0GkE=
X-Received: by 2002:a05:6102:3e06:b0:4c1:9695:c7c with SMTP id
 ada2fe7eead31-4deed3ff88amr12367431137.24.1747069022049; Mon, 12 May 2025
 09:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
 <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com>
 <CAP+JOzR-UyYGwizSBnHjmJj8ERweZdiJi2cWExi64W9BGa+nNg@mail.gmail.com> <CAEjxPJ6XxLoN5ECTOxADAQAFLYpjL1ieN6bLQ1NKTtUkRpWziQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6XxLoN5ECTOxADAQAFLYpjL1ieN6bLQ1NKTtUkRpWziQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 12 May 2025 12:56:51 -0400
X-Gm-Features: AX0GCFuebXNMReHx4lia2pHJZK4TsMVRD8I75MFEaldqiKtP06g_a-daQodNZ6w
Message-ID: <CAP+JOzR24JyOWeKHDhi6+tYbd70V2Unkw5ppDkhrb7EK2A14=A@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Inseob Kim <inseob@google.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Junichi Uekawa <uekawa@chromium.org>, Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 12, 2025 at 10:31=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@chromiu=
m.org> wrote:
> > > >
> > > > Hello Stephen, Paul, and all libselinux maintainers.
> > > >
> > > > I'd like to ask your opinions about an idea to keep the semantics o=
f genfs in
> > > > the userspace, before sending a patch to expose the new genfs_secla=
bel_wildcard
> > > > kernel capability to libselinux users in polcaps.h as
> > > > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> > > >
> > > > As a background, we introduced the genfs wildcard feature to the ke=
rnel selinux
> > > > in https://lore.kernel.org/selinux/20250318083139.1515253-1-takayas=
@chromium.org/
> > > > (Thank you for your help and reviews!)
> > > > That enabled libselinux to use wildcards in genfs rules. There we c=
hanged the
> > > > semantics of genfs with the capability enabled in the kernel space =
from prefix
> > > > match to exact match with wildcards for kernel implementation simpl=
icity.
> > > >
> > > > I'm wondering whether we can keep the user-facing semantics of (gen=
fscon ...)
> > > > statements in CIL files in the following way.
> > > >
> > > > When secilc compiles a (genfscon ...) statement to the kernel binar=
y format, it
> > > > adds a following `*` to the compiled kernel genfscon statement if t=
he input has
> > > > (policycap genfs_seclabel_wildcard). If the input doesn't have one,=
 secilc does
> > > > not add any following `*`. That keeps the behavior of (genfscon ...=
) in CIL
> > > > from the user perspective with and without the new wildcard capabil=
ity. This is
> > > > similar to what our first kernel patch did, but done in the userspa=
ce by secilc
> > > > this time. So, the (genfscon ...) keeps the backward compatibility =
of prefix
> > > > match for libselinux users, while keeping the kernel implementation=
 simple.
> > > > That would allow users to keep existing rules without modification.
> > > >
> > > > I'd like to hear your opinions.
> > >
> >
> > I agree with this approach. It should only be adding it when writing
> > the kernel binary policy.
> >
> > > (added James to cc for the secilc question)
> > >
> > > I'm assuming you mean libsepol rather than libselinux. I could be
> > > wrong, but I believe that in general policy capabilities are only
> > > declared once in the policy and typically in the base module, and
> > > those settings are then applied globally to all policy modules. While
> > > you can put one in a non-base module, it still has a global effect on
> > > the final policy. Putting a policycap statement into every CIL module
> > > that wants this behavior would possibly trigger an error (not sure
> > > how/if libsepol/secilc handles duplicate policycap statements) and
> > > regardless would enable it for the entire policy.
> >
> > The policy capability can only be declared once. It will give an error
> > if there is a duplicate.
> >
> > But since the CIL modules are not compiled individually, it doesn't
> > matter where the policy capability is declared. CIL doesn't have the
> > concept of a base module, all modules are equal. Since Refpolicy
> > modules are converted to CIL in the policy infrastructure, there is a
> > base module, but that is because Refpolicy has the concept of a base
> > module, not because CIL does.
>
> I think the problem is that there are multiple CIL modules shipped in
> Android (e.g. vendor, platform, oem, ...) and more than one of them
> might contain this policycap statement to indicate that its genfscon
> statements should be interpreted in this manner. So the final combined
> policy that is fed to secilc could end up with duplicates unless they
> filter them out, or secilc is modified to ignore dups.

I don't think it would be a problem to ignore duplicate policycap
statements. It should be a fairly small patch.
Jim
