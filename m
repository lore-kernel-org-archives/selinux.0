Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9357330
	for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686873; cv=none; b=AfxIYuq/sgMbXFonztuaL3fQafgJlhFA/vsxUioyQuzYDUaJ4oZE7ApLOMKAvqBU8sMxutVDvATJ1EDxuwazlifyzKXww+YXDYW0p24O8iZrR8b4zOwniw8IvzrW/htn5bEZc+42SBVOQupu+yp/jTuIExTQPfZ8MRg6+E9CJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686873; c=relaxed/simple;
	bh=boTrg/1W3lzWNgbiudbkYHEdbuys38hwpy2WCcozWWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJdbCQsRzi6IH0Gv/RVWyu3x8PqKDHmTs+uL3fqGm3ikjeTJrhbKIqYv1nkRwn3gX+bOE832arWWXaYR5SJanm1o7FVOrX9FvhSbQIISf3UUX0U49yJPtqcM9CxPBEFsfFf8Wh6taqdSiWonVwgHS+6EVQTicXkU8byOFLqP+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OlrmZP7d; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OlrmZP7d"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so1054983276.0
        for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705686871; x=1706291671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YImctniov99fnAhSQAoU8PYK+WctTBxQAwf+URIRT0=;
        b=OlrmZP7dN0tIgzo3FrP3VavmrBZ8kpPhX+WxjoACjZ1gIBWqI/HdUBgPZAfGE3Py7q
         5t+6irOxxGSEF/Yrh3Yd7qVMu1JmP2+B2IZuGk5kfdxCkzE+0S6OImZ1NrtRWmvWf6in
         n9fdYs8VF0f5IoZaadYoBkpFJFKg3m2L1exUY1oM0s3g0sFs83dZZleHD7dpKoTcvJV2
         Hya541n6GK9um3+F2qDvcqUI7+C89s+62cyLg4w5q3PXD58Fv+HV31xmsoTkNZn62ULi
         uDl00IPKdqKi0uUgeYZ4ahpQnW682+5PwcweYLFS8FKTYGYLL2xXWJUNiF/oN7fhaXtA
         6qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686871; x=1706291671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YImctniov99fnAhSQAoU8PYK+WctTBxQAwf+URIRT0=;
        b=qZHCVwkFPkV+pYYDQeOBUS+4Q3jo2Nqf7wwdxre6ZOnWy5v5W8YrQMfBDbBnvCUWtu
         PnlPJxnlGFicJIxEaPWKJGZvFYpzoEHpV6urwW57Ez679mQod66OQ9wObJR3l3jKU6H4
         lFl8yZo6diBACQ4ak9Z+mso1V3CxoE83jwIUE+geLL+x1JP4Azj203/KOXllM3eey3q/
         tscV1lciL2bY6ZDwoS+dPot1RDcUwdeFFsBnjB4JegXU1tJU/k5VVH0eMeSlpzrPFBBq
         6x/BRuvxl5JH6qF7NDMfu1zC7ftmPG+FvZbuulh4NMWfSMqITs19xWNa1dmT4MBJ82OP
         yUzg==
X-Gm-Message-State: AOJu0YyfUg0RE0jC6xsg7qaRRUO7hQLBGJtdQla1l4MR2fgTHhMJpUE6
	6ECWYpgkxafllJxJMBruGvFaXP0/jb6pYhr9w6qkXd8HhJCa4lmNR0Lw39HC7pHuqvWBsHienSv
	2g1b+3Uc4d9WftVwBW+3w4K1LQcOVbGP3pVaf
X-Google-Smtp-Source: AGHT+IE0iBubnXg45S7uodfCUhmzDvqiTaMbflNNeK2mak/EGPYuCgeX4euNa9vIEswbaUyBNlV1wycDwXLnYuYsrKo=
X-Received: by 2002:a25:8584:0:b0:dc2:22e5:fc59 with SMTP id
 x4-20020a258584000000b00dc222e5fc59mr273763ybk.40.1705686870861; Fri, 19 Jan
 2024 09:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRBkW4bH0K_-PeQ5HA=5yMHSimFboiQgG9iDcwYVZcSFQ@mail.gmail.com>
 <80b76dac-6406-48c5-aa31-87a2595a023f@kernel.dk> <CAHC9VhQuM1+oYm-Y9ehfb6d7Yz2++pughEkUFNfFpsvinTGTpg@mail.gmail.com>
 <610f91a7-9b5a-4a07-9912-e336896fff0c@kernel.dk>
