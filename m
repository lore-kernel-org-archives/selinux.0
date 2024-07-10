Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138382F36
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579678; cv=none; b=jq1R/0TRwEGmeAQJCzgHGZDE6SrB5DQzq16lGbyY4a7KDHpfl20xTu2v/2LrpXgjl8KPtVBBrH6lPQoVK4lhfd8ujtsJV5SYzzMjE+xmWVLd6y6zeycFgH9pyiG3pRyI1XrRkHXIso1eE8SjG1xsyAll7Np/870BRsd/1kUJr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579678; c=relaxed/simple;
	bh=lMo0JXrk/hycW5W25YWDIVGLQsi/Z7lN/n001w/5sA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpUgDwgkg8L+NOMZen/caVaZqYsNOi8mZODQ6E/1v4CBG4JlWvdlnDGAKuJBaOVTjFFAIkYDjEQYvDmkElL8WeRGT538XMdU1+PK3cz6M0B/wx2ClDZXRb7yWL1zPUGyP62zDeA69ipvUtJGZB1cxor2YtRj5pXGq/FH2V0+/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OtRHra7b; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OtRHra7b"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03db345b0cso5006397276.1
        for <selinux@vger.kernel.org>; Tue, 09 Jul 2024 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720579676; x=1721184476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yVYb311QnErZM4L5Y/2obPkhPem1pui5+2OLTDdlq4=;
        b=OtRHra7bLJi5649x013jc9o3aBcZPzlvSrGSB+m7bcQSI06/SVgOEPoWMUkPpHjldS
         PqckQqMS4zdotlaU2gsdphpCYqg2Q/fDd3cQfH0tuoR8/D55kfmk5cxblpxwAknTgaEl
         uyvoHCHP9w5TPEFvWyeiuFMDqwQSLuF9melrAzadUKKJx/07KCoAlYitiuAVoH+JFhqq
         QURXf+7+JllVTVMolY/R0hWTqt0mu6K/tgkvIHRbgixsg5ZuKOBcNK6p1ZRILK2Nvp5V
         ksvesW6LewqPOnLZxmNhPdB/A7DyPJNq2y0x4NvaJpmk+e2AwaXkvJX5IUHuc/SaPu5U
         nxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720579676; x=1721184476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yVYb311QnErZM4L5Y/2obPkhPem1pui5+2OLTDdlq4=;
        b=h7YRrPKtduD0UMdNGTJ+TjqGFDAOPWK2kfJhX0bcFH64m9Rbryk9Ime7Hv67i+GkhS
         9cw1QJrt3n9F/Zaw+FwXzYQmg7GQ3lkMWqDPsj3KEoEdZCzDm/JkMb4qaPANabmlj7XQ
         G+KBfoHs0WqlPAbZlf9NHJfbgmaeRKvwILWzBdaRf2oQEvT7NnMbXNxePB3kpR6cD1JN
         05l8kT88zKeSLuUmqUiRGdYZyA5/OVIAGj+ip/vvfzErkkDk/6r3iis7fTqaZnBH56RF
         ilQpbT0s+3sM5jPNfspiZ0K4ehlhGqXx/swhBX91CDVayEjU5JPQVxGmHEJepxaffc/9
         9m0w==
X-Forwarded-Encrypted: i=1; AJvYcCWoSo2LARKUYJOyObb/npZrBCJa2dA8O9kvT0IaWyN3vKUKHvHJmU1frI1Ggnuq+xtbkckZpo5SREkKxg9uSpOjBaOimBdwGg==
X-Gm-Message-State: AOJu0YwmmZLNqofHx8EEv35i5kZBRoAbSMqEDUK3MVUoL7aCwOeWeztG
	2wJ+4OrDuYSNmnIloqJyMWztIA8dPX9WUd11ZG0JbZMeg3dEgIjlnGSZyi347jabwqrMIM+cLz3
	xPJGd0hHknKxgRWp+CpLIUvXWh2PvZ88P5Vtc
X-Google-Smtp-Source: AGHT+IEyLpZ8aD7RQiEruu/Kpfqpl9db+ZYGiq8CiZtBHn73Jxa7oX7k7YpkJTp8gzuQeGeEAIj/YuYT+ClGkAxdSAA=
X-Received: by 2002:a05:690c:6a13:b0:631:3718:584a with SMTP id
 00721157ae682-658f0fb3a0fmr49604067b3.50.1720579676004; Tue, 09 Jul 2024
 19:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com>
In-Reply-To: <20240710024029.669314-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 22:47:45 -0400
Message-ID: <CAHC9VhRAHg3pjHLh8714Wwb-KYReEijfE_C3i48r72VztUmdJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The LSM framework has an existing inode_free_security() hook which
> is used by LSMs that manage state associated with an inode, but
> due to the use of RCU to protect the inode, special care must be
> taken to ensure that the LSMs do not fully release the inode state
> until it is safe from a RCU perspective.
>
> This patch implements a new inode_free_security_rcu() implementation
> hook which is called when it is safe to free the LSM's internal inode
> state.  Unfortunately, this new hook does not have access to the inode
> itself as it may already be released, so the existing
> inode_free_security() hook is retained for those LSMs which require
> access to the inode.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h     |  1 +
>  security/integrity/ima/ima.h      |  2 +-
>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
>  security/integrity/ima/ima_main.c |  2 +-
>  security/landlock/fs.c            |  9 ++++++---
>  security/security.c               | 26 +++++++++++++-------------
>  6 files changed, 30 insertions(+), 30 deletions(-)

FYI, this has only received "light" testing, and even that is fairly
generous.  I booted up a system with IMA set to measure the TCB and
ran through the audit and SELinux test suites; IMA seemed to be
working just fine but I didn't poke at it too hard.  I didn't have an
explicit Landlock test handy, but I'm hoping that the Landlock
enablement on a modern Rawhide system hit it a little :)

--=20
paul-moore.com
