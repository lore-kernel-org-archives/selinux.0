Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446D30E84F
	for <selinux@vger.kernel.org>; Mon, 12 Jan 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227252; cv=none; b=Tq9jqvf4H+HqlPPffSkHJIz6s9um3N+KG9/s1RqVI6QucqVeeiP9mcYUrGOK3vQ+s8y18KYigZtl/mc/68Vq/4oCOK68gN48FKs9EZAeTANoRLMhFnwtv9tNUqcJ2PHEU32iQY83wCQBTptEjh4b9s6v2cXGtAYS6E6oupoTIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227252; c=relaxed/simple;
	bh=oJTgfyM5IvICDKoyTHBHFznK1mUCcZD3E0Y4evbifdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TROvZIroUG+OWLqtDWCYwqbU+VqZ6mzI74afXDubP24T3KTyt7TrqcahgQbwcJT8XwG+7B3T7h0SN0dI6TPWqg6dsVKn8U0ITX8GtFUIItIuTa+DRDk9G1UpF1SUqUYQObYr2OsN2NhLMlxVXniCYqaXA/8CghtfV1APA0oxToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewlcIeeA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewlcIeeA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0c20ee83dso57676515ad.2
        for <selinux@vger.kernel.org>; Mon, 12 Jan 2026 06:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768227250; x=1768832050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQw4DWbt/5PgBJphqXvAFJPVOKJkjIHNKZbqArIqlns=;
        b=ewlcIeeA/CrkTxMmDAvgWeuXm19lMLFpYusJQVcMPbQPlAGSspsK4yeh7JbaPNLWlC
         8oGeNFA18DV9NFZI7TCBqMl0nIGbqKqA/o2vYHJ9y+sgWzVpG3gdCZipi6u4pim6VjcS
         ZSdmlq6fElMjJ2Yo597BKiMGDdNHE6zojVofOhcVq0eJghkHEJkjLCxk5WrJcEb6uxkJ
         z84PkTNN7XZ0P2JTz6u9yDItZ/p4Ig7MlX58KQGPgQMLsENaqRdO6IfHMwmwNMtPLMzE
         j9FNHZKrBxLlWChOrtE/ukvHM0Gl+Zw0IpOjk7d21fI1tlhYrrBX/xZy+2xePzmkY9WJ
         HQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227250; x=1768832050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQw4DWbt/5PgBJphqXvAFJPVOKJkjIHNKZbqArIqlns=;
        b=oypFTPqWwQEBkf4b/+HNGmpXbKyZAXDYbFgJP6+zHktM3nPe1ill78drBCgqdXZycA
         24AVhBpzeWL0P/alfHyAkZzZ+ILkNk7a/2/H1nBsCyJkcPHL9KMK6l5otX8VGtAKggFU
         Azzr/uTFyAG5DUvriRnqsWN6EcNXugibVVsdm/2NRM0ebhkQkAxGrBTDkvEUXGkjxszr
         vl2gb+y/hfYDqIQ/c3hBnHldrY6Umytwmcgaw+XYIYreJxsfy+rpxT7f1Er0wEfX+eIC
         9sBz9Yfo7DvRld1rJtIVo3ZAWWcAhDEUxDX4WplX/keKrgikSG0MvWkZb5n25lLuxkvX
         PIuA==
X-Forwarded-Encrypted: i=1; AJvYcCUzKmLeMAJ5QhdzHOZiEGQvjUbspZXCdRSS2E2kUJOfQL1ot0azP/fiHkRCEhEJ3Bk5q1T6gyA2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zdVjF1nf7s7TUBM2W0wERjh7hXCvRXhbQ3mb3Qh7O3zSvFaN
	pjjokv2Acg+618ctdDk5nigyeqD6Q05amdA2hA/yl0ZMzijBuPqTxBab9D8Kbf2oDE6pMrdSXyG
	o8wv3IQyjdYnMCKlLbmlHH31x6mUbaFA=
X-Gm-Gg: AY/fxX4tizIxwjOf5bYXehoysqYuNVWn65SX3PN0vx4fvpTX3cI/asB/tOHzZPLlgEH
	e5asNOIXt3cuGk6ca89Uxap//RTuTDpLK2+56m1COIcACI2T3qSes48zLX0m4+pk8QwzlMhbrTT
	HBazMu7dE57QQrAX8sr48CI9ewvsXkcrP+yWAiEXwqBnMUfcRDolXZ6Gl3VLxlDlB4ReZZuZwca
	HV31O49VVjUMAbr2vPMcUxNOS6JZwOflPo6xVe6bCpaxu2yfJJ2xanjNQ/fMzKScmrsNFDmAxwO
	MNIq+g==
