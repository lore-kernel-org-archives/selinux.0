Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AF1D2F5C
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677846; cv=none; b=LDwjJKOLFM+72K3wLpRifyJ4dsmeloNKWACbZRYibV1fo06WotVv2dkpomYZc/XmKt4jMFZYVzQyIEI7nDK6acVpRSgXzvaZ7gqK6IvIr9vozpjJ6alSfIL02bBcriHT2sNVgZ7KMqXmEe9vD4qhDllnqj8BUi+6cHKORN2XpVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677846; c=relaxed/simple;
	bh=MOOrFFVd/j4LC4Clh7cGEsMw9B9tNUc5RDVtT6mAKCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B04A0Ch4IE83Rfyv8ZW8u6/Az/pScV4Py1EMwqm60iDEGM2nTsMqeKy9qhDURyWZNxucVWfQjd9RCF9xqqteyDlIDrgPg8QUjgp0h1UlWJKikD8575cdMMkhAWMuODLKb9DNAyJ/u8Jb+JxvbxwQ75mAAK9vgff/TYsALTFn1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=jI3grPGn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="jI3grPGn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677843;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpTEzepp26spiJ8ZHrDs3GRobaxeX2+/+GpXYw//a2U=;
	b=jI3grPGnzu7K933a5sX52YUYRghn2d1G70mVaULL+nUW+q9dswk9vh2sANmS65VEalMA2Z
	uulfxatXyNZiDX5nqwqu3dfJZrhqA0WSEndFMQLzxOxM5t2KqE5oODphHsWlp1Kk9JkxXM
	S2vtG9Ru/oA/zw/BMIqx9KDIXCDcVF9mGo4jNPcM7YciUrzkw71lzMy7iSFT3Ka4TFyUrl
	23CakCjyvyWS1d7ZFdM28S3Vf2ivTZxb2ZFOztGyQDe9h6aFbD8XW1HUwADGhLS1rc5o/B
	82vHgzJFgLtxclu/KQJT6V5JmJyNAQdfXIgKQmWzfqSRFtF/z2L8ghgyxsi92w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 00/22] selinux: harden against malformed policies
Date: Fri, 15 Nov 2024 14:35:42 +0100
Message-ID: <20241115133619.114393-23-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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
 security/selinux/ss/avtab.c            |  67 ++-
 security/selinux/ss/avtab.h            |  12 +-
 security/selinux/ss/conditional.c      | 170 +++---
 security/selinux/ss/conditional.h      |   6 +-
 security/selinux/ss/constraint.h       |   2 +-
 security/selinux/ss/context.c          |   2 +-
 security/selinux/ss/context.h          |  10 +-
 security/selinux/ss/ebitmap.c          |  31 +-
 security/selinux/ss/ebitmap.h          |   6 +-
 security/selinux/ss/hashtab.h          |   4 +-
 security/selinux/ss/mls.c              |  70 ++-
 security/selinux/ss/mls.h              |   6 +-
 security/selinux/ss/policydb.c         | 698 +++++++++++++++++++------
 security/selinux/ss/policydb.h         |  68 ++-
 security/selinux/ss/services.c         |  82 +--
 security/selinux/ss/sidtab.c           |   2 +-
 security/selinux/ss/symtab.c           |   2 +-
 security/selinux/ss/symtab.h           |   2 +-
 23 files changed, 895 insertions(+), 357 deletions(-)

-- 
2.45.2

