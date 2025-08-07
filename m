Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8A26AAAA
	for <selinux@vger.kernel.org>; Thu,  7 Aug 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587276; cv=none; b=l69ktcZn9Hg36wKwbFj2Zom4DPgtZ4rEuNytaM7j7f/Kvj0XUb1fWXUqxyf3vuqWkAgNQDsSiO0iv1YSJz3H1hs57jEhwCesK7cuRwuo9wi+EbCaGi1yZfQMg+PUvpZgsK/Jl7fiW98EaUqrDrw3PpTjZWWqEQ2An/oQbqhm+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587276; c=relaxed/simple;
	bh=S5duOYIsIrTSQJWDktRsp7LMwwNw3gBQciu6NPWEOk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8oaVjmIgJ24c6VuCYXm8iFYS9+SJLCtuVVGtDlDjh3W1Wq8lMDWV0brdCGgOoDCkgLz34UsGdax6G9gCX3eI4IrdycUvedE1BYQLBle3rNQQLn1Y08RvYHBgU3T5Q+22Pkft6r/qbU4ePpuw9f8hS6G65Cy/4eJmBwHHQtiTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KjRWxR8t; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KjRWxR8t"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32106b0930eso1450290a91.0
        for <selinux@vger.kernel.org>; Thu, 07 Aug 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754587274; x=1755192074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCv33JLYlQWvy+u2owQ6Y5A7BoaiU+a+e/6Fp8KCqBY=;
        b=KjRWxR8tU2WfdzQYcLaNY76W1GlrEn6aWc3E9JmwqdaAUjcZAgxcv86KvZ0qFhk8Y0
         Un7NIihk2wfcwu6N8WWWPY4iQf6NjEtIj5pP0k9dF+kagSZ7lQPAbEawfeq1jnoOMtpV
         3QYWKxJDEk2BX2IZxkenvy1EzwSN7F/RBIvp0+8gQAhli07ENYG/ozsjOxoaXVTNXlkQ
         zOttwgwrbSh3NWQ9Op4YuXviS0Bi8/GnYzjvblkPEjS8J988smz2eTeuKUXW6JYO5hBl
         /JnHPugzgvUKdHYavJqpnfbFLnhysbf8t4W+27gTcsT8s0qi2SmO1a5JT2kJKqpYZKGr
         mprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587274; x=1755192074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCv33JLYlQWvy+u2owQ6Y5A7BoaiU+a+e/6Fp8KCqBY=;
        b=Yr2WqljYEeCMv2nbRG8fBzpvw6l5IxijcXoJwUYj+biymoEktMtIEp1Q7QrV4soetj
         IrNLC4tre9uTKrql7JMjG4FRhfUhSyjJRW2byAqiCRp4Zv44UScipuL2lTn8fqKJWAtQ
         kKwFf/ivRYc2uVYoph4LF2Iq4akK2F9Pvs3dlgQ+JWqvxeGwBytpuYEz8ZsHFUlf7lWx
         eV3Fiq+arynDG0VUkKQ5jt3ve9Cp+itxjfUwwkZlfTR97E2WRh37bnR6LLETsnRZKg1y
         y1pNj/lurKE5Tcds5WmqmzL9GV3npfUKOUu+74kIDClQYRbyYqGACgsaS8vLQjuS897J
         TE9A==
X-Forwarded-Encrypted: i=1; AJvYcCW4hnlFWrvSZIPQnICOBeVJpWQRk2VJAvRMXcvk6qyy/mhkkSsOz9xUIODTjg6oUxqikZ7mEsjm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9gFMoKprNCf0zNI9LlwrmX2TDPveoEzeDv8zJPTycOKPX0sN
	kRjX+rwYsuCuLWjWT76yVF+VK7BhAssQ7AKPX/HGXdXkJ8DiQBBE7dRKjOCi54ohM3q4dpruVuD
	ARNS42MuS6s+X8U2hnfdW6T8wdjdgmYYqOKTLtWO3
X-Gm-Gg: ASbGncsKSacsVENnvsmJr3Pyv0i+/E0YxjuKsEtWmG/KdqHKdF54howl4hgh+x8eZ37
	k+0Kkw1K/FgChLGRRQbmCAG22BXPBhz4cSRADLk57unSjr8a6CfU7QDcyB0AJeCNRJK5MrhQehR
	iaGgm6uu2snYogAs+TMMavCRttVFEGRiEqH8XDWCgTt1ZlCmu7kErPOfMxmKXNG8s45F62N0EdB
	L3qXOo=
X-Google-Smtp-Source: AGHT+IE1js9/9cU38IinGxfvXT2Ji0uPC3Bg69YPXOFInZafaUocl0WGvMzZgGZ+mkjiCIVl33QfNGzjWOqBIV71i4o=
X-Received: by 2002:a17:90b:1f90:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-32166ca45cbmr9173240a91.20.1754587274179; Thu, 07 Aug 2025
 10:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
 <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com> <87pld788yu.fsf@microsoft.com>
In-Reply-To: <87pld788yu.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Aug 2025 13:21:02 -0400
X-Gm-Features: Ac12FXyww-IWezWFt1gs_pTcPutnWqR1fhfrR3ryTkQDZeZCYr98-5G2rs8gz-M
Message-ID: <CAHC9VhTPrrgRh7v-H7qpizbxHNcW-V1qj-=24+Z8at2w4Co4uw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> This patch introduces LSM blob support for BPF maps, programs, and
> >> tokens to enable LSM stacking and multiplexing of LSM modules that
> >> govern BPF objects. Additionally, the existing BPF hooks used by
> >> SELinux have been updated to utilize the new blob infrastructure,
> >> removing the assumption of exclusive ownership of the security
> >> pointer.
> >>
> >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> >> ---
> >> v2:
> >> - Use lsm_blob_alloc
> >> - Remove unneded null check
> >> - ifdef guard bpf alloc helpers
> >> ---
> >>  include/linux/lsm_hooks.h         |  3 ++
> >>  security/security.c               | 86 +++++++++++++++++++++++++++++-=
-
> >>  security/selinux/hooks.c          | 56 ++++----------------
> >>  security/selinux/include/objsec.h | 17 ++++++
> >>  4 files changed, 113 insertions(+), 49 deletions(-)
> >
> > This looks good to me, one nit/question below ...
> >
> >> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
> >>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr=
,
> >>                          struct bpf_token *token, bool kernel)
> >>  {
> >> -    return call_int_hook(bpf_map_create, map, attr, token, kernel);
> >> +    int rc =3D 0;
> >
> > I understand the motivation behind initializing @rc to zero, but to be
> > honest it is redundant and will surely result in a follow on patch from
> > someone to remove the initialization.
> >
> > Do you have any objection to me removing the initialization during the
> > merge?  This would obviously apply to the other two as well.
> >
>
> No objections on my end. Thanks.

Okay, merged to lsm/dev-staging with plans to move it to lsm/dev once
the merge window closes.

--=20
paul-moore.com
