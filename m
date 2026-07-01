Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5092381AED
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927487; cv=none; b=MVAINr0g+9IMe1nsEUudTMrWNhwColGck3Wad01FwmGsrEo7JFkK3xYVsgp4ygRHvBG4i8EiBG2VhMO12Dvg35AXAxklA4UKNZosVYzDHPyR/ZMr9BkoNM4YHWlGukf1lgIdlkww3mVsNcio81xfngvEtnYsXbVL+utm/E4Ee8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927487; c=relaxed/simple;
	bh=1BeZ0vZOmvQCWZez/NrW5gZtEY4Wu9gF0TE8GWlr/bk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irbo+n+isbZp3KWrIkH6MDTJnpdm1Np19ikpBHWbubc9aAkcQ9zqgnjjnhe3SK9Le0mjZHZEeWRFrVpa2UFy9Nfx/eFmP3J4RpbmOberzl78a35+NxKdNHnNbNYpSyHDwHJSxJ7HD9byooE78kGGJ2Se8/kXrZEeaFR18baP0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAyLt83m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAyLt83m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782927484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Fl6mrCm3bEB9t+DK+pRVK9KGdcgnaZ3na8xxoBHMrNI=;
	b=XAyLt83mh6oO9rapeAwd5b1WEJLQDd0HRO2KZ3l5GOJZPwqQwEaFpx9XUccS5I+dyJwhg6
	ho10lIgk0L/01WG7i9gYKOJGPSV1GEHS9PoY1fxL2KvIEyvAwjwTIpVMgJWZc9VXnAxi6o
	dfI6vH9H8doi5cF3gwW+5PPj2UKYMiI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-ihSBlqP4P86iOS5lE9a3jA-1; Wed,
 01 Jul 2026 13:38:03 -0400
X-MC-Unique: ihSBlqP4P86iOS5lE9a3jA-1
X-Mimecast-MFC-AGG-ID: ihSBlqP4P86iOS5lE9a3jA_1782927482
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C36321933E97
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 17:38:02 +0000 (UTC)
Received: from localhost (unknown [10.44.33.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 448D91955D53
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 17:38:02 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: SElinux list <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 3.11
Date: Wed, 01 Jul 2026 19:38:00 +0200
Message-ID: <87o6gqsj9j.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello!

The 3.11 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

User-visible changes since 3.10
--------------------------------

- Several security improvements in libselinux, dbus, gui, mcstrans and sandbox
- Added `secilcheck` program to check CIL neverallows against binary policies
- Improved `restorecond.service` to use new `restorecond -F` option to run in
  foreground
- restorecon only logs error on read-only filesystem instead of failing (allows
  relabeling with read-only BTRFS subvolumes)
- Added `setfiles -A` option to disable SELINUX_RESTORECON_ADD_ASSOC
- Introduced a new SELINUX_RESTORECON_SKIP_MULTILINK flag to
  selinux_restorecon(3); if set, then selinux_restorecon(3) will refuse to
  relabel files with multiple hard links to prevent mislabeling them. Updated
  restorecond(8) to always pass this flag when relabeling files to prevent
  mislabeling hard links to files owned by others, e.g. when relabeling user
  home directories or /tmp.
- Dropped sandbox/seunshare -k/--kill support (unused by sandbox, fundamentally
  racy, redundant with killall -Z).
- Fixed sandbox/seunshare getopt flags to match the actual options.
- Fixed sandbox/seunshare remounting of /tmp and /var/tmp within the sandbox.
- Fixed sandbox interactive prompt for saving files.
- Added a cache size cap, max client cap, receive timeout, and maxbit cap to
  mcstrans to reduce the risk of DoS from misbehaving clients.
- Fixed mcstrans UAF on SIGHUP reload of its configuration files.
- Fixed mcstrans translation for uncached entries.
- Fixed semanage audit fd creation to avoid hitting RLIMIT_NOFILE on large
  semanage import operations (#291).
- Fixed libsepol generation of constraint expressions with a list of names when
  writing policy.conf from CIL.
- Fixed libsepol to generate constrain/validatetrans instead of
  mlsconstrain/mlsvalidatetrans when converting a module to CIL unless the
  constraint contains an expression based on level.
- Fixed libsepol selection of tunableif or booleanif and to skip empty
  conditional blocks when converting a module to CIL.
- Fixed libsepol/secilc reporting of CIL source file info.
- Fixed libsepol to require at least one perm in a CIL classperm and to
  correctly count the number of elements in the avtab.
- Fixed libsepol to link xperm rule permissions correctly.
- Fixed libsepol off-by-one error in cats_ebitmap_len().
- Fixed dispol and dismod to show all options in the -h text.
- Fixed checkpolicy handling of out-of-range and complement at range boundaries
  for xperm rules (#530, #531).
- Dropped legacy fscon statement support from checkpolicy - never used in
  SELinux policies for mainline kernels (#518).
- Fixed libselinux constructor to not clobber errno (#445).
- Fixed libselinux selabel_partial_match(3) to correctly find partial matches.
- Fixed libselinux selinux_init_policy_load() to still try to mount selinuxfs on
  /sys/fs/selinux even if the mount of sysfs on /sys fails - this can occur
  legitimately within a user namespace.
- Improved restorecon related functionality in libselinux
- Improved semanage-fcontext(8) manpage
- Dropped Python 2 support from audit2why
- Multiple documentation improvements.
- Bug fixes

Security/hardening changes
--------------------------

- Rewrote libselinux selinux_restorecon(3) to eliminate TOCTOU issues in file
  relabeling if /proc is available (so that it can use /proc/self/fd-based
  pathnames). If /proc is not available, selinux_restorecon(3) falls back to
  just passing the full pathname each time for compatibility within chroot or
  other environments. For callers that pass the SELINUX_RESTORECON_REALPATH
  flag, like restorecon(8), selinux_restorecon(3) will still follow any
  intermediate symlinks in the initial pathname as part of realpath(3)
  canonicalization. Otherwise, selinux_restorecon(3) will not follow any
  symlinks. This may yield different user-visible behavior for setfiles(8) and
  restorecond(8) but only if a path containing an intermediate symlink is
  specified on the command-line (setfiles) or configuration (restorecond) since
  they did not follow any symlinks found during the tree walk regardless.

- Rewrote restorecond and sandbox/seunshare to eliminate TOCTOU issues on their
  other path-based operations via /proc/self/fd and the use of a safe_open()
  helper. This may yield different behavior if a path containing an intermediate
  symlink is passed to them via configuration (restorecond) or command-line
  (seunshare).

- Many hardening fixes spanning the entire tree (including but not limited to
  #522, #523, #525 thru #529, #532 thru #534)

Development-relevant changes
----------------------------

- Reformatted entire tree based on .clang-format and added new
  check-format/format make targets to check and/or reformat code to match.
  This is now a requirement for new patches.
- Improved CI and refactored CI build into a custom GH action
- libselinux and python use system Python3 build module
- Fixed build errors with glibc 2.43.
- Fixed libselinux build for non-pthread builds.
- Build shared libraries with -fPIC for LTO.
- Fixed uclibc build failure (#435).
- Multiple fixes for musl/llvm-based builds, including adding a new
  EXTRA_LD_FLAGS variable that can be set for libselinux builds to pass
  --undefined-version through to lld (#511 thru #515).
- Fixed libsemanage pywrap target deps for parallel builds.
- Updated pywrap build targets for modern python builds using the Python3 build
  module.
- Disabled build isolation for sepolicy python module.

