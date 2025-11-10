Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC50274B3A
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790378; cv=none; b=p1V6ceael1oHZL4yL55AWGX+Pdo8uNLLd9Aig1OvsjqOaY2NbQtYO+BwRqHWeQlg6yLJORBqgpkuwBdDjX+TbJTBoiNX9ph4aG8mhJtcd5NISa3YLqQM/Bo0nMMEiqU4qVcxpC5Gc0OQM4udfTxNxNlac/iyf6LD7/fy/qk/CEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790378; c=relaxed/simple;
	bh=4ToGFPM89A8KMf+3NwVyDkAMkA1r7oRcL8vJOi8hcfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPCcWGpCfgL+Z/sm7ynpOdFuVo4InxT84ScuOB8ZQDq9ymGBLvqjJb8gcYG0phYCXHLFda5tBS2mAq/8uUC+jKW5Xfg3cpSMZditZx1W0yYdkL9FgO43g3pl8LI4GLSTzr4EnY1d0ymC13ZAFFN+sgP9y692gHu9NJjrn+avi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPDv6hmD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7Iq0eNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPDv6hmD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7Iq0eNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762790375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tGZfCCs/sNAxX3RiKdrnmZErm8OJWyhr/uuOtcwZBg=;
	b=ZPDv6hmD8PTiFOp5DBNByaI+tW73E37iTqlIiUSfzdgd0mtlAMwAlw6UfIXSDR+mxkIofm
	JUq24lXfbxftSQ513EH2w7GGZq6wDAoDg2T5R+YXSWRbAG4KkO00+ZM9jDfb30IxfBSZJ0
	LxCdJX78yyR/n+YhNG4FquyaGFTTWAI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-MZ56XurkPjCYb3vyUO3scw-1; Mon, 10 Nov 2025 10:59:34 -0500
X-MC-Unique: MZ56XurkPjCYb3vyUO3scw-1
X-Mimecast-MFC-AGG-ID: MZ56XurkPjCYb3vyUO3scw_1762790373
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso1689075a91.2
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762790373; x=1763395173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tGZfCCs/sNAxX3RiKdrnmZErm8OJWyhr/uuOtcwZBg=;
        b=M7Iq0eNwhGp4p8oRrDzFjeXgvEKiNAKuGP0uITrDH31E20NattT5gJl1Ut9E/43UHm
         HIj8oopR+hin85HyoHgDKMrEILr+G0PgyfyCmhU6GWChAQ5NWeBUT1u0qQwip95yZUhi
         l9CQdWC9LOe9U4IjrUcjeVT+zRe28a4NyMpwjWULpena3FPzTenj8QtXEuT875G2q+uE
         BomsHtaHEGxuohukwTwhMLBrCEHYe+tJ1qu4en3jveAzFUJc/+o5N2VBB2+G3RjU1ZWF
         M54rj3YIvbOVZmVOFXN9o7ikQWKVRXbSB2B6ttlfh6zRIxRxjjvrQqWW/sD71KDvAUxm
         9nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790373; x=1763395173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8tGZfCCs/sNAxX3RiKdrnmZErm8OJWyhr/uuOtcwZBg=;
        b=gyRnrS/Y/Qb4jeB43/BoZy+v/VsCDgQdPwJBYgpUSQNbhkgJecm/fGRnZL8Ykz09fO
         mEBt0Zlm+v0wpL3L8Yz2P4Rz5g3RZPGp7wn9WA2f3KBB5axZGEniv/tNc+lm7RhgLzMb
         2ad7Hbaz0gc0mhkuSC+Hv4rRUkEL3u2PUjEfm5Td9pnrgseN354CKp5T8IKxI266mROs
         Nj/BVS/tUy28R3CSSvTGYq0b4veHlwvc265sekljdJsKJcBUJDnP7qKrI69NS/+l+BV7
         Ds9IjCbccwYwR4VacjKghT7kOAkaAp0lwG/TZeL0cPiGJwVpfQ3hYGqIZBWkcZq7XJeu
         ZqWA==
X-Gm-Message-State: AOJu0YyuoPk68BH9hBZQ7V20mLuxCqLViBzML4PBb5bdhdWXMPT50Bhw
	d2Pcz9VBCSVxJI5jjXZD/1j5/ITT3+rOBj4wUp8mr6x0YdMs+CLNviy3nuOJY8zCmH2kkPZjOk5
	9erV7Dsz1eJcjOgqm3plEau2yh8dNtuFZ9Ay91xmzTMpXD7UF0kkywpaqd5sEVDpM13KNX+xckB
	mNDI/OQ/51ZWMvhRql3AFUkSXlYooNYykHmVnciKV+JGXg
