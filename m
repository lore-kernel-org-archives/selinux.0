Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B83227EA8
	for <selinux@vger.kernel.org>; Mon, 12 May 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060317; cv=none; b=uP3fBkIBiSs5ypN6BDVjEg8tHMsuKjiYS4fXRBcS1nQFb7SRVjZit5dnLl7aZM3PrJLTrxtZr+yOotSqEbbtzBcgCPb5Lb/qVWGXByFLPHsG2MdOVJSDBFcNjmVXvODJGZKuJ4tYbkkDSYYqMAgCnERUH9erfihj3tOTelPLysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060317; c=relaxed/simple;
	bh=N4PgWqb9bd8YVwPWr9HFfOginV+hot33Jl18PbRZH38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyixDpfFASHCXAmkfnU0wsIPhXhGPE3iF2nNQL5KhTu5SKPM+Ga46l7OK6ht/6xhf4IF9uOBdAH/2nfi260OdDDyGX2DIStSpeB2glwKSeoao7zPllxhEzAJrzmBGfVu/WtXjP1rRxSFpDUn86sv5gPJPZVA8+446BEw8rsBdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHWhfkGW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHWhfkGW"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c13802133so1258288a34.3
        for <selinux@vger.kernel.org>; Mon, 12 May 2025 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747060314; x=1747665114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4PgWqb9bd8YVwPWr9HFfOginV+hot33Jl18PbRZH38=;
        b=aHWhfkGWGf2Z6K69a0PRyiOqKXtDPxY6cyW2EDZJqqMeP1ZnpRYPetJ/L59a4uhym4
         mySlS2ymoX4+OL9tPAr6zhVQNhkVeB4EmISuFdmbgEBHbGvYBwTLjAWK2/egdzIdquJL
         VSrsYoqrRd2KGrRjKhw4/42MuXIo2UlEgx2xc6+mdzUc0TSrJaxzx3wniwuCJQ267MvU
         aZvEfAB8QZ4nXa9FlNbxuIoIYIyz+Xm2XS/XUTE0EkocoHgDsQjQZkZUFeVHpF0vo83X
         90etyKq493z+TMbDmf+ovOBSo4N1avzvv4ud2bs3Iu+0NPZYZ/Q8fZc68uoDyo1MhFD7
         sSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060314; x=1747665114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4PgWqb9bd8YVwPWr9HFfOginV+hot33Jl18PbRZH38=;
        b=dIuMco5GYpGE6uYVhaQMfNGGALrZ4mgRKby816xA+jVZVB/JxDH3Pa4PANMle9J0Xa
         HaqM/VThsvK1HDwlXilSu/iE1aHrpFAAtz83J3E8Acp3gj9htLjdoWYgsMtAUXmHWEzn
         U1UtvraNgSeIYAVc2SyJyNFX0sM9aKTHm+U4YRk/FmVat3RfwuxqQrQrCVHCd921yGj9
         PQpQcjbDhYh+NhjmDSUpaaVZCIAnEsPjVbECJ7gNrr/GRJ6FBLDFtvDqnqoHf2YoXFXr
         B3cUVgZWCHsS+GPdWa25isXMrSLsqRFoOq4STbxlGJTS9UEbjs2JSNogirTL1odR9bjG
         ky1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbSd+Nq8vWkRoJJkFY+0rJk+lW73QIhIxJK0aMzTFU3zJnRfe9b6LJ12UnnFBaWy871sKkpcIv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5T9WpKJci0npNOxFWd7KL0GSivSmpm9//8SCugCsXTIpuVpV
	ByFv3c2o/F6vFJyDj/HkeQN9preHBp20GA8pLwAEvEQYilxwYiCJY91Lvh+gLvmQfsE/2eXDQ8/
	IbfxR2KQJ89UGmBx2UplurbpWFG8=
