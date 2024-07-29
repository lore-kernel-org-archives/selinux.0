Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF92143C6F
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248940; cv=none; b=oVxSlFyXYKod7MZGwIcs5BzP7iB/3Nd46seEupuJCRIFdtnAeD808HTFoVNj3+Tj87uC9RA4+gCSLLJ/qwAQrEqxv/yWMuduMz7DcsY9N9q6kZjl0/eqDo+mEbMtu7FGDlkZ4dfGsG+flqqYzhZK66b0XiLtXLmcO0m1Re3Svdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248940; c=relaxed/simple;
	bh=94HpCqIwg6BpBMPLVy8Gp//1JlmALRCUA0aVAoB9dK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB7zNg4QkMU5uicsXpWl8TZBBJV71677CStmpaObXPNIIUM3R5RfB96F1crSfeaxcQ0/Fm8CHcBQT7BUgjTTvMaNXdzMlNpQUXTrfIbolFpqP+bWa3WR6x0EvLJLZheFuIgc5RIMA/sie3Ehxla7gWF40G16UhESTYxbKKrR5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghUwKQlW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghUwKQlW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722248938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94HpCqIwg6BpBMPLVy8Gp//1JlmALRCUA0aVAoB9dK0=;
	b=ghUwKQlW8pOOtS2zcJdcj8c37BeppOgF1LnPOr/pt7a9yKngG5hjLj0grkRHcvxUUK7yqf
	2Ntg0rrDe7HAFzJoUhdIleGYK1VRVZyKCugMwMG2xU6fjKzikS/oired3P1Mt+dGVdtnGS
	8yJ095OHe0Dv0Je/yrlg0CwBDPpde6E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-LvQJrrWNOCWAzmAxmHkAJw-1; Mon, 29 Jul 2024 06:28:57 -0400
X-MC-Unique: LvQJrrWNOCWAzmAxmHkAJw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb77ab2074so3136011a91.1
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 03:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248935; x=1722853735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94HpCqIwg6BpBMPLVy8Gp//1JlmALRCUA0aVAoB9dK0=;
        b=Sc9CvuEV+Chz4Te2rMKTFrKoD2nY2oUPm3Qh5fDVWwDEwDo3qxcDr+zv1axMgHh5nu
         P7KFrhRnaE1izoydLbhldBz5koy8AcIP5Q4wuwC/6UCriwzpnYQggyZLAoEdCbmnHU/g
         Ke9z5k5Etx+mjsDYWXozvVFqe3tcLATwlUF4h0Fv9CztHggW8iOL0fnUNLNzgzkF+WN1
         B7fdgk7u7ODaHbNkUYUyq4/MyD9CmDpvRM7mxRojIBT7z6FW4pIruZsi60JSBP/kf2wU
         4asBbcGuwr05/5J5x2/oeRih4da9ZXF7DnDaKjgEVdftM+cysNwZlyG7gakwV9iiUgJ9
         7Eug==
X-Forwarded-Encrypted: i=1; AJvYcCWhpQA5Y9cDDp5ls8yyJxCkxPOyUXUZTHTGXm9CYUfBiC/TjLEjeMVAdQGGoY/bvV6bg1xmL3Q84RDJdqNM9Ucrj4ThB3E+FQ==
X-Gm-Message-State: AOJu0Yyddo/m7EzK58hztYJYohivMkzJAjDgUYNk7RGMpMaT6Alvpn2c
	8bpWv1WbTkTC4s9qKGYdyzndZwf4W9mmnOAhCXCineBnuRPe3OfLYBJ/CKT2WPZBafIJtoepOHg
	d4SuC119EZTUexiRhIj+Omh8G9xkAJx6xDvoGWAA2nu9dyHL8p1l9YNQ2D2nPbT+ZvqeGppzN9a
	9onLWQQ62jV2d9+Sit1kV2rUteXpPgCybRoNx9kFBw
X-Received: by 2002:a17:90b:4c10:b0:2c9:7e98:a4b8 with SMTP id 98e67ed59e1d1-2cf7e207326mr5246206a91.24.1722248935721;
        Mon, 29 Jul 2024 03:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNC/iS70v48zrdpZXE+dD099lMsj3bVzyfkaPrvoNB79eNxNaWVl5ejuzlLHrFBwBSRnBoCL40IKptXEr4wkw=
X-Received: by 2002:a17:90b:4c10:b0:2c9:7e98:a4b8 with SMTP id
 98e67ed59e1d1-2cf7e207326mr5246190a91.24.1722248935365; Mon, 29 Jul 2024
 03:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702095401.16278-1-gongruiqi1@huawei.com> <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
 <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com> <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
 <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com>
In-Reply-To: <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 29 Jul 2024 12:28:44 +0200
Message-ID: <CAFqZXNu_cLLH811Z8CxDb07Adf+E_z+1nH=7nkO9H83CY9RETw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 4:55=E2=80=AFAM Gong Ruiqi <gongruiqi1@huawei.com> =
wrote:
>
>
> On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> > On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.c=
om> wrote:
> >>
> >>
> >> On 2024/07/18 0:17, Paul Moore wrote:
> >>> ...
> >>>
> >>> Where (what distribution, version, etc.) did you see this problem?
> >>
> >> The problem occurred when I ran the testsuite on Fedora 40 with v6.6
> >> kernel, and it was the only failed testcase.
> >
> > Sorry for the delay... For some reason the test passes for me even
> > with cgroup v2 only and without the patch (also when run from a
> > regular user account with sudo). Do you happen to know what
> > circumstances are needed for it to fail when the cgroup is not
> > switched?
> >
>
> As the comment in the script says, a process need to be in the root
> cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. So
> maybe in your case the shell process is already in the root cgroup?
>
> In my case I need to ssh to a Fedora VM, and that makes my shell process
> to be in a sub cgroup called /user.slice/.../XXX.scope (looks like some
> systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in the
> system with cgroup v2 only, the script skips moving the target process
> to the root cgroup, and therefore the subsequent test fails.

In my case I ssh as root and end up in
/user.slice/user-0.slice/session-1.scope cgroup,
/sys/fs/cgroup/cpu/tasks also doesn't exist, and yet the test passes.
The same also happens when I ssh as a regular user (with cgroup
/user.slice/user-1000.slice/session-3.scope) and run the testsuite
with sudo. So there must be something more to it... maybe some kernel
config or sysctl setting?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

