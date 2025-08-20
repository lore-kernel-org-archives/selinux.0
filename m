Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE1202F93
	for <selinux@vger.kernel.org>; Wed, 20 Aug 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722849; cv=none; b=LKwIunAu0PobGkEaW8e1n0jExEWP6QkVz5E+oriMqrKlWsxr3yPL3POiSFsY1KPspPNBDJzH7YipMG6upQj4JvZL1TgzoQoe4GIREJMdTRg5MV+7QLUuSInN1/W62/9P3ERSu7MHkGeRD9iZU2DIjmieuy35rvn7FOUf1uv4tFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722849; c=relaxed/simple;
	bh=LLGwe5WKKiR+/T0UVyJ8BMXr5RI9JCQuA6qnVVXw4Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hc2q5IBNCqtbVMYq02nUPGEDM6CelTAVBPtR4W5wdw8+5o6LHmBWZRQjfTGUA3qjHY3k5mC1bEHGiXnzsBFeSrcKnoJuGsvO3OyIxuA15fHf/AZvkRGVq7psIQi2t2bv9MI2XEAiQ5wyiCVlVCv6sUwcdMnzVn8Be2epZZOoP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RaqsC6+a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RaqsC6+a"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266b2368so235356a91.0
        for <selinux@vger.kernel.org>; Wed, 20 Aug 2025 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755722847; x=1756327647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/ItnwIKlKwrAH7BkYoa42hrDmspyKaszOsyRccCX1w=;
        b=RaqsC6+aSu9HcmBTO54iHHbjYG9cLklo3N8TRNfUNSub04v4tO7tXvrQ0r79njh1iU
         xqlkieAqEm8bOxRx5gDvFKS8/hHTOOnOkzQa/LBBMUKmdKtQZHazACZInhnyo1K1Menf
         EWWWiIjWRisI66TBGxoR8y827JHsd4xIuZsL3+huMpldUICM1NDPNPsMfsSHBbZ6ZxnE
         BCANGn5EcmHN8ZOxrs00DwmNfDm4oRioJCJhbpkeEFTzRVZ7MOhCfEmjLLiw5KWEHMaF
         Z7prwme7mhI31JmyZ5KIgQbRGKWb3mePltygHQ0n2cFBtlUnSl1wLlB/XFCkhwAqesgy
         0lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755722847; x=1756327647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/ItnwIKlKwrAH7BkYoa42hrDmspyKaszOsyRccCX1w=;
        b=D5Ox9qNe4pPH/ChYgdgBu3fqB11VHpiKvMlNcnvchPr/Os1aY2a+P75sLjbSnznwi+
         D1wiQB9v3oDTgG5K0mwk/tJgcEb6ITVdoZ6D9yipaaTmKxKgeYtwUkZSBNUVmQRXdvDH
         NAJY+RhRXX+9GJXlnAjQhlcffG2gfq8M7IrbeIPrqtcg8j89ogXcQTl7UR8zUX0xv7Ma
         kTNCSKAgMRhRc/7qNG7MzX4qmC25IZLgOp8vBhRxtOHTyCI1TBAtqhAjfrmu0xEOAIaD
         b8wQTaDfmqB2ooFufk5digjP/Ne1k3wrbkpntcQs1CyrRkFLvz2lCdzJDj8PZS0VMjmv
         9nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzn/vpYbMWe6A2D34fkY3JPaKk21mtYiPs8W+ep4kwOanGW9o5gedB5vHHKTTRXdAdYE6ZKKDH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9bJB2KXxQO/hygzu3/iizL+gOt4qohCxhmN3/NBmgiOglI9l
	De0NhTpDq9RtD1A1MtcK67pBWIMiupXRHP2zc1Z2l/cyo+SxO1LMqvnieFd27Y+3X2Gj91kS8Sp
	/dbti5DrVtp7Xpa9hd0DnQ3q0bf1eb/uJoOvvmVvl
X-Gm-Gg: ASbGncuQwMvIGq+6xeo/V81Wm+cRQ72q9GsXS2nR/653sHIb9M1n12sVg+A6QwKmuC7
	BxQFTd3TTMOwd+mAn8F3gC8Zwl8V/Pgkn4LnAUZ4xNkZdqkLABAP4J2trJ42VVnm6XXwkoUgHXD
	2CWgNP+8v0XkpYAQTYKx4Wzcu26+ZSuPtteipuZmNFfBvJ55ytSodpR9KtOTX2l0I4ynlvrZyvK
	XAIyyQ=
X-Google-Smtp-Source: AGHT+IHlYPutLT2oSST8npSUhTtoKml8G2f6TV3BT52vGO5/zR8EoiIIEn0wbnhrPEKd715/Wu+n/cQQS/YY8ur8rN4=
X-Received: by 2002:a17:90b:4d89:b0:31e:5cc7:133 with SMTP id
 98e67ed59e1d1-324ed1191c0mr237216a91.11.1755722847048; Wed, 20 Aug 2025
 13:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com> <20250820.ieNg1quoRouz@digikod.net>
In-Reply-To: <20250820.ieNg1quoRouz@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Aug 2025 16:47:15 -0400
X-Gm-Features: Ac12FXxekNNUodMCyui3r7zk-6AkI6wHmMwDFgSht8ALnfPP7m7btBD4wLyVLrQ
Message-ID: <CAHC9VhS3c257ywxADRzPYE-DsXSwRp8P2RhAfdDnXJHOX5bXTQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:44=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:

...

> > Since we have an existing LSM namespace combination, with processes
> > running inside of it, it might be sufficient to simply support moving
> > into an existing LSM namespace set with setns(2) using only a pidfd
> > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
>
> Bike shedding but, I would prefer CLONE_NEWSEC or something without LSM
> because the goal is not to add a new LSM but a new "security" namespace.

I disagree with your statement about the goal.  In fact I would argue
that one of the goals is to explicitly *not* create a generic
"security" namespace.  Defining a single, LSM-wide namespace, is
already an almost impossible task, extending it to become a generic
"security" namespace seems maddening.

> > setns(2) caller to match that of the target pidfd.  We still wouldn't
> > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
>
> Why making clone*() support this flag would be an issue?

With the understanding that I'm not going to support a single LSM-wide
namespace (see my previous comments), we would need multiple flags for
clone*(), one for each LSM that wanted to implement a namespace.
While clone3() has expanded the number of flag bits from clone(),
there is still a limitation of 64-bits and I'm fairly certain the
other kernel devs are not going to be supportive of a flag for each
LSM that wants one.

Maybe we could argue for our own u64 in cl_args, or create our own
lsm_clone(2) syscall that mimics clone3(2) with better LSM support,
but neither of these seem like great ideas at the moment.

> > Any other ideas?
>
> The goal of a namespace is to configure absolute references (e.g. file
> path, network address, PID, time).  I think it would make sense to have
> an LSM/MAC/SEC namespace that would enforce a consistent access control
> on every processes in this namespace.

Once again, I'm not going to support the idea of a namespace at the
LSM framework layer, individual LSMs are better suited to implementing
their own namespacing concepts.  However, I do support the LSM
framework providing an API and/or helpers to help make it easier for
individual LSMs and userspace to create/manage individual LSM
namespaces.

> A related namespace file
> descriptor could then be used with an LSM-specific syscall to configure
> the policy related to a specific namespace (instead of only the current
> namespace)

That is a reasonable request, and I think the same underlying solution
that we would use for setns(2) could also be used here.

--
paul-moore.com
