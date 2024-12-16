Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574B2063C9;
	Mon, 16 Dec 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367328; cv=none; b=t5lA07sYRosIrTvZPa51uiL39YUExpgQMy76jrmM+SWMZkR8L1r42tN+3kLt4WigEpZCwW8Ib6NbX3kltyj2/YD0yRfEVFGGvG2OsxCdAvXrkGsA6FlNG5w8Dxg05Hb2DS5mRdGX58+uUcOlhPZYZEMJa/vVITRtQiOp/JkqqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367328; c=relaxed/simple;
	bh=gO8n9vZfpBjfodmCvr1/fbnzjIA/qScsIumVEWsMZoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbH2onxbt06qke1uvCBq3yXoutYC1dMxSxSLNpMmn1zMTsoD12ejNz9m1dhMirA00kTdT2J9B3Mx2skFg0KyniIcjAOpKvM8M5mvJP178QHt+AstezBjhs7wH5Ard+je2GqQgo/M2psoFSrWI2/qN5fxtDRKpml+qDNwC9lvYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Plwfp0bo; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Plwfp0bo"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367325;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3EeGZr/t96R0XuHvR13YB4j6oGq0qLz1TSEmdxnqKY=;
	b=Plwfp0boZO+ECktNZQncqJ4Ddk0FOAQuoiStDkBE0Qi64nFOIxEKfqQdRe8Fy6T9pKUIKt
	mBb3PMaaUKnFj157SMOKGJAFOE4LCK4fdsq6NPgX9qKqe5ZvfQliyrrFdu8Kn+8pdc352y
	fmo2xsjOnw9i+eIv34+q5w34NgK8unMaaVMqmpIeCwonOYT+mo+Nem3EwzwdzzqTpPjTld
	pXw6xGBnhlLONr/hqpKABOMTNJF7GPjocubDb0byfuzY1ikddjhhweCKwZ/hV9RjnKUyhr
	UxoqA7H4yluSbzQCYxM3EbxgwHixIdnOT75fpOVR3XpN4RHFd2phAySoFZFz9w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 00/22] selinux: harden against malformed policies
Date: Mon, 16 Dec 2024 17:40:21 +0100
Message-ID: <20241216164055.96267-23-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

With the SELinux namespace feature on the horizon it becomes important
to identify and reject malformed policies at load time.  Otherwise
memory corruptions can compromise the kernel or NULL-pointer dereferences
and BUG() encounters can bring systems down.  Currently this is not a
security relevant issue since loading a policy requires root privileges
and permission of the current loaded SELinux policy, making it one of the
most privileged operation.

The first 9 patches are cleanup commits with overseeable diffs.

Patch 10 unifies the underlying type used for security class identifiers.

Patch 11 to 21 add various checks at policy load time to reject malformed
policies.

Patch 22 needs some discussion:
It limits the valid set of characters and the length for strings defined
by policies.  Currently there are no restrictions, so control characters
are accepted, e.g. Esc as part of a type name, and their length can be
arbitrary.  Human formatted security contexts however must not be
arbitrarily long, one example is they must fit in a page size for
selinuxfs interaction and network associations.
Thus the patch introduces the following restrictions:
  * Disallow control characters
  * Limit characters of identifiers to alphanumeric, underscore, dash,
    and dot
  * Limit identifiers in length to 128, expect types to 1024 and
    categories to 32, characters (excluding NUL-terminator)
    
p.s.:
On a related note to patch 10, the underlying type for types (and type-
attributes) is also not consistent:
In role, range and filename transitions, and the actual datum u32 is
used, while avtables use u16, practically limiting the number of
available types to 65534 (= U16_MAX - 2 (0 and U16_MAX are invalid)).

v1: https://lore.kernel.org/selinux/20241115133619.114393-23-cgoettsche@seltendoof.de/

v2: 
  - also convert ebitmap_cmp() as suggested by Daniel
  - accept instead of rejecting unknown xperm specifiers to support
    backwards compatibility for future ones, suggested by Thiébaud
  - add wrappers for str_read() to minimize the usage of magic numbers
  - limit sensitivities to a length of 32, to match categories,
    suggested by Daniel
 
Christian Göttsche (22):
  selinux: supply missing field initializers
  selinux: avoid using types indicating user space interaction
  selinux: align and constify functions
  selinux: rework match_ipv6_addrmask()
  selinux: avoid nontransitive comparison
  selinux: rename comparison functions for clarity
  selinux: use known type instead of void pointer
  selinux: avoid unnecessary indirection in struct level_datum
  selinux: make use of str_read()
  selinux: use u16 for security classes
  selinux: more strict policy parsing
  selinux: check length fields in policies
  selinux: validate constraints
  selinux: pre-validate conditional expressions
  selinux: introduce ebitmap_highest_set_bit()
  selinux: check type attr map overflows
  selinux: reorder policydb_index()
  selinux: beef up isvalid checks
  selinux: validate symbols
  selinux: more strict bounds check
  selinux: check for simple types
  selinux: restrict policy strings

 security/selinux/hooks.c               |   2 +-
 security/selinux/include/classmap.h    |   2 +-
 security/selinux/include/conditional.h |   2 +-
 security/selinux/include/security.h    |   4 +-
 security/selinux/selinuxfs.c           |   2 +-
 security/selinux/ss/avtab.c            |  58 +-
 security/selinux/ss/avtab.h            |  11 +-
 security/selinux/ss/conditional.c      | 166 +++---
 security/selinux/ss/conditional.h      |   6 +-
 security/selinux/ss/constraint.h       |   2 +-
 security/selinux/ss/context.c          |   2 +-
 security/selinux/ss/context.h          |  14 +-
 security/selinux/ss/ebitmap.c          |  39 +-
 security/selinux/ss/ebitmap.h          |   8 +-
 security/selinux/ss/hashtab.h          |   4 +-
 security/selinux/ss/mls.c              |  70 ++-
 security/selinux/ss/mls.h              |   6 +-
 security/selinux/ss/mls_types.h        |   2 +-
 security/selinux/ss/policydb.c         | 698 +++++++++++++++++++------
 security/selinux/ss/policydb.h         | 116 +++-
 security/selinux/ss/services.c         |  82 +--
 security/selinux/ss/sidtab.c           |   2 +-
 security/selinux/ss/symtab.c           |   2 +-
 security/selinux/ss/symtab.h           |   2 +-
 24 files changed, 940 insertions(+), 362 deletions(-)

-- 
2.45.2

