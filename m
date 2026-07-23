Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21233233704
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830799; cv=none; b=VBCiQXk7MrDlg+OZE8JHBFhmS4tH+x34Xon7mVXqjmtGUCQtr/7EIlCwI3QMZipWBtPtqZJQ6ZolqJS7sN5huEJNM1aApxlHzeCF4rIL4afUEfBCYIKzHdJqOXXQSsbgaS5Kzqgmm74z0UwW31bky8z8cj4O4VXWQqLvEGPcvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830799; c=relaxed/simple;
	bh=pI7/WtZOHzSScov8+QbTEhBJxeSAlAowONsIBY+cVFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr1fPLVhfmhV7Mj9hK49g6t/c8of0hwaZUAT66SchGMdxtMtQKLvoQmpE2pJbTH93p5644UK2R1q/UHAL2AUWTI2p9J+avfkVzfPIRjOXo1XMoVTLN5nINmb2g032pQDDXNilPQx+Ceezn/TIiz3oVUSdixH9p2Rm2PvPBdcRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktSxNb3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktSxNb3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC01F00A3D
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784830791;
	bh=230JIUQQh1B8eXgnA7apJW7i59Sy5/z4fOTfm/SVITY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ktSxNb3cR0on7rn7A3P0kbIKvesh+jXX7dggrnZPQ2DQ0hFk7Mek5xOcn98cyfasn
	 NzN28wMx8G1ieUm7rh6K1x+BjetK3fxlF7itmTj+YwqxSelB4IxM+v8VFG2qfmS3ot
	 S45eFjj/k44D3QSETUqo7BvzZWNu9gp3/XLsE1U15gF+Hwigx9t5G4HHgWXi+MRtnU
	 Sf/fMAgD9VBHhKzwikm88JSLMFkfxS3G1wXdHLoXru5zpU+vTw+JUmZ/ekDQHAvzEs
	 P9IqmSCmHShsvMPTzOuHvvUEesxlA2x7lk5yJUemfowKBHoovbffGqXT2FuCSyLRxQ
	 6FUX98+/qRRTw==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e50979c71so127060285a.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 11:19:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RroNdUixywYufFr8E1shiX0j4N9STe0hFV8UG7H2x/c7vmqk/BAoJ5U9jVCbPUX7F/xG6IWLPi+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6paZ9BfKmD4RC7s4q85jv2OytzT5uFXFS1SlrSPGbYFHi4L5E
	RfZZ/ylL+i6cg3Jxe1/HSV0b9jy1L8OjTuRZ99vBoSXrkjiRuo/2FxHaAEmaPnoB3HkpS5jHBxR
	FLGt0EojhwL8PH8BGvwco9nT2Ae1oFVQ=
X-Received: by 2002:a05:620a:4606:b0:92e:c117:9eaf with SMTP id
 af79cd13be357-93103b4a81bmr439311085a.93.1784830781920; Thu, 23 Jul 2026
 11:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org>
In-Reply-To: <20260706235053.4104951-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 23 Jul 2026 11:19:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
X-Gm-Features: AUfX_mwQVJsDURmFHDnLlF8xG3as6jhlEKJ7pwuuU3MpfW-PPAUe3hPTNSoz2Bg
Message-ID: <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, brauner@kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian and folks,

Could you please help review this set? Does this set address
concerns from earlier versions?

Thanks,
Song

On Mon, Jul 6, 2026 at 4:51=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> This series replaces the monolithic security_sb_mount() hook with
> per-operation mount hooks, addressing two main issues:
>
> 1. TOCTOU: security_sb_mount() receives dev_name as a string, which
>    LSMs like AppArmor and Tomoyo re-resolve via kern_path(). The new
>    hooks pass pre-resolved struct path pointers where possible (bind
>    mount, move mount), eliminating the double-resolution.
>
> 2. Conflation: security_sb_mount() handles bind, new mount, remount,
>    move, propagation changes, and mount reconfiguration through a
>    single hook, requiring LSMs to dispatch on flags internally. The
>    new hooks are called at the operation level with appropriate
>    context.
>
> The new hooks are:
>   mount_bind        - bind mount (pre-resolved source path)
>   mount_new         - new filesystem mount (with fs_context)
>   mount_remount     - filesystem remount (with fs_context)
>   mount_reconfigure - mount flag reconfiguration (MS_REMOUNT|MS_BIND)
>   mount_move        - move mount (pre-resolved paths)
>   mount_change_type - propagation type changes
