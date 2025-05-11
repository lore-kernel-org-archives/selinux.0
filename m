Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42725D8E4;
	Sun, 11 May 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984697; cv=none; b=M/Yuz0kWlB0hkHlebJVNEdNx93VEU9p1Zm0tOnBObcN5VUBsDF5NKnWnzhvCo0tB85R/AdVsZFv4LGLTl5NORfz24Ko+PlpZLxmgVpED6hQLVPZDlpUuCTTsCxQeXSoKANipBghLdVgdw6yyWPJ3Vs7xLfRt1AsSZjlAY87lD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984697; c=relaxed/simple;
	bh=Pf+VzyysXD68l+KJQCLG2aEwhEMl4XVbBRNkAwxMSTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8r2aJJQSerLeG+DeKxDG7f6EqelYQo34cnYldRXY6DK5UXx75trBigE3WIEcwMO4NteRk/tgfqbRN0szNAlSSPMslAyOnOj+yMT8vLksio8WN1TjQvUL9D7YlSVqkqWZXhIMvEnmFIpvufDk3KJQPrbcQY/VSacPfGu6bXkxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SbcI5efI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SbcI5efI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984694;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=at5EPWGlV4UKqMblvAMTE9/lujase2/QeqyVZV1+yY0=;
	b=SbcI5efIaZie5Masa2rB+JAZ9MUDkPHfDEr9HETc1RRQVTB4jZaDA+M2d3prNf5gPhIbW8
	TVS81hiRT9pJu+V/LCJJgT3VHzZHZ+wS/ADbw+x8cd4sPncKxXDMRmZ9Xm2VjEN2/dXiCb
	CfVmRlQD47f7kQoGQ8SAPI0xyWJR9FiTSFk/UT2LLODN/7I2znuCaLv5zaU9dCfGgFj8oN
	epk3ezLvB+xVkybIBPFuxmke6guVl8IpmDOSUIYD25UA9plZseyPWmIeHiBd95wvbfL5Ov
	ZcxfTar9HwRm7O8dbIOXZuNx7BJS4prwrqjN+kmvuNUJsOHtMr4F0QKxnpdhzg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] selinux: harden against malformed policies
Date: Sun, 11 May 2025 19:30:15 +0200
Message-ID: <20250511173055.406906-15-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-1-cgoettsche@seltendoof.de>
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
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

Patch 13 limits the valid set of characters and the length for strings
defined by policies.  Currently there are no restrictions, so control
characters are accepted, e.g. Esc as part of a type name, and their
length can be arbitrary.  Human formatted security contexts however must
not be arbitrarily long, one example is they must fit in a page size for
selinuxfs interaction and network associations.
Thus the patch introduces the following restrictions:
  * Disallow control characters
  * Limit characters of identifiers to alphanumeric, underscore, dash,
    and dot
  * Limit identifiers in length to 128, expect types to 1024 and
    categories to 32, characters (excluding NUL-terminator)
    
v1: https://lore.kernel.org/selinux/20241115133619.114393-23-cgoettsche@seltendoof.de/

v2: https://lore.kernel.org/selinux/20241216164055.96267-23-cgoettsche@seltendoof.de/
  - also convert ebitmap_cmp() as suggested by Daniel
  - accept instead of rejecting unknown xperm specifiers to support
    backwards compatibility for future ones, suggested by Thiébaud
  - add wrappers for str_read() to minimize the usage of magic numbers
  - limit sensitivities to a length of 32, to match categories,
    suggested by Daniel
    
v3:
  - rename comparison macro to cmp_int()
  - move some portions from patch 2 to patch 3
  - minimize magic value usage
  - fix error branch reported by kernel test robot
  - merge ebitmap_highest_set_bit() patch into patch making use of it
  - introduce a central limits.h header
  - add limits for all kinds of string: filesystem names, filetrans
    keys, genfs paths, infiniband device names
  - add patch 14 for MLS stringification hardening

Christian Göttsche (14):
  selinux: avoid nontransitive comparison
  selinux: use u16 for security classes
  selinux: more strict policy parsing
  selinux: check length fields in policies
  selinux: validate constraints
  selinux: pre-validate conditional expressions
  selinux: check type attr map overflows
  selinux: reorder policydb_index()
  selinux: beef up isvalid checks
  selinux: validate symbols
  selinux: more strict bounds check
  selinux: check for simple types
  selinux: restrict policy strings
  selinux: harden MLS context string generation against overflows

 security/selinux/include/limits.h   |  90 +++++
 security/selinux/include/security.h |   1 +
 security/selinux/ss/avtab.c         |  49 ++-
 security/selinux/ss/avtab.h         |  13 +
 security/selinux/ss/conditional.c   | 152 ++++---
 security/selinux/ss/conditional.h   |   2 -
 security/selinux/ss/constraint.h    |   3 +-
 security/selinux/ss/ebitmap.c       |  27 ++
 security/selinux/ss/ebitmap.h       |   1 +
 security/selinux/ss/hashtab.h       |   4 +-
 security/selinux/ss/mls.c           |  84 ++--
 security/selinux/ss/mls.h           |   6 +-
 security/selinux/ss/policydb.c      | 597 +++++++++++++++++++++++-----
 security/selinux/ss/policydb.h      | 106 ++++-
 security/selinux/ss/services.c      | 111 ++++--
 security/selinux/ss/symtab.c        |   2 +-
 security/selinux/ss/symtab.h        |   2 +-
 17 files changed, 1008 insertions(+), 242 deletions(-)
 create mode 100644 security/selinux/include/limits.h

-- 
2.49.0