X-Google-Smtp-Source: AGHT+IE+yrlLC31F4kyVtwW5QfjU5isp3twm5hIVbYMeJyPazA9h8VseQYiKOaunY/n/jZ+LOqFp31kLiIpOlhC5M5Y=
X-Received: by 2002:a17:903:1905:b0:290:cd9c:1229 with SMTP id
 d9443c01a7336-2a3ee42b171mr181927875ad.19.1768227250296; Mon, 12 Jan 2026
 06:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205024259.704-1-ericsu@linux.microsoft.com>
 <caeaa280-ffa3-415f-bf39-340f66ee45fa@linux.microsoft.com>
 <CAKrb_fG=OdXSydv0GV8XmtXv2ptfNN=U0ebht_3CTu+oe-wskA@mail.gmail.com> <CAHC9VhRcZb5KKT9yqrqw4odFWgiXgv_-U+KoR=qrtepE5zt-bQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRcZb5KKT9yqrqw4odFWgiXgv_-U+KoR=qrtepE5zt-bQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 12 Jan 2026 09:13:59 -0500
X-Gm-Features: AZwV_QjUVB-pt97l-4pLsJ5zDIrdq7on18ax3ZtKC_EQW38ASUqVjVBIFNQWYrA
Message-ID: <CAEjxPJ5oCPUAaSxoCi9DQGBrPMfXBF-qNvzpxA-+7ZRuSgHdhA@mail.gmail.com>
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Dec 10, 2025 at 12:37=E2=80=AFPM Daniel Durning
> <danieldurning.work@gmail.com> wrote:
> > On Thu, Dec 4, 2025 at 10:12=E2=80=AFPM Eric Suen <ericsu@linux.microso=
ft.com> wrote:
> > > On 12/4/2025 6:42 PM, Eric Suen wrote:
> > >
> > > I need to mention that this patch is based on v6.17. Ran into few
> > > Hyper-V VM/testing issues with the latest kernel (v6.18) that I have =
not
> > > yet been able to resolve. I believe the issues are related to HYPERV
> > > configs, but troubleshooting will take some time. In the meantime, I
> > > would like to get this patch reviewed early.
> > > > BPF token support was introduced to allow a privileged process to d=
elegate
> > > > limited BPF functionality=E2=80=94such as map creation and program =
loading=E2=80=94to
> > > > an unprivileged process:
> > > >    https://lore.kernel.org/linux-security-module/20231130185229.268=
8956-1-andrii@kernel.org/
> > > >
> > > > This patch adds SELinux support for controlling BPF token access. W=
ith
> > > > this change, SELinux policies can now enforce constraints on BPF to=
ken
> > > > usage based on both the delegating (privileged) process and the rec=
ipient
> > > > (unprivileged) process.
> > > >
> > > > Supported operations currently include:
> > > >    - map_create
> > > >    - prog_load
> > > >
> > > > High-level workflow:
> > > >    1. An unprivileged process creates a VFS context via `fsopen()` =
and
> > > >       obtains a file descriptor.
> > > >    2. This descriptor is passed to a privileged process, which conf=
igures
> > > >       BPF token delegation options and mounts a BPF filesystem.
> > > >    3. SELinux records the `creator_sid` of the privileged process d=
uring
> > > >       mount setup.
> > > >    4. The unprivileged process then uses this BPF fs mount to creat=
e a
> > > >       token and attach it to subsequent BPF syscalls.
> > > >    5. During verification of `map_create` and `prog_load`, SELinux =
uses
> > > >       `creator_sid` and the current SID to check policy permissions=
 via:
> > > >         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> > > >                      BPF__MAP_CREATE, NULL);
> > > >
> > > > The implementation introduces two new permissions:
> > > >    - map_create_as
> > > >    - prog_load_as
> > > >
> > > > At token creation time, SELinux verifies that the current process h=
as the
> > > > appropriate `*_as` permission (depending on the `allowed_cmds` valu=
e in
> > > > the bpf_token) to act on behalf of the `creator_sid`.
> > > >
> > > > Example SELinux policy:
> > > >    allow test_bpf_t self:bpf {
> > > >        map_create map_read map_write prog_load prog_run
> > > >        map_create_as prog_load_as
> > > >    };
> > > >
> > > > Additionally, a new policy capability bpf_token_perms is added to e=
nsure
> > > > backward compatibility. If disabled, previous behavior ((checks bas=
ed on
> > > > current process SID)) is preserved.
> > > >
> > > > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> >
> > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
>
> Thanks Eric and Daniel!  The v7 revision looks pretty good to me, does
> anyone have any other issues or concerns with this patch?

No concerns but was waiting for a version based on something newer than 6.1=
7.

>
> --
> paul-moore.com
