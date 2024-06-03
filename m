Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C21386BB
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453988; cv=none; b=gb28bvOv1y9yBTHtr+pZvJdDrgQA8hkBaLBe31Zmzczbl8QcZGYVDMvjYPpoB44KM+4kNEUp4GCYbcuVd4L2gzdqpObQaIcuNZlwyQwKXrP0yssepDEvBOKBvuF5ZvnDP854JfY05o3QlKv0y953YHWpQ0cwAAqtMCjlF+kCr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453988; c=relaxed/simple;
	bh=TrBwn/d0GqpAZPrdLpc4RcvWvhLgItWxHDsohsEZ+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDcQiQwryyiUD7cCZiMnGbM8ukdwCOIHVdaA1e9kQYgqsUxzYKKrIS0bFxndhfCpMLMc2Dt9SlYbIwtgJBvTDd11qP5yUVBx+aIPidOWpqmHpiXWezsQvIIB1V2VRVVBGWMpj/hkD5eFx8ucMUJbdeomuDzKUCYIffdbkStJPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cqk3uWBH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cqk3uWBH"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a08b250a2so5076457b3.3
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717453986; x=1718058786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2SrD9AjsN7hWG3w/JbHlDonIw+G9fSsvP6AVFkewqI=;
        b=Cqk3uWBHO5xkcSR9OvfeaYwHFU2Nz+N7UgMH5n1qAYOO8wqBNB0VbfSGLRZJJYUgoI
         2kj+OERIQMbTonNExd7yXScSt3DqB0Oim6pjUuwW2rh4iO6fj9gMeL/RZSnhyi9Z2KOn
         l9D4mnqAjBmJE+VUOCEw2y59h3ca/CAkpZ04HbZ74+zpD6B+h73yC50iCvG+zCW/+ASA
         YlZSQbxCqeCd76xnNPFPIWlkWmnWjD9BVuoA7ykJtoyyP3SRpCoqYhkqri/C3z/Oupov
         lhbkpNki4YfemDE66lgUF3Que4IhTAvbkcwVevhfLkTU1/ItbT7bWO4m5U8U7QHusB2u
         M3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453986; x=1718058786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2SrD9AjsN7hWG3w/JbHlDonIw+G9fSsvP6AVFkewqI=;
        b=BY7Cu9y3JBOK23/Qa4vUOTDjgkyFE9cDuUEiIJL7qJCvNZ0bYNIxqkykLE32/DqWYM
         qx2P4/TubbHYsOKnR2ZLos11zxiPQK9ijwAk6+bDcwPrBnP352n1+DJtzpBMYiIWZnHM
         eF+TuTWcCQ4cgiF3+5ApRlZS00tuMNbs9TBhbUyooaE/cJeAwLuFILaQAIYwSHmqMJFA
         jXxgJIvlM7sudhP1IaiPoMIxoShDYLnF3H0OBpZQhP5WbCnL7qw3b4RBvRa2bfSFNzcG
         SYDcA6RBPwL2DPmM/kpBCFj13tOC/WVfM8y5pWtOL3AoY2wHB1BzScZzwGqSXIzdrMtg
         h8Lg==
X-Gm-Message-State: AOJu0YyAzhp+ouYiEUuydT2Tikv9PRfjgeMVnDi1S+J8A+IPm2+DRvLL
	oafciW6hFAsn1w8MV5wv85aWi5vnD+4LmsfIIDaXilmGaVxlDG9pjA5J9PQ87OFKpUxJRJiHAPl
	OJs48HTSJ7Siz2OhryQZoCy64suCdBJg8TLDl
X-Google-Smtp-Source: AGHT+IEoFZngLQNS1XtJnekiPwFn2p+z+HRz+Ler08TZyqvLEc0Sw3TmueJSUNY7Se/9laGlczTR31R2relv4GZbMUQ=
X-Received: by 2002:a0d:c884:0:b0:61b:3402:805f with SMTP id
 00721157ae682-62c79626ca6mr107691097b3.10.1717453985979; Mon, 03 Jun 2024
 15:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com> <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
 <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com> <CAHC9VhQUi8vo+gZ0OXYXGSbLpuSaCaNx+7CzXw0eAJyQ48X80w@mail.gmail.com>
In-Reply-To: <CAHC9VhQUi8vo+gZ0OXYXGSbLpuSaCaNx+7CzXw0eAJyQ48X80w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jun 2024 18:32:55 -0400
Message-ID: <CAHC9VhRQBpOPEwKec7K9hdsbZ3RZbj51yy5YuyjGfQQNLjb7RQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, May 6, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Fri, May 3, 2024 at 12:26=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > I also need to track down the appropriate commits for the 'Fixes:'
> > > tag(s); I'm not entirely convinced that some of the other patches wer=
e
> > > targeting the proper commit ...
> >
> > Looking at this again, I'm not sure we can easily narrow this down to
> > one or two commits as the current flawed situation is really the
> > result of a lot of things.  If I had to pick two may be the addition
> > of the BPF LSM and the introduction of the LSM hook macros?  I think
> > this patch may just get a stable tag without an explicit set of
> > 'Fixes', which should be okay.
>
> I merged this patch, with Casey's ACK and a stable tag, into
> lsm/dev-staging.  Assuming no issues are uncovered during testing, or
> mentioned on-list, I'll plan to merge this into lsm/dev after the
> upcoming merge window closes; I'll send another note when that
> happens.

Quick update to let everyone know that I've just merged this into lsm/dev.

--=20
paul-moore.com
