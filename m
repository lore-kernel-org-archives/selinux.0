Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0B156F3F
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327340; cv=none; b=ixj7IVfkOz8b/k0gDBGruhjA9fReEdiBf76tl0jB7aJw5L7ZrNxxOocaf4fgAGR7XuHxjEDhL2U/elB62Y1kC4OzqsK/6WX66UXIS2w9nF5K/GKdYFq9Rri51t8+4sX5ekPMaJWUT8qnnG48yZvQ7PsPCEQA23SNkKfbpECAtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327340; c=relaxed/simple;
	bh=WOOMSfhnQcNODeN5xJyfMfPqy0keIAX/hzTWSUrYaGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqB0smQmcXer5MbfhqFem2rxUCr97I+zmlzSEeyXrwqc0tUrW3ujzjja8qB4tu9eSauHh6OPScgD0NVFkwp4dFMaM+gD4+GsSvq1DK1HcyNsjarm9h8OLd1L/rXA9SGkIhyapMg555XDnEpEwU+vHhjoVWCS2B+DeZG2OTmc19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/cXf2Pb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/cXf2Pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722327337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOOMSfhnQcNODeN5xJyfMfPqy0keIAX/hzTWSUrYaGA=;
	b=N/cXf2PbeTjUSpfFJpUQqfrCGlx/c97bC3M45WQMxK33oU1JzzulGIVPWIKL6XxeS6Qm5M
	F9k536AYg3JqO0QaUjWM8zRLiasMiqTRGl7jNsiHfiFWWE8ErAMYFLhEsryereWpjWDg4j
	v7JZtMK8hIGW12GFpyL6LBTXDXnHPNA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Cj2ALHz1N7alyfryupDGJQ-1; Tue, 30 Jul 2024 04:15:34 -0400
X-MC-Unique: Cj2ALHz1N7alyfryupDGJQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb4ea563dfso5576884a91.3
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 01:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327332; x=1722932132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOOMSfhnQcNODeN5xJyfMfPqy0keIAX/hzTWSUrYaGA=;
        b=MNyLYKHa6QW/CE3lO5Q0i5+YzVOmzPtft7SVqiqnmVHPkfG4/6tSJFauaZZHIlCXpF
         GcRbkF51giIMGdcaOmXjYec220tmB6vVv7YxTlF6vNN+f1IUdlJmujemtYI93N2dkgQY
         Vz770fjQ7aGqvttHMaRFOXX2ksgdqyCjWb2HnCENGjZfFGq7c/MiQdUAzgW/BLbbEsix
         fX9JhXmBOulYqOo9bAhv/HXFXJRoXi7CVJKM+69mNq1wFPM26Nv142y/l0iuJ4eObriX
         Gk0O4pYBvLGmUK4vyCgQEXWXsq1t2gjuvA9HOYrFeoZgVn5S3DezSSsrYYX4RWpiZN5h
         57Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVqiNFUv+v0SQHY/m8cRdNkQjJwCRg3iiP/TWRUOE85CI/tAn608WNL1dJh23FEQtPgWZh9be3jwNSOH33Ebf7WzpjEnragPw==
X-Gm-Message-State: AOJu0YxywRbql2KD7uPqd8jRpXDhk1CyXWbj+0o2+bpwIGW6/EK3wn7c
	bLXvwCS39HEFqZ1dp093inihFPXc5gn9bb8WvU9RgcdxIDbmNhZbmBTptggtTUZI8Cv4SLcKIhd
	VtjrOFxDAVbd8Mu1VV8HfcaL9LTVzz4A4ZfI5oDO21fYWHJB+yqJlQ/POy4m+9uJPzpNJexEyr+
	1eWLhW1oRezGJtFVTuRwDjTwkDDKfuu5roKjcPpA==
X-Received: by 2002:a17:90b:1e03:b0:2c9:7219:1db0 with SMTP id 98e67ed59e1d1-2cf7e097ee5mr11968769a91.3.1722327332662;
        Tue, 30 Jul 2024 01:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeIY6efqBzVRcnHDrZf789cD3QSb4GU491Vbgv01oZGYCmlbPHS55aNBW4HeDxvzWdKSlTy0/zXAZP3u9j+fc=
X-Received: by 2002:a17:90b:1e03:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2cf7e097ee5mr11968756a91.3.1722327332330; Tue, 30 Jul 2024
 01:15:32 -0700 (PDT)
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
 <CAEjxPJ4H_MVWd5iaP5eE_q0tbebSFRE=KMS80-dE3EdRpmv84A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4H_MVWd5iaP5eE_q0tbebSFRE=KMS80-dE3EdRpmv84A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 30 Jul 2024 10:15:21 +0200
Message-ID: <CAFqZXNtNipvJLt3kvhQ0hB-P_Niyn0fQK0VTp-+Ce15WiJYO+A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Gong Ruiqi <gongruiqi1@huawei.com>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 29, 2024 at 6:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > On Sat, Jul 27, 2024 at 4:55=E2=80=AFAM Gong Ruiqi <gongruiqi1@huawei.c=
om> wrote:
> > >
> > >
> > > On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> > > > On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@huaw=
ei.com> wrote:
> > > >>
> > > >>
> > > >> On 2024/07/18 0:17, Paul Moore wrote:
> > > >>> ...
> > > >>>
> > > >>> Where (what distribution, version, etc.) did you see this problem=
?
> > > >>
> > > >> The problem occurred when I ran the testsuite on Fedora 40 with v6=
.6
> > > >> kernel, and it was the only failed testcase.
> > > >
> > > > Sorry for the delay... For some reason the test passes for me even
> > > > with cgroup v2 only and without the patch (also when run from a
> > > > regular user account with sudo). Do you happen to know what
> > > > circumstances are needed for it to fail when the cgroup is not
> > > > switched?
> > > >
> > >
> > > As the comment in the script says, a process need to be in the root
> > > cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. So
> > > maybe in your case the shell process is already in the root cgroup?
> > >
> > > In my case I need to ssh to a Fedora VM, and that makes my shell proc=
ess
> > > to be in a sub cgroup called /user.slice/.../XXX.scope (looks like so=
me
> > > systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in th=
e
> > > system with cgroup v2 only, the script skips moving the target proces=
s
> > > to the root cgroup, and therefore the subsequent test fails.
> >
> > In my case I ssh as root and end up in
> > /user.slice/user-0.slice/session-1.scope cgroup,
> > /sys/fs/cgroup/cpu/tasks also doesn't exist, and yet the test passes.
> > The same also happens when I ssh as a regular user (with cgroup
> > /user.slice/user-1000.slice/session-3.scope) and run the testsuite
> > with sudo. So there must be something more to it... maybe some kernel
> > config or sysctl setting?
>
> As a further data point, I also have been unable to reproduce the
> reported behavior.
> That said, since tasks doesn't exist, isn't the passing test a false
> negative (i.e. it isn't truly testing as intended)?

I don't think it is. The test wants to verify that it is possible to
change the scheduling policy with the SELinux permission and that it
is not possible without it - and it tests basically identical
conditions with the permission allowed and denied, so it indeed
verifies it correctly. The cgroup switch is just a preparation step so
that changing the policy to realtime policies can succeed at all. When
the test fully passes without switching the cgroup, then it just means
that the switch wasn't necessary for whatever reason.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

