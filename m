Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E13B71B5
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653302; cv=none; b=V0OKbMC3LAyBa3sLweXU310UQ5bspoiiEdez8GVLb3DsQuOG5f506cYmbhRBh2nQbMFnY2+yv7ND7r84oz6vwmEcqV7JEvSNs6pDvVlZIgp6qhmqv5q0kXRyvmxH1CZqVQrDKPi9GmnYHrfPzNeciMZdssAIojVNxxzSB11Qn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653302; c=relaxed/simple;
	bh=xKVFfBdH/6oH8z7CoLAtGLazpyOF2odkfJxLv6ixZSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBXXKOQ/WgYCMykKATkWQMeba4Ax5N4u1FN5S0IGNgKvvnEx8RmWQAz3MHpCCRjxx2VMz9jqF+MdkoCX6k02SoOePRm80rwCwJNMpKTzjZ9SJDYJ7d2oD7O/ueMV5DvZ76DMREgUWHeAAadyzrnNYDTt9Jf5L/fotFAfPwLbeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMMYH4pg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMMYH4pg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780653299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CXSvsy20OlU0ffY+ovt8xL6+JI9uBPK0yH7zAmIsXN4=;
	b=TMMYH4pgk6wMnXpnFhbyCtdSK1redR7H3pGiFnbzQZYYUJsk6slUfOCQX+16RNk9izqTNX
	nqB2DAI+1CV9lGSyTtRlThXfZR45V7K03cwpJTPc2SkfT7tjwzPCYDARiDeWufxdaOvxkk
	QdtkY4S9EzUU+61t+yiyx5G+y5UxvQ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-EGI4_-U2NNGFfeqmkSAt-A-1; Fri,
 05 Jun 2026 05:54:57 -0400
X-MC-Unique: EGI4_-U2NNGFfeqmkSAt-A-1
X-Mimecast-MFC-AGG-ID: EGI4_-U2NNGFfeqmkSAt-A_1780653297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F861800365
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 09:54:57 +0000 (UTC)
Received: from localhost (unknown [10.44.32.151])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88794195608E
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 09:54:56 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.11-rc1 release
Date: Fri, 05 Jun 2026 11:54:55 +0200
Message-ID: <874ijh5n2o.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


Hello!

The 3.11-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.11-rc1
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.


User-visible changes since 3.10
-------------------------------

- Several security improvements in libselinux, dbus, gui, mcstrans and sand=
box
- Added `secilcheck` program to check CIL neverallows against binary polici=
es
- Improved `restorecond.service` to use new `restorecond -F` option to run =
in foreground
- restorecon only logs error on read-only filesystem instead of failing (al=
lows relabeling with read-only BTRFS subvolumes)
- Added `setfiles -A` option to disable SELINUX_RESTORECON_ADD_ASSOC
- Improved restorecon related functionality in libselinux
- Improved semanage-fcontext(8) manpage
- Dropped Python 2 support from audit2why
- Bug fixes

Development-relevant changes
----------------------------

- Reformated all code based on .clang-format configuration


