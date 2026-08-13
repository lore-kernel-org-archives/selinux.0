Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0050299943;
	Thu, 13 Aug 2026 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581697; cv=none; b=pzRqOr+o3sF5nsnugcybLSWLwt0eEGOhu0pAqWrPpCKnNCgVAHIidI7ARh9mt88d9To3l+fSjQSmiQp9smcT6BeKulI35PjnGBMk3Gc5EJNYvgQqnF7IlItwnQoGpVKNphXyhGCq2EY6647bwTzyLiVGZWCajOjHggpsa/uqvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581697; c=relaxed/simple;
	bh=NTlHIfLmcN1rD2SS4lRcmYmfN4ou96so+CLAxMYwv4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MpA67/x84rEEQMGG5lu8KU/IfWBPUUUnUbJGLtRHKyi9mZwEN2auTbt/hDhO4Ecr6rqS4W8is1Oxu/1SKtfBccZOx9ipR6ORZns9S8AYPcnGz5hUfc9Iwu6JWNRImphgAaj8rYXrGviph4cWt5OtyAS25t2oHq0DYMmlcKfoAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPkrHXa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPkrHXa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2E01F00A3F;
	Thu, 13 Aug 2026 00:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581696;
	bh=l7Kc3MixeizTkHNQBxFkTelPI1LJYXzxl6McHwZXqUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPkrHXa9n1sELkAiQ2KxFOdlXhnVx9M/3RjbfL6ggxQ26cwAaurI/9Qp/gvsez704
	 720XTigt64cw1NztR7bf6qRXv1b/thYw6qAermHKdMfU4GsNuW2IOIizueP2xIOI3l
	 rN5BB0LPv2E/paSjbekgM0wV2tk/spoCyHiBtlcn5n9Lf6VC9p3oEWYKBhciZUqDqz
	 K4EUXfe0BgC1US132arVSSIFllqpHDJ0pA2grXrQ3p2GKT0jz7hTw3+nMcGMn7w7Lm
	 AiBAWClwikDQP11u/9b87LLxxB4r3YD5BaRJrKYfx60Hpuam74PzGfplZewnIOt/vf
	 o+PIz43l3CH/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/5] selinux: Add BPF_LOADER_LOAD_FD syscall
 permission
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260813002618.3755631-5-tweek@google.com>
References: <20260813002618.3755631-1-tweek@google.com>
 <20260813002618.3755631-5-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:41:35 +0000
Message-Id: <20260813004136.2A2E01F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The SELinux access control check for BPF_LOADER_LOAD_FD is complet=
ely bypassed if the bpf_token_perms policy capability is enabled, leading t=
o Privilege Escalation.

Pre-existing issues:
- [High] BPF_LOADER_LOAD_FD fails unconditionally with -EINVAL if CONFIG_BP=
F_JIT is disabled.
--

--- Patch [4]: [PATCH bpf-next 4/5] selinux: Add BPF_LOADER_LOAD_FD syscall=
 permission ---
commit aa42284da62cb224bfd501dfd4306e6584b6a8e1
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

selinux: Add BPF_LOADER_LOAD_FD syscall permission

Add the BPF_LOADER_LOAD_FD permission to gate the bpf syscall command of
the same name.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7c5993f69545..b4ff5ea5306df 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7196,6 +7196,10 @@ static int selinux_bpf(int cmd, union bpf_attr *at=
tr,
>  		ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
>  				   NULL);
>  		break;
> +	case BPF_LOADER_LOAD_FD:
> +		ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__LOADER_LOAD_FD,
> +				   NULL);
> +		break;

[Severity: High]
Is it possible this check can be completely bypassed if the bpf_token_perms
policy capability is enabled?

Looking at selinux_bpf() earlier in this file, there is an early return:

	if (selinux_policycap_bpf_token_perms())
		return 0;

Because BPF_LOADER_LOAD_FD doesn't have a fine-grained SELinux hook later o=
n,
this early return skips the access control check.

Furthermore, loader_load_fd() internally calls kern_sys_bpf() which executes
the inner map creations and program loads with is_kernel =3D true:

	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size, KERNEL_BPFPTR(NULL),=
 0);

This passes the kernel SID (SECINITSID_KERNEL) to the fine-grained hooks
instead of the user's SID:

	ssid =3D kernel ? SECINITSID_KERNEL : bpfsec->sid;

Will this allow a user with CAP_BPF to bypass their SELinux constraints and
load arbitrary programs as the kernel?

[Severity: High]
This isn't a bug introduced by this patch, but will BPF_LOADER_LOAD_FD fail
unconditionally if CONFIG_BPF_JIT is disabled?

Looking at loader_load_fd() in kernel/bpf/syscall.c, it unconditionally cal=
ls:

	err =3D kern_sys_bpf(BPF_PROG_TEST_RUN, &sattr, sizeof(sattr));

However, in kern_sys_bpf(), the BPF_PROG_TEST_RUN case is compiled out when
CONFIG_BPF_JIT is disabled:

	#ifdef CONFIG_BPF_JIT
	case BPF_PROG_TEST_RUN:

This causes it to fall through to the default handler which returns -EINVAL=
 for
BPF_PROG_TEST_RUN, breaking the feature entirely on non-JIT configurations.

>  	default:
>  		ret =3D 0;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813002618.3755=
631-1-tweek@google.com?part=3D4
