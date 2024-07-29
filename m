Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAF1D69E;
	Mon, 29 Jul 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254146; cv=none; b=HIPqas6qJjpPbSNmEnqoVuAdocXAU2kn62CzqIngMTvvFOQmixPHtjOlmoG1ldaCRdjevVkmm7qrM8TR9a9mIJRrL7H8EuXocLoFQdjEc0x0L+oIa1xaJPShnG0SxEuAXW9Ao3dugYWdbVDCsMmvvoRxKMy3udKvaWIPHMhbU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254146; c=relaxed/simple;
	bh=lVvDNEFpX03SJnSG5bu3Bem0pmuhRNncFVjJuRFD9Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvfXeTmuGopC0TBGnRj0HOJlSXSnNTgm7t/9JF/6ddAbdWutwmZOoOEQQ4rVbjClSZ/hcZ1XHykA03dARLpEdTndNK6UfGhgIqUB//zZd3REGPsV5/A6EoFwhSAI3jpTSsOW1ayrUh3w9DHp8r9cJwNl4O9FtawZ2Vlyy9kBbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmp5EQbG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmp5EQbG"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso2439183a91.0;
        Mon, 29 Jul 2024 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254145; x=1722858945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVvDNEFpX03SJnSG5bu3Bem0pmuhRNncFVjJuRFD9Fw=;
        b=lmp5EQbGtDUnxB8172jWKBXsxKn1IbeXr/CeXg5gDGr4YaIT+VpOqL96QIX8Z2MV5B
         SzIN8eKXuq8+bWfrLxD4gvEthxdb/4RECQ6mj4RwM1qBLLCEHGq1VaVEldApythCh7vp
         +YZGyNHJJeNzo3F7RB7auYQTsmKzqtsqFPPpjKWEPefSrjqpUFi6Qw4Sui6oJ9If32XT
         Q5ra9qNh4ANi5UQGx5rcP7rrR25cGU1R04gnkXXId4RiSbkoVGUfEocRvnFJCyl+Mm1w
         bqwNES7gvF5yhOd97iAkMPlvmOAC/ltgb+XzVvJsg8yWM6x9bg6e10AM13LRMlWnQZv1
         4PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254145; x=1722858945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVvDNEFpX03SJnSG5bu3Bem0pmuhRNncFVjJuRFD9Fw=;
        b=Box6O0G0wnDjTQPAvQzZHx946bQB2MpF4RA2UAeVWHqkoKn4B0bWNXrpHb5qa7PzP3
         J7oj6Kd65jr/MgR7cjZO7d+PAko5S7mIAx6NEpqBt7rf/Kd77lMwqfCVbq5mfc/x+YkF
         whlU6fYp4+qUV/nNtBd2Bn5SnQnJYdI28Tlk17ewLSE7lo4snfTO1x+fL1epCg5Xjtj/
         +KviYLuzMW7LatzYnjQCdj3baDhkiOJaK52dXAxTuewtAnKPcTVz49gnkWpZuZYt+gog
         ZiRu6NxC0SE2suKYQ0Ie7ThxEuvtOGkBA76X4t+PXpd+5NWQAp774HhKz0ITJjjZWhIV
         ZYKA==
X-Forwarded-Encrypted: i=1; AJvYcCX9rhy7O1BkQddTmvvxA2Y/5lMqSLngnKoJA8lpFKJEtR/xtZ0K3XU01Bp618ehvltQro2OMWgI1MuNwePqDp65wJSWam2dbNpnlgkT3M1bSn/H4C02HT7lvyKQmGxKeLc9+f0o+g==
X-Gm-Message-State: AOJu0YwHiXwdA/pLXDG2cIlr/Nlj7Q0WFINKK5lfGBk62O+KlnyfO4pZ
	mlun9apaw+ZwpPexTy0CpbUrDAUmIuVHC3jFA/yYkqx9ZbylSF6i7yuNtE7gl+gJ47M5xgOuNES
	UGCIxhYoFSmyjG5E86S+Sb2XDZ0URTg==
X-Google-Smtp-Source: AGHT+IG/aZbWDtxoNnOzHkj+SliJsGoJineAi6iWzJaWWf/ludzKYrS9udSITPblKA+nrtnaJ5YGjO2nTJoYPWtfbQQ=
X-Received: by 2002:a17:90a:e7c2:b0:2cd:7d6f:31b0 with SMTP id
 98e67ed59e1d1-2cf7e866982mr7892114a91.43.1722254144749; Mon, 29 Jul 2024
 04:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702095401.16278-1-gongruiqi1@huawei.com> <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
 <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com> <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
 <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com> <CAFqZXNu_cLLH811Z8CxDb07Adf+E_z+1nH=7nkO9H83CY9RETw@mail.gmail.com>
In-Reply-To: <CAFqZXNu_cLLH811Z8CxDb07Adf+E_z+1nH=7nkO9H83CY9RETw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 07:55:33 -0400
Message-ID: <CAEjxPJ4H_MVWd5iaP5eE_q0tbebSFRE=KMS80-dE3EdRpmv84A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Gong Ruiqi <gongruiqi1@huawei.com>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Sat, Jul 27, 2024 at 4:55=E2=80=AFAM Gong Ruiqi <gongruiqi1@huawei.com=
> wrote:
> >
> >
> > On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> > > On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei=
.com> wrote:
> > >>
> > >>
> > >> On 2024/07/18 0:17, Paul Moore wrote:
> > >>> ...
> > >>>
> > >>> Where (what distribution, version, etc.) did you see this problem?
> > >>
> > >> The problem occurred when I ran the testsuite on Fedora 40 with v6.6
> > >> kernel, and it was the only failed testcase.
> > >
> > > Sorry for the delay... For some reason the test passes for me even
> > > with cgroup v2 only and without the patch (also when run from a
> > > regular user account with sudo). Do you happen to know what
> > > circumstances are needed for it to fail when the cgroup is not
> > > switched?
> > >
> >
> > As the comment in the script says, a process need to be in the root
> > cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. So
> > maybe in your case the shell process is already in the root cgroup?
> >
> > In my case I need to ssh to a Fedora VM, and that makes my shell proces=
s
> > to be in a sub cgroup called /user.slice/.../XXX.scope (looks like some
> > systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in the
> > system with cgroup v2 only, the script skips moving the target process
> > to the root cgroup, and therefore the subsequent test fails.
>
> In my case I ssh as root and end up in
> /user.slice/user-0.slice/session-1.scope cgroup,
> /sys/fs/cgroup/cpu/tasks also doesn't exist, and yet the test passes.
> The same also happens when I ssh as a regular user (with cgroup
> /user.slice/user-1000.slice/session-3.scope) and run the testsuite
> with sudo. So there must be something more to it... maybe some kernel
> config or sysctl setting?

As a further data point, I also have been unable to reproduce the
reported behavior.
That said, since tasks doesn't exist, isn't the passing test a false
negative (i.e. it isn't truly testing as intended)?
