Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D820110B
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664649; cv=none; b=gudAibxFP5Y4giNkC3ZYKCMurjWG4hUy9L1hY4grAJXRtRaLeCwqoychEGqZ5ByOj4OtGM2k4WfHORdwdGTsDPvkhhz61fLIhVp3dQrLdC3OgCDqLPACWXWp2+9DmWIkyrCA1xusD+8ar1gp/Q+XTrA3dC6EXNe47CQuFJ7vrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664649; c=relaxed/simple;
	bh=NKBUFksnZkjRmO4SP8ytqDVtDgDgxtY2clQQDjQcw+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y+lggPPk+MVfFlTABAq6q90VczO/lT4o/FUrxd90r818gR1iXsQtW/2TLS55tQwjOrV+5HERGZZOFTnaBmKfEhgl3JSoiZQPO7XK+IAqjSpgFuvo8BYwnWwurtWsmJxsYafiB+lDgmesfvetQ2heaaVnC9V6TBZeQcfmgDCFsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR2QUY/f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR2QUY/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752664645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zrnFWR3+3yAGDsuszckVm1FVxfzMPbzeFPJ2xgIromA=;
	b=LR2QUY/fTm9Yi/YDt9GgQ6TKLXbWL9JCVJtIHIDe4a3805qXdzBZWi/OgeLw2ZDMvCNRVi
	rhgkcYv3Qy5Bej14is40fIyP/iCI+zjz2pLDmD1Vd/NARPvSnkmcpyMMjGCtNcezdimPWQ
	C1bCaoTR2Ffs1y8jflI8d+cXMdhBYVo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-3__wlOaZNO-9I47Tz1VTzw-1; Wed,
 16 Jul 2025 07:17:23 -0400
X-MC-Unique: 3__wlOaZNO-9I47Tz1VTzw-1
X-Mimecast-MFC-AGG-ID: 3__wlOaZNO-9I47Tz1VTzw_1752664642
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69611800284
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 11:17:21 +0000 (UTC)
Received: from localhost (unknown [10.45.225.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5808019373D8
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 11:17:21 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.9
Date: Wed, 16 Jul 2025 13:17:19 +0200
Message-ID: <878qkomlkw.fsf@redhat.com>
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

The 3.9 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

User-visible changes
--------------------
* Support static-only builds with DISABLE_SHARED=3Dy

* Add restore option to modify user and role portions

* setfiles: Add -U option to modify user and role portions

* semanage.conf: Add relabel_store config option

* semodule: Add [-g PATH |--config=3DPATH] for an alternate path for the se=
manage config

* libselinux: Fix local literal fcontext definitions priority

* libselinux: Fix order for path substitutions

* libsepol: Add new 'netif_wildcard' policy capability

* checkpolicy: Add support for wildcard netifcon names

* libsepol: Allow multiple policycap statements

* libsepol: Support genfs_seclabel_wildcard

* Replace all links to selinuxproject.org

* Bug fixes

Shortlog of the changes since 3.8.1 release
-------------------------------------------
Alyssa Ross (4):
      Support static-only builds
      libselinux: be careful with non-portable LFS macro
      libsemanage: add missing libaudit private library
      policycoreutils: use pkg-config for libsemanage

Christian G=C3=B6ttsche (23):
      checkpolicy: rework cleanup in define_te_avtab_xperms_helper()
      checkpolicy: free left hand conditional expression on error
      checkpolicy: abort on mismatched declarations
      checkpolicy: perform cleanup on error in define_filename_trans()
      libselinux: add restore option to modify user and role portions
      setfiles: add option to modify user and role portions
      libselinux: introduce context_to_str(3)
      mcstrans: make use of context_to_str(3)
      libselinux: constify global strings
      libselinux: use local instead of global error buffer
      libselinux: initialize regex arch string in a thread safe way
      libselinux: limit fcontext regex path length
      checkpolicy: free ebitmap on error in define_compute_type_helper()
      libselinux: limit node depth while parsing compiled fcontexts
      libsemanage: fix handling errors during child execution
      semanage: improve -e documentation and fix delete operation
      libselinux: prioritize local literal fcontext definitions
      libselinux: retain LIFO order for path substitutions
      libsepol: update sort order for netifcon definitions
      libsepol: add netif_wildcard polcap
      checkpolicy: add support for wildcard netifcon names
      secilc/test: add test for wildcard netifcon statement
      libsepol/cil: reject wildcard only network interface names

Daniel Burgener (1):
      Switch from bison name-prefix to api.prefix

Inseob Kim (8):
      libsepol: Fix markers for info nodes w/o children
      libsepol: Allow booleanif to have info nodes
      libsepol: Make line markers of rules configurable
      checkpolicy: Support line markers for allow rules
      checkmodule: Support line markers for allow rules
      checkpolicy: Allow lineno > 1 for source file line
      libsepol: Allow multiple policycap statements
      libsepol: Support genfs_seclabel_wildcard

James Carter (5):
      libselinux: Do not inline compile_regex()
      libsemanage: Ignore missing field initializers in swig generated code
      Policycoreutils: Make pkg-config work for more types of builds
      libsepol/cil: Fix copying of declarations
      libsepol/cil: Expand class-permissions in deny rules

Petr Lautrbach (6):
      README: update subscribe information
      Update VERSIONs to 3.9-rc1 for release.
      Update VERSIONs to 3.9-rc2 for release.
      sepolicy: use multiprocessing 'fork' method
      Update VERSIONs to 3.9-rc3 for release.
      Update VERSIONs to 3.9 for release.

Rahul Sandhu (1):
      libsemanage: create semanage_basename to ensure posix compliance

Robert Marko (1):
      policycoreutils: run_init: define _GNU_SOURCE

Stephen Smalley (2):
      libsepol,checkpolicy: introduce neveraudit types
      userspace: replace all links to selinuxproject.org

Thi=C3=A9baud Weksteen (2):
      libselinux: warn on identical duplicate properties
      libselinux: Document thread caveat for security_compute_av.3

Tristan Ross (3):
      libsemanage: add relabel_store config option
      libsemanage: add semanage_handle_create_with_path
      semodule: add config argument

=D0=BD=D0=B0=D0=B1 (2):
      Insert -I../../libselinux/include and -L../../libselinux/src into sub=
programs where needed
      Inject matchpathcon_filespec_add64() if !defined(__INO_T_MATCHES_INO6=
4_T) instead of using __BITS_PER_LONG < 64 as proxy

