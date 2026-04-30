Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382338D;
	Thu, 30 Apr 2026 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507410; cv=none; b=fR6TF/Iu1alHg3Zr5qHR1v9AmUQNdOnRYffKHn6QxVR1fHwHIaXZzQq70Foixs3fX42DNeNEjuStvoiXk1GIAbZpxpHP5kxsWmllHNMb6eGvmd8GiPXPL45T5e9tVM5uXDfZ8nepR5Eaxr+OBhpXDGrhN1JxBJMV9xK+h2VTrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507410; c=relaxed/simple;
	bh=p9Phw1+Q0qn7qJdQ+RdBxfq/ar2HNwvEN/RCKhkS0Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DowoTQFRUz2FsSNn7ogMBZ/7az1LfzN6UbknGcTleksb3F4PY/dFf/aNnENF71gOqoJd90hzz2syqTmCK2W5MtddGzlyaV1SK3TCKidNqsAFMBOXqSNh4fZiDjDk8HABsoWEQTQvx4XZQLG2GSgei1U+djt4JnfzCuahoasA2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2io5zCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2io5zCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2425C19425;
	Thu, 30 Apr 2026 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777507409;
	bh=p9Phw1+Q0qn7qJdQ+RdBxfq/ar2HNwvEN/RCKhkS0Jk=;
	h=From:To:Cc:Subject:Date:From;
	b=O2io5zCPCWx+DUmuFfauRNsEMGKvEpFxbLUil1Zln8q2E2SjH2xBthmHA1xSeUkNi
	 BEsdm0YkAP6804hb1IDRxgvf9GETm0jwdeOVZFtSbb3vBszDI9DcneMNrHamCKSgnN
	 K0vaWcF65wwZlGxl0Iejmp2sv5D66EyFRii4jTJNDOF1gW7eNnoq070m62ILob07zK
	 Vzr8XlCn9wdgMoBuetwdLUXLb3BXKHFjCmhK9DdlHdJh1zt2gzCi2ok58UXtZZswS3
	 L0L5dmkTgUaZTHG/fw5XhnXaMJYGhD2cGamjQsOKgSv1SAr6eATeVQd7KbWFdTkTmy
	 epfA3dpQiAv/A==
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
Subject: [PATCH v2 0/7] lsm: Replace security_sb_mount with granular mount hooks
Date: Wed, 29 Apr 2026 17:03:08 -0700
Message-ID: <20260430000315.918964-1-song@kernel.org>
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

Changes v1 => v2:
1. Rebase.
2. Add Reviewed-by and Tested-by from Stephen Smalley.

v1: https://lore.kernel.org/linux-security-module/20260318184400.3502908-1-song@kernel.org/

Song Liu (7):
  lsm: Add granular mount hooks to replace security_sb_mount
  apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
  apparmor: Convert from sb_mount to granular mount hooks
  selinux: Convert from sb_mount to granular mount hooks
  landlock: Convert from sb_mount to granular mount hooks
  tomoyo: Convert from sb_mount to granular mount hooks
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
 security/tomoyo/tomoyo.c          |  63 ++++++++++++----
 13 files changed, 406 insertions(+), 161 deletions(-)

--
2.52.0
