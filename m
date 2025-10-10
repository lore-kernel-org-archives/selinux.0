Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0963016FB
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124111; cv=none; b=Fu9aV8tqPyIyJ5Rsy6rn3650q5A578YuCfcEjNmSByuIHSavhqmn2jdRvUnHLUXuPXG9NQijK0tcqjZQNrSFhjk1+VdGbebQadb9OcESNDQIXbn7Uf3q2KUemj9DuKz1NfLusCoi78M2blnomOOLFigxxdzl9R+a4PdqfnOEXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124111; c=relaxed/simple;
	bh=hI0WGHXvQRP3WaaPFjQMy4Ip6uIJMlvV5H9Gbic+2Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUgiiGFojSU05lpTSLrk8Y7xL61DiGnRpokfbre5+XqPDXEkHs/jqwLpwQS7WEgMYlWlNV8+dDmf9GxK771rGNoPmIC3cRuBrcLB1xz5tMk+bVEvVB6K7ML8zf3TC2/MvzJfrfrxUp9unX0y5RMmDzbWO5KPDqPuNdRgFzJDzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xzv9H8z+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xzv9H8z+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so1960606a91.1
        for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760124108; x=1760728908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA8UUvpe0qzPleckWyrKGXhRny3dtcOgMvCv+JPF+Pg=;
        b=Xzv9H8z+CdQO5K1snAmioRvvtzZiTPcCWNK5vIRhTpcbhLYeeN/baNI+fvCIyffMbi
         Uo6F7VFZWd3H/uriIRimgU/rH3By6zL759XbMGM2+73wtsLSCh4rSgiRgPPfyNYPnurc
         ZI0prP/SdDg4xRM1+XZPGpKENSVGaRCdBLGg4mpiS1pix79lnZrtpjXq0ashRaaTOxta
         0gtKo9pM0OIwuZ6xY5ds3O+0P0UzadUmpSw+E0P/+ZKYEA2RasoGY/7RCZUCHydBHEyL
         AKLwjmdKMsykkDfOb79AEACV71CJPq5Xn0ybugTb8HCagLGjIUWSnOqPRNM5VqzEPolL
         Hkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760124108; x=1760728908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA8UUvpe0qzPleckWyrKGXhRny3dtcOgMvCv+JPF+Pg=;
        b=QJm3du1x2ro5SoFNYe1kZXgnwfLJ+HhfW0jCL1pNFONTURdcrtnqqFfVoO/FkXIZmM
         RjfE+zjTxmNPgSIcEejy7xHJPT8bwerchPl2BeUZ+QPf4qJ/GBY6tWxAdui7yixK5eGo
         25RlNpViH8hR07KEubfniXXL9zpCSa+SC5N47fHgzAC+HanoH+qJbP4zunElNN2hu3Cb
         +y7ATEvTTx403503oZV9aV0r2laqdI/1q2UoQ7jVHd5PLZ9Tqi5MXgd8OTi7RUCDONEn
         7k0rYuJRwupaQQKV0xCTSeD+4OXoQ9R1atG0aupPd1bxH3Hr1NySN6BDlbLvWsoZrM31
         750w==
X-Gm-Message-State: AOJu0YzmOq/QgPtDYbystFWS+HkovHO4UDMekl8XCSgWLIHgwTgHBOJd
	M1LANMSgCiz4TbbIxX12Xy0PcL63ZMWFHyI1arvspbOBMmCguPQ/0uIOepQ02KxCfke+rH+ZDfI
	ZQDS7e72VwTGGO0wHoXZs9BjLHsY9KiBSs4e/dD77
X-Gm-Gg: ASbGncsoTrCy+s6+BFkwK03OpoSucVGLF+CmckA3FxxbZ2O7F1ozXrRDh7sgx+zbX2Q
	aMmDL63DvModOWY22HcYOjlt91ng4kOBa+bKKa3Vvj2AK1NmPzZmK5hYX/UfTIBapKND3nBRYFD
	mMPIb7kpGnFhtHn6QbkgiEoI0dUL5PJO6sKqcSLeBKDNwAWjmE5fi6j3R1HTtUykd0+DAVNwFS7
	BlIUKVugzpR6Rr6jxYTUteCtA==