X-Gm-Gg: ASbGncsVsLFgOCJdNUhhnYXw73cYt9kVKU2jALYqHtXk693IBAgzmiGcxmy9C8KQWWW
	9/puMYAWruWCLt84sCwSJC5hR6Tm0Y0HjfaTd0KTEzthFXwD1xWkDjj8TH+cMOQaiY61yGOfKhi
	UbS1J6RzfozrMkGdG8xyYBX5JxdqarsNqPjnCigNhETbYVYTuEToJor0C4iJa4JYjbVzUVfcRYG
	AKn5KCxVOSSVj89
X-Received: by 2002:a17:90a:d403:b0:340:d06d:ea73 with SMTP id 98e67ed59e1d1-3436cbf89c1mr12318599a91.19.1762790372849;
        Mon, 10 Nov 2025 07:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFukRFvfnXdNFJ5+1nDRyDmf67/iVVy2Csp9o/7x2eNQlVUVSbTtfqFKPDP6YloMDDIiX8odPHKL2Gr9iGznPU=
X-Received: by 2002:a17:90a:d403:b0:340:d06d:ea73 with SMTP id
 98e67ed59e1d1-3436cbf89c1mr12318574a91.19.1762790372451; Mon, 10 Nov 2025
 07:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110141123.51580-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251110141123.51580-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 10 Nov 2025 16:59:21 +0100
X-Gm-Features: AWmQ_blLt5vWcAJWSDLeSSdRtOKGze9s8L1EFbs8mnQ_LOjX2qJZ0-DbbpYPePU
Message-ID: <CAFqZXNsYWUSOXAf1gCy-u6p5tHdALKvqyKQ9aN1GAF33kMJziA@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] Add tests for io_uring
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> iouring.c is a lightly modified copy of the one from:
>     https://github.com/linux-audit/audit-testsuite
>
> Only minimal changes were made to allow iouring.c to work within the
> selinux-testsuite; more could be done to specialize it for the
> selinux-testsuite, including using libselinux rather than hand-rolling
> its own custom functions, but not sure if it is better to keep them as
> close as possible for future joint evolution or let them diverge.
>
> The audit-testsuite only appears to exercise the "iouring t1" test
> case; for the selinux-testsuite, a test script and test policy were
> created to exercise allowed and denied cases for each of the io_uring
> { override_creds sqpoll } permissions and for each of the anon_inode
> permissions required for the io_uring anon inodes to execute:
> 1. iouring t1 without any provided exec context, i.e. child process
>    runs in same context as the parent process,
> 2. iouring t1 with a provided exec context, i.e. child process runs in
>    a different context from the parent process, and
> 3. iouring sqpoll.
>
> To avoid a tight coupling on Fedora policy, which defines a default
> type transition on io_uring anon_inodes to a single type for all
> domains, the test policy is written using the minimal testsuite domain
> type interface so that the test domains are not associated with the
> domain attribute and can therefore have their own unique type
> transitions defined for testing purposes.
>
> Since the base policy on recent Fedora includes the base set of
> io_uring permissions, the conditional guards in the policy and
> tests Makefiles simply test for the definition of the io_uring
> class in the policy support files to determine whether to enable
> the test policy and tests to run.
>
> This change does not include tests for the later additions to the
> io_uring class for cmd and allowed, which were added to subsequent
> kernel versions. The allowed permission does not yet appear to be
> defined in either Fedora policy or refpolicy, so testing that
> permission would require a modified base module. Such tests should
> be added in a future change.
>
> This change also does not explicitly test that io_uring operations on
> files, sockets, etc are subject to the usual SELinux permission checks
> for such objects in the appropriate subject context. Tests for these
> should likewise be added in a future change.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 addresses feedback from Ondrej Mosnacek <omosnace@redhat.com>,
> including updating tmt/tests.fmf, the README.md Debian list,
> and adding --pid $$ < /dev/null to the secon commands to avoid
> a dependency on having a terminal.

The "< /dev/null" isn't actually needed there, I just used it to
demonstrate the bug. Anyway, I applied the patch with the redirections
removed and also removed one extra empty line at end of file that git
warned about.

https://github.com/SELinuxProject/selinux-testsuite/commit/3b4e44eb32430163=
b5e823e266495dc57813fe9c

Thanks!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

