Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FD55C2C
	for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684848; cv=none; b=YzVytbk16dbV578kmARmC0uFJGDCjGU/Xw4cffqvnlNaIhNsnFp1dQRkr5cmW500IlcrEnY0aIeRsawNYODMtZUCXvBJRZyFlPH74pwgvvFR6So1mpyuIXH67a7ceBLw6yRMDHUeIfLeRAAaW/skKlMs6srD9pAGet69ltP1kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684848; c=relaxed/simple;
	bh=VMddoGlM3Hnbo2LIduvF3DDsuQMktZzY1ageAUl8Wa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwydKPPNAMYscHbC7zhJE4woP9stjwuC/0+DHyT88xguw1vAXu67Mq+ysYRHRLIrAf/4GjLO6NbH5sW2D0xSFEPy2EpwJNwNTVf5h6BVS6LSXMeXRbFNSqY4B33NRaRrLKjNLsoHkSt/r1ueb//FH61TpZE3io3rz6XvNjc4J9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b7VbVwa/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b7VbVwa/"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc256e97e0aso752850276.2
        for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705684846; x=1706289646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yjjv0C0A4iL45ZfvIHG0YfKaYF+I6d2xy9d7YamhnKI=;
        b=b7VbVwa/ZdCJZshL6kvLWvqCxsgMnwrlPp34WXP1SA7DYh9mJKJOTP1JM2n7LsDE+2
         59MQWBhpNtf5kj3P50EpmNQqoypmTOv8rlkQ+F15ZP9hnE3H0TnH65fMxVSMbkCO8MMv
         BjTXGuSF142dDLpLuIKRpLzn8rN4tjQfgGdaM7HwwzW2kodxKhJDtlG8aMRDGWXW8NA5
         DGT0cjDnXUiX6/Hbd3VDNNKE8SCFYj5DJiXtaYEb5XCS5BLvc4uNlPkZIlORXeMQRMgr
         QIWGXXMQoPf7ashvj8irEfiPU1U1GQa+VqoRLxa9ilocUvLLZeUytVrMocX2dJGGb0k2
         6LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705684846; x=1706289646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yjjv0C0A4iL45ZfvIHG0YfKaYF+I6d2xy9d7YamhnKI=;
        b=wYkiJOcqfofKs/cnqdAV0EUd0t7pS02gXGHNuBodl/Dv4c1Xz1s4nk2ydSVI6wiAnQ
         ATHasPUBkZGIO/P/SWHb6rm1eUqBp5B2sKAWpA2SHb4JZxNDPAeud5zU273+wz7/4aq1
         ELe1dw7o3Igxm2XH//uHKaxAS5uN1o1JpUWdN4KGvMB+l0hOjFHAQhzGGoPwNPUpbeUm
         4vLeoV6oOOJYLqPHLnHH2ROJcQMx519xFLSBl62AP3/SISSUoOzdKBlIBo8jGMna3/7i
         S3eaZOJwHnQZT5l4Np6xZp+WVUArkaFR6ZiJgbamxXOroIAO2Jofl5zoz3DQ6z8x1ZrJ
         CCgg==
X-Gm-Message-State: AOJu0Yz8HWE2X9Tsw+NJGi68ffCBMCMkSInwIfyIU5amiAaxOIJvn8+3
	b4+ftEQWqZDsjXjQw7NNsqLiprZVpnQDwORXGk8EQFE44PxeB4bHy0DylFu2oglR8YgpW5BgEGn
	/xLULYHX7kZUMgkTVp77iqOQqQ7P+MBXosLRL
X-Google-Smtp-Source: AGHT+IFXg4d8WiKDyeEquwabFJzCscnCekukXwzURRpdmVpPNxI0W3nAiioWj7F7OwIHu/8oS2pKyFI3hK+ClGv0NhU=
X-Received: by 2002:a25:a101:0:b0:dbd:f4e7:5311 with SMTP id
 z1-20020a25a101000000b00dbdf4e75311mr200335ybh.0.1705684845715; Fri, 19 Jan
 2024 09:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRBkW4bH0K_-PeQ5HA=5yMHSimFboiQgG9iDcwYVZcSFQ@mail.gmail.com>
 <80b76dac-6406-48c5-aa31-87a2595a023f@kernel.dk>
In-Reply-To: <80b76dac-6406-48c5-aa31-87a2595a023f@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 Jan 2024 12:20:34 -0500
Message-ID: <CAHC9VhQuM1+oYm-Y9ehfb6d7Yz2++pughEkUFNfFpsvinTGTpg@mail.gmail.com>
Subject: Re: IORING_OP_FIXED_FD_INSTALL and audit/LSM interactions
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, io-uring@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:02=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 1/19/24 9:33 AM, Paul Moore wrote:
> > Hello all,
> >
> > I just noticed the recent addition of IORING_OP_FIXED_FD_INSTALL and I
> > see that it is currently written to skip the io_uring auditing.
> > Assuming I'm understanding the patch correctly, and I'll admit that
> > I've only looked at it for a short time today, my gut feeling is that
> > we want to audit the FIXED_FD_INSTALL opcode as it could make a
> > previously io_uring-only fd generally accessible to userspace.
>
> We can certainly remove the audit skip, it was mostly done as we're
> calling into the security parts anyway later on. But it's not like doing
> the extra audit here would cause any concerns on the io_uring front.

Great.  Do you want to put a patch together for that, or should I?

> > I'm also trying to determine how worried we should be about
> > io_install_fixed_fd() potentially happening with the current task's
> > credentials overridden by the io_uring's personality.  Given that this
> > io_uring operation inserts a fd into the current process, I believe
> > that we should be checking to see if the current task's credentials,
> > and not the io_uring's credentials/personality, are allowed to receive
> > the fd in receive_fd()/security_file_receive().  I don't see an
> > obvious way to filter/block credential overrides on a per-opcode
> > basis, but if we don't want to add a mask for io_kiocb::flags in
> > io_issue_defs (or something similar), perhaps we can forcibly mask out
> > REQ_F_CREDS in io_install_fixed_fd_prep()?  I'm very interested to
> > hear what others think about this.
> >
> > Of course if I'm reading the commit or misunderstanding the
> > IORING_OP_FIXED_FD_INSTALL operation, corrections are welcome :)
>
> I think if there are concerns for that, the easiest solution would be to
> just fail IORING_OP_FIXED_INSTALL if REQ_F_CREDS is set. I don't really
> see a good way to have the security side know about the old creds, as
> the task itself is running with the assigned creds.

The more I've been thinking about it, yes, I believe there are
concerns around FIXED_FD_INSTALL and io_uring personalities for LSMs.
Assuming an io_uring with stored credentials for task A, yet
accessible via task B, task B could submit an IORING_OP_OPENAT command
to open a file using task A's creds and then FIXED_FD_INSTALL that fd
into its own (task B's) file descriptor table without a problem as the
installer's creds (the io_uring creds, or task A) match the file's
creds (also task A since the io_uring opened the file).  Following
code paths in task B that end up going through
security_file_permission() and similar hooks may very well end up
catching the mismatch between the file's creds and task B (depending
on the LSM), but arguably it is something that should have been caught
at receive_fd() time.

--
paul-moore.com
