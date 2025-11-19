Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6512D738A
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566953; cv=none; b=lywB8cktdal9Q2xoUmF/WccnCxRMa3Gx0n32Yc2hFZsqfkymMzfpMuOo6FVSxsUH6uLCptkFgwhr0tO8vUv3H4CS4sLMyHC8uEU1Qyq1cIFYYSKKFas3wBWEh0d/R4wujiPEXwD3qjmaSU6U351mCgHTL0Pb+tqfhkUqDcG8Tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566953; c=relaxed/simple;
	bh=3uHp36/QrA5MCyBxbK7ysxm4w1IwWja3CTiBAY2TRko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBpUkvxHNHCYAA6+qPSWAkTnOk3huGssGCWCp56ZCfLCe15cM6YL34tf1Eq6aI94H3QlySC0VvSK2KeUBj4ByVQjdoPziYUaVwqhnyJZzV/8oRnBydiHhp9nk2eDDxvRDFTJOph7iNAs/6jeDbjQF+1EjllEDlYeEXfEM/6EdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AF2AmkgQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AF2AmkgQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3438231df5fso8105502a91.2
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763566951; x=1764171751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60J1esHKct5VJAcp35KkHN9td4b9zav8rEsQTKfQsp0=;
        b=AF2AmkgQtTKkok7Qeyx1QLDKBwqZ3Z3PAhrWjGH9ucG9zP4mHlH1JrWmWAfpp6uAec
         1e2o7WEU2DMSAkJ5FHy/yclFDAj2JpfqNhy2zebmpoR8ro57AhVJY7DCQlvhgu+ovGFB
         QR2LC2CTbjRdkfvFGCp2Tow/RI1qATtl939OfIU/LrHQ1o0llBYZrggcvnDy/PrZKySA
         T4ALcK04Iw8OYV4kq7s0yZTxXqAZP33yd8NNltXdiAz7KmrFuvEOhpusA6hTdPpH4C/z
         lJQbStnn8IrPSgJ0cBMRLJgchHNMmU0dRwA23H9DRDAsxVJfKEO+7HzdHpqOsKyKy1Hk
         UzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566951; x=1764171751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60J1esHKct5VJAcp35KkHN9td4b9zav8rEsQTKfQsp0=;
        b=r24WWZKUX0s8tDURW8yHEnW/oT1FgQe5+WF04UuCZco5+vF+tmzAKxGUKjGwCmNa73
         Hezqrin9yZzKQQXw8WPdJ7zPRSPxQiSAS/ekya4PnvoereijhMkPgoekk/gFzz/aeWT/
         xLRuwXz5+/APjWU9h91qtyMUumqsalAQ/MKCNxxgjq1imNfjlXnuFn22WWhmprrcgJAp
         x4iMMI6S4T32OOJSk5BqSPB9ngPX+c14lihQB01Lf3TF640MzdTW6ox10QUB1nMNq+m6
         +uB3cZZoNwL3FGtLJiwV9Y7Zjd5wWEt1VxkdDm8sNvDKwUZE+Ceq0y6ePswIHHBpV44k
         BULA==
X-Gm-Message-State: AOJu0YyDP8z165bfYZ30h16Wi7sB6JnFYxF3mtZY72c1SZnnao4gG3qY
	Us1xy56762ObqQDqGpohVgm9PK0p0Rr8iq3lJ49Ovud0qOmC/j8ZTvO+2z9Ov+ZRkScvo1BRbaX
	82M+xx/Neq/QMp+q0SqT+t+pxHKRyvtcBTmhqQVJffCGI3SX2qnU=
X-Gm-Gg: ASbGncsHstVHtQm4s8zZ3g6ISSli4RVRZcYaCrPuuXDUQurdVslbXPEtClG+dCzQezZ
	C5PxxmjwnsNwuF92Noa1KzAkB3zuxzBNRQpfs5Ufet07TgSWrtiHXEct9vAg9aaqF7KcbREmSv6
	DBfdlzyIjNJ2Mwc145ZpUV5pw81bd1plkitIQC2v/M88CuhyfKyVA1MWCJzNYi4z0LHJEDEpeuB
	cwyr1w0suI2daWrmt7w1UAbXjVRCB6f3WfGPxeyxfksmibRzeOTYwHGbeBQOoffEtRQk+UnBn3m
	U5HxbQ==
X-Google-Smtp-Source: AGHT+IEjYvJRkU6C0s7/mIg2Hnk2zmDkcgjnJjHBb1CjvgQ1ne/SjQBO7b/hAz0FWnNH7eK3739TELpVCtDREjBAB2g=
X-Received: by 2002:a17:90b:1c06:b0:341:ae23:85fd with SMTP id
 98e67ed59e1d1-343f9ea58damr26450382a91.11.1763566950608; Wed, 19 Nov 2025
 07:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119020334.521449-4-paul@paul-moore.com> <20251119020334.521449-6-paul@paul-moore.com>
 <CAEjxPJ7bpvNFY5EAZyS7UDbVfc5y_84qv28mbztLLNvk8ROo5A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7bpvNFY5EAZyS7UDbVfc5y_84qv28mbztLLNvk8ROo5A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Nov 2025 10:42:19 -0500
X-Gm-Features: AWmQ_bkC4o_zZ1Jlp-PokwtMs2V_69aXfQz5kbG7XtW2wqGcjXftdUvNbKSjfAU
Message-ID: <CAHC9VhQGh2XU1TKkZ1CQESd0yALL9oS-kw1vmgr5eWLW=uuktQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: rename the cred_security_struct variables to "crsec"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 9:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Nov 18, 2025 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Along with the renaming from task_security_struct to cred_security_stru=
ct,
> > rename the local variables to "crsec" from "tsec".  This both fits with
> > existing conventions and helps distinguish between task and cred relate=
d
> > variables.
> >
> > No functional changes.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Did you mean to leave the tsec variable in current_sid() in objsec.h
> and the old_tsec/new_tsec variables used in various places unchanged?

Nope, thanks for catching that.  Expect a v2 later today; the change
should be pretty quick and mechanical (and likely all the problems
caught by the compiler), but it's large enough that I want to run it
through the normal set of tests first.

> Not looking forward to re-basing the working-selinuxns branch on top of t=
his.

Yeah, sorry about that, but using "tsec" for both task_security_struct
and cred_security_struct was going to be a constant source of pain.

> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

--=20
paul-moore.com
