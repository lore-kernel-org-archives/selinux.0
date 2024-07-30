Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819C1891DA;
	Tue, 30 Jul 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339057; cv=none; b=fKJV8thnvWGcpW0ViNnOPEOtCZ+WUFahns5mVTzdUJPs2JPyTas0z3qQOkOPhX/CzuWq0R06cASJwMaVZrvyk603VAzaiEt7+ly/1t40mbnhrZ2HKLpfQS1RJQiu6QDg29lggJOMe9Nd8O3kJTWtMFJut1RnkXCH5PzXFVhiTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339057; c=relaxed/simple;
	bh=+P99OUNbhY3hP9HJ4urn5F7bu4I3fUBFJ53MDn6BKAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBPzZ0vYOZyqSZeHaaTTT6V+Iq+WsW6wjGoDd4hryjSBbBTrm97vIeIhcz1RYyoobYhMTn1p1nTWg1Q8vvYFrYTFe9VHtsOTdM2oDb4EfSi3speIQu1RxSTJt5Ea3QfllHcXSF7pEA0CxLROqa9OFJJj9RJdcaE2VjLZ5OvephY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jujtUx8t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jujtUx8t"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd65aaac27so26102695ad.1;
        Tue, 30 Jul 2024 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722339056; x=1722943856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P99OUNbhY3hP9HJ4urn5F7bu4I3fUBFJ53MDn6BKAU=;
        b=jujtUx8tRHGs74RmFZsCgya+B6VhNj7mBUaiGzNdwFtcsU+HqZtVny/6VRvUz3km/g
         2v6UBOZNTR3ZAZVlVMy+CtaPy51hKl+F1ZW/ggGV8znCjgX4WLM8AqY0DMHxdSZPWSXW
         +CDPdJsv52iyHNfMXtGWWyaWmLDivo1dRYyt3QYGVrBMggj2uAWzC3LFUBZih10HZPeS
         etMhxdOHE9fMGQ58dFJberWw3iDs4tkaJ/t1NA0Tzlg7OgezUY1GpbbJMb36Rbg5C4DT
         JflRIsYIyA7nlPv8RJIeUze4Wv5t1p6WfpjgnjHOQA4DgZrjosqJnQ8RznBQV6EznmGm
         tmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339056; x=1722943856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+P99OUNbhY3hP9HJ4urn5F7bu4I3fUBFJ53MDn6BKAU=;
        b=VDtiqm3fgdDhztmyI9BRIOyI+GZLE6aCIvjkeiYvXipTvvz7cEM2lL5KSYi7CS4KZ5
         C5xRS8L9rH9DTljsgaPHh6/5TNDHxPAkhAJ038+REG87Tx2NNUkM3sigJ8OfC9E5UX/W
         pJEPEvt2Xf+75oPh49k+MY0CigX6EjNj8amZgLIptdk91n10jaqFBnPgfr4zOWNyvUsV
         eQK3Pxvjz9gjKAY8F41JiYuNl0QjxOIoYnU/kepiKzvHPpJ05FgPL7xWUYPwUjxM8s02
         08Rvt3DRq/TzCmeND+ONCiotmuqsqAG3G33SAF67XMnm7gS39pIk7JIYNd5qnvQuh4qY
         pyig==
X-Forwarded-Encrypted: i=1; AJvYcCVcN/1XJBKs/rjsu0Lywl+R0tQvT9DLa7qT71QQk4+Ih9cAmZwBCFPgLPrTM3/ZnYV7U7b5OxmXo/AFqs+bw2bFSA/kkysiSOPGKVG9j1A02BaZKWOZYMSUhnkDfOmMg4nAXmQjSA==
X-Gm-Message-State: AOJu0Yy9uXMOLHMYR3fbgu12bTJY87LP++rzOhub8CbGZiFW3QM0m/d0
	3mMMf4HN/O9aMyGWPVBkf7hFCeSq3TYQ3f/21bKgFrsiKUPB2A8h8BlXQ6kgCmhPC8Tz5mFBXfm
	KhSuUPfJYjbweK040xG3YzWprN0mZrw==
