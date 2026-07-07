Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E343FFD
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382679; cv=none; b=lbeC60mt33WfktZS+czL3xxc9J9njlloteqgdTkFvEmOkzX8UiqUfgSE+uVT994jeUCGNaUjxyYWlU3YSx/6o1RlJAJyy/dQfSN6YKpJ94uonRAXV+BtcPo9f4a+wgvcLmqdNAILCR1rXAtZEgYof/TGqSru+5lHIKx4tuQfcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382679; c=relaxed/simple;
	bh=0O4jbOy1CptrUkTjzVUlsLv1islz7/uaeX6/epz8wO0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZg68CAFTyDpfa5YMxVWGZdkiZZSULFMbQYY7yw59rGN5pqUs66jF4smDnt5SK7teDTJ0qLa1pyTrM7JM+iBvhSJ3BpE8knZz9YmKBKzBUZFTcAHQx5KvdklDSOVU/kIKErObs5b4xnipQ8q7MvVNF/izLtZEsiM6B6vEDuNx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiYyOquf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiYyOquf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3261F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382678;
	bh=8S/xYWa5cME5B1gn8r6MlimTOE+gFqXdRTEUHXh26Ug=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AiYyOquf8J4ZfV9TX8hSd8IrVdEujzu/h5CL6BeWcUFMJUGKe8ESIvPplLmNQQ1r1
	 nmxFnBxJkkYOo4IfSYirPk8ygfw1JunPZKzUXTpXZB5t4OaRtws10IoYksyQOvjF6t
	 VSlh/ac7CDDbfYhjd2jb2GqsT9/Ekefvz5VNKQz18i9ux5KdxEDzY/qpIr9suYXf1z
	 jCphKBUb9rg2V1wiG1D6rqUNXcBPWgoHy+zmfFqsoWPmnHyxtuR4K3veGrc+mKibcX
	 M6Qgxbq7hHpyEmnYDy2ma/0OJcsnID9F3+eOA65C4csdABXkjJRuonj5zLn7wK3fFl
	 RnUmUEo7fZ0KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] landlock: Convert from sb_mount to granular
 mount hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-6-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-6-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:04:37 +0000
Message-Id: <20260707000438.5A3261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing the legacy `sb_mount` and `move_mount` LSM hooks wit=
h new granular mount hooks without updating the VFS callers completely drop=
s Landlock's (as well as AppArmor's and SELinux's) mount sandbox protection=
s.
--

--- Patch [5]: [PATCH v6 5/8] landlock: Convert from sb_mount to granular m=
ount hooks ---
commit aefe12302c757bd8116e65f91a6c6d4886925d19
Author: Song Liu <song@kernel.org>

landlock: Convert from sb_mount to granular mount hooks

This commit replaces Landlock's legacy sb_mount and move_mount hooks
with granular mount hooks (mount_bind, mount_new, etc.). The new hooks
are wired to a common helper that denies all mount operations for
sandboxed processes.

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe2390326..4e6712f972f0a 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c

[ ... ]

> @@ -1950,8 +1978,12 @@ static struct security_hook_list landlock_hooks[] =
__ro_after_init =3D {
>  	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
> =20
>  	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
> -	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
> -	LSM_HOOK_INIT(move_mount, hook_move_mount),
> +	LSM_HOOK_INIT(mount_bind, hook_mount_bind),
> +	LSM_HOOK_INIT(mount_new, hook_mount_new),
> +	LSM_HOOK_INIT(mount_remount, hook_mount_remount),
> +	LSM_HOOK_INIT(mount_reconfigure, hook_mount_reconfigure),
> +	LSM_HOOK_INIT(mount_change_type, hook_mount_change_type),
> +	LSM_HOOK_INIT(mount_move, hook_move_mount),

[Severity: Critical]
Does this conversion inadvertently bypass Landlock's mount protections?

Looking at path_mount() in fs/namespace.c, the VFS still relies on the lega=
cy
security_sb_mount() API:

fs/namespace.c:path_mount() {
    ...
    ret =3D security_sb_mount(dev_name, path, type_page, flags, data_page);
    ...
}

And this wrapper strictly evaluates the legacy sb_mount hook list:

security/security.c:security_sb_mount() {
    return call_int_hook(sb_mount, dev_name, path, type, flags, data);
}

Similarly, vfs_move_mount() in fs/namespace.c still calls the legacy
security_move_mount() API.

Because this patch removes sb_mount and move_mount from landlock_hooks, won=
't
these VFS calls find an empty hook list for Landlock and unconditionally re=
turn
0 (success), allowing unprivileged sandboxed processes to perform unauthori=
zed
mounts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D5
