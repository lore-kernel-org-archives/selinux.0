Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368E2C9D
	for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178596; cv=none; b=O4n4nNr08TIANBUqgVj5GIc60HDFBzkwQlXNYTTwiRndkO9ygHz08jg2Wv3Wb60YP3xe1JpaxMTeXuDGl+IVvKqE3y9IjR9tBpA5f5MttzUUwmU2taKOnJ2EL2880JQnJoaJzxeLW4V0zHTx9Ve7Ss1CWLdRDJHWWVplJ2cRVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178596; c=relaxed/simple;
	bh=87ERf2wTv0a4DKMomddwO03Al/jMwPTHR22zgQID+v8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRkA9xMnyGcjWGJH4Kez9v4ikB1MQS9FqP1l2mZeMJ7rtWx536KbjLP2IQAPX2kxywUU0lhPtIs/SAen+oBjkLYNs1fV2XcrV3B6BURHgB9kvbO8MriPvW+LPf//Q6TeE9/5zCBA4y0GXKSn+y2ypiLJBQM/o3M9t5WEaNl48j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FY4gGEOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FY4gGEOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738178593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rkc4y7b+om3b+JggAllihcxsbjbXd6ihhadA9HLe8wg=;
	b=FY4gGEOKS3ftB5Olri82kGPjSdTWhIGdqhLAWbWjECtFBOwHNtPMQdLza4rTGTzI7AxL4G
	o3Fqg8qfddZkzA+YqHDyKuTTfeSmIB3mq8fbAKM7FntGuvTD+AiwYz5Gx6XxJV61g/aGNt
	u62pIGfzaTQcZwgdD9G42/9Y2lfvi5M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-dzK4qGDMMxeY1a-WsCc_8g-1; Wed,
 29 Jan 2025 14:23:11 -0500
X-MC-Unique: dzK4qGDMMxeY1a-WsCc_8g-1
X-Mimecast-MFC-AGG-ID: dzK4qGDMMxeY1a-WsCc_8g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B3D1801F11
	for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 19:23:09 +0000 (UTC)
