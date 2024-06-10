Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0415CE
	for <selinux@vger.kernel.org>; Mon, 10 Jun 2024 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717978744; cv=none; b=nJWtdxWEvBSlaE/1piie7wor63+waaXNEd8M4YMXR0jwS6f3PMwTtfPwiy6JjxWVPdcVH7mNTWNozR4Cjq8X1y/6oLO/+WnqKd3Gi4KJndgHMBhTuJ7x8tOEArUezZLDuE01nCq24AotrXbXqNOMjpav92q5+joVZZkQFUsW3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717978744; c=relaxed/simple;
	bh=ouwqqZ0IrZq2p2VNSQskkMAORAvHn7/TuYsSh0/Nnes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hy5cjonIzRkw4b+Wed94xmAg5BCaMNHTQmftK39hAYbJrBi2gqlV841pkpPMfG4/HTd7DFP4Vz1KMKONeNUZw+RKa2v0lKW+tbTwCooO5BcENB+PFJa7MYJwSK984CxjmZzbCmrg9lHAIG1d4by+J0lcyS4y9Nv6VJOYvVsalwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBSp1Q0K; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RBSp1Q0K"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfb12c0b4ceso991915276.3
        for <selinux@vger.kernel.org>; Sun, 09 Jun 2024 17:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717978740; x=1718583540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaBC4lccKq90V2Qdlha3eJDRzM1Bcauqmp5mASHkKAs=;
        b=RBSp1Q0KZSkKXckwKm0NH9KWKK5B+2YY5YU4X/4nzvQWEKPM1v55ClNvnC7+Yny4jC
         Uc3bPfpFgjmC0zjs+fdvdjzoQDxGJuSlUEp8DCWfatyKzs6qil3gyCYvKQgcGElhOAzx
         P1C9KAk+0vHoMGuVp1BOPlydzgjvuEhRsAEsD7kHLRwdVoJzLXtU1kFGlexxszvYLhpV
         RW5PYCH3gr9itlXgflPMlGvcobNWzbGArbc2ztA8wDEv0N6mmfEjwRxGMV05SWDQkZ6/
         hTer95s4MbetC8+D4CQnIjl1+EsjgEQb7pDoJCIMONxKk9D3QxuztjlH/INCSjT6GhE0
         JqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717978740; x=1718583540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaBC4lccKq90V2Qdlha3eJDRzM1Bcauqmp5mASHkKAs=;
        b=grzTJl0UaG21tbho7ihjOk3LmdVat9DAivunx1VS0doqMl26t5ZgIrsUN+Z8scwj6Y
         UWTIOYSrRBgySh8z7iCgPkFAG1T1PM3qI9EujrGUVJQMBBcPbhiRGcHNhBLddhR5C3D5
         inXhXeBkidomMsP1Sa1tbFCa1PMXMcF0Z1ZDGdwUkufZs3b4Q6z7/nK9L4UhbPj8N4Q+
         ErOVX8AkG700597KQXmKcings8Nd019OBwpmbgZXO48jdlua2S+Cx/0SNO947Yr/YLQR
         Lk0HFZfAtPVPycFVAqhoWzXP9QWCaDNDMcq+0LNNpI3Clx43wTeAt0M/z1BwbgltEvuQ
         Xyhw==
X-Forwarded-Encrypted: i=1; AJvYcCWXQhp/76KzGahYGsimWyxbir9pnoK8mfxaUs7goa3ADO4/M7RyqEsCatPQzdOSUvgZiAT+6FGhiWa5+FQL+p/v8xTkQHyAnQ==
X-Gm-Message-State: AOJu0YyBcZzvtzetabXqpHhdMVwsdNr+5cgYV87mj3JwHKF7HCCZBHEf
	IUDJ1DymWZklJER070BONYWfzoKvrJFfZy+bLqJSgpFPoz9ZNgzJd1Gcp5u2tPtd8H+9f74aU0B
	KmDEERFXiKLPSE9hY85l8PyNYXkKf/vdQZv8G
X-Google-Smtp-Source: AGHT+IGUSJ9gCJQ/d525KZWGwnLKi0KTucuS2fT52NdM142pz4Cm/kHolpWE6kV3MsEu37U2P/YkyNLgVNYRzBxA+78=
X-Received: by 2002:a5b:2ce:0:b0:dfb:308f:911 with SMTP id 3f1490d57ef6-dfb308f0b87mr1143735276.60.1717978740109;
 Sun, 09 Jun 2024 17:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609104355.442002-1-jcalmels@3xx0.net> <20240609104355.442002-5-jcalmels@3xx0.net>
In-Reply-To: <20240609104355.442002-5-jcalmels@3xx0.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 9 Jun 2024 20:18:48 -0400
Message-ID: <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, John Johansen <john.johansen@canonical.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 6:40=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.net>=
 wrote:
>
> This patch allows modifying the various capabilities of the struct cred
> in BPF-LSM hooks. More specifically, the userns_create hook called
> prior to creating a new user namespace.
>
> With the introduction of userns capabilities, this effectively provides
> a simple way for LSMs to control the capabilities granted to a user
> namespace and all its descendants.
>
> Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> namespaces and checking the resulting task's bounding set.
>
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> ---
>  include/linux/lsm_hook_defs.h                 |  2 +-
>  include/linux/security.h                      |  4 +-
>  kernel/bpf/bpf_lsm.c                          | 55 +++++++++++++++++++
>  security/apparmor/lsm.c                       |  2 +-
>  security/security.c                           |  6 +-
>  security/selinux/hooks.c                      |  2 +-
>  .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
>  .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
>  8 files changed, 76 insertions(+), 14 deletions(-)

I'm not sure we want to go down the path of a LSM modifying the POSIX
capabilities of a task, other than the capabilities/commoncap LSM.  It
sets a bad precedent and could further complicate issues around LSM
ordering.

--
paul-moore.com
