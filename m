Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79521DD539
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526716; cv=none; b=izAOdE5DSaK+mlnEsEu2WWukMdXGUGI424Vq/OXEW/psvE2Tzc/DEYqaJr8pU3kXUv5lmpe0KZzft1O4exXmNGUzlvnrNd+/Sowc9cvi6j0QrmgoX09/7QzmiZTTqnpkVWlD10/iXHr9JCctB76iodEZZ/XS1MUGZms/We5aZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526716; c=relaxed/simple;
	bh=tFU0/+b3cWG/xN7SvKsqTKSzVo0l4od2TxjaTFTr0yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b80RduO+qYP/SVTKwqWgFLoPeYYLE5BavvYT3J8r8xKJoqomdiiBAheNOyk3kliTwUz0KfQgtxqj/1lteAsTEmzk/GuAUkj8MvYPGJY3rn2Es5QF5OaeptKhTVL1UeMployLUAKk1/Nax5+D5BjKoQEE2O4Czx2wJTzopSblA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qffqtjdl; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qffqtjdl"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e637edaa652so1102455276.1
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745526713; x=1746131513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcwmTFhpzpamQX/j5lER7caqqO4fvXUMr3+zkezWQEA=;
        b=QffqtjdliQMTMcHnXuNp/Hj9o56UKafXKTV/FhH0beSPkV8lZ4JkaoJpTQ93TovPfj
         UV9Ku37agTJrjySvQLc59S8F4bgK9J/ICGrTZFjgxN9ZoAQ2IHBGbaK6j23mGOjobENm
         NHyouD3yWNyMAzubFWbjMr+HVuJnLUL7tsLxM+KEnnEw+NL8BahJqTpGeXaENXDeWLc7
         rG1v4Mhvfyn3Hw5HBHFA+pXSOtRy4KAZHOPEmWkfDbsUXRC12RuNOyhpYEVcrmTh7d0h
         fatQchJqTsjVxlBRqnI6HuZiSs/ghjEnzz4BIt4Q87DzbeEBDek5gXV/eBfBFmAyWFHY
         NfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526713; x=1746131513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcwmTFhpzpamQX/j5lER7caqqO4fvXUMr3+zkezWQEA=;
        b=F3SOJBpO9e6b8wUsTDpKrVmydpg7h85Cq5Swb9eSlagm2wPOydizh9EYuujMbfO2RB
         kRciWEk7UTiArqIBvBbNiMeRlWFz+hEc27rVIrVaVCkaJO4XaAKd12e2djAoNp9btrT0
         QaZuzlO2AljnBJS5aMufTlXARVtXpf/5IibnqL8V1J+QjjMBKxD5ts6vgcPUT06Loudz
         1Awckork4bIq9MygDmConEOaD6g9C82KwAW3ugxgKYViBh8Zlv3imNcl5+TMc8NfUk3F
         Y+E6g1smZ1NNWQRDBRQi9D8/waPkoo/Ij44lU3Z7sf/0C0LlDMEM4h/iYUwphbjOAKPg
         rswQ==
X-Gm-Message-State: AOJu0YzR0OZkSQwh4EKp5DoS9p1F+8hDNYOp26C7JIXb71PjtMXDpv29
	N/gx7SOW+oN6XiXaQ/FPRXXqI+ipD+HjeOiwlvh92D14jDCe9Muj45vQJIBmlGqGLLWwDePteK8
	B4Pr6Mu+tfU3qp+QTq6A/bfVGHU4/2Bqs1C4D
X-Gm-Gg: ASbGncuyMPqRfDuW/9nN2/B5z8Gxx2eSgu/nnH0OoTGWeUE0jOevyHUYa4C2ybPIHkM
	NnHYcbmjrHq4gNPL7GNF9fU8RSzyEUgY6GbakSuXooYEYZ1Duo0Ik2ho8u1yyUtICdqNw/gcRo0
	5gnaGuYaN83mlpLkBApjQ5ClsxKfDbUs51
X-Google-Smtp-Source: AGHT+IHl7Xi2/XKp51YgMLrV9W4rXjyDte59ThM1Kwj6gGHdhlykbZ60N4ZEVXukCZDlZpW2Kf1fgwRvVh9OYXB8Ngs=
X-Received: by 2002:a05:6902:1792:b0:e6d:e8d4:680b with SMTP id
 3f1490d57ef6-e7312b2dc6dmr1238573276.6.1745526713486; Thu, 24 Apr 2025
 13:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200310.2409-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250424200310.2409-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Apr 2025 16:31:41 -0400
X-Gm-Features: ATxdqUEGznLojHMgxD9cnlt5ejcrOE-sD1aS-yVW8P-T96-CRp7oNsdYPw2PGOI
Message-ID: <CAHC9VhRk-0jFcap7xeELQBykx4EOa35EdkyRB+V86nGXnXf-qA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce unconfined as a first class concept
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Introduce unconfined as a first class concept to SELinux. Previously,
> SELinux had no such concept and unconfined domains were solely defined
> by policy.
>
> Advantages of elevating to a first class concept:
> 1. Explicit allow rules for unconfined domains can be omitted, shrinking
> the policy.
> 2. The kernel can leverage this knowledge to further optimize checking on
> unconfined processes.
>
> Disadvantages:
> 1. Yet another juicy target for exploit writers, similar to permissive
> types.
> 2. Requires a new policy version/format and bitmap.
>
> This change just introduces the basic support but does not yet
> leverage it to optimize the AVC or hook function logic.
>
> Link: https://lore.kernel.org/selinux/20250424185213.17910-1-stephen.smal=
ley.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/include/security.h |  4 +++-
>  security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
>  security/selinux/ss/policydb.h      |  2 ++
>  security/selinux/ss/services.c      | 12 ++++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)

Maybe I'll warm up to this idea, but my first reaction is not
positive, I really don't like the idea of special domains with an
inherent set of policy rules.  Yes, we can mark individual domains as
permissive, which I realize at a high enough level it looks very
similar, but to me the important distinction is that marking a domain
as permissive does not imply a set of policy rules, it simply ignores
any denials.  A minor difference, but one that I think is important.

I want to think on this some more.

I'd probably be a bit more open to the idea of a AVD_FLAGS_DONTAUDIT
flag that could be used in conjunction with the _PERMISSIVE flag to
both ignore the policy access decision and squelch any resulting audit
events (even the first one).  Admittedly, that likely wouldn't present
quite as many possibilities for future kernel optimizations as the
_UNCONFINED flag.

--=20
paul-moore.com
