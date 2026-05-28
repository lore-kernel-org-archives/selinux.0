Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716F3FF8BE;
	Thu, 28 May 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992776; cv=none; b=d5a3v9M2oCptGU50Sg+ZxNimKvx+sn6XM2SAtRNKC3KFBfGi4RGwiGn9Bu6AEwtwlmWjvZxyfS99iAujy7tu436Xs9sEze8VepHQFw8Nt/D1cWrQ+xORUzQtfFXDU8hsWcI5wbbcki9e411bD2wQG0GbNgeWjU0RBkSZKHIbsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992776; c=relaxed/simple;
	bh=Jup5QZAB7CgZCOZgXzmqKuc+qMZisSNc6sUEIDv8XGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ij7C3mYo0qnjt7UW3YIDFN1jpHQFkCu9nO56wFBis/cqzuwByjWVF/9czmQ0O8roEjlEEr7xG3CNED638BhO49DpASDCHB1myLyd3GGC3KjAQMLzTko7BpcC7dDvqwlKJhUSsbj3HElEHXSbSHIW2hstjlC3dnDDciOhJdgUHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeTJ3VSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeTJ3VSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B7E1F000E9;
	Thu, 28 May 2026 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992774;
	bh=umxsgUfAIAKmPR1v090QSLcMtlURT7J/ewk8HNWQtrk=;
	h=From:To:Cc:Subject:Date;
	b=DeTJ3VSwFKc3bt5yFdvGRk31HID8mMkQdxWCJdVMVIeLWNilaD/qsk9q89+RZd31Z
	 pxBrqQWlZvMIDNIDJp9DZU2OH5zLRSmCXMCKYoDjuKTYWiwFcmIf5W8UWTuKNzv2RQ
	 f8hcFCTnjezsMeRzp/GISxe1IFSfK8xtl8M9MRmRjRncmNuPOq09/pKeurdoH7C3aS
	 RU2eeoJFhFeIzpbiiDrSrMGU0vuW+CQ80ObegYCTrdeanOQ6aihKpRSqYTicTfIYMl
	 eEOK4q+h6efomljTBKF4j+v6J5/dXlLOKjryLlZdpNp/B6QmIcr0wg7Q6XwZKBow92
	 jcUR+9QNuNLAw==
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
Subject: [PATCH v5 0/8] lsm: Replace security_sb_mount with granular mount hooks
Date: Thu, 28 May 2026 11:25:59 -0700
Message-ID: <20260528182607.3150386-1-song@kernel.org>
X-Mailer: git-send-email 2.52.0
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

 fs/namespace.c                    |  41 +++++++---
 include/linux/lsm_hook_defs.h     |  14 +++-
 include/linux/security.h          |  56 +++++++++++---
 kernel/bpf/bpf_lsm.c              |   7 +-
 security/apparmor/include/mount.h |   5 +-
 security/apparmor/lsm.c           | 102 ++++++++++++++++++-------
 security/apparmor/mount.c         |  37 ++--------
 security/landlock/fs.c            |  41 ++++++++--
 security/security.c               | 119 +++++++++++++++++++++++-------
 security/selinux/hooks.c          |  49 ++++++++----
 security/tomoyo/common.h          |   2 +-
 security/tomoyo/mount.c           |  31 +++++---
 security/tomoyo/tomoyo.c          | 109 ++++++++++++++++++++++++---
 13 files changed, 457 insertions(+), 156 deletions(-)

--
2.53.0-Meta
