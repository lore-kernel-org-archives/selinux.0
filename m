Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EC6FBF
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670513; cv=none; b=YtXzJUT87AXpKhtasUmRscbpL96nqlzWh2ySHXg6tobkmF2XDbqYcv/R057qdYywNAXnH42uwADOhBCQGM/3Yn/djsk40j2EvzqfqOS0L6g/CiajrTt3eU9ugn35Y9WA3gQ++b765rfXAffDk9QEOap/Y22vtZMfcmcWJr45eUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670513; c=relaxed/simple;
	bh=gCXXVj0CQu/bLJBAPjTs0ra1iowVgf/e+BHC7xVpr1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWsuAc6N69Ky4DQ1W7oLS85URrwFppXZai78ETRKvu3pLhX3T4zW1g/ardJSS31PANy9BQErNEWc7wExmCDvYSr+3zPwRNi3o2E0jIZGZya//8yNsnuopL8gLOrnOzxjs5TyWF0E9+NCVtLhSsZX+q1P63dlI5RG69fDHB62ULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vsfhdu6D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vsfhdu6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749670509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZCtVR2Fu5jNWKBMsiM9ZbA7DP9t6XnUF36PTv3Smrtg=;
	b=Vsfhdu6DyBPT8ckz6+949yPSMc6JIliuRZFdlQtWzDLexAW4K4AybLJhVf1W/GJalOSml5
	XFMC01I42XvyVQkOr2CWGQjuUxQlosv2J0sgZPrdlcthzJ5YH1eBK/dmvH4EBoxysP41zC
	XXtpD8TwEv/8HrA2shcVNpDyBiYzmgQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-1xxymqkCOCGYPod_Or5Vgw-1; Wed,
 11 Jun 2025 15:35:08 -0400
X-MC-Unique: 1xxymqkCOCGYPod_Or5Vgw-1
X-Mimecast-MFC-AGG-ID: 1xxymqkCOCGYPod_Or5Vgw_1749670507
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 657C01809C80
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:35:07 +0000 (UTC)
Received: from localhost (unknown [10.44.32.71])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDB9E180045C
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:35:06 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.9-rc1 release
Date: Wed, 11 Jun 2025 21:35:05 +0200
Message-ID: <87frg6dqc6.fsf@redhat.com>
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

The 3.9-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.9-rc1
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

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

* Bug fixes


Shortlog of the changes since 3.8.1 release
-------------------------------------------
Alyssa Ross (2):
      Support static-only builds
      libselinux: be careful with non-portable LFS macro

Christian G=C3=B6ttsche (18):
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

Daniel Burgener (1):
      Switch from bison name-prefix to api.prefix

Inseob Kim (6):
      libsepol: Fix markers for info nodes w/o children
      libsepol: Allow booleanif to have info nodes
      libsepol: Make line markers of rules configurable
      checkpolicy: Support line markers for allow rules
      checkmodule: Support line markers for allow rules
      checkpolicy: Allow lineno > 1 for source file line

James Carter (1):
      libselinux: Do not inline compile_regex()

Petr Lautrbach (2):
      README: update subscribe information
      Update VERSIONs to 3.9-rc1 for release.

Rahul Sandhu (1):
      libsemanage: create semanage_basename to ensure posix compliance

Robert Marko (1):
      policycoreutils: run_init: define _GNU_SOURCE

Stephen Smalley (1):
      libsepol,checkpolicy: introduce neveraudit types

Thi=C3=A9baud Weksteen (1):
      libselinux: warn on identical duplicate properties

Tristan Ross (3):
      libsemanage: add relabel_store config option
      libsemanage: add semanage_handle_create_with_path
      semodule: add config argument

=D0=BD=D0=B0=D0=B1 (2):
      Insert -I../../libselinux/include and -L../../libselinux/src into sub=
programs where needed
      Inject matchpathcon_filespec_add64() if !defined(__INO_T_MATCHES_INO6=
4_T) instead of using __BITS_PER_LONG < 64 as proxy

