Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BA205517;
	Thu, 12 Dec 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026082; cv=none; b=S+rPsP7tPCBpL3pt9/mlftFWhSG4DZP0QMCc3JrX9i3GjVnQSGuJrH6zHyOY4p+D3bs/e3rIvMTKz0QbNi1jj82RL9f+GbalQLWLY3OGrRNNMP1Ef/m3cIBk4NpRKrFDnUicLwv3cWPAGGjAffisV8kH/JiI/mR3fjxVV6TVTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026082; c=relaxed/simple;
	bh=FN326kwmo+usXXkE7JMlfZ8nRm/bpLoTgK37DeHwPjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzgB1jhcVkAUwyU0lyInKnfzU9id1FlpMw+7pfJzC/fY6nlIyIES4u39GmHyQ7GMXoj8PCi9vXdUuSqt16937xHkk11osp95g1scCDDBdu2QWa9UaysZOi8gl99coc/mxZ/jotqhb4ViL6PyY2BqnBzCqZDIvSo0CN5UimIdnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBG0apyx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBG0apyx"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd4c0220bbso901749a12.0;
        Thu, 12 Dec 2024 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026080; x=1734630880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev4lgX+KZs+L6jXNa7LK4+bkXUMVJIDLTTwkZV/NGlk=;
        b=XBG0apyxDcNOFd2U42QUQYi+di4EokTScvAjvrjiM52N2mlOfj6NaXUChe17TGHcpK
         qYMC3pAqD7KI5Yn8EaCIXxf/35y/APenOlMM0RonhBE3u3+M+OXkXqDHC1IOsSUjlmPp
         4RZJvdKijUvQGCdNJrUhmPCpEf2kXBCw3dT6gDloYTDU4mnlXYEsfneO+qTGIK8dP3Jl
         Jl79Ff3x6IVWQEmXPkB+r29blqOQX9FC1My/WAIjSaTzINVzbrbUI0NWipkjgd4cOFlI
         VmKPT716MeSaXGAsjK7ghXweA5duz7Bq9icqWJrNapgFLHMQedqsglwsoLBJNanlvycN
         DSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026080; x=1734630880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev4lgX+KZs+L6jXNa7LK4+bkXUMVJIDLTTwkZV/NGlk=;
        b=QtbvVWLYo6leFRGoSPx9QtA0RpstN9S5cECv7W4hv4PvTUvamrI3Y5uh+LC7QbcBAM
         jy5VP81W7XtGhB7AyNqIE+YHCMm9zqSbvkkt7Upqn73RMJ53MhXzSo2cIC5DAK1tySCo
         mOTXnrO/wn4QsYX3CgXjUoJXVdjzffQn+z1P9kCyiLbvxgHCB8LpoiiqG8B5iZ9A4XGb
         7lCB9sPONgGIz8fu6j5R9ZOxpuWm0xu5LkIHG2tIoiaogW0KWf63dzlMXxYJNU5eaJ4g
         utDg6/yXSOHjExMNptYdzOES6QGI5EBy2tV8y067JCcsRO4sIgl1T+rfzB5WPSGbvqnF
         37ow==
X-Forwarded-Encrypted: i=1; AJvYcCXHyUm7an7mk5D4uffUf563ZfOLdHQD+Y3ML/X2qKcODECzvXSWGYU1R0Mz0i/hSPj2jzXX+7c6d5D2pjS7jJsJzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgnJ7jStMJPEQUm2qA7vsafZLt6Hu42hwaRbr4YYw1zx1QKLh
	GuEP+pw3jntxrfqNFzCp4dMC5XX4V7iGR2YAjiqpap6WKOGWXzBqoNRcUcoI+SxaL10HDnonooH
	5Es1mnsEAHQzonL1nFlo5OYbb+lM7pg==
X-Gm-Gg: ASbGncuXHNBhCxsBJg/e8LkY9BFrCesBM6asncx+alkm5fhsSJfJOoqd5Hfaxl/H2Vq
	88ZHDVjDGOgB2JCVu1SUOCvHNVUOJSlZmGoVmHw==
