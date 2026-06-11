Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA12E7631
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166716; cv=none; b=Lj9AB9z6QqQz/+vc9RdPxe2woIRFyQue+QvdiSBuHfyHIsKhNKBc2JRX96xCuHJQSWNpdxMwiuJGb0v4VGnZFZlxHTBsQkY1PYAWx23TQKZ8NW3FHSd9qb/LIA4M5IGDvHA/Rj1wzsAP+dur1Sqplb+/ulv4RfxGtsy5AHOq2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166716; c=relaxed/simple;
	bh=eOJr3m7SfX1Fj2rGM0HcvOx2TkhNND3GGf6pyNJnUU4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Be0Fl9c9AhbuP2gqmV+AhbE13CYeNzRi+/VNDLbWb2jKiz/TfYB/2NTKGy543MUihIZSpetJTiGjcnsVbcHiVxscW4gIf0bp28mbp9uB8prrdoK6uSlpaKU978M2KEClIP7ksHe956UPZ1XEXCFmfJTQxwkdRhr0H6jHhRXtIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUAsFpO3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUAsFpO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cZmbp20fOFcYprB6aKspk7zNdlvVPh12J0oiLvterTQ=;
	b=DUAsFpO3Udre5haFn105ueG5aiVovT2jkUgWH5iIbr7emCP3NlNCmCq5yDXq3EbS+RGneQ
	Jk58gxMrGWn8HCODO+rQ8orzviGiOftaOINVDTkAWddlzf9vSDjQP2xXBxktuKRRwvUVHc
	Dqc74NVsckoqanFmIc61CPldaR/4n9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-rJRTV-_5O96qyGW0HqTGmg-1; Thu,
 11 Jun 2026 04:31:52 -0400
X-MC-Unique: rJRTV-_5O96qyGW0HqTGmg-1
X-Mimecast-MFC-AGG-ID: rJRTV-_5O96qyGW0HqTGmg_1781166711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90B8F1800675
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 08:31:51 +0000 (UTC)
Received: from localhost (unknown [10.44.49.213])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DDDC3000223
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 08:31:50 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.11-rc2 release
Date: Thu, 11 Jun 2026 10:31:49 +0200
Message-ID: <87a4t1mqa2.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello!

The 3.11-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.11-rc2
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

User-visible changes since 3.11-rc1
-----------------------------------

- Bug fixes

Development-relevant changes
----------------------------

- Improved ci and refactored ci build into a custom GH action
- libselinux and python use system Python3 build module

Shortlog of the changes since 3.11-rc1 release
----------------------------------------------
Cathy Hu (1):
      libsemanage: avoid "all" as requirement for SWIGSO/SWIGRUBYSO (bsc#12=
66385)

Chris PeBenito (3):
      ci: Refactor build into a custom GH action.
      ci: Explicitly set bash shell in build-userspace action
      ci: Add additional output grouping in build-userspace action.

Christian G=C3=B6ttsche (16):
      Makefile: support custom clang-format binary
      libselinux: bounds-check serialized regex length before PCRE2 decode
      libselinux: reject invalid file_kind in compiled fcontext loader
      libselinux: avoid out-of-bounds read on empty failsafe_context line
      libselinux: validate netlink message length before accessing payload
      libselinux: use size_t for index
      libselinux: drop trailing returns
      sandbox: drop unused macro
      policycoreutils: declare local variables static
      policycoreutils: drop unused macros
      restorecond: declare local variables static
      mcstrans: check context_range_set(3) for failure
      secon: check selinux_raw_to_trans_context(3) for failure
      restorecond: warn on selinux_restorecon(3) failure
      restorecond: drop unused macros and variables
      Consistently use NULL as pointer constant

Cristian Rodr=C3=ADguez (1):
      libselinux: Do not clobber errno of the world

Fabrice Fontaine (1):
      libselinux/src/se_linux_internal.c: include stdint.h

James Carter (8):
      secilc/secilcheck: Exit with an error for an assertion violation
      Have clang-format ignore auto-generated files
      libsepol/cil: Fix type confusion when writing policy.conf from CIL
      secilc/secilcheck: Remove extra sepol_policydb_free(pdb)
      libsepol/cil: Add check for too large of file size
      secilc/secil2tree: Test for stdout rather than stdin
      libsepol: Ensure dst gets set when copying range transitions
      libsepol/cil: Need to add to the length rather assigning it

Marcos Freitas de Morais (1):
      secilc/docs: Adjusted correct statement keyword

Pepper Gray (1):
      add test for fts_* availability

Petr Lautrbach (4):
      ci: install necessary build python module
      libselinux,python: Use system Python3 build module
      Add check_format Github CI job
      Update VERSIONs to 3.11-rc2 for release.

Rahul Sandhu (1):
      libsepol: cil_resolve_ast: add in a CIL_SRC_INFO for the copied data

Renato Caldas (1):
      libselinux: restore: drop the obsolete LSF transitional API.

Robert Frohl (1):
      sandbox/sandbox: fix saving file changes

Sergei Trofimovich (1):
      libselinux: drop long deprecated `-Wstrict-overflow=3D5` flag

Stephen Smalley (29):
      restorecond: avoid busy-loop when watch list is empty
      libselinux: selinux_restorecon: add flag to skip multilink files
      restorecond: Use new SELINUX_RESTORECON_SKIP_MULTILINK flag
      restorecond: pin watched directories
      mcstrans: fix UAF on SIGHUP
      mcstrans: handle NULL domain
      mcstrans: mcscolor: handle NULL my_context
      mcstrans: cap max clients
      mcstrans: set receive timeout on accepted client sockets
      mcstrans: cap the per-domain translation cache
      libsemanage: fix OOB cleanup in semanage_direct_list()
      libselinux: serialize legacy compat_validate() callbacks
      libselinux: fix selinux_status_updated() for MAP_FAILED case
      libselinux: restorecon_xattr: clear dir_xattr_* after freeing
      libselinux: selabel_close: only call func_close if set
      libselinux: audit2why: clear static variables on init failure
      libsemanage: genhomdircon: handle NULL bsearch() in get_users()
      libselinux: label: ensure specfile_list is NULL-terminated
      mcstrans: fix glob() error checking
      restorecond: fix glob() error checking
      restorecond: avoid clobbering last character of config line
      restorecond: delete unused code
      libselinux: fix REQUIRESEUSERS true/false handling
      libsemanage: genhomedircon: fix STR_COMPARATOR() passed to lfind()
      checkpolicy: drop fscon statement support
      libsemanage: bunzip: guard against size overflow
      libselinux: label_backends_android: fix non-anti-symmetric cmp functi=
on
      libselinux: label_file: prevent num_specs overflow
      libselinux: digest_gen_hash(): reduce the chunk size for Sha1Update()=
 calls

Yi Zhao (1):
      sepolicy: set conf.substitutions['releasever'] to empty str when rele=
asever is None

netliomax25-code (2):
      sestatus: null-terminate process and file check entries
      libselinux: avoid out-of-bounds access on zero-length lines


