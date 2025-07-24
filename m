Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB02E1742
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366278; cv=none; b=WIamVoU47DwmBt71gBN+F6ik09EgZQuqIBETSYsePN15agwcFV5PUhVmJFwABgvhmFE7hSydY49c1a+GHkLJWfVKPn9r2c3dtX8vAZ6i0sL5Fz0snlLmw2KzlmqrIX6JRWaA4YHgc5JGtbSRYfaR+O9EvCtYqDfKyJiEKmaEW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366278; c=relaxed/simple;
	bh=KSH4vWda8H7uBcI+hcidtF8BO6/8ALd1jaAq0OGt5NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Umt2egLEy6YBNVzhFjpGWeQ7bejo6zQmGxGGtrUZ27/iE7GrN3HgH/kQYnuQzKnR3qjCiUjOCEySB8ItfkJQr2ptp5HHrtMdpV7Tw4uG3OX7u46K0F6yqOJDyad8ELmlE9kKzRaXhvLZIl3JXF+WvRNBJ02v2z/cw5Ojm00hrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUqxa3FQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUqxa3FQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso8407235ad.0
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753366276; x=1753971076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSyg5lw6C9eZ2bR6BGhDqvIHOQ1TbLlLdtWPLZYmgU4=;
        b=HUqxa3FQ1J95YbDq+gArss5O3Cz93OfLOs7KEvy/Xchh/b3bbJdpwc0J3ckVNjOfWL
         +s9qTw8jc6cldhCa4tUFb8VBGVRApKyeqVsD55Hqs3D6nvcNMJ0/48SeszWRwhv1/mfF
         MPVbpJ4D6Rd9q0MYHGgwkJEl/MPF8vFlkE5cojPIsBrnFCj2F9ebq1ZTzQNlitZARXcs
         +L9dIBCul2SrhRAVrU1HxFCMhEShH4HJLBgLZd1NNeNi5SUahiySsqURc4+GEcYzGHl5
         JU/WprXAx1jBU1CX33uWzr7/XplC2zhOCQcP6WMrYxzu++s6WyaC/R8QpVmz4vbzstBn
         j8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366276; x=1753971076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSyg5lw6C9eZ2bR6BGhDqvIHOQ1TbLlLdtWPLZYmgU4=;
        b=fVNlbU0nnQRbqFRwe+3KdXpOq34RJIvkRjozjbvN1XTG/tUdFI0moLvOj/pf27Z/FV
         msy2p0fKsmBn5nvpe/VgPqHti65a5444/h0Vfw0cMIwCvf4U64rw+eWCr0Rh+I7W46qW
         mJCyXzNQkv2O09WmEyd0Fq5RIyxDCh3cJR7BjWnCUhGHNQulhtyW6IAzlzwsyLt1Vx0C
         47ijowaR7/DvsV/X4BgQWUxjGLmK50mUN2c1lilTXCoGolDxvufz4jxDpHA4q1GKPKM7
         pKA+aTodsMX4Ukqql4kZu93KJRdI1RCnv1ADEzVqRjAgiLzce9TwkXkLK1rv6ELspzeq
         ZDrQ==
X-Gm-Message-State: AOJu0YxKcsSy5zK7HjAEnnQnQyvZO/TJr1HlCVBDnwbEOBaayeigyNGa
	NbAMhWBlI7x7nVog7rnMQfs4rEUYxH1cvtDdkaXhoURw9zbixkiSrOr6eyfo+lVY/Hd9ATZJATx
	BVPZC1pUbyGniQa1aM/8McoBC8FNPb1fRQA==
X-Gm-Gg: ASbGncvk13Devv/eur4tGBDsIvCkZ1IcGgKqGPOoyX8hOYGUZwFJDC2igDA0GLlbSlg
	1wCR0waaMJTgK5lYC3f0M5e7/1evxcX6On1Tyhu+PAvAQ18SY2hCtHO+CUbNBcngSCUm00P+eNK
	s2b1kMS1Cl9A/d1O9B9ae8zBXhyswI8v5Ioo0EzRelfUIQVUO/+hyc8rDGyfOwbdkKGhe0mQPA9
	ojVl6s=
X-Google-Smtp-Source: AGHT+IGFrRIg6R5Xacr5dWMcPY5J26qk8pPTYVQ4ocy4U2i5LzavEVDve/1zXO4kSxic/tFQN/BPTnxuA12SB5+sDgo=
X-Received: by 2002:a17:903:2444:b0:235:1b91:90a3 with SMTP id
 d9443c01a7336-23f98161932mr90586765ad.7.1753366276276; Thu, 24 Jul 2025
 07:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724084044.23390-1-lautrbach@redhat.com>
