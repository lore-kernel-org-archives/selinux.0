Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E01F8AC5;
	Mon,  6 Jul 2026 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381863; cv=none; b=kT4BPANKDG/emqeAqJrt88ueqC8/K8oES4DtPgbzjr4FhKWw32nAPXNW32J7MA57n0i/0FQQJ6EkiECTIWRffbJqqkR8uKB0XfRPvjo3Lh+8AnR9iDvsZlmKHMUgApKw778cyHV0V5CmYQWVsZDBUFDg7Lm5LFe04YZxAtv9zSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381863; c=relaxed/simple;
	bh=T2lruLJcsZTsq8HoQPJWIp2ecA8LE+AUCWkjJOP35IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpC0tITrmgURv8ot87qjUl+RDgrHvBDiWZOw5U4Cbc7G1Fq/2Uyrn5R5QRQ1d3wjaSegtGn3bV/cjxY+pkTkWE/pKquNpiMv1UF2J+LKPRTQyl4KcAOWHeibsmcR3xvmwxthKg6armJy8SqeQoScmKYYrbCfox1E/PPhCPlAq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJWFdRrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJWFdRrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068D71F000E9;
	Mon,  6 Jul 2026 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381861;
	bh=MQw4xDJeL8UYTO9Tpj4vdh6UQQ9CEz2MfSlji5wdJ9w=;
	h=From:To:Cc:Subject:Date;
	b=DJWFdRrAF4VjaSykKQzp5rlSdb6eiyuPI5BjNyp7YZLlv5/DRjzl/PLQlJvcjk5sE
	 zAEIubE4VGvxDrs15tx853gjwL85SWBTLPVnVuWF2xut/6bgeuhmq57JV9SeWkcRnC
	 PlJ3sCNK+5F948ir9e2g43tRjH45xTTyC7S1beH73AClkM+WMotZLHvF4MjOTR7wd5
	 cGHNQ7A6PdK2Lzqi2H4RDNjtuHy0RyK+Zjeyynjg2usH5AWmE6h6/iEhFI3QdrUZ/0
	 Xa85wJi6akv6McWTs+cVE5c4dnyzbYBnIL3zH2h3T3p1y10C448r2bADvNBCxU/7Mu
	 OkRYzt5/q3EBQ==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	john.johansen@canonical.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	herton@canonical.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
Date: Mon,  6 Jul 2026 16:50:45 -0700
Message-ID: <20260706235053.4104951-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces the monolithic security_sb_mount() hook with
per-operation mount hooks, addressing two main issues:

1. TOCTOU: security_sb_mount() receives dev_name as a string, which
   LSMs like AppArmor and Tomoyo re-resolve via kern_path(). The new
   hooks pass pre-resolved struct path pointers where possible (bind
   mount, move mount), eliminating the double-resolution.

2. Conflation: security_sb_mount() handles bind, new mount, remount,
   move, propagation changes, and mount reconfiguration through a
   single hook, requiring LSMs to dispatch on flags internally. The
   new hooks are called at the operation level with appropriate
   context.

The new hooks are:
  mount_bind        - bind mount (pre-resolved source path)
  mount_new         - new filesystem mount (with fs_context)
  mount_remount     - filesystem remount (with fs_context)
  mount_reconfigure - mount flag reconfiguration (MS_REMOUNT|MS_BIND)
  mount_move        - move mount (pre-resolved paths)
  mount_change_type - propagation type changes

mount_new and mount_remount are called after parse_monolithic_mount_data(),
so LSMs have access to the fs_context with parsed mount options. They also
receive the original mount(2) flags and data pointer for LSMs (AppArmor,
Tomoyo) that need them for policy matching.

The series also replaces security_move_mount() with the new mount_move
hook, unifying the old mount(2) MS_MOVE path with the move_mount(2)
syscall path.

All existing LSM behaviors are preserved:
  AppArmor: same policy matching, TOCTOU fixed for bind/move
  SELinux:  same permission checks (FILE__MOUNTON, FILESYSTEM__REMOUNT)
  Landlock: same deny-all for sandboxed processes
  Tomoyo:   same policy matching, TOCTOU fixed for bind/move, unused
            data_page parameter removed


This work is inspired by earlier discussions:

[1] https://lore.kernel.org/bpf/20251127005011.1872209-1-song@kernel.org/
[2] https://lore.kernel.org/linux-security-module/20250708230504.3994335-1-song@kernel.org/

Changes v5 => v6:
1. Move security_mount_bind() and security_mount_move() under
   LOCK_MOUNT()/LOCK_MOUNT_MAYBE_BENEATH(). (Christian Brauner)
2. Rebase.

v5: https://lore.kernel.org/all/20260528182607.3150386-1-song@kernel.org/

Changes v4 => v5:
1. Restructure series: add new hooks in security/ first, then convert
   individual LSMs, then replace old hooks with new hooks in
   fs/namespace.c (single patch), then remove old hooks. This keeps
   all fs/namespace.c changes in one patch. (Christian Brauner)
2. Rebase.

v4: https://lore.kernel.org/linux-security-module/20260515200158.4081915-1-song@kernel.org/

Changes v3 => v4:
1. Move LSM_HOOK_INIT(move_mount, ...) removal from patch 7/7 to each
   per-LSM conversion patch (3/7, 4/7, 5/7). (Paul Moore)
2. Add kdoc comments to tomoyo mount hook functions and rename
   tomoyo_move_mount to tomoyo_mount_move in patch 6/7. (Tetsuo Handa)
3. Add Acked-by from Tetsuo Handa to patch 6/7.

v3: https://lore.kernel.org/linux-security-module/20260509015208.3853132-1-song@kernel.org/

Changes v2 => v3:
1. Rebase.
2. Move security_mount_move() call in vfs_move_mount() from patch 7/7
   to patch 1/7. (Paul Moore)

v2: https://lore.kernel.org/linux-security-module/20260430000315.918964-1-song@kernel.org/

Changes v1 => v2:
1. Rebase.
2. Add Reviewed-by and Tested-by from Stephen Smalley.

v1: https://lore.kernel.org/linux-security-module/20260318184400.3502908-1-song@kernel.org/

Song Liu (8):
  lsm: Add granular mount hooks
  apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
  apparmor: Convert from sb_mount to granular mount hooks
  selinux: Convert from sb_mount to granular mount hooks
  landlock: Convert from sb_mount to granular mount hooks
  tomoyo: Convert from sb_mount to granular mount hooks
  vfs: Replace security_sb_mount/security_move_mount with granular hooks
  lsm: Remove security_sb_mount and security_move_mount

 fs/namespace.c                    |  77 ++++++++++++++----
 include/linux/lsm_hook_defs.h     |  16 +++-
 include/linux/security.h          |  60 +++++++++++---
 kernel/bpf/bpf_lsm.c              |   7 +-
 security/apparmor/include/mount.h |   5 +-
 security/apparmor/lsm.c           | 105 +++++++++++++++++-------
 security/apparmor/mount.c         |  37 ++-------
 security/landlock/fs.c            |  44 ++++++++--
 security/security.c               | 129 +++++++++++++++++++++++-------
 security/selinux/hooks.c          |  52 ++++++++----
 security/tomoyo/common.h          |   2 +-
 security/tomoyo/mount.c           |  31 ++++---
 security/tomoyo/tomoyo.c          | 111 ++++++++++++++++++++++---
 13 files changed, 508 insertions(+), 168 deletions(-)

--
2.53.0-Meta