X-Google-Smtp-Source: AGHT+IEIhAbh1zXOrsRK4QSHkiPI0DXy6miwBpPYVMSbWGnO39ORkIWz6hSP5bOl2E0ST1mIHbbzyUteJI3IpCbCIKw=
X-Received: by 2002:a17:90b:170e:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2cfcaaf5cb9mr2805598a91.10.1722339055491; Tue, 30 Jul 2024
 04:30:55 -0700 (PDT)
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
 <CAEjxPJ4H_MVWd5iaP5eE_q0tbebSFRE=KMS80-dE3EdRpmv84A@mail.gmail.com> <CAFqZXNtNipvJLt3kvhQ0hB-P_Niyn0fQK0VTp-+Ce15WiJYO+A@mail.gmail.com>
In-Reply-To: <CAFqZXNtNipvJLt3kvhQ0hB-P_Niyn0fQK0VTp-+Ce15WiJYO+A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jul 2024 07:30:44 -0400
Message-ID: <CAEjxPJ773Q3oSXPVJ7Vw7dC7Ycs1+GZ3M8NoFXfPDx6xXpw8qg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Gong Ruiqi <gongruiqi1@huawei.com>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Mon, Jul 29, 2024 at 1:55=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jul 29, 2024 at 6:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > On Sat, Jul 27, 2024 at 4:55=E2=80=AFAM Gong Ruiqi <gongruiqi1@huawei=
.com> wrote:
> > > >
> > > >
> > > > On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> > > > > On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@hu=
awei.com> wrote:
> > > > >>
> > > > >>
> > > > >> On 2024/07/18 0:17, Paul Moore wrote:
> > > > >>> ...
> > > > >>>
> > > > >>> Where (what distribution, version, etc.) did you see this probl=
em?
> > > > >>
> > > > >> The problem occurred when I ran the testsuite on Fedora 40 with =
v6.6
> > > > >> kernel, and it was the only failed testcase.
> > > > >
> > > > > Sorry for the delay... For some reason the test passes for me eve=
n
> > > > > with cgroup v2 only and without the patch (also when run from a
> > > > > regular user account with sudo). Do you happen to know what
> > > > > circumstances are needed for it to fail when the cgroup is not
> > > > > switched?
> > > > >
> > > >
> > > > As the comment in the script says, a process need to be in the root
> > > > cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. =
So
> > > > maybe in your case the shell process is already in the root cgroup?
> > > >
> > > > In my case I need to ssh to a Fedora VM, and that makes my shell pr=
ocess
> > > > to be in a sub cgroup called /user.slice/.../XXX.scope (looks like =
some
> > > > systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in =
the
> > > > system with cgroup v2 only, the script skips moving the target proc=
ess
> > > > to the root cgroup, and therefore the subsequent test fails.
> > >
> > > In my case I ssh as root and end up in
> > > /user.slice/user-0.slice/session-1.scope cgroup,
> > > /sys/fs/cgroup/cpu/tasks also doesn't exist, and yet the test passes.
> > > The same also happens when I ssh as a regular user (with cgroup
> > > /user.slice/user-1000.slice/session-3.scope) and run the testsuite
> > > with sudo. So there must be something more to it... maybe some kernel
> > > config or sysctl setting?
> >
> > As a further data point, I also have been unable to reproduce the
> > reported behavior.
> > That said, since tasks doesn't exist, isn't the passing test a false
> > negative (i.e. it isn't truly testing as intended)?
>
> I don't think it is. The test wants to verify that it is possible to
> change the scheduling policy with the SELinux permission and that it
> is not possible without it - and it tests basically identical
> conditions with the permission allowed and denied, so it indeed
> verifies it correctly. The cgroup switch is just a preparation step so
> that changing the policy to realtime policies can succeed at all. When
> the test fully passes without switching the cgroup, then it just means
> that the switch wasn't necessary for whatever reason.

Ok, thank you for clarifying.