Received: from localhost (unknown [10.45.224.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F5961800267
	for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 19:23:08 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.8
Date: Wed, 29 Jan 2025 20:23:07 +0100
Message-ID: <87ikpxs9us.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello!

The 3.8 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

Important change:
--------------------

The internal representation of file_contexts.*.bin files is completely
rewritten and new format stores all multi-byte data in network
byte-order, so that such compiled files can be cross-compiled,
e.g. for embedded devices with read-only filesystems.

User-visible changes
--------------------

* libsemanage: Preserve file context and ownership in policy store

* libselinux: deprecate security_disable(3)

* libsepol: Support nlmsg extended permissions
=20
* libsepol: Add policy capability netlink_xperm

* libsemanage: Optionally allow duplicate declarations

* policycoreutils: introduce unsetfiles

* libselinux/utils: introduce selabel_compare

* improved selabel_lookup performance

* libselinux: support parallel usage of selabel_lookup(3)

* libsepol: add support for xperms in conditional policies

* Improved man pages

* Code improvements and bug fixes

* Always build for LFS mode on 32-bit archs.

* libsemanage: Mute error messages from selinux_restorecon introduced in 3.=
8-rc1

* Regex spec ordering is restored to pre 3.8-rc1

* Binary fcontext files format changed, files using old format are ignored

* Code improvements and bug fixes

Shortlog of the changes since 3.7 release
-----------------------------------------
Christian G=C3=B6ttsche (95):
      libselinux: deprecate security_disable(3)
      libselinux: avoid errno modification by fclose(3)
      selinux: free memory in error branch
      libsemanage: check for rewind(3) failure
      selinux: set missing errno in failure branch
      checkpolicy/fuzz: fix setjmp condition
      policycoreutils: introduce unsetfiles
      libselinux/utils: introduce selabel_compare
      libselinux: use more appropriate types in sidtab
      libselinux: add unique id to sidtab entries
      libselinux: sidtab updates
      libselinux: rework selabel_file(5) database
      libselinux: remove unused hashtab code
      libselinux: add selabel_file(5) fuzzer
      libselinux: support parallel selabel_lookup(3)
      checkpolicy: avoid memory leaks on redeclarations
      checkpolicy: avoid leak of identifier on required attribute
      libsepol: misc assertion cleanup
      libsepol: add support for xperms in conditional policies
      checkpolicy: add support for xperms in conditional policies
      libsepol/cil: add support for xperms in conditional policies
      libsepol: indent printed allow rule on assertion failure
      libsepol/tests: add cond xperm neverallow tests
      libsemanage: white space cleanup
      libsemanage: fix typo
      libsemanage: drop unused macro
      libsemanage: drop dead assignments
      libsemanage: drop dead variable
      libsemanage: drop unnecessary declarations
      libsemanage: drop unnecessary return statements
      libsemanage: drop duplicate include
      libsemanage: drop const from function declaration
      libsemanage: check memory allocations
      libsemanage: use unlink on non directory
      libsemanage: free resources on failed connect attempt
      libsemanage: declare file local function tables static
      libsemanage: avoid const dropping casts
      libsemanage: cast to unsigned char for character checking functions
      libsemanage: drop casts to same type
      libsemanage: fix asprintf error branch
      libsemanage: avoid leak on realloc failure
      libsemanage: use strtok_r for thread safety
      libsemanage: free ibdev names in semanage_ibendport_validate_local()
      libsemanage: simplify malloc plus strcpy via strndup
      libsemanage: check for path formatting failures
      libsemanage: introduce write_full wrapper
      libsemanage: more strict value parsing
      libsemanage: constify function pointer structures
      libsemanage: simplify loop exit
      libsemanage: constify read only parameters and variables
      libsemanage: avoid misc function pointer casts
      libsemanage: adjust sizes to avoid implicit truncations
      libsemanage: use asprintf(3) to simplify code
      libsemanage: use size_t for hash input sizes
      libsemanage: drop macros used once
      libsemanage: drop dead code
      libsemanage: preserve errno during internal logging
      libsemanage: avoid strerror(3)
      libsemanage: avoid writing directly to stderr
      libsemanage: skip sort of empty arrays
      libsemanage/tests: misc cleanup
      libsemanage: set O_CLOEXEC flag for file descriptors
      libsemanage: handle cil_set_handle_unknown() failure
      libsemanage: handle shell allocation failure
      libsemanage: drop duplicate newlines and error descriptions in error =
messages
      libsemanage: check closing written files
      libsemanage: simplify file deletion
      libsemanage: optimize policy by default
      libsemanage/man: add documentation for command overrides
      libsemanage: respect shell paths with /usr prefix
      libselinux: make use of calloc(3)
      libselinux: avoid dynamic allocation in openattr()
      libselinux: move functions out of header file
      libsepol: harden availability check against user CFLAGS
      libselinux: harden availability check against user CFLAGS
      libselinux: avoid memory allocation in common file label lookup
      libselinux: use vector instead of linked list for substitutions
      libselinux: simplify string formatting
      libselinux/utils: use correct error handling
      libsepol: avoid unnecessary memset(3) calls in hashtab
      checkpolicy: drop host bits in IPv6 CIDR address
      libselinux/utils: drop reachable assert in sefcontext_compile
      libsepol: add missing word separators in error message
      libselinux/fuzz: update for lookup_all() change
      libselinux: restore previous regex spec ordering
      libselinux/fuzz: readjust load_mmap() update
      libsepol/cil: free nlmsg hashtable on error
      libselinux/fuzz: handle inputs with trailing data
      libsepol: fix typos
      python: fix typos
      libselinux: set errno in failure case
      checkpolicy: check identifier before copying
      checkpolicy: remove unneeded queue_head()
      checkpolicy: do not consume unmatched identifiers
      checkpolicy: clear queue between parser passes

Daniel Burgener (1):
      CONTRIBUTING.md: Drop dependency and build instructions

Dmitry Sharshakov (2):
      sepolgen: initialize gen_cil
      policygen: respect CIL option when generating comments

Fabian Vogt (2):
      restorecond: Set GLib IO channels to binary mode
      restorecond: Set GLib IO channels to nonblocking

James Carter (9):
      checkpolicy: Check the right bits of an ibpkeycon rule subnet prefix
      libselinux: Fix integer comparison issues when compiling for 32-bit
      libsepol/cil: Allow dotted names in aliasactual rules
      checkpolicy: Fix MLS users in optional blocks
      libsepol/cil: Optionally allow duplicate role declarations
      libsemanage: Optionally allow duplicate declarations
      libsepol: Remove special handling of roles in module_to_cil.c
      libselinux: Close old selabel handle when setting a new one
      libsemanage: Set new restorecon handle before doing restorecon

Ondrej Mosnacek (5):
      ci: use Testing Farm for running the testsuite
      ci: update Python versions
      ci: add missing libbz2-dev dependency
      ci: fix pypy conditional
      README: fix broken testsuite run status badge

Petr Lautrbach (11):
      libselinux: set free'd data to NULL
      libselinux: fix swig bindings for 4.3.0
      libsemanage: fix swig bindings for 4.3.0
      libsemanage: open lock_file with O_RDWR
      fixfiles: use `grep -F` when search in mounts
      Update VERSIONs to 3.8-rc1 for release.
      Update VERSIONs to 3.8-rc2 for release.
      sepolgen-ifgen: allow M4 escaped filenames
      Update VERSIONs to 3.8-rc3 for release.
      Update VERSIONs to 3.8-rc4 for release.
      Update VERSIONs to 3.8 for release.

Stephen Smalley (1):
      libselinux: formally deprecate security_compute_user()

Steve Langasek (1):
      Always build for LFS mode on 32-bit archs.

Thi=C3=A9baud Weksteen (5):
      libsepol: Rename ioctl xperms structures and functions
      libsepol: Support nlmsg extended permissions
      libsepol: Add policy capability netlink_xperm
      libselinux: rename hashtab functions
      libsepol: Support nlmsg xperms in assertions

Vit Mojzis (12):
      libselinux/restorecon: Include <selinux/label.h>
      libsemanage: Preserve file context and ownership in policy store
      libsepol/sepol_compute_sid: Do not destroy uninitialized context
      libsepol/cil: Check that sym_index is within bounds
      libsepol/cil: Initialize avtab_datum on declaration
      libsepol/mls: Do not destroy context on memory error
      libsepol/cil/cil_post: Initialize tmp on declaration
      libsepol: Initialize "strs" on declaration
      libselinux/setexecfilecon: Remove useless rc check
      libselinux/matchpathcon: RESOURCE_LEAK: Variable "con"
      libsemanage/direct_api: INTEGER_OVERFLOW read_len =3D read()
      libsemanage: Mute error messages from selinux_restorecon

