Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575B1A5B9D
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872138; cv=none; b=VjKLChLF8qrjNTESqzfTqMjJLk8sY5mA2TZaJkY/SH4kNbGJavJY/t7mZNyKlrgThnpSvL4R9LzBxGn5vLPUjJoaSXMypZz4bxsHXxQCimIerTe+shKUHcqMXKV4Vf2+4y33nRlzYmcyfa4gU5tWvGZjRP9aAb7G0zuvh0UlYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872138; c=relaxed/simple;
	bh=G+UeIdvDmhozOMev50uzQC5IdqFkVytoBs+wlNeCBGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZpCC7nxsx6VLrwr75wZu5jxVPoQVXhJNHmcdcq374aIqBpfzp6ss9iwxEXPIegP6G4fUHk+tUuNZ3wRbLGtRA8Wg4ypIVedz6rOdwFtWdodNGjOHU3XEc1LXgLwKh/GhbtFq5yB+oF0jEQdptALgpysOrBgBnlIFb8pLRObMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VO6/9sP6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO6/9sP6"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso3334e87.0
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 21:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756872133; x=1757476933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBAgkezvjtgsEvFnaLUOfCYAhLD+HNKmsnLKlupg1TQ=;
        b=VO6/9sP6JW2mU78w6Yg3cbGzqAPuSIJfIih9k9FXVhTzcLk7F4GFqvzRCdtHt78+Rq
         AmDQvRVq6/HcpOvrE5NW44qBddAmFVXC6jxpRNnzwO4Acex1DS91rRCCn6WEA4dYxbaE
         gKP2l3oAKBVfk22sdIvENsaktBa0BLOimIlUC7NVVQ3VcHGqgHVoumiNQhB2WE8Zhgwv
         ryXgzxvVlhEKZH2dhvzzK4o/tU69WDE9691+Su8aAuwDZmrTpzHXko2eOv0B2Cc+zjCQ
         tPgZFJuu/08xAvEJkTN7CpYcGV4SsbB14Xn+kDSLtxgNkNVM8elItZ034/+TDdY3JLss
         zISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872133; x=1757476933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBAgkezvjtgsEvFnaLUOfCYAhLD+HNKmsnLKlupg1TQ=;
        b=mBdM7E/Q6o+WDZzPPMdCgIIpC9HkopXS2+YoEa5ejaLO55H9hA5Q/xUQBDHW0U83Gd
         fqUElrLrILKfOdSmiWM8xwrBNmItVL5e3lWE+lG9JGQ+dVav5n1wIHey104Euy2gbM4A
         qMgX2XQ29g1A/rapa7LeW23H0Q4irERvx1VF3a+t7f+KHaPXQ+5NJB8I9uq88Ilp5KeB
         0CVgmJrLIo6d1iKC7uAjvtFxAL42LHH3hwS75eqvXUFYr3jxM9Axfs++kifyMytNA53m
         tCOzZnk7kmjIF+zbjr08B2axJExBUGLvCFQNhqOCDKwv+s6rvulZ1VAX1w+Thl5hbs+s
         Na7A==
X-Forwarded-Encrypted: i=1; AJvYcCX3oYejjVWOspchAvoj0b4NjmsXmnUvJyEVDcegJPYk0vyO2mMgjXDsIkqBf8oRG9g3tfRjPQw5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sBWtUcRev28TpiHGy+G7NpzLGqtNHzhAYN4KFh5ad49uLW4K
	vDLlEWw3U2M1sMoxpjWZ6Q0Diw5KJLxuGUL98C0eNUA4HtPzDwWsSICbO8Vp9Mw4VJYOk+YkzA6
	A26ZRtaBr0o7GRwVeK5VW+jFy/Ah9lbYpCuSHB51e
