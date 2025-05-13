Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD720CCE4
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125877; cv=none; b=ZrceNdvSLinx+JWiFygkpbcsNYnMqNTUKxfKKr9iF8Ct2P+CFvhgRXduQjW4Gb8OyQOx/DTyCPgaQcN1QfZeH9sYyEjsWvbxmGp5eEpQQJnh4svVdaosl/k6uAfVL5d1wtk0YX7oVEA8gkVR7xdscxe7dLB31ag/kh+LuKEIMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125877; c=relaxed/simple;
	bh=dhOdgxB3IssQW4oUiydtbpHTRmmM2/04bM0Qh+sBe5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdg89XKuoidnMQr130hpiIYS1SLPl1Bw672yFUYccO1ShXW9gLL6UF3UB4Y8idz023ppr3qKrJN4F5iGwRAMBDeuK+8zmp7N2JtK+hbYJ6VoWSoANE7C0CKxb+uTBMwbh61LbkxhAzI8TO+zydmq1YPpQwQYSftTO144CtP9Dk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHa6VETB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHa6VETB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso7811a12.0
        for <selinux@vger.kernel.org>; Tue, 13 May 2025 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747125873; x=1747730673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhOdgxB3IssQW4oUiydtbpHTRmmM2/04bM0Qh+sBe5Q=;
        b=uHa6VETBOvOllZKlPvzY5oO8y914KE4Ygu5WavzzWRLUZbsfX8u1LlVHJcqkOvqok8
         evqj8efTuYCTkZhcXwCwJQhWZz7Ci9Sjz5HhbiRDbrDeeGofSov9dCLQs1zGkY9PSh91
         GeCr6gAHgPRYM0rMiZo0EKdk08PcI8LnTs4L6KYHof1cPEkS51Ygilh7xyzipyAnWL/Q
         QCne4VhP6wWWQDwE3GPo3cawFf8ntGdziLpXCOH4qpDM0Ju0C2qwEmku1GnSSWs1AbGX
         Sdzb+LPmqhtAeLXbQGG/vtV9PatYc+4aM1h3t58WIwD9Ucp+PFTLm+DiPZlSFoAimipb
         9nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747125873; x=1747730673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhOdgxB3IssQW4oUiydtbpHTRmmM2/04bM0Qh+sBe5Q=;
        b=ZnaWv0AIqHAuKj435rVPbT33oLuxThXbkjYkVAGnyaSF1Imn+0lIQyBQyzqtwKnw+U
         4zY++BuJyfYkzI4Ws1wuPxfgab3jJzb/zbvo0Yeu5f9pQd42xvCi3zJRWDtHQCctpHyr
         wcRNrF8hlrSYgfj7daVdGLylZa2jL//2DDkGvycoQYQcVGHTBSitghMBpfP1gM3BrKI6
         nDCfl8F+ujTVdl+tDlUdnDrEB/H5Ovdf/XcFTb4+HoJ/QpTMR7tVXlLkQUA5MgH//MeN
         roOUloTT7XX+g7BXiub8WjW0HqYS26itJtsYhitA2rhPJVdX1Ipk+F0Tc/Ad3TRNq4Hi
         gi5g==
X-Forwarded-Encrypted: i=1; AJvYcCV6z9ZpJiBi6OHfW/uLnq25p664mCel9l0yq4W5YxKezk5z0qX1MTCQSfl4uoTrdJtZCQAT0krb@vger.kernel.org
X-Gm-Message-State: AOJu0YySkENnbXBPxuN36wNFMs1JfWW/Y9xjZjeQfPiVvYQ8oTk4tdtG
	9cjp9Z/hulo508qczqaOo1XQJn4S/oAyXBJS2Cphb8AGN5Sjt+JD97T1X/NcHqOafz0Ckasll9n
	47dsDVvKwIVTti/k8DqTYYSflJYURvDyXj442irnh
X-Gm-Gg: ASbGncsED79YMZXHKMh6t3isfvqPbGmcw70eTXPvAcwiN4b4XD72Y19zspzv5wplpVN
	VvUtWSDrLzEhuDTB+JnvfcPBcAzmY+rkEDWAvUtV0xr2hxk7T8NGCFjASn4smLRRsGkLN98PnL3
	793mFyqHpegfpCOK/l/shboBMnr2kJL4+4YxXyS6LVZD7okElHzKALAUu5XEXd
X-Google-Smtp-Source: AGHT+IGR1RqIYgTP7wETJvKqbM+5YtkDWDzfzt5zW0P4ynO1kiERA0GN1rE5ory/aKnuW3laA3+DjpaB6/rW7Np9QSQ=
X-Received: by 2002:a50:cd03:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5ff6f152dfdmr52561a12.7.1747125873294; Tue, 13 May 2025
 01:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
 <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com>
 <CAP+JOzR-UyYGwizSBnHjmJj8ERweZdiJi2cWExi64W9BGa+nNg@mail.gmail.com>
 <CAEjxPJ6XxLoN5ECTOxADAQAFLYpjL1ieN6bLQ1NKTtUkRpWziQ@mail.gmail.com> <CAP+JOzR24JyOWeKHDhi6+tYbd70V2Unkw5ppDkhrb7EK2A14=A@mail.gmail.com>
