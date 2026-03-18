Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6D3E4C83;
	Wed, 18 Mar 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859446; cv=none; b=WUSh/hXYSJ7ETn+JTAyPQtZAUt70ebwjiwMjLCiqiPpvDM2dS9lXQaNm79/haXLN9NHrzj5Xg5qVw6ebl/JMYfuX1MYFm91r/sF9aunGSjFiqRRBfImx1lW5SWGc6eOLzkrRXDJKxpmn3V6J45oqqDmuFfT8wV4h2OoqIWb6y1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859446; c=relaxed/simple;
	bh=Gjz4e+rul5Oy8KZpMy9Pp9cpbls2xxDCug5CNQYn8eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGenzNyHpwVE2fN4L7ZdkqZhow8ZP2zxJOT941+IXSJ/vnNjHg8cAoOcq/35jSSrfQe9yfcqodXVeSNA/UFDRs+EiLxNb+g0J+ggZ2nK3I6Verp500mdWU+Gm4xqHAz/nxxUFGf2IoboSKoxHkr8e6wjFMicTuFBOX0jzKciPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqyCmZNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqyCmZNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C25FC19421;
	Wed, 18 Mar 2026 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859445;
	bh=Gjz4e+rul5Oy8KZpMy9Pp9cpbls2xxDCug5CNQYn8eg=;
	h=From:To:Cc:Subject:Date:From;
	b=PqyCmZNCbVBdKDk8+yUMS6AbHrBkmAdC3nplALeoYzMh0VIUofFG24OhDvh/tY03w
	 +Qgqum+Cpn+dagOwmTzLFt+u7TONca5JgRE/oa+D0qeYtzSRMNXKRR9VvK6VmXJ3ew
	 29xZraxTIDaApjtSvW1zmJdLPVG9o+Lp7+RYS/66gat8H+TZ2SWcc9fI1jEBdmZZBV
	 zfm6gqPQmvkwV/UzSg+KQazjBe93RWuztvpKHMC/4RwtnHzwcqvmaMQmk2BoiX9V6f
	 CWK/TRbkjw2jVVlq82gsX9jcIylaTOevITEbO6RLiHSxkIsKb05ZRMHYB3v2FHCl4s
	 K3GfZ/rQGruhw==
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
Subject: [PATCH 0/7] lsm: Replace security_sb_mount with granular mount hooks
Date: Wed, 18 Mar 2026 11:43:53 -0700
Message-ID: <20260318184400.3502908-1-song@kernel.org>
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
