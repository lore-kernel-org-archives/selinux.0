Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A641422AE
	for <selinux@vger.kernel.org>; Wed, 22 May 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399339; cv=none; b=M8/zCJsApoJjcMOAUnDjP8lG714CfNXnugw+BwJIW7fN3ufgpNr6T1jm06KD7g9ivZXF14hFUv9mrVGLQzN4DfStp1/JujryYmqq+jK15iqXEnpxEsJS+Lin94UaT7xdwVpG18oZp9QRcPA9wpLnEtWSRVVsJi0C91wAPQwDV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399339; c=relaxed/simple;
	bh=Wyrx98biIfrfMRzU75kfMc57QqiLkgc/NQUCXRNdoKw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DrmEHALacau5UtFr0RDkxNyDkfbvmxF3QjsY0nj/P6LboferJfiQFD44VWbecNSAf7y/6ybIbJINBDvujeO6N8zp0cm7uP6pPw0xT4xkL5dQTNph87A2l6p1p7an7LyOeR+0KZPQaaPl2ji2QQ/lqjGP1i+yN20wHJuY1dMa2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgZaqEjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgZaqEjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716399336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UGStwJ+fsx1bqJhPQeKA/a7adQZKcf5jZcYCDuZLH8Y=;
	b=KgZaqEjswgiknFtlVh5UL7WKlGoOqsCTWSDVi0oeOnKOorA9SyzKgsP937umbC0XrFJrPF
	WiGD6ZOoZk65TwDKp7yT9ZygI6TsgGm2wixPQkCbiF7bKf2aK9JJhk0ySWsMnqGJ3l6o+G
	8GAAkuyok9zaasgISh7ZZoLg3QlLGYM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-OF4bvpYjPTOLPwooqj468A-1; Wed,
 22 May 2024 13:35:35 -0400
X-MC-Unique: OF4bvpYjPTOLPwooqj468A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EFC6380008A
	for <selinux@vger.kernel.org>; Wed, 22 May 2024 17:35:35 +0000 (UTC)
Received: from localhost (unknown [10.45.224.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C2AD02026D68
	for <selinux@vger.kernel.org>; Wed, 22 May 2024 17:35:34 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.7-rc1 release
Date: Wed, 22 May 2024 19:35:34 +0200
Message-ID: <87pltdzr4p.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello!

The 3.7-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me know.

User-visible changes
--------------------

* `audit2allow -C` for CIL output mode

* sepolgen: adjust parse for refpolicy

* semanage: Allow modifying records on "add"

* semanage: Do not sort local fcontext definitions

* Improved man pages

* Code improvements and bug fixes

Shortlog of the changes since 3.6 release
-----------------------------------------
Christian G=C3=B6ttsche (66):
      libselinux/man: mention errno for regex compilation failure
      libselinux/man: sync selinux_check_securetty_context(3)
      libselinux/utils: free allocated resources
      libselinux/utils: improve compute_av output
      libselinux: align SELABEL_OPT_DIGEST usage with man page
      libselinux: fail selabel_open(3) on invalid option
      libselinux: use logging wrapper in getseuser(3) and get_default_conte=
xt(3) family
      libselinux: support huge passwd/group entries
      libsemanage: support huge passwd entries
      libselinux: enable usage with pedantic UB sanitizers
      setfiles: avoid unsigned integer underflow
      libsepol: reorder calloc(3) arguments
      libselinux: reorder calloc(3) arguments
      sandbox: do not override warning CFLAGS
      mcstrans: check memory allocations
      libselinux: use reentrant strtok_r(3)
      checkpolicy: add libfuzz based fuzzer
      checkpolicy: cleanup resources on parse error
      checkpolicy: cleanup identifiers on error
      checkpolicy: free ebitmap on error
      checkpolicy: check allocation and free memory on error at type defini=
tion
      checkpolicy: clean expression on error
      checkpolicy: call YYABORT on parse errors
      checkpolicy: bail out on invalid role
      libsepol: use typedef
      checkpolicy: provide more descriptive error messages
      checkpolicy: free temporary bounds type
      checkpolicy: avoid assigning garbage values
      checkpolicy: misc policy_define.c cleanup
      libsepol: ensure transitivity in compare functions
      libsepol/cil: ensure transitivity in compare functions
      mcstrans: ensure transitivity in compare functions
      sepolgen: adjust parse for refpolicy
      checkpolicy/fuzz: drop redundant notdefined check
      checkpolicy: clone level only once
      checkpolicy: return YYerror on invalid character
      libsepol: reject MLS support in pre-MLS policies
      checkpolicy/fuzz: scan Xen policies
      libselinux/utils/selabel_digest: drop unsupported option -d
      libselinux/utils/selabel_digest: cleanup
      libselinux/utils/selabel_digest: avoid buffer overflow
      libselinux: free data on selabel open failure
      libselinux/utils/selabel_digest: pass BASEONLY only for file backend
      libselinux: avoid logs in get_ordered_context_list() without policy
      checkpolicy: use YYerror only when available
      checkpolicy: handle unprintable token
      checkpolicy: free identifiers on invalid typebounds
      checkpolicy: update error diagnostic
      checkpolicy: include <ctype.h> for isprint(3)
      checkpolicy/fuzz: override YY_FATAL_ERROR
      libsepol: validate access vector permissions
      checkpolicy: drop never read member
      checkpolicy: drop union stack_item_u
      checkpolicy: free complete role_allow_rule on error
      libsepol: constify function pointer arrays
      libsepol: improve policy lookup failure message
      checkpolicy/tests: add test for splitting xperm rule
      checkpolicy: declare file local variable static
      checkpolicy: drop global policyvers variable
      github: bump Python and Ruby versions
      libsepol: validate class permissions
      libselinux/man: correct file extension of man pages
      libselinux/man: sync const qualifiers
      libselinux/man: use void in synopses
      libselinux/man: add format attribute for set_matchpathcon_printf(3)
      libselinux: constify selinux_set_mapping(3) parameter

Fabrice Fontaine (1):
      libsepol/src/Makefile: fix reallocarray detection

James Carter (7):
      libselinux: Fix ordering of arguments to calloc
      libsepol: Use a dynamic buffer in sepol_av_to_string()
      checkpolicy, libsepol: Fix potential double free of mls_level_t
      checkpolicy/fuzz: Update check_level() to use notdefined field
      libsepol: Fix buffer overflow when using sepol_av_to_string()
      libselinux, libsepol: Add CFLAGS and LDFLAGS to Makefile checks
      libsepol/cil: Check common perms when verifiying "all"

Petr Lautrbach (1):
      Update VERSIONs to 3.7-rc1 for release.

Topi Miettinen (1):
      audit2allow: CIL output mode

Vit Mojzis (3):
      python/semanage: Do not sort local fcontext definitions
      python/semanage: Allow modifying records on "add"
      libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)

