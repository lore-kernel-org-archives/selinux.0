Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85C18FC7C
	for <selinux@vger.kernel.org>; Wed, 26 Jun 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424286; cv=none; b=koerwM5SfkEIhQPqUphuLwBnKEhNcdhc7zUXGWL+FhDkqsP8ziOhzyAgdxk1kflCjVrbVoqYgJdDXaigntF0lABC9T255g5j+VD2bhbb7y5P/3wqP4EpNuMZmy7JgivsuwTJxKjUmFT89wFXpiWxrD6cXEsAU/1PkkHspquNm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424286; c=relaxed/simple;
	bh=xSgdzJbaohWt8iGF3zW1n0bXkJLf1r1JyIMuC86h7uE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEBkrGBlhAr7bz5K0KxYZSdWTGGEElQT4rGdNhJADGTsds/4hYKArf9yl+p5cUOp78XP852RmW1J/t8TTLQXxPT6EzxRCwtedTp08ALmvz3g8By/5G9LL51wRdLChFBbACHpcHfYGmSNTo+Yl5fA/sEeV9F21nqYQznm5iggxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sdyz46Y2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sdyz46Y2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719424283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+shc7i0VUniYru6+BW7hbGWMUuDK9W8rvWrxgkmE4/A=;
	b=Sdyz46Y2T07owmQTzu7djhXyiBZx0D+1IozfbjBaXLfZ/AQ9lwvhr+/XkX5GtmQ5vlwErK
	AHMl80gat4Q+qJuQ19RtaYNF5Q87MI4qWm/HuwnSNJ2odpCp0BtjAernR/uD0/02eSEif9
	XJ0Ud3c8tgGLuxhI/ZxnaqRZSZDeCo8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-sWWKFYYhPkuoI3EJAVeN2g-1; Wed,
 26 Jun 2024 13:51:21 -0400
X-MC-Unique: sWWKFYYhPkuoI3EJAVeN2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 231A5195605E
	for <selinux@vger.kernel.org>; Wed, 26 Jun 2024 17:51:21 +0000 (UTC)
Received: from localhost (unknown [10.45.224.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 929C03000221
	for <selinux@vger.kernel.org>; Wed, 26 Jun 2024 17:51:20 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.7
Date: Wed, 26 Jun 2024 19:51:19 +0200
Message-ID: <87ikxvfv8o.fsf@redhat.com>
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

The 3.7 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

User-visible changes
--------------------
* `audit2allow -C` for CIL output mode

* sepolgen: adjust parse for refpolicy

* semanage: Allow modifying records on "add"

* semanage: Do not sort local fcontext definitions

* Improved man pages

* checkpolicy: support CIDR notation for nodecon statements

* sandbox: Add support for Wayland

* Code improvements and bug fixes


Shortlog of the changes since 3.7 release
-----------------------------------------
Christian G=C3=B6ttsche (84):
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
      libsepol: reject self flag in type rules in old policies
      libsepol: only exempt gaps checking for kernel policies
      libsepol: validate type-attribute-map for old policies
      libsepol: include prefix for module policy versions
      checkpolicy: perform contiguous check in host byte order
      checkpolicy: support CIDR notation for nodecon statements
      libselinux: free empty scandir(3) result
      libselinux: avoid pointer dereference before check
      mcstrans: free constraint in error branch
      libsepol: hashtab: save one comparison on hit
      libsepol: move unchanged data out of loop
      libsepol: rework permission enabled check
      checkpolicy: reject duplicate nodecon statements
      libsepol: validate attribute-type maps
      tree-wide: fix misc typos
      libsepol: contify function pointer arrays
      libselinux: constify avc_open(3) parameter
      libsepol: check scope permissions refer to valid class

Fabrice Fontaine (1):
      libsepol/src/Makefile: fix reallocarray detection

James Carter (8):
      libselinux: Fix ordering of arguments to calloc
      libsepol: Use a dynamic buffer in sepol_av_to_string()
      checkpolicy, libsepol: Fix potential double free of mls_level_t
      checkpolicy/fuzz: Update check_level() to use notdefined field
      libsepol: Fix buffer overflow when using sepol_av_to_string()
      libselinux, libsepol: Add CFLAGS and LDFLAGS to Makefile checks
      libsepol/cil: Check common perms when verifiying "all"
      libsepol: Do not reject all type rules in conditionals when validating

Petr Lautrbach (9):
      Update VERSIONs to 3.7-rc1 for release.
      sandbox: do not fail without xmodmap
      sandbox: do not run window manager if it's not a session
      seunshare: Add [ -P pipewiresocket ] [ -W waylandsocket ] options
      sandbox: Add support for Wayland
      Update VERSIONs to 3.7-rc2 for release.
      fixfiles: drop unnecessary \ line endings
      Update VERSIONs to 3.7-rc3 for release.
      Release 3.7

Topi Miettinen (1):
      audit2allow: CIL output mode

Vit Mojzis (3):
      python/semanage: Do not sort local fcontext definitions
      python/semanage: Allow modifying records on "add"
      libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)

