Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97263201105
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733609; cv=none; b=npPSsH5N2Vgi1iqIzh6CNB8f+jj/nu0DY9xYGHpWc72L+CVdtoNC4QvAZLo2BonyhY53CnghZ6RiCwNb+6xdhY3Gljea2zgCm/x8hDbtB1O38gjo//UoaoOFORP3YjpgqzychtNoq5jSlYsZm6fYxtyjMXwGMKwcdHRRS/Ma/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733609; c=relaxed/simple;
	bh=0S8W27US3VUCSSZIpzL9U21qGW1LG8S87YJJFH47gXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lb+CmA+QGMGNpBYlNBAXcWfJAOOB4zYSXjNYYVDZPmP+9w+W+PAOlzcaout+Gs2nKga1R9Dv0g4ExGRzmm5j9eIla2yeQxPlBNrORfz3u9aWNdH012LKjh2JsmEzTNqmTlX5LGiSMibdX6Gj61DcM1p0vxvSlfczuEBm0zasGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiGwiApY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiGwiApY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732733606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8wKV/Kg46QkeehVGB581KjlUXEsEixfXq8HbDU/Eomk=;
	b=LiGwiApYg6gJcwbvFD/q3KvnX6rTCDXVX/fUSHMIFTaa8sfI8sWNlZmKsA1NW4tbLMf0PE
	T9xuNrmSz93rCXhVX1o/NydfjuVtM8NfCOeGdxanU5jpeti0z1LzjE7W2O+pEqLGRCTRqS
	fMfcQe2H8PZSl7tYWqqYPYel1389TAM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-u3BEOYMyO5aD6oMqAkniqg-1; Wed,
 27 Nov 2024 13:53:24 -0500
X-MC-Unique: u3BEOYMyO5aD6oMqAkniqg-1
X-Mimecast-MFC-AGG-ID: u3BEOYMyO5aD6oMqAkniqg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B07411955EAE
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 18:53:23 +0000 (UTC)
Received: from localhost (unknown [10.45.224.170])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34244195E480
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 18:53:22 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: SElinux list <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 3.8-rc1 release
Date: Wed, 27 Nov 2024 19:53:21 +0100
Message-ID: <87mshkv78e.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello!

The 3.8-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

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

Shortlog of the changes since 3.7 release
-----------------------------------------
Christian G=C3=B6ttsche (70):
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

Dmitry Sharshakov (2):
      sepolgen: initialize gen_cil
      policygen: respect CIL option when generating comments

Fabian Vogt (2):
      restorecond: Set GLib IO channels to binary mode
      restorecond: Set GLib IO channels to nonblocking

James Carter (7):
      checkpolicy: Check the right bits of an ibpkeycon rule subnet prefix
      libselinux: Fix integer comparison issues when compiling for 32-bit
      libsepol/cil: Allow dotted names in aliasactual rules
      checkpolicy: Fix MLS users in optional blocks
      libsepol/cil: Optionally allow duplicate role declarations
      libsemanage: Optionally allow duplicate declarations
      libsepol: Remove special handling of roles in module_to_cil.c

Petr Lautrbach (6):
      libselinux: set free'd data to NULL
      libselinux: fix swig bindings for 4.3.0
      libsemanage: fix swig bindings for 4.3.0
      libsemanage: open lock_file with O_RDWR
      fixfiles: use `grep -F` when search in mounts
      Update VERSIONs to 3.8-rc1 for release.

Stephen Smalley (1):
      libselinux: formally deprecate security_compute_user()

Thi=C3=A9baud Weksteen (5):
      libsepol: Rename ioctl xperms structures and functions
      libsepol: Support nlmsg extended permissions
      libsepol: Add policy capability netlink_xperm
      libselinux: rename hashtab functions
      libsepol: Support nlmsg xperms in assertions

Vit Mojzis (11):
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

