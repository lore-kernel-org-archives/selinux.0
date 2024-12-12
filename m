Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC02139D2;
	Thu, 12 Dec 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023441; cv=none; b=qvsfmUVGTndySTtv5BVBfcefjroE1McDkstYoF8QLXL1e974+Ru/lQRYf8sAyzICVx/JxCbnZG824MuTw1pBBq+pJZpiIkVUAfkIBAWUj6SvntaaKzXjal3kw7URRDfD/BzSBVf1dJuJTeUZM0wgnjrQOx5URysAElScUqHPR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023441; c=relaxed/simple;
	bh=jJ4vxJzwkLKcvaiN5JDvcD0h/aUPJZNjkkjjQ+R74zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnXzoGMiUnwPUEWrkhuvTJemnt9DwcZ79h2nCurz74pGz8KH6sSD6cStnYoyXo1cPMjgUAQ5hH4VN+7JiJ8ISYej4fsktDMBeQRvE+UWHbFEdOiW/WgwwNPGTlresPOtbsLyC3CItKapzY3nYeOyUB4PNFkecQGwVY9BynOpfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy+lV9Hr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy+lV9Hr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ed193c9eso739245b3a.1;
        Thu, 12 Dec 2024 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734023439; x=1734628239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGg/1yqGqYAIfNZjT4PnWcO5DxVjHUYawCu2OI0SXt0=;
        b=Cy+lV9HruksYzWtfPVjPTS5gZoGWDGGz2KO8QtlclKjoqLbC71fPj2jfKxps1DntbU
         M3fxasXB05BW/bi1/E9KBr2FB9oYyqcS72Owy5o6BJPTsy1Z6zM05JbBVL2NvdAZoE0W
         YFVdYoTkoM46nSP1HYw8NFbfZnl2Km8SFc/nYfacWvCX9YLGrRj9zb2LdSKqzVomZrYw
         VGMCnLiK/FgVd7+uJge5E5U9gI8+8yUynD0OmRbrKHepMSv3xe/CvlPtibgz6gmmKpex
         NstYTQYAfqtenKXK+iY89CKzz+4AYpHC3ioOsqdxOc6wTYoBTOMu86YmmpBbWgFrDJ/s
         UXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023439; x=1734628239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGg/1yqGqYAIfNZjT4PnWcO5DxVjHUYawCu2OI0SXt0=;
        b=Ey4pBcHCa2reHnhkswq9/CKnZ0yuFexxAWWdDB65DdGYQy/wU3OPDkGZXqRTju4rNJ
         Xb5BXxxZoUccpDvnvJznFsOw3DJSwDvT9zozlvp+1ZIZF4iKRsRWPTcBeFWFXgawlpLW
         AV1difXPeclC2a3keoIsFyalBpn0/ujHgZ+TD/whyvda917TYvU4i4wU+8ifXTKSyy2j
         f8rVh9iR8BV/FWMaXFr8cpLvDzn3/kvNlutWkZlTzzzUaNTNC8bhGl2JpM+izTD38ZcT
         zPjqMM1QIchHS45Hl4cyee/p1nLUpn8wuZ3YnMXHA01+zmiPar2JByi6/wtxEw0O+TMy
         WNLw==
X-Forwarded-Encrypted: i=1; AJvYcCXUAIMll2gFDMZxX4J9O9qDlvBb3yXZg30cNEjEIzbr/ApWeeqA/pftMH5FC6PaqKeoOT2fLD3LX7YJG/E+Sd3Usw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynGZIUxuKYHmkX9OBY+U8PimAa8/CyjfA2cPejHnnuRmlcPTNL
	1vnZjvEsSft4G9CUh/TTSmNOpgBglrUbDTcAbpyhOXG+mjJuH/jflAU98yp73BfBBp/pgvcKi4e
	9MaSujyQIDLQFRzE9WeDBGUWJezc=
X-Gm-Gg: ASbGncsWvSiF/8BbZzHuh67aKrk0iMXCUnuyLCjqS7ZXq3L9Vyst0KzYjkgd/r3nz8Q
	38cTolBPFUqoNbms1b6PoH0jesY9Wf8t0sjE+FA==
X-Google-Smtp-Source: AGHT+IEfxZHw8I5O8L7cFLfUG6CMhCbG0aLiHU1n1pTDwFP5RkkrXZTs1shs5n107y0RNoNl0Xx6Wv6AdcrEXIfXNdg=
X-Received: by 2002:a05:6a00:300a:b0:725:8c0f:6fa3 with SMTP id
 d2e1a72fcca58-72906bf2645mr1504872b3a.22.1734023439024; Thu, 12 Dec 2024
 09:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTUX1L=WDtVaEMWDgCreyphrOLDtjL4Fg3gvQk8ihs0Dg@mail.gmail.com>
 <CAEjxPJ5DXJRRYB+RHfeWm7TYKF=LJKFNFq5X6S8H6JrQwhf4iw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5DXJRRYB+RHfeWm7TYKF=LJKFNFq5X6S8H6JrQwhf4iw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Dec 2024 12:10:28 -0500
Message-ID: <CAEjxPJ57bUx05FYh6Eu-06CEV2-zfWLbo_yz3j-HDDZK0JLnCw@mail.gmail.com>
Subject: Re: The curious case of pidfs and pidfds
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 11:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Dec 11, 2024 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Late last year Chris sent an email[0] about the increasing use of
> > pidfds on modern systems and the difficulty in distinguishing between
> > pidfds and other file descriptors when passing or inheriting fds
> > across a process boundary.  A few months later there was a similar and
> > very brief discussion on a related GitHub PR[1] to add some basic
> > enablement in refpol.  Unfortunately both discussions faded without
> > much in the way of resolution and I'm concerned that we don't have a
> > (good) plan for handling pidfds.
> >
> > As we are starting to see pidfds become more common (which I view as
> > an overall positive), the lack of a good way to handle pidfds is
> > becoming more of an issue.  Having just started to look at some of the
> > kernel code a couple of hours ago (see fs/pidfs.c) I'm worried that
> > many of the access controls we have for /proc/PID may be missing or
> > bypassed with pidfds and their associated inodes.  I haven't spent a
> > lot of time on this just yet, and with the upcoming holidays it isn't
> > clear how far I'll get before the end of the year, but I wanted to
> > send out another email on this topic to see if anyone else has spent
> > any time looking at pidfds and pidfs.
> >
> > Anyone?
> >
> > [0] https://lore.kernel.org/selinux/da1d9efd-fdc1-4651-8a7a-30ae4a39992=
6@linux.microsoft.com
> > [1] https://github.com/SELinuxProject/refpolicy/pull/762
>
> I could be wrong, but I think pidfds are controlled via ptrace hooks
> and those check the task label rather than whatever random inode is in
> the pidfd.

Apparently I'm wrong. If you take the sample program shown under
EXAMPLES in the pidfd_open man page, you can seemingly run it on any
PID in your PID namespace, irrespective of whether you are related to
said process, have a different UID, a different context, etc. What am
I missing?