X-Google-Smtp-Source: AGHT+IGTeehtBw3qjbGTNM+m5Bdz+uNcBMcC6tRQVVZcF/5MGEwEPmmaiblhvoH9IUwDfz8iTfGVrdjjiO6V++hyzp8=
X-Received: by 2002:a17:90b:4984:b0:32b:94a2:b0c4 with SMTP id
 98e67ed59e1d1-339edac69f1mr23278205a91.16.1760124107966; Fri, 10 Oct 2025
 12:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-67-paul@paul-moore.com>
 <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com> <282070d5c0dd68140ae221833ea8c5ba4baada4f.camel@linux.ibm.com>
In-Reply-To: <282070d5c0dd68140ae221833ea8c5ba4baada4f.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 15:21:36 -0400
X-Gm-Features: AS18NWA1UhcMnoxQZ8o6nsgmKBpdtKMi3SdQHbKu3a6H7VszJ9jkeDxuiYclago
Message-ID: <CAHC9VhTxNhE8CzqGTiq_UFET10Pt04KVQ8V227ro-FQ-KQKt7w@mail.gmail.com>
Subject: Re: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:54=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Tue, 2025-09-30 at 16:11 -0400, Paul Moore wrote:
> > On Tue, Sep 16, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > > evm_init_secfs(), to work around the fact that there is no "integrity=
" LSM,
> > > and introduced integrity_fs_fini() to remove the integrity directory,=
 if
> > > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > > scenario of being called by both the IMA and EVM LSMs.
> > >
> > > This patch does not touch any of the platform certificate code that
> > > lives under the security/integrity/platform_certs directory as the
> > > IMA/EVM developers would prefer to address that in a future patchset.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > [PM: adjust description as discussed over email]
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/integrity/evm/evm_main.c  |  3 +--
> > >  security/integrity/evm/evm_secfs.c | 11 +++++++++--
> > >  security/integrity/iint.c          | 14 ++++++++++++--
> > >  security/integrity/ima/ima_fs.c    | 11 +++++++++--
> > >  security/integrity/ima/ima_main.c  |  4 ++--
> > >  security/integrity/integrity.h     |  2 ++
> > >  6 files changed, 35 insertions(+), 10 deletions(-)
> >
> > I appreciate you reviewing most (all?) of the other patches in this
> > patchset, but any chance you could review the IMA/EVM from Roberto?
> > This is the only patch that really needs your review ...
>
> Paul, I'm sorry for the long delay in reviewing and testing this patch se=
t.  It
> wasn't enough to just review this one patch, but it needed to be reviewed=
 in
> context.
>
> The initcall ordering is extremely important for IMA. IMA-measurement nee=
ds to
> be initialized after the TPM, otherwise IMA goes into TPM-bypass mode.  A=
s
> expected, the initcall ordering seems to be fine.  However this patch set
> modifies the initcall debugging.
>
> The kernel boot command line option "initcall_debug" outputs "entering in=
itcall
> level:" messages for each of the initcall levels, and "calling ...." and
> "initcall ..." messages for the individual initcalls.
>
> For example,
> [ 0.896556] entering initcall level: arch
> [ 0.896556] calling report_snp_info+0x0/0xd0 @ 1
> [ 0.896556] initcall report_snp_info+0x0/0xd0 returned 0 after 0 usecs
>
> With this patch set, the "calling ..." and "initcall ..." messages will n=
ot be
> emitted for the LSMs. In lieu of these messages, the patch set defines a =
new
> boot command line option "lsm.debug" ...

This is not a new kernel command line option, oddly enough Kees wrote
the patch exactly seven years ago today and we first saw it released
in Linux v4.20.

> which outputs "LSM: entering ....
> initcall".
>
> For example,
> [ 2.225821] calling security_initcall_late+0x0/0xc0 @ 1
> [ 2.225825] LSM: running ima late initcall
>
> Regardless as to whether the performance information is actually necessar=
y, the
> initcall debugging change should probably be documented.  Maybe update
> initcall_debug to reference lsm.debug in Documentation/admin-guide/kernel=
-
> parameters.txt.

Thank you for the input, but I would just prefer to leave it as-is.

--=20
paul-moore.com