In-Reply-To: <CAP+JOzR24JyOWeKHDhi6+tYbd70V2Unkw5ppDkhrb7EK2A14=A@mail.gmail.com>
From: Inseob Kim <inseob@google.com>
Date: Tue, 13 May 2025 17:44:21 +0900
X-Gm-Features: AX0GCFuCsum_hU8c1TaaM1TT8P4rhxfjk0e7tAFUDtQcsrTFFxo3lExl_FoUhKA
Message-ID: <CA+QFDK=o3_xTWnEyLm6kTKzcGrz+mMKXy1kQLNqeqiBUBHBBvw@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: James Carter <jwcart2@gmail.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Takaya Saeki <takayas@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Junichi Uekawa <uekawa@chromium.org>, 
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 1:57=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, May 12, 2025 at 10:47=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, May 12, 2025 at 10:31=E2=80=AFAM James Carter <jwcart2@gmail.co=
m> wrote:
> > >
> > > On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@chrom=
ium.org> wrote:
> > > > >
> > > > > Hello Stephen, Paul, and all libselinux maintainers.
> > > > >
> > > > > I'd like to ask your opinions about an idea to keep the semantics=
 of genfs in
> > > > > the userspace, before sending a patch to expose the new genfs_sec=
label_wildcard
> > > > > kernel capability to libselinux users in polcaps.h as
> > > > > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> > > > >
> > > > > As a background, we introduced the genfs wildcard feature to the =
kernel selinux
> > > > > in https://lore.kernel.org/selinux/20250318083139.1515253-1-takay=
as@chromium.org/
> > > > > (Thank you for your help and reviews!)
> > > > > That enabled libselinux to use wildcards in genfs rules. There we=
 changed the
> > > > > semantics of genfs with the capability enabled in the kernel spac=
e from prefix
> > > > > match to exact match with wildcards for kernel implementation sim=
plicity.
> > > > >
> > > > > I'm wondering whether we can keep the user-facing semantics of (g=
enfscon ...)
> > > > > statements in CIL files in the following way.
> > > > >
> > > > > When secilc compiles a (genfscon ...) statement to the kernel bin=
ary format, it
> > > > > adds a following `*` to the compiled kernel genfscon statement if=
 the input has
> > > > > (policycap genfs_seclabel_wildcard). If the input doesn't have on=
e, secilc does
> > > > > not add any following `*`. That keeps the behavior of (genfscon .=
..) in CIL
> > > > > from the user perspective with and without the new wildcard capab=
ility. This is
> > > > > similar to what our first kernel patch did, but done in the users=
pace by secilc
> > > > > this time. So, the (genfscon ...) keeps the backward compatibilit=
y of prefix
> > > > > match for libselinux users, while keeping the kernel implementati=
on simple.
> > > > > That would allow users to keep existing rules without modificatio=
n.
> > > > >
> > > > > I'd like to hear your opinions.
> > > >
> > >
> > > I agree with this approach. It should only be adding it when writing
> > > the kernel binary policy.
> > >
> > > > (added James to cc for the secilc question)
> > > >
> > > > I'm assuming you mean libsepol rather than libselinux. I could be
> > > > wrong, but I believe that in general policy capabilities are only
> > > > declared once in the policy and typically in the base module, and
> > > > those settings are then applied globally to all policy modules. Whi=
le
> > > > you can put one in a non-base module, it still has a global effect =
on
> > > > the final policy. Putting a policycap statement into every CIL modu=
le
> > > > that wants this behavior would possibly trigger an error (not sure
> > > > how/if libsepol/secilc handles duplicate policycap statements) and
> > > > regardless would enable it for the entire policy.

We keep backward compatibility of (genfscon ...) so they'll always be
prefix-matched. For example, (policycap genfs_seclabel_wildcard) in
./vendor/etc/selinux/vendor_sepolicy.cil won't affect how genfscon
statements in /system/etc/selinux/plat_sepolicy.cil work.

> > >
> > > The policy capability can only be declared once. It will give an erro=
r
> > > if there is a duplicate.
> > >
> > > But since the CIL modules are not compiled individually, it doesn't
> > > matter where the policy capability is declared. CIL doesn't have the
> > > concept of a base module, all modules are equal. Since Refpolicy
> > > modules are converted to CIL in the policy infrastructure, there is a
> > > base module, but that is because Refpolicy has the concept of a base
> > > module, not because CIL does.
> >
> > I think the problem is that there are multiple CIL modules shipped in
> > Android (e.g. vendor, platform, oem, ...) and more than one of them
> > might contain this policycap statement to indicate that its genfscon
> > statements should be interpreted in this manner. So the final combined
> > policy that is fed to secilc could end up with duplicates unless they
> > filter them out, or secilc is modified to ignore dups.
>
> I don't think it would be a problem to ignore duplicate policycap
> statements. It should be a fairly small patch.
> Jim

So, simply supporting this (allowing duplicated policycap statements)
will be enough even for the Android case.

--=20
Inseob Kim | Software Engineer | inseob@google.com