Shortlog of the changes since 3.10 release
------------------------------------------
Cathy Hu (4):
      Disable build isolation for sepolicy python module
      README: add SLES and openSUSE as distros
      restorecon: Only log error on readonly fs (bsc#1232226)
      libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (bsc#1266385)

Christian G=C3=B6ttsche (19):
      libselinux: prefix ruby objects with interpreter
      tree-wide: build shared libraries with -fPIC
      libselinux: drop unnecessary strdup(3)
      libselinux: support non-pthread build
      libselinux: drop duplicate include header
      libselinux: drop void cast on function returning void
      libselinux: enclose macros and macro arguments
      libselinux: constify regex interfaces
      libselinux: hide regex_data_create()
      libselinux: drop unreachable return
      libselinux: drop Python 2 support from audit2why
      libselinux: drop unneeded warning overrides
      libselinux: correctly find partial matches
      libselinux: avoid heap allocation in partial_match() leak path
      libselinux: skip per-dirent fstat() when d_type is sufficient
      gitignore: add entries for coverage related files extensions
      libselinux: improve restorecon progress locking
      libselinux: reset scanned file count at selinux_restorecon(3) entry
      libsepol: link xperm rule permissions correctly

Dustin Kirkland (1):
      policycoreutils/secon: fix discarded-qualifiers warning with glibc 2.=
43

James Carter (11):
      libsepol: Fix out-of-bounds memory write in discard_tunbables()
      libsepol: When resolving names check if a block is abstract
      libsepol: Validate datum array entries for avrule blocks
      libsepol: Change log level of "Failed to resolve" message
      libsepol: Fix double free in copy_avrule_block
      libsepol: In module_to_cil skip empty conditional blocks
      libsepol: In module_to_cil correctly choose tunableif or booleanif
      libsepol: In module_to_cil use constrain and validatetrans where poss=
ible
      libsepol/cil: Add function to check CIL neverallows against binary po=
licy
      libsepol: Add a function to output CIL declarations from a binary pol=
icy
      secilc: Add program that checks CIL neverallows against a binary poli=
cy

Kalevi Kolttonen (8):
      libselinux: remove useless assignment and test
      checkpolicy: replace malloc()+memset() with calloc()
      checkpolicy: use calloc() so no need to do memset()
      checkpolicy: remove unneeded tests before free() calls
      checkpolicy: add missing strdup() failure checks
      checkpolicy: remove unneeded malloc() casts
      libsemanage: use 'bool' for boolean options
      libsemanage: make expand-check a proper boolean option

Petr Lautrbach (9):
      semanage-fcontext(8): improve -e documentation
      restorecond: Add -F for run in foreground
      restorecond.service: Use Type=3Dsimple
      libselinux: do not discard const qualifier
      libsemanage: Do not discard =E2=80=98const=E2=80=99 qualifier
      libsemanage: Do not use vfork()
      restorecond: Do not unlink pidfile if not used
      Reformat all the code based on .clang-format
      Update VERSIONs to 3.11-rc1 for release.

Rahul Sandhu (6):
      libsepol: policydb_read(): use a static string for policydb_str
      seunshare: guard fallible function calls by checking retval
      cil_reference_guide: update specification for valid symbols
      libsepol: check the number of elements in the avtab
      libsepol: cil_policy: check at least one perm exists in a classperm
      libselinux: restorecon: add_exclude: validate directory before deref

Stephen Smalley (49):
      libselinux: Do not fall back to /selinux on a sysfs mount failure
      sandbox/seunshare: pass O_NOFOLLOW to openat()
      sandbox/seunshare: switch seunshare_mount_file() to use open()
      sandbox/seunshare: fix error checking for setfsuid()
      sandbox/seunshare: remount /tmp and /var/tmp with the proper flags
      libsemanage/tests: fix const correctness for test_utilities
      libselinux: update pywrap targets for modern python builds
      python/sepolicy: update for modern python builds
      libselinux: restorecon: revisit pinning files to avoid TOCTOU issues
      restorecond: do not follow symlinks and do not relabel hard links
      restorecond: NUL-terminate ut_user before use
      sandbox/seunshare: prevent rsync from interpreting paths as options
      sandbox/seunshare: fix getopt flags
      sandbox/seunshare: prevent path traversal via -W/-P
      sandbox/seunshare: verify RUNTIME_DIR before use
      sandbox/seunshare: drop unused runuserdir_r
      sandbox/seunshare: fix killall() realloc and missing type comparison
      sandbox/seunshare: rewrite to pin directories before use
      sandbox/seunshare: fully check setfsuid() calls
      sandbox/seunshare: check owner in seunshare_mount_file()
      sandbox/seunshare: fix fd_tmpdir_r check
      libselinux: fix selinux_restorecon() error handling
      libselinux: selinux_restorecon: write digests during traversal
      dbus/selinux_server.py: validate policy config value
      gui: do not load from cwd and properly quote inputs
      restorecond: don't set gl_offs for glob()
      restorecond: do not pass the same string to basename()/dirname()
      restorecond: create a separate io channel callback for stdin
      sandbox/seunshare: check for errors from parent drop_caps()
      sandbox/seunshare: fix undefined behavior for child
      sandbox/seunshare: drop -k/--kill support
      mcstrans: prevent stack overflows
      mcstrans: avoid size_t underflow
      mcstrans: cap maximum category bits
      mcstrans: continue on failed accept() or add_pollfd() calls
      mcstrans: fix memory leak of sortable
      mcstrans: fix after base classification pointer computation
      mcstrans: fix error path leaks and NULL-derefs
      mcstrans: only update maxbit for categories read from config
      mcstrans: fix off-by-one in MAX_CATS / maxbit comparisons
      mcstrans: check and handle NULL returns from create_*()
      libselinux: selabel_subs_init(): do not read past terminating NUL byte
      libselinux: load_mmap: avoid unmapping already merged mapping
      libselinux: read_spec_entries(): handle nread =3D=3D 0
      libselinux: label_backends_android: preserve errors from process_line
      libselinux: label_media/label_x: preserve errors from process_line
      libselinux: label_backends_android: free prop
      libselinux: label_x: do not leak memory on an invalid type
      libselinux: label_support: move digest_add_specfile() bounds check

Thi=C3=A9baud Weksteen (2):
      libselinux: do not log on unexpected escaped character
      libsepol: Fix off-by-one error in cats_ebitmap_len

Vit Mojzis (4):
      libselinux: Ignore directories removed during relabeling
      mcstrans: Fix translation for uncached entries
      libsepol: Fix memory leak in role_dominates_copy_callback
      checkpolicy/test: Show all options for dispol and dismod in -h