In-Reply-To: <610f91a7-9b5a-4a07-9912-e336896fff0c@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 Jan 2024 12:54:19 -0500
Message-ID: <CAHC9VhSJn6Kd=M8N-pLgJMvo9bhtdB6bX_xK=8aPYj5qQ8aTvQ@mail.gmail.com>
Subject: Re: IORING_OP_FIXED_FD_INSTALL and audit/LSM interactions
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, io-uring@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
> On 1/19/24 10:20 AM, Paul Moore wrote:
> > On Fri, Jan 19, 2024 at 12:02?PM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/19/24 9:33 AM, Paul Moore wrote:
> >>> Hello all,
> >>>
> >>> I just noticed the recent addition of IORING_OP_FIXED_FD_INSTALL and =
I
> >>> see that it is currently written to skip the io_uring auditing.
> >>> Assuming I'm understanding the patch correctly, and I'll admit that
> >>> I've only looked at it for a short time today, my gut feeling is that
> >>> we want to audit the FIXED_FD_INSTALL opcode as it could make a
> >>> previously io_uring-only fd generally accessible to userspace.
> >>
> >> We can certainly remove the audit skip, it was mostly done as we're
> >> calling into the security parts anyway later on. But it's not like doi=
ng
> >> the extra audit here would cause any concerns on the io_uring front.
> >
> > Great.  Do you want to put a patch together for that, or should I?
>
> Either way - I'd say if you have time to do it, please do!

Okay, will do.  Just a heads up that due to personal commitments this
weekend a proper, tested fix may not come until early next week.  With
this only appearing in Linus' tree during this merge window we've got
plenty of time to fix this before v6.8 is tagged.

This would also give people an opportunity to point out any flaws in
my thinking - in particular I'm looking at you other LSM folks.

> Probably just include the REQ_F_CREDS change too.

Sure.

> FWIW, I'd add that in
> io_uring/openclose.c:io_install_fixed_fd_prep() - just check for
> REQ_F_CREDS in there and return -EPERM (I think that would be
> appropriate?) and that should disallow any IORING_OP_FIXED_FD_INSTALL if
> creds have been reassigned.

Yeah, easy enough.  I was originally thinking of masking out
REQ_F_CREDS there, but if you are okay with simply rejecting the
operation in this case it makes everything much easier (and more
predictable from a userspace perspective).

> >>> I'm also trying to determine how worried we should be about
> >>> io_install_fixed_fd() potentially happening with the current task's
> >>> credentials overridden by the io_uring's personality.  Given that thi=
s
> >>> io_uring operation inserts a fd into the current process, I believe
> >>> that we should be checking to see if the current task's credentials,
> >>> and not the io_uring's credentials/personality, are allowed to receiv=
e
> >>> the fd in receive_fd()/security_file_receive().  I don't see an
> >>> obvious way to filter/block credential overrides on a per-opcode
> >>> basis, but if we don't want to add a mask for io_kiocb::flags in
> >>> io_issue_defs (or something similar), perhaps we can forcibly mask ou=
t
> >>> REQ_F_CREDS in io_install_fixed_fd_prep()?  I'm very interested to
> >>> hear what others think about this.
> >>>
> >>> Of course if I'm reading the commit or misunderstanding the
> >>> IORING_OP_FIXED_FD_INSTALL operation, corrections are welcome :)
> >>
> >> I think if there are concerns for that, the easiest solution would be =
to
> >> just fail IORING_OP_FIXED_INSTALL if REQ_F_CREDS is set. I don't reall=
y
> >> see a good way to have the security side know about the old creds, as
> >> the task itself is running with the assigned creds.
> >
> > The more I've been thinking about it, yes, I believe there are
> > concerns around FIXED_FD_INSTALL and io_uring personalities for LSMs.
> > Assuming an io_uring with stored credentials for task A, yet
> > accessible via task B, task B could submit an IORING_OP_OPENAT command
> > to open a file using task A's creds and then FIXED_FD_INSTALL that fd
> > into its own (task B's) file descriptor table without a problem as the
> > installer's creds (the io_uring creds, or task A) match the file's
> > creds (also task A since the io_uring opened the file).  Following
> > code paths in task B that end up going through
> > security_file_permission() and similar hooks may very well end up
> > catching the mismatch between the file's creds and task B (depending
> > on the LSM), but arguably it is something that should have been caught
> > at receive_fd() time.
>
> If there are any concerns, then I say let's just explicitly disable it
> rather than rely on maybe something in the security checking catching
> it. Especially because I don't think there's a valid use case for doing
> this, other than perhaps trying to bypass checks you'd normally hit.
> Better to err on the side of caution then.

Agreed.  I'll go ahead and make the change.  Thanks for the quick
responses and understanding of a very security-biased perspective :)

--=20
paul-moore.com
