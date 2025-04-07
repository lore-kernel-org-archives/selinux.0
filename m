Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2522332D
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053046; cv=none; b=DPlXoWzd8UlJ3fHz5cKqeGhtovIRoG1jVwq7xmGxo2bIUxepuWwv4WwAzFbGPdIJlMTM0ewWnk585LtChxk2Q+bZ7nMzTEheHtulBdHuJZ5VmviucFVITFIixUYF56a8Z4JUr6KWA3Wva7QO0woqDCLrY8yc/+HuLznhJCuSHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053046; c=relaxed/simple;
	bh=oyQiUYgNZEUIQo9u3/NoZh2W2/i4tDla/wyhIlLO55U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z074d5MHEhqoXHGu9zqKq62xB0+lYkjEn3llWEypVd4BUZmKmHrjo0YDLVgR2Od3RksuauBrRSCbjVwJzlnVvWDVkvC4QcNpCIgNPteh4wTZne/vZfQpsxqdpXnWerRZW3CWYTvNnhxNLLkVhB1be8w3rlREBR9w+wXBr8w3DVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3OVd5J5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3OVd5J5"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso4014245a91.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744053044; x=1744657844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyQiUYgNZEUIQo9u3/NoZh2W2/i4tDla/wyhIlLO55U=;
        b=a3OVd5J549KpR0/9HIxGNMSWenJu2qvzE+F/hV4QEKKpCDwVct212ScCdqhhFQtZg9
         JkVjva8rXEke6v55NVmWVmKFjHmk9AJqh6J8aj6uGFEbesoL2gzKM4B2TmmD5gOMXfeS
         Ypn5BojJBBBQuYstjiUXM50nlgWxoKIOAvrZT5Bou55Hg+5c5MkDHteO6LXgPtKYL5Uf
         hPNG11UOA4BdOSY9IufH4kL/dD3tCP6TLk74w89A8gB7FCkhlN3hxyfMeaZm/fkHaL6U
         G3DiWX0GrmNXYCvRZoY9t/z0oZSTyrQoYgqwjF/mFRi0ijtOStZlf3gk41O/TJVZAzWG
         e31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053044; x=1744657844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyQiUYgNZEUIQo9u3/NoZh2W2/i4tDla/wyhIlLO55U=;
        b=BNgN8oKETNDz0ZhO1UQEDG86LuibCmbNb1uOJvB2lcAHG19fa4/ub3a7b0mwPE/i3O
         BLIpK/Zfr/JFf7fQAjkvXbThCgpPxyl1h7VHc7essj8eFaZlEGS1noW2k1SuN2JLsHXF
         nKzwNZgPBtNGgg0PtY9a7ka8I5fA4WnCM5u+xrEFDxSHEJgTh4Tnvz0zHybWsSE+1AEF
         TZeDgenkIePn03afmfbrDacU/X6Wtdu1TS7zGRR1F8v9d/EgBNlUKH59ncXdctFFbvMy
         ujtH5NnL5KGGOZMKP+XWclucqmHQvBieW6QYfEBe9ndTsDKbBfZ31zgMfpg5zxstf/zY
         sHkQ==
X-Gm-Message-State: AOJu0YwCh7t9+hHsjHqGHXVUUhZeZiRJpTnv6xALpQuU6PRHNik5QcBM
	nVj/hzx2YedF1aO5WozdicRA1JRN2phZ/PJoRDcBrhL8iutz69Xwryo9odNSOhGYYt7PtmA3acn
	9/fd9bu+zRA+38NgIyhz481gu8HM=
X-Gm-Gg: ASbGncuI4RZqfJzyAIyrM0fVi4X+avHW6NRFHOT0nuvhNgobzQ70aMteFfDa7HmrKu0
	5jFdkA0lkfAnAjhAHbm98bDNii7ldf80c6KUAO/sspAaiJ2+gIlagNswMxAnjTssmW8PQ3A+5SW
	iYeaWgeITYWNtWV0hFF/xyrDLFyQ==
X-Google-Smtp-Source: AGHT+IGhJqhtZNJpDd+u+CN6emrEzSrzL07lGPHq5lekznb5bpfjU7sUb6HwFR37HrVo5be31D43jXxAZ9jr8RnDaoY=
X-Received: by 2002:a17:90b:2710:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-306a61657f8mr19818442a91.18.1744053044559; Mon, 07 Apr 2025
 12:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed009068-754c-428f-8ef3-3b79dc9ec8b3@o1oo11oo.de>
 <CAEjxPJ4333bqBye1iV90hopdqwzzXQ4Mn0rBP41qUocBSLPBfQ@mail.gmail.com> <baa1be5e-765c-4526-bc3d-d5e4306acb4f@o1oo11oo.de>
In-Reply-To: <baa1be5e-765c-4526-bc3d-d5e4306acb4f@o1oo11oo.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Apr 2025 15:10:33 -0400
X-Gm-Features: ATxdqUGSME1GbQ07sVgdGxjRqiLVTs7ljheWiavYpfe_K28ssQUDM9LOdIm9Tig
Message-ID: <CAEjxPJ6_OY+NgMNYNJWahzgCNciucT5DFhs3jLmW3Do7BMrjDA@mail.gmail.com>
Subject: Re: AVC reclamation strategy questions
To: Lukas Fischer <kernel@o1oo11oo.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 2:58=E2=80=AFPM Lukas Fischer <kernel@o1oo11oo.de> w=
rote:
>
> On 07.04.25 18:14, Stephen Smalley wrote:
> > On Mon, Apr 7, 2025 at 10:54=E2=80=AFAM Lukas Fischer <kernel@o1oo11oo.=
de> wrote:
> >> This message [3] from last year though states:
> >>
> >>> The current logic prunes the least recently used bucket
> >>
> >> Which in my understanding only works if "used" means "reclaimed from".
> >>
> >> Is this understanding correct or am I missing something?
> >
> > I think you are right. Apologies for mis-stating it in the previous ema=
il.
>
> No worries, thank you for the quick confirmation.
>
> > Patches to improve upon it would certainly be considered.
>
> I do not think I will be able to contribute anything meaningful in the ne=
ar
> future, sorry, but I will keep it in mind.
>
> Some background for why I am asking about the AVC, which I considered alr=
eady
> adding to the first mail: I am currently writing (or did already write) a=
n LSM
> in Rust as part of my master's thesis. For that, SELinux serves as compar=
ison,
> in structure and for the upcoming performance evaluation. To describe the
> caching functionality correctly in the thesis, I was unsure if I grasped =
the
> code correctly, which is why I asked.
>
> Also, for the performance evaluation I do expect my implementation to of =
course
> be slower than SELinux, since it is by far not as optimized, the question=
 is
> more by how much, since my policy semantics are quite different.
>
> And no, the intent is not to upstream the Rust LSM, but I will probably p=
ublish
> it. Maybe a much more cleaned up future version of the bindings, should t=
here
> ever be a need for them.

Ok, if you should release it, you might want to post a link to the
linux-security-module@vger.kernel.org mailing list.
Might want to consider using the BPF-LSM as an alternative to writing
your own native kernel code.

>
> Thanks,
> Lukas
>
> >> [3]:
> >> https://lore.kernel.org/selinux/CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qt=
zwc-YwGz=3DmLjQ@mail.gmail.com/
>