X-Gm-Gg: ASbGncukFI/V4XkaKu7Cmt+IwVig+6NhuX3jGBplP/brf0onES2I8oXnuyHLv/UyAfr
	MCWjfAe6u6uuuSuNzl/C+B8lTzTBXnnEC1jTgg7/pD7oOZOBbDbYQlEeccXLGxhgBWv/iZ7QwHh
	2+UwjlTzOkdWTHSiZrdxWDkAq5QdnZMNQbDoMo8Dx5zhVd/TNliDxgGiXGrXoUWs2vL3UdIhIgJ
	Uvl3CkJdIFHZoAK0UYx2W/c3XRLNxfiGYaJPRI/Fw==
X-Google-Smtp-Source: AGHT+IGRgTBvxXLf3FUe9pbA+Gbgb46OBUk433uJ9Au+0QZmxdHaZw5915xHIwg0jxvzefS4DQzR5Stkj4/hrd4rzT8=
X-Received: by 2002:a05:6512:3b0c:b0:55f:6a35:dd47 with SMTP id
 2adb3069b0e04-55f6f4e88ffmr932686e87.4.1756872133264; Tue, 02 Sep 2025
 21:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055401.618729-1-tweek@google.com> <CAEjxPJ4UzRUKkWgoO80hpPF6HhkPM_DUq7BV4+Nh6RhRAdpP7g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4UzRUKkWgoO80hpPF6HhkPM_DUq7BV4+Nh6RhRAdpP7g@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 3 Sep 2025 14:01:55 +1000
X-Gm-Features: Ac12FXw8h010kBDqu6PajImHLoBoqppS5Ydr2dylJhyi2HiGp9YU-XTaZ9zML78
Message-ID: <CA+zpnLdDjWK9Bz82moHrgEL4vtAkXvujPmj+JZcrk=TKidnpeA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for memfd_file class
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:08=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 2, 2025 at 1:54=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > A new class "memfd_file" is introduced to the kernel in [1]. This class
> > is only used when the policy capability "memfd_class" is set. Add tests
> > to validate this new class:
> >
> >   1. Validate that memfd_create() requires the "create" permission.
> >   2. Validate that fexecve() on a memfd requires the "execute_no_trans"
> >      permission.
>
> Thanks for this patch. Do you have example CIL modules for defining
> the memfd_file class and memfd_class policy capability that we can use
> to exercise these tests without needing to modify the base policy?
> And corresponding sed command for updating
> /usr/share/selinux/devel/include/support/obj_perm_sets.spt to define
> it for use by the test_memfd.te file?

Thanks for the review. Here are the changes I added to the tmt
configuration for testing:

    # Fix the current policy.
    semodule -c -E base
    sed -i \
      -e 's/\((class user_namespace (create ))\)/\1\n(class memfd_file
(execute_no_trans entrypoint ))\n(classcommon memfd_file file)/' \
      -e 's/\(anon_inode socket\)/memfd_file \1/' \
      base.cil
    echo "(policycap memfd_class)" >>base.cil
    semodule -X 456 -i base.cil
    rm -f base.cil

    sed -i.orig \
      -e 's/\(define(`all_file_perms'\'',\)\(.*\)$/\1\2\ndefine(`all_memfd_=
file_perms'\'',\2/'
\
      -e 's/\(class file all_file_perms;\)/\1\nclass memfd_file
all_memfd_file_perms;/' \
      /usr/share/selinux/devel/include/support/all_perms.spt

I've pushed the complete tmt configuration I used to:

https://github.com/tweksteen/selinux-testsuite/commit/6920c02f6d78a9ddd190c=
62479df3b7569c694cf

I am not sure which part is suitable for upstreaming, probably the
policy update similar to nlmsg?

> Is there an actual policy version dependency or is that just
> cut-and-pasted from prior examples?

cut-and-paste, I'll remove it. I assume the check on capability is
sufficient here?

> And then lastly, please run ./toosl/check-syntax -f to fix up
> formatting issues with the C and perl code before submission.

Ack. Thanks, I will run it for the next version of this patch.
