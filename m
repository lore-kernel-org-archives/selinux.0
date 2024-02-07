Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0D149E1D
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343888; cv=none; b=nvkEHA2cIr4L7wxjcaos8Rlmt7dqh7qlUlgkGA/HWXiuQa9JQMrVCQLqQrd6rxU1qCqaAWPoUHMSVl0lb926D9B8e/n46qf0e/0jdObuIAzO7OFxa6TggGCN0CnJl+Y9jLHzSbOGkyjXgP/WVFusQmry2SgeoIREXehwde74RBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343888; c=relaxed/simple;
	bh=T+xsOiFjNR+63CEA+G99uFG/TWED50uemjfpeROhEl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKIlu/bw2vb+SSg3JUt6NxxhHln9leeu0GTyld554yfiN4Af9s0sij4fkqdlDgbP1i7zx9EWw0vXFYpDqZOVLHXLzj4CQtBOsrqUB/Y63gmx7hFt6WVZCTL9hp6io3Q7MX3cWjr+3nFpSpAjA7K5F32841PAxmM+PedRVCRqVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNX0jqR5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNX0jqR5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso9424205e9.3
        for <selinux@vger.kernel.org>; Wed, 07 Feb 2024 14:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707343885; x=1707948685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/QLPuK75GUrGk9HoWYSYpwUJ1LKTuAKQV/adMnofcU=;
        b=jNX0jqR51CQAEBl71aejJVZE4rB6C1SXW+jYd3fXvvLPJxKyhKSNWHf4bLO5Io+z7j
         kGmhgmh24qB+ag4l4YmKtbDVQQ02HIO7S6a5wU71Uk95JGJblXtS09UHPv6FQF7hEgYh
         o8PUjysMJA3h3bciAn6hqziCDJvk9OHriGgFNQeBPAwRNG9PDDFSUTnN2Lkys7HNhb67
         sk8ngnmZNiqK9W2FoKHx5lJ4Nr+yUgmY6Dn72BjE0yGR/+wiabessXcwGbsRTIqJ/YyJ
         CHUtiyyVvU4OgJbFX9rdRTug+aiv4I4WQ1mxWB0bjncObfIUBq3jLi6g8VvDTQo0/qVC
         J/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707343885; x=1707948685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/QLPuK75GUrGk9HoWYSYpwUJ1LKTuAKQV/adMnofcU=;
        b=TmC+KxwenRlYr7qhr2XHqXer3U1r29L0XevOChakYR9UX/gJhnWBEFH3Sktyop9IzG
         34J8TzzkFzDyIgwYYgqQRDXguZ2fT4W0PTdp2niu45/BGcRrsSETq2/2Tm0TPlTEHG5r
         v7j+D7baEBUDDrFe3pjAdk/63KI78ioTMCJNRtmLezTp6DoNNEYAQa/22kkjZO/FFXQN
         ptIpr9rBEK6FEt7YVfTiTS21K1rBpDyWIPhAqT0etFpaqByD63kPEwNhOHGRJKny1QNS
         6JSbxgXSiES1dmXPl3JYAu+YbtMA+b8wglSoRghOl8/YRn/8SFH6XuAFxfioZNDp9/xn
         dy9Q==
X-Gm-Message-State: AOJu0Yx8i/FHPj+z+hDPjwI055Ij0Np9dGbVjbfEzDOtsqoOkDKesDrW
	Y+wp39dqmhT2yD6eK0yoaglU9l7xyw89U7GRBSOTQC39BYRg1YdmdRZ5dk88JhDDLKvHgRLY7Y7
	JNW8C2vvq763JqUyMkgIO6+owrPE=
X-Google-Smtp-Source: AGHT+IH9eT505oCCr2u2Na5KCI660hU8Qbu2ZpQqQEdU+i17iITI+YUQFXD0dAwVT8Kw01fo7P85w7DxCUR8f5bpTM8=
X-Received: by 2002:a5d:4b0e:0:b0:33b:4acd:22dc with SMTP id
 v14-20020a5d4b0e000000b0033b4acd22dcmr3426447wrq.16.1707343884667; Wed, 07
 Feb 2024 14:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128100035.82170-1-debug.penguin32@gmail.com> <CAHC9VhSsyOpZuHwT1ZZz3h=kWYXnWoCGfy_pLwEktXAfswkRAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSsyOpZuHwT1ZZz3h=kWYXnWoCGfy_pLwEktXAfswkRAQ@mail.gmail.com>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Thu, 8 Feb 2024 08:10:48 +1000
Message-ID: <CALk6Uxr+WY9ioCtBGvfAZyzSwmYPbcerVaXGa43Z7eTdfn77Cw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use kfree_sensitive for certain code paths of security
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	cgzones@googlemail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Paul and Casey for taking the time to review. I'll let that be,
as it may not be needed until further particularity.

BR,
ronald

On Tue, Jan 30, 2024 at 7:58=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Jan 28, 2024 at 5:02=E2=80=AFAM Ronald Monthero
> <debug.penguin32@gmail.com> wrote:
> >
> > As with kfree_sensitive() it does kfree() and memzero_explicit()
> > internally to clear sensitive data. The patch includes some of
> > the code paths to free data such as keys, hash table and
> > scontext and tcontext of selinux, which would benefit
> > from kfree_sensitive() to replace kfree()
> >
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  security/selinux/avc.c            |  4 ++--
> >  security/selinux/ima.c            |  2 +-
> >  security/selinux/selinuxfs.c      | 16 ++++++++--------
> >  security/selinux/ss/conditional.c |  4 ++--
> >  security/selinux/ss/hashtab.c     |  2 +-
> >  security/selinux/ss/policydb.c    |  6 +++---
> >  6 files changed, 17 insertions(+), 17 deletions(-)
>
> I agree with Casey's comment, I'm not seeing anything in the SELinux
> code that would warrant the use of kfree_sensitive().
>
> --
> paul-moore.com