X-Gm-Gg: ASbGncsCq+O5AJMVxqJ4PIM5TTpABcQot56TSwxiVDlcNw/Uvf9VQgxsKsQrpG0XDKu
	24pvbPe5clNKPH7Fi4ktyWIVQ4HNXDLtLUZqGpd1mpH0enmCoCDe2ipx2jChY/yrLwtZi6QvkZW
	JOEwT04zqBPlcedE3mQ0p0Pflxbq6LMw==
X-Google-Smtp-Source: AGHT+IGo857ErwedjhIqFhPNsf7Q27GYhxJ5W95lFg2FBS7SNTt8ATBJcoUjdwUYqX2cRZsyacRdFkKBCo9l4Uk4j2E=
X-Received: by 2002:a05:6870:a590:b0:2d5:1725:f529 with SMTP id
 586e51a60fabf-2dba44c3190mr8389896fac.27.1747060313175; Mon, 12 May 2025
 07:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
 <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 12 May 2025 10:31:42 -0400
X-Gm-Features: AX0GCFsF8pOJM7qMZ5EDPQbgoFcCRAMDUFT1FMSaPshlVifCJK_Q5JyQcjAg-bk
Message-ID: <CAP+JOzR-UyYGwizSBnHjmJj8ERweZdiJi2cWExi64W9BGa+nNg@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Inseob Kim <inseob@google.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Junichi Uekawa <uekawa@chromium.org>, Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@chromium.or=
g> wrote:
> >
> > Hello Stephen, Paul, and all libselinux maintainers.
> >
> > I'd like to ask your opinions about an idea to keep the semantics of ge=
nfs in
> > the userspace, before sending a patch to expose the new genfs_seclabel_=
wildcard
> > kernel capability to libselinux users in polcaps.h as
> > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
> >
> > As a background, we introduced the genfs wildcard feature to the kernel=
 selinux
> > in https://lore.kernel.org/selinux/20250318083139.1515253-1-takayas@chr=
omium.org/
> > (Thank you for your help and reviews!)
> > That enabled libselinux to use wildcards in genfs rules. There we chang=
ed the
> > semantics of genfs with the capability enabled in the kernel space from=
 prefix
> > match to exact match with wildcards for kernel implementation simplicit=
y.
> >
> > I'm wondering whether we can keep the user-facing semantics of (genfsco=
n ...)
> > statements in CIL files in the following way.
> >
> > When secilc compiles a (genfscon ...) statement to the kernel binary fo=
rmat, it
> > adds a following `*` to the compiled kernel genfscon statement if the i=
nput has
> > (policycap genfs_seclabel_wildcard). If the input doesn't have one, sec=
ilc does
> > not add any following `*`. That keeps the behavior of (genfscon ...) in=
 CIL
> > from the user perspective with and without the new wildcard capability.=
 This is
> > similar to what our first kernel patch did, but done in the userspace b=
y secilc
> > this time. So, the (genfscon ...) keeps the backward compatibility of p=
refix
> > match for libselinux users, while keeping the kernel implementation sim=
ple.
> > That would allow users to keep existing rules without modification.
> >
> > I'd like to hear your opinions.
>

I agree with this approach. It should only be adding it when writing
the kernel binary policy.

> (added James to cc for the secilc question)
>
> I'm assuming you mean libsepol rather than libselinux. I could be
> wrong, but I believe that in general policy capabilities are only
> declared once in the policy and typically in the base module, and
> those settings are then applied globally to all policy modules. While
> you can put one in a non-base module, it still has a global effect on
> the final policy. Putting a policycap statement into every CIL module
> that wants this behavior would possibly trigger an error (not sure
> how/if libsepol/secilc handles duplicate policycap statements) and
> regardless would enable it for the entire policy.

The policy capability can only be declared once. It will give an error
if there is a duplicate.

But since the CIL modules are not compiled individually, it doesn't
matter where the policy capability is declared. CIL doesn't have the
concept of a base module, all modules are equal. Since Refpolicy
modules are converted to CIL in the policy infrastructure, there is a
base module, but that is because Refpolicy has the concept of a base
module, not because CIL does.

Jim