X-Google-Smtp-Source: AGHT+IFwiU2+XgJj14YAhzP03pHsYS/He28pX3YqZcZ1qvek5TtKSbYPbqCVXQxlqMCXwmmCw2yZUNyoAseSiUIEkcI=
X-Received: by 2002:a05:6a21:789e:b0:1e1:ab03:8653 with SMTP id
 adf61e73a8af0-1e1daaf4b52mr2081110637.9.1734026079997; Thu, 12 Dec 2024
 09:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTUX1L=WDtVaEMWDgCreyphrOLDtjL4Fg3gvQk8ihs0Dg@mail.gmail.com>
 <CAEjxPJ5DXJRRYB+RHfeWm7TYKF=LJKFNFq5X6S8H6JrQwhf4iw@mail.gmail.com>
 <CAEjxPJ57bUx05FYh6Eu-06CEV2-zfWLbo_yz3j-HDDZK0JLnCw@mail.gmail.com> <CAHC9VhRaeQC1amoQSJSNUz1F4FYfJmj5YuwnkJUU_r4ft81Rwg@mail.gmail.com>
In-Reply-To: <CAHC9VhRaeQC1amoQSJSNUz1F4FYfJmj5YuwnkJUU_r4ft81Rwg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Dec 2024 12:54:28 -0500
Message-ID: <CAEjxPJ7A1MDoSB37o8AHN8U3==9ByVTQ9Vkegwk1fMyG9_wH5A@mail.gmail.com>
Subject: Re: The curious case of pidfs and pidfds
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Dec 12, 2024 at 12:10=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Dec 12, 2024 at 11:19=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > >
> > > > Late last year Chris sent an email[0] about the increasing use of
> > > > pidfds on modern systems and the difficulty in distinguishing betwe=
en
> > > > pidfds and other file descriptors when passing or inheriting fds
> > > > across a process boundary.  A few months later there was a similar =
and
> > > > very brief discussion on a related GitHub PR[1] to add some basic
> > > > enablement in refpol.  Unfortunately both discussions faded without
> > > > much in the way of resolution and I'm concerned that we don't have =
a
> > > > (good) plan for handling pidfds.
> > > >
> > > > As we are starting to see pidfds become more common (which I view a=
s
> > > > an overall positive), the lack of a good way to handle pidfds is
> > > > becoming more of an issue.  Having just started to look at some of =
the
> > > > kernel code a couple of hours ago (see fs/pidfs.c) I'm worried that
> > > > many of the access controls we have for /proc/PID may be missing or
> > > > bypassed with pidfds and their associated inodes.  I haven't spent =
a
> > > > lot of time on this just yet, and with the upcoming holidays it isn=
't
> > > > clear how far I'll get before the end of the year, but I wanted to
> > > > send out another email on this topic to see if anyone else has spen=
t
> > > > any time looking at pidfds and pidfs.
> > > >
> > > > Anyone?
> > > >
> > > > [0] https://lore.kernel.org/selinux/da1d9efd-fdc1-4651-8a7a-30ae4a3=
99926@linux.microsoft.com
> > > > [1] https://github.com/SELinuxProject/refpolicy/pull/762
> > >
> > > I could be wrong, but I think pidfds are controlled via ptrace hooks
> > > and those check the task label rather than whatever random inode is i=
n
> > > the pidfd.
> >
> > Apparently I'm wrong. If you take the sample program shown under
> > EXAMPLES in the pidfd_open man page, you can seemingly run it on any
> > PID in your PID namespace, irrespective of whether you are related to
> > said process, have a different UID, a different context, etc. What am
> > I missing?
>
> I haven't had the time yet to really dig into everything, but one of
> the things that I noticed very quickly is that the inodes are marked
> as S_PRIVATE which avoids a lot of the inode level access controls.  I
> believe there are other concerns beyond that, but that is likely the
> biggest.

I think that part is ok - IIUC the inodes are just anon inodes and
don't actually contain any of the process state and reads/writes of
the pidfds don't return or modify process state.
The question though is whether any of the pidfd syscalls or ioctls
allow one to access the process state without going through some kind
of permission check on the task label. It appear that some of the
pidfd syscall do apply checking, e.g. pidfd_getfd() checks ptrace
access to the target task, pidfd_send_signal() likely hits the usual
hook in kill, but others do not, like just polling the pidfd to see
when the process exits or the PIDFD_GETINFO ioctl. We're not just
talking about a lack of LSM/MAC checks there - there don't appear to
be any DAC restrictions either.
