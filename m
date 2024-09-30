Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F3153BD9
	for <selinux@vger.kernel.org>; Mon, 30 Sep 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723196; cv=none; b=Dy4cUyTtZcyIb3lIqTkcEPz4Q7kupbju6I/r6di1nPeBahB8dd9IpoIF/ExVGBkBdMbUrb1VJFFZdRZ4vf4dAYWIcC/Y8sjbvgNUkpmm2hxfWrJqksl7IBIaw+uUoYaak6STThUczYO0hcPSC9ybmb3Fvf35Yg1/tPa3RwVt4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723196; c=relaxed/simple;
	bh=hEX58ZKFc8Cd3hpNg0jndQSnG4G7Zww16eFtVIUePeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbPjF3uUuPx97fQOqDG7O0+NvE+APTxXEksmkd0uSP2b3/luNuLROKdDOKWLykx+BBYDWJJOpO4jG3fd7nuW97bmltGFls+mHzbGuAKijdSlwsXhI8d0FQNWsWIkvdouZKfs0I98AaamSN/dBIiwSp58uLwYpWbakyt6zmduiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjEzh/S2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjEzh/S2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2db89fb53f9so3460356a91.3
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2024 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727723195; x=1728327995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEX58ZKFc8Cd3hpNg0jndQSnG4G7Zww16eFtVIUePeU=;
        b=JjEzh/S2gEB6we7niGThzalLFT2DfTA7ZimGYq/FDunhXMnI1z8rgQJDrqF+4irnFC
         m1UeertLbhBbhQ2n07v+gf21dG2hpy3zskgyPdRxqtCOLJm8po1uxVAqEVFOiI/jvGVI
         47nVuMg3eieauKr8dU82aczRyKAvjM2UYElwcDOf4U+dtdMCWtp1fSeUNpVd2Oo52b0S
         mmK5OZ4/K2QrOK6m0Xlga2MihIWIIGrTn2TJlc/pJqA7lPj/QX1eEFD4cSC+sZMNrP4/
         jdLNfOpwU15uHBDDncKkvRLkuVpVEswGlggL2eUnvN2fXkn1bVF0aXb6BFiIgNyFANUC
         YxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727723195; x=1728327995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEX58ZKFc8Cd3hpNg0jndQSnG4G7Zww16eFtVIUePeU=;
        b=RecJ9K0fl7cymn4elniZhtrJ5bR5NAa94+rR/lo1Tnp4ks6XeBV9gVvtVa2OzeZyrD
         q4x3jgYq9wi/5WUPngU5llQPOsT0VBmLSc2et8Bs74kbJFO07KFND6MUprGC33Szx05s
         4Hr8DoiDZ/4Znw27l6+Vw2oq/DIxhbpJPvKwASSDgDziYYj4YOh0p2hdr2gAxFqGbbaU
         fjEToKlP7OI/WEMhWMxMHKwrn/Tuz+ViENOyptoVecFIoJ0TRHCEFxpkIIfwmbVPcwWv
         R3ypFecASoZXWTTt3aPjaan+T/U1Of8QLI6j+a/UCT82twO74BxqseLRpGCO5524tBDp
         a7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXoy+ZEpTjK65aCkdOe5Yes6PKvZF3FaaFqOjyNbsZ6WnOD+M1mMh8e+umNllLLPGsRBkuQ4PFa@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLnjFHqXQ/ijNYF+umIY3moYZJgLLn05U/RVEqJSFLUP2yvVI
	6oU1F6/TEpE33d/v+CiLft+y2lhwVQZU5V1TVnzttiU/S2XrBegYZB18vFe+D+7h9tgV+IxQxrU
	V5iPKgY95mpc3wzsCeGJ69ligoDQ=
X-Google-Smtp-Source: AGHT+IFsUgyUCTjr4aWR+tjeU7Jr4b+LMxCuCRAnozxdxb9nJ/UVCAKS/D6ak9+VPhfOmsI0YXqoDoC9QoCWPDpt5zo=
X-Received: by 2002:a17:90a:cb96:b0:2c8:f3b4:421 with SMTP id
 98e67ed59e1d1-2e0b89a68d7mr15069383a91.4.1727723194548; Mon, 30 Sep 2024
 12:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
 <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com> <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
 <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
 <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
 <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
 <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
 <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
 <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com> <8992e65f-b1f6-4376-918d-c7c81a649c53@gmail.com>
In-Reply-To: <8992e65f-b1f6-4376-918d-c7c81a649c53@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 30 Sep 2024 15:06:23 -0400
Message-ID: <CAEjxPJ4+uju2phxNB0JPA00tYSsHM67y-TNRS-UxG7VpXKe35g@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Topi Miettinen <toiwoton@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:12=E2=80=AFPM Topi Miettinen <toiwoton@gmail.com>=
 wrote:
>
> Hi,
>
> I wonder if SELinux namespaces could be used for sandboxing,
> specifically with systemd. When enabled for a service with a directive
> (something like NamespacedSELinuxPolicy=3Dpath), PID1 could load a servic=
e
> specific namespaced policy and apply it to the service as it starts.
> These kind of policies could be extremely minimal and hardened when
> optimized.
>
> The implementation should avoid interfering with other sandboxing
> activities and also avoid AVC pollution from them, so preferably there
> should be a way to set up the namespacing and load the policy in a way
> that these will only take effect at next execve() call, much like
> setexeccon(). However, errors should be returned as early as possible
> though so that the error can be associated with the loading. Also it
> should be possible to enable SELinux namespacing independently to other
> namespacing options as they are controlled by other directives.
>
> Would this be an interesting use case? Would it need major design
> changes? Systemd already loads a SELinux policy at boot so there's some
> infrastructure in place.

I don't think there is anything in the current implementation that
would preclude such usage, but I'm not sure that's a major use case
for the SELinux namespace support - sounds more like you want to apply
Landlock or similar sandboxing via systemd configuration.

At present, the unshare operation is not deferred to the next
execve(), no different than any of the other namespace unshare
operations, but that's easy to do if it is necessary for some reason.
The current sequence as I've sketched in this email thread is to
unshare the SELinux namespace, mount your own private selinuxfs
instance that only affects your policy, load a policy, set enforcing
mode, and switch to an appropriate security context in the child -
either via setcon(3) or execve(). The policy and AVC are private to
your namespace. Permissions are checked against the current namespace
and all ancestors (for the checks that I have converted thus far,
still WIP). The process context in the child is separate/independent
of the context in the parent, but bounded in permissions by it.