In-Reply-To: <20250724084044.23390-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 10:11:05 -0400
X-Gm-Features: Ac12FXxTBYw0lT8h3Om8sfT-t-TYZt7HImWiPhPHedEFNSnBLX-Y50aM0kWpHHY
Message-ID: <CAEjxPJ5+2r+nrSv4w757=Ue6gj0XX0WtOKSyp3-UUfQ2rzksQA@mail.gmail.com>
Subject: Re: [PATCH] Update CONTRIBUTING.md
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:52=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> This is based on
> https://github.com/SELinuxProject/selinux/wiki/Contributing with
> preserved "Developer Certificate of Origin" part
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  CONTRIBUTING.md | 51 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index 575410bf8c3d..c501cf842dcd 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -4,18 +4,31 @@ Contributing to the SELinux userspace project is a simi=
lar process to
>  other open source projects. Bug reports, new features to the existing
>  code, additional tools, or updated documentation are all welcome.
>
> -You can find a list of open issues where you might contribute to the SEL=
inux kernel code at
> -https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinu=
x userspace code at
> -https://github.com/SELinuxProject/selinux/issues.
> +You can find a list of open issues to the SELinux userspace code at
> +https://github.com/SELinuxProject/selinux/issues
>
> -See the SELinux userspace
> -[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
> -information on mailing lists, documentation, and other resources.
> +See the SELinux kernel [Getting Started](https://github.com/selinuxproje=
ct/selinux-kernel/wiki/Getting-Started)
> +guide if you want to contribute to SELinux kernel development instead.
> +
> +## Mailing list
> +
> +SELinux has a public mailing list for developers, subscribe by sending a=
n email to
> +[selinux+subscribe@vger.kernel.org](mailto:selinux+subscribe@vger.kernel=
.org).
> +It is generally wise to read relevant postings to the list before beginn=
ing any
> +area of new work. Searchable mailing list archives are available externa=
lly at
> +https://lore.kernel.org/selinux/ . Patches for SELinux are tracked via
> +https://patchwork.kernel.org/project/selinux/list/ .
> +
> +## IRC
> +
> +An unofficial SELinux IRC channel is
> +[\#selinux](https://web.libera.chat/?channel=3D#selinux) on [Libera.Chat=
](https://libera.chat/).
>
>  ## Reporting Bugs
>
> -All bugs and patches should be submitted to the [SELinux mailing
> -list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org.
> +All bugs and patches should be submitted to the
> +[SELinux mailing list](https://lore.kernel.org/selinux) at
> +[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
>
>  When reporting bugs please include versions of SELinux related libraries=
 and
>  tools (libsepol, libselinux, libsemanage, checkpolicy). If you are
> @@ -23,17 +36,20 @@ using a custom policy please include it as well.
>
>  ## Compiling
>
> -See README.md for instructions on how to compile and test this project.
> +There are a number of dependencies required to build the userspace
> +tools/libraries. Consult the [README.md](https://github.com/SELinuxProje=
ct/selinux/blob/main/README.md)
> +for the current list of dependencies and how to build the userspace code=
.
>
>  ## Contributing Code
>
> -After obtaining the code of the repository (see below), create a patch
> -against the repository, and post that patch to the [SELinux mailing
> -list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org. When =
preparing
> -patches, please follow these guidelines:
> +After cloning the code of the repository (see below), create a patch aga=
inst the
> +repository, and post that patch to the
> +[SELinux mailing list](https://lore.kernel.org/selinux) at
> +[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
> +When preparing patches, please follow these guidelines:
>
> --   Patches should apply with -p1
> --   Must apply against HEAD of the master branch
> +-   Patches should apply with git am
> +-   Must apply against HEAD of the main branch
>  -   Separate large patches into logical patches
>  -   Patch descriptions must end with your "Signed-off-by" line. This mea=
ns your
>      code meets the Developer's certificate of origin, see below.
> @@ -43,10 +59,7 @@ design on the mailing list prior to submitting the pat=
ch.
>
>  ## Development Repository
>
> -Git is a modern source code management system. For more information
> -about Git please see the Git website.
> -
> -To get an anonymous checkout of the SELinux userland repository you can
> +To get a copy of the SELinux userland repository you can
>  run:
>
>      $ git clone https://github.com/SELinuxProject/selinux.git
> --
> 2.50.1
>
>
