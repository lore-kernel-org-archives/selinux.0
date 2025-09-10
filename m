Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35C263C8C
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520210; cv=none; b=u4Ud98y+7A/Ovjubb8nFfamI2pgcgsGBzh1llfaev2az0jf1YT6v5SdljhoUQdrffXh+BZAcDf4Y5xKDd5FH/yRN8DEh+SBF3Vz4fERGgJxiQn5kFSsJ1uUe6cW3eCX254K/HqcPw0EHFc3zeSP7En5ibI/8PQB61FvA1c2vv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520210; c=relaxed/simple;
	bh=6pCBoWI83k0t2LUOpaNjeP7VeriO7YBZq8d7JvKg/6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyc79aoSiuo53DvAhu/p1YnaZhUhzOMcw91inJoLGF5ozZgY9K8xISyRt7z4RaYi2c6ERXuRraFNPuAjAfW+zGo+ctSn6r5ZIQeOytoJLNzI87bLY6HHqxB2dyOGsncKzx+GDFbaKfR1i3emKeLavGKKyTpHz6y6PBbub8jMkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec/kLAJC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec/kLAJC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457f581aeso64587675ad.0
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520208; x=1758125008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgYlLiO/oHczf4mnMmL1ZYUR6nWiUQmtZFf/tPn3Kc8=;
        b=Ec/kLAJC134NgXxfE4eCIRdEe7hxJICrUXZy/q5lq7Acme29FFNk3rQT4DcLN3wqpy
         FWI07EZ6faDdRv08zWNU6oXYAIDvN67zCE+3Gk9axNAG/kdbqV7+FzKhoLthLOXQIPwE
         RKxb41wT0CZ+LM9yLJteMkJbgMBmOVt90EkBKtO3gSJj+/keMQhkdzbUhOyUWE950XlQ
         zMkwSu9yre4ty6VpSE6myAXiLKPiVRsVRUlFhTKrWlueHuCJT5QI78Fx3wwMdUQ+G8EB
         Bw8comTH3+4PcVRnzE8X1YURJVXbJjebP6cTmO07BmuTKz6ZxuwMI/UrkwmaPQSEBd+g
         N7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520208; x=1758125008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgYlLiO/oHczf4mnMmL1ZYUR6nWiUQmtZFf/tPn3Kc8=;
        b=MxgVAOrGQHDJGkE672QojFMa19hqCk5CetZVLzFKO+0R5tXTVo2GXASrjiaF3FnKA/
         L+BA2VYHp8nLCZP5EUE/7q/Rg5bGCqEZiGryf9moCgeAzahh/RMHW6mlyp4KW7+3Io/9
         q9iFszzwNiwgpyTn8VlR45jUxldWiekbcTroG8Ryf5K57xxf+fBtJPcLthfmRbeedRJu
         W5+32ql4NQJ2BIsfN4L/32EIOarDo+J8+85Hd7q1b0YPNzqmfK4qGiooYm8isZgU7Yxa
         1DL558jzKP27zheEmzCqaWCdufanBDDjxUOx/1WUstv/7Lvacot97ocbXmfT13Ii0Nz0
         3Kjg==
X-Forwarded-Encrypted: i=1; AJvYcCWEWW/hkScvqm8bzojgiFHzkXHu1TmhJS8Q3dcLk5Qust0/+MWqBDP1a6V8xV2wLsnHYZOwlSaO@vger.kernel.org
X-Gm-Message-State: AOJu0YwoevnJPNU1ie6K/Y2zOMJRZXpqoXoBWxnnWwv0pwPWfyaOKafB
	6wM5WM0jlhXQ4vtZGJjj1SkTwx8IoRqU/VaavkknarvVPPT4ou9kJBol+iXFLZMxJbtJtNw7Sv0
	dahALStcI/jf8T0Bs7gojOl1wucT1LV4=
X-Gm-Gg: ASbGncvmwvywAcd3wF38w+1k2CSbPO7/Mbc5a1QXZvEgeeWOMK3nvglpEc6sYhD/P+/
	msGgafKxwugFreCGTPBc3jcaqE4jXPNHIs1HHYXw08HbtxD9tSYP3TzsJjRUUsYETbg2jIZzBZR
	vDtYLYM3tJFc2e2oOsz9JC700ldnwe4hd9d5bnuoErCJMEvGCLG4kgMwuS+TnT2QYyOOVnfgkY5
	J3MCcY=
X-Google-Smtp-Source: AGHT+IHOfVbL9NlPDdOUnidO/OulqfW9GNvn9oaG9EQ7O7uX+5jP8SDzU7DLh4NMLtqOIB8wZIw8IrIXZ4cxWIljR6s=
X-Received: by 2002:a17:902:fc47:b0:249:407f:9638 with SMTP id
 d9443c01a7336-251761623dcmr195501275ad.61.1757520207711; Wed, 10 Sep 2025
 09:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
In-Reply-To: <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 12:03:15 -0400
X-Gm-Features: Ac12FXyWkzCMl-AsWDTDzp4158H9VgJy0MjV98131p84LcpNHjCmKab7QuTZRyE
Message-ID: <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > A prior commit, see the 'Fixes:' tag below, added support for a new
> > > object class, memfd_file.  As part of that change, support for the
> > > new object class was added to selinux_bprm_creds_for_exec() to
> > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > similar.  This patch adjusts some of the sanity checking added in tha=
t
> > > commit to avoid a "silent denial" in the case of a kernel bug as well
> > > as return -EACCES instead of -EPERM so that we can more easily
> > > distinguish between a permission denial and a fault in the code.
> >
> > Technically, this doesn't make it easier to distinguish because we
> > usually return -EACCES from avc_has_perm() and friends, but return
> > -EPERM for capability denials and in certain other cases (not always
> > clear why, arguably a bug unless we were just replicating the error
> > number for some existing check that also returned -EPERM).
>
> It's awfully fuzzy from my perspective.
>
> > My
> > suggestion to use -EACCES was because that is more consistent with how
> > we report denials outside of capability checks.
> > To actually test this, would need an updated libsepol patch that deals
> > with the fact that the policy capability number changed on merge, or
> > re-basing the original patch on top. Otherwise,
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> To be honest, this isn't the sort of discussion I like to see for
> patches that are merged in the -rc5 time frame, if we're merging stuff
> at this point in the dev cycle we should be past uncertainty like
> this.  I'm obviously not going to merge this patch and I'm going to
> drop Thi=C3=A9baud's patch from selinux/dev too so we can sort this out.

Not sure it warrants reverting Thiebaud's patch. I was fine ack'ing
that as is. I just thought we might want to follow up with something
to improve the error handling here, which can be done anytime IMHO.

>
> Thi=C3=A9baud, go ahead and take the WARN_ON() change for your next
> revision of the patch, and let's continue the discussion on the proper
> return code.
>
> --
> paul-moore.com
