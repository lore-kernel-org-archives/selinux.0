Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8B14F9F9
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737628; cv=none; b=P9NVv708L7DBP7B7HCphB/1I4TF3LU0o/7xNn6I+2FnS7RXBjDI/6v7+O8rsj1cHyDZ3tmzTsofD7gM4pcfZyGd9RzoaBYRC9WAMpudwFpnrQ9yn5/0Bmh9qqRjWfZyrMCaDquBrbPAXYPvi+5M46HmP2ZnhvZcNiEE1fszVhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737628; c=relaxed/simple;
	bh=QuYkDdOR8zSzktmSfK2b3ONlrBpj4bWO9v8TddYdYSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJ0pWSgOJk3oKIfoUl+gVb9Q0oO7ZuZRB8sMuDUUWEDeIbSThVWIJCI4WmEq5CcC8K9DYxg5/SleNzX7x2fY44ffiEI5Mj2xD7EHlOQpBaeXTWx+lTpc3prBmvURFcnxkOAkNQBMKB0pUytCplAEOuiItuqrY6PUdOQ0XvD5rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfbEa7ph; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfbEa7ph"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso328818b3a.0
        for <selinux@vger.kernel.org>; Fri, 03 May 2024 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714737626; x=1715342426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9d4e1dPI4GidFYYLkRdf2JPHQYv0rHWg3o7B5HV5Yc=;
        b=dfbEa7phM5DrufyT2He+Y9tOvYM/ECTb8QUWcjWKc5lNwIekbVSvqNkoO3c0Epv/bD
         qv957u/NE/sYbefChDr89Yo/M1Xf3q31YsWh1cpBPO3sEt75zuqvxgDvuriOFbWUrowx
         N07GlKzhUCn78l5uce+IVJsOH2KKRLlVoPdQTFF2XcKDHnrgu/RYkTwMTZY2IqbDA3/Q
         c2+0NWiM/H3Ln45it9zH9M05VDzZ7cdZYKkqmdaD8GvHzhZ7VAkcjly9lQz8BHdhvBv7
         sF/KmuQNb1w7jNAc/uZ91RU6xy0WViBO6tT6YfdVCii8s22vuMoCAGc0pgE1zUQScPfU
         Milg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714737626; x=1715342426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9d4e1dPI4GidFYYLkRdf2JPHQYv0rHWg3o7B5HV5Yc=;
        b=SnyL46tVozEapacBxffwMoiqOLCYGd4RPm098DMqWApCFbOZeaG+4CM2XtcPV3XxLx
         fmeASCC6adnKPwfFrdsTHtNo+9hcxh330p+c1cnbK9KpQ9amn6LaENk+ucNhlo9vUbnG
         eT9gS80iG170/DJepT1W8t8+sr+gTW505qnQq1YNJaS0zZbFWvC8GgWIilYcn0jon0qu
         duB6sINjRVmFtHYCsyjKRxS9yuTkvJIN6ZXWxnKJMA6NDkWyytKriCHr4DMULxokBgA+
         A8OM2GxdpJMNVI/ndzI8OvLu1Y9SKrrWni6VHXxq9NQswf7R2fAe6o+qfKfModikVtF4
         47VA==
X-Forwarded-Encrypted: i=1; AJvYcCVlGTU2sDE7FuCp2o4L1Gr5JtfT1JocPKZu+8b0n2hqKt6tZ3CTCEXksZt5mmIZNsA3HYpH/iNcgLvScBbkX1o5rBMgUdeQPw==
X-Gm-Message-State: AOJu0Yyx67grOUx9jyPUc/qP5dq5t44LufV41OSckXqLclelyEvqlHPz
	p/DB36PCuZdoE2B5aka2tiNYrTPVPcdxoxlxFzkwtgzv4CFlBeJnPTYDipyaIHI3D+rtMylQ8kT
	kL72ig5zSye4H9k9x7wocDPA3I5+w2w==
