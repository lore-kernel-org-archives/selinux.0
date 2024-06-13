Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755F13B2B4
	for <selinux@vger.kernel.org>; Thu, 13 Jun 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311397; cv=none; b=uLwd6CjCcqEqRHwYDX5kBLxExTRT0Ltsv6hzWaeAgtrm7Kxk+q5U4wndo0X0pecYeNdET37VEUdB7+VykCJXuWpUOlze/kkH7M/ps39/k2xXGJ6s6UlE7KFqNsnGnwD8wA47RcSruqblV7TzNDNyMnFlEWKZVo4W99faf24qKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311397; c=relaxed/simple;
	bh=Te1wWeTYuhWG0UJJRZ0nQ9Ccy7EzdVqqwIlRrujyH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axjb7DJ0yPlzHbpiwh+RWyLBcsAg0BVQXkjspHwHxCRF6fvmYXdRq5Tx11kWzW9DCR+cJDefiueTITcmUixMXlOv1T3C4qWuS700ueQYWAB0UR517zqXWKLGO3HjDMr6XoK6jSoRRFqZKNezQgNefpWpb0SxwPhIfBCOGsr678Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fuMZHDa4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fuMZHDa4"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff02b8a956so1352718276.1
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2024 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718311394; x=1718916194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbp06UNvP6AGs/AzZYfCY2RlFHeTWL3VjFq/M7RiWuQ=;
        b=fuMZHDa4bjNFsZajlFm6gAnBMvg/BwfoJNgcncVCRis1Xp1EqIcaCMTgNtrGkb+lev
         Td1yWR1Rkd2rkCeBDcQJUchRHw/8NkPLAFMjtHsDDx4h3uwj27b8hpy81y9LyFa2yyfM
         9ipuVzXbIEcs/BrpeRd3fBf6ccrZSzLeL8ssvU9nrI5TxLLoREyYQ7oBFjKdY47fYmNX
         brSHYzQODPhrEttIHfMF8nrIT17YW5MH2w3MuvykUxNS6eeSH7aWNVoHMwlDZOaX/+Nv
         qu3T40pgZ0PL8LiZWv6i/IS/Cc+IYcgv1Cs9LlVkewvKLmdhIAUqNzgMG4diumVCwnjX
         H+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311394; x=1718916194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbp06UNvP6AGs/AzZYfCY2RlFHeTWL3VjFq/M7RiWuQ=;
        b=GX9Y/3WRfnIt4GWpfQkJCIlmDiuFJuC7ld+56G7QFs4oU+8bm0lx8wEl1LJgobQnlY
         GEG468mfy2Bl2xAkIji0+fye/iaCoC2MaT2UBso5LVLhkUQFIXxMJrJNG8UTA6y4xYQo
         bv74vpnoSz6oJcGP7h0cPVHSfS8BDnYlGgDkzVlQfG3fmVJH1mjjgsBUL8Rhl00AOsGE
         KYTIFIZ1uaWqyUsiys9yt2c5pq877VosnpNwFIHe34I61jTn8/g+avECZ9uEH7Ge1KHx
         K44UBcRKa2w4T0tyBCK0I3cWOwIcbBk/NE1w1vqzUgSCxnyNFNbnf5EAHd56NL15OxVI
         MkRw==
X-Forwarded-Encrypted: i=1; AJvYcCXbec2TUghRXcG42/58mWhtRDHFZMQpAStAt98xbEisfYAXXGpnyr/EXIYFnHofcTs1aGbHbZ9KpngM24NQKrhLzGug4vQjPA==
X-Gm-Message-State: AOJu0YyNH7XNmB4z7hhn0tWBsJms8MdekXDNa/HnBoApA8yuZA5A13Gk
	sX1XxVG5cJMTAxL7I0CS8hvmLZn/ziMnMdjnyU8abAbNNWUWFtSBG6vqeCGC76jbU9QT56HaFTN
	TCwhaAn2qGY94sA7x6VXpltSExrHZ0wRs9CQL
X-Google-Smtp-Source: AGHT+IG0WhxM6z6YdDtEWCi+I5IKFVVK+KMGdEQEjK8s3DDuXT3JscqlC3UvTHCxO6S8YW/rHWD2Pox3VJGxEor1JBc=
X-Received: by 2002:a25:b327:0:b0:dfe:653:3de0 with SMTP id
 3f1490d57ef6-dff154f9c91mr601718276.63.1718311394391; Thu, 13 Jun 2024
 13:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609104355.442002-1-jcalmels@3xx0.net> <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com> <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
 <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
 <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce>
 <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com> <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
In-Reply-To: <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jun 2024 16:43:03 -0400
Message-ID: <CAHC9VhTfXGeSkDxCaHRWRJjc+4DBorHOrqhrw8BzWhKD9SG39Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
To: John Johansen <john.johansen@canonical.com>
Cc: Jonathan Calmels <jcalmels@3xx0.net>, brauner@kernel.org, ebiederm@xmission.com, 
	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:54=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 6/12/24 10:29, Paul Moore wrote:
> > On Wed, Jun 12, 2024 at 4:15=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0=
.net> wrote:
> >> On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
> >>> On Tue, Jun 11, 2024 at 6:15=E2=80=AFPM Jonathan Calmels <jcalmels@3x=
x0.net> wrote:
> >
> > ...
> >
> >>>> Arguably, if we do want fine-grained userns policies, we need LSMs t=
o
> >>>> influence the userns capset at some point.
> >>>
> >>> One could always use, or develop, a LSM that offers additional
> >>> controls around exercising capabilities.  There are currently four
> >>> in-tree LSMs, including the capabilities LSM, which supply a
> >>> security_capable() hook that is used by the capability-based access
> >>> controls in the kernel; all of these hook implementations work
> >>> together within the LSM framework and provide an additional level of
> >>> control/granularity beyond the existing capabilities.
> >>
> >> Right, but the idea was to have a simple and easy way to reuse/trigger
> >> as much of the commoncap one as possible from BPF. If we're saying we
> >> need to reimplement and/or use a whole new framework, then there is
> >> little value.
> >
> > I can appreciate how allowing direct manipulation of capability bits
> > from a BPF LSM looks attractive, but my hope is that our discussion
> > here revealed that as you look deeper into making it work there are a
> > number of pitfalls which prevent this from being a safe option for
> > generalized systems.
> >
> >> TBH, I don't feel strongly about this, which is why it is absent from
> >> v1. However, as John pointed out, we should at least be able to modify
> >> the blob if we want flexible userns caps policies down the road.
> >
> > As discussed in this thread, there are existing ways to provide fine
> > grained control over exercising capabilities that can be safely used
> > within the LSM framework.  I don't want to speak to what John is
> > envisioning, but he should be aware of these mechanisms, and if I
> > recall he did voice a level of concern about the same worries I
> > mentioned.
> >
>
> sorry, I should have been more clear. I envision LSMs being able to
> update their own state in the userns hook.

Ah, okay, yes, that seems reasonable; although like any other change,
until we have an in-tree user we should just leave it as-is.

--=20
paul-moore.com
