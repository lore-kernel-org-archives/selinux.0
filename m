Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067223043B2
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966619; cv=none; b=TEY/ucI8lHm9hUIv9S4DqRFKxsQZnq/b71F24aXZBCbYoZrmiHrYtp4Vfvy9OoiWHspdVtxsZw3zzgAatx931R29NEAyhpFaTKHNmB2blgPyFanUbI5tIXrxbVGDS/OXAMarcgkS+JkH3jdDpHM4iDswvowrnm7GgjaeZSK8wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966619; c=relaxed/simple;
	bh=Iejz8Bysso9/E42jRwjs5MtJJpkFiFK5fALhrrNe/mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVAlF8aE9Kqypb+hazf8Hi3E3ZgWUn0lfSMWqcccQ8l/3aT1ENZK+9d7kfjldEtmRgjokFuLK4IIQ3+8h+Mq2dzbSbFTACgcgO0ofAZKM02Hh4Iy/eSSP8PoFeaN8I5seMBjzgj9OXC6bqHzIVGtmrG5Wy/KJsY9MxU63bxQliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuPcwLFd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuPcwLFd"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso5740717a91.0
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760966617; x=1761571417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg3hxzR6eIgP4G6gS4tNnbnwUVQ+dXH2gK7ZUymAqAk=;
        b=HuPcwLFdH11t0smMeqL4oM1l3djU8VMmAPIiWQYCcEi9mulWXTaUb0LWU08xP0Yzwp
         JfZqEJR3mXFCqypqXcUaHbPa8/44a3ajtc7BrK+9Ld0iXOexs3Irgr2DlWVYIEQ2te65
         MZhKMFBk93iqs2PDTQNFDokO2APGHuHG+pddPQ7xFJlyfIgP6WRr7LsRyz/NnjUeiByh
         xJhW6WuYGLxs66050KvS3jWn6ElbN7krdrBFjxeeWLQNlK8H0TONo8LJNzsiq8wGpS/v
         aY/9HlXVjj+XCt0JTmNaLGYsxsgt96RnVKHKeJf31VKzdNNnNfMhBTMZSBBShLXpeqAY
         oUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760966617; x=1761571417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg3hxzR6eIgP4G6gS4tNnbnwUVQ+dXH2gK7ZUymAqAk=;
        b=sIMSWsCZKXn2tlb6lCRMzIPbH/yC4eHnBOB3dLsa4ratXdnkO5/WdJM3FZgIJgAJpv
         gRMwujD22pwoA0r5cj52d8Kieq9WQa+CSx1Q5ASHnOkbc226zK2OQed0/J5fPjgLZReW
         t8qkjJ+LiBKr+xWhNS1TrE4suBL8Ogrl7AEzDz4JFzNvsnZv+Z6wSMOf62wGkenzhk1l
         DCdRuO8sfybwt8hbSfL6y+tonSA+VU+VUC26nwS1c1kHSoooqaRCtDgRse+Hfl/sND1N
         PiT1o03Q4UqmlTIeSM3jPU7c9scAMvc6yIedsmbyBdSUMcMlPgspNk7rst3mPkhaNQ5S
         H8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzFzVhJtEPIkSV+YHhoriaa/EDjSLxosNsmmKOnOWwF0mJnFEtOgyROcqRS/z4FbqECEKTJdA3@vger.kernel.org
X-Gm-Message-State: AOJu0YzvphS70IbGTWAK+xjr3ZGaYZHHu+rT10XCIUcvGMxEGaI+RQOc
	EpvZ2L0Vy4n3om3rbwALKUVweEWj7HIu72rZDqZY6XfYuO8TnVz3MsMJ6RwUVJ59R2zbZd9y3xh
	HrtneW125aekGrdt+uIf5Nu2yQKOr2v0=
X-Gm-Gg: ASbGncsdrxbieLhhmrkoJ4SVNItiG7KPQgNppOQZszRRNkQ+DtrlL6uqQEFRMBxOQYM
	6PujCApXJgsZuZkyOCO6SdCcOULzhjOlcwMbt32NKcjMvWo202vXgdQyiZGYwGdPxes7Cig/Nb3
	lD6wMkv+UMyjtyKvttcbHckIZjXSRaWsyHl13Cvy1S0WPk65eyMq1kkRoysy8nyU0ckGjYJ+dyt
	3BIqs9aL5VPuUCy3gC2XVJsUNYbG0fgZ/nNaVP4d0gHZ5EZMF4e1MWR/BwP
X-Google-Smtp-Source: AGHT+IFMdjiEjCpWwfzuHU63feOP8G3jY8fj99z6OquwJDHGJKPdF7OBZCkGXEEDkkmymCFEa2bB5+bhzsK5h4+Gxlw=
X-Received: by 2002:a17:90b:1b4a:b0:330:b9e8:32e3 with SMTP id
 98e67ed59e1d1-33bc9c0e75dmr17118078a91.12.1760966617074; Mon, 20 Oct 2025
 06:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7y=scNU61+TLMXNMzrvxMbkUdB5a+drAM7gqg2z02POw@mail.gmail.com>
 <20251018061117.55976-1-nvraxn@gmail.com>
In-Reply-To: <20251018061117.55976-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 09:23:25 -0400
X-Gm-Features: AS18NWBEXjniBaiSGKb7jDP5n452kkh0IisgAHTkm3kRMSMGLPPLbNLWUNu9AKs
Message-ID: <CAEjxPJ7CML048d69QTSyWTRpWRCzweScM3EgxqxhFAYHM67o3A@mail.gmail.com>
Subject: Re: [RFC PATCH v4] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 2:11=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Currently only an RFC.
>
> Add the .clang-format configuration file, taken from the Linux kernel
> repository. We don't have any official style guidelines in tree at
> present, which makes it a bit unclear how to format C code for new
> contributors. As well as this, different parts of the codebase seem to
> been formatted with different styles on occasion, so using an automatic
> formatter should resolve this.
>
> As well as this, replace all the existing indent targets with a single
> toplevel `format` target. Managing all the source files to be formatted
> is not pretty to maintain, and doesn't really give us much.
>
> Also define a toplevel `check-format` target to verify that all code is
> formatted properly. This only becomes useful in the future once we have
> reformatted all existing code, but is wired up for now.
>
> For the future:
> 1. Reformat all existing code. I understand this is a big change, hence
>    the RFC, but we may as well get all code formatted if we go down
>    this route; afterall, it's not like this will cause any breaking
>    changes.
> 2. Add a CI target to check that all code is formatted as per the new
>    clang-format configuration. The `check-format` target can be used
>    for this.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

LGTM but still posted as an RFC so will await a final non-RFC version.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