X-Google-Smtp-Source: AGHT+IEZoc13S21AfM9RkjG74tSt7HYRe0e9qBI567S4j1RudoTpiQrnrSZmzclCyfF5jiVVB4xKw5yNoeD9uE9RrBU=
X-Received: by 2002:a05:6a21:2c98:b0:1a9:3cf2:508d with SMTP id
 ua24-20020a056a212c9800b001a93cf2508dmr2238892pzb.38.1714737626181; Fri, 03
 May 2024 05:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3c9593d-fc73-4016-b057-57706e94d170@ieee.org>
 <CAEjxPJ6uFiUjb0siO4+D8a7Z9ZB=WWNdO=54m1RsCO8HT9n5Yw@mail.gmail.com> <2f3f2911-bed9-499a-a117-56a404ddbe33@ieee.org>
In-Reply-To: <2f3f2911-bed9-499a-a117-56a404ddbe33@ieee.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 3 May 2024 08:00:13 -0400
Message-ID: <CAEjxPJ66_2jic8erKo6RBE4psXxF3AK=1jvS7ERpB7Hmot0PCw@mail.gmail.com>
Subject: Re: cgroup2 labeling status
To: Chris PeBenito <pebenito@ieee.org>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:16=E2=80=AFPM Chris PeBenito <pebenito@ieee.org> w=
rote:
>
> On 5/2/2024 2:53 PM, Stephen Smalley wrote:
> > On Thu, May 2, 2024 at 2:37=E2=80=AFPM Chris PeBenito <pebenito@ieee.or=
g> wrote:
> >>
> >> The state of cgroup2 labeling and memory.pressure came up for me again=
.
> >> This was discussed March last year[1]. To summarize, refpolicy has a
> >> type_transition for the memory.pressure file in cgroup2 to a default o=
f
> >> memory_pressure_t. For example this file:
> >>
> >> /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
> >>
> >> with the idea that we allow daemons to write to this without allowing
> >> writes to all cgroup_t.  Unfortunately, the thread ended and I haven't
> >> seen any improvement.
> >>
> >> The conclusion was[3]:
> >>
> >>> Ah, now I remembered that we made it such that the transitions would
> >>> only apply if the parent directory has a label explicitly set by
> >>> userspace (via setxattr). Not sure if we can improve it easily, since
> >>> we can't use the normal inode-based logic for cgroupfs (the xattrs ar=
e
> >>> stored in kernfs nodes, each of which can be exposed via multiple
> >>> inodes if there is more than one cgroupfs mount).
> >>
> >> Testing on a 6.6 kernel and systemd 255, I still see the same issues,
> >> where most are stuck at cgroup_t, with user.slice entries get
> >> memory_pressure_t[2].  Based on my investigations, the user.slice work=
s
> >> because systemd sets the user.invocation_id xattr on these dirs.
> >>
> >> Next, I tried modifying systemd to use it's version of
> >> setfscreatecon()+mkdir() when it creates the cgroup directories.  This
> >> did not change the labeling behavior.  Next I changed the code to a
> >> post-mkdir setfilecon() and then all the memory.pressures finally had
> >> expected labeling.
> >>
> >> This setxattr() requirement is unfortunate, and the fact the
> >> setfscreatecon() doesn't work makes it more unfortunate.  Is there any
> >> improvement being worked?
> >
> > Possibly I misunderstand, but selinux_kernfs_init_security() appears
> > to honor the create_sid (setfscreatecon) if set, so I would have
> > expected that to work.
>
> Does there need to be an xattr on the cgroup2 fs root directory for this
> to work?  Based on the tracing I did on the systemd code, the post-mkdir
> setfilecon() would have happened on the root dir, but the
> setfscreatcon() version of the code change obviously wouldn't have
> changed anything when it ran on the cgroup2 root dir.

That could be the case, based on Ondrej's statement on the earlier
thread. So it isn't a limitation of the SELinux code per se but rather
the cgroup2/kernfs code.
