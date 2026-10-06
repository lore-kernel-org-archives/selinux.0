Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF844456E10
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291796; cv=none; b=pV6pX0dG29HIdRKEI5QzhwVte1WStYe/4/e8RT94+7Qbrh4liXIf43yHmo3Me7HNp0wTrvZpS4+qCUsx0veYGEH6N+BXs/l7Tz+pTHxh7wh/Cw5tzMqtssw4B+5EuUnOMeD+G/7dJFIjTAhYzEs2r0Cbu9Y6r+fNnh2u3777Qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291796; c=relaxed/simple;
	bh=JEuxKxjeROohAt1qvhi0Ub8NO2/wyFYkKU6mgpF4Hfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPksAA7d5YbcBE4sgx8zvMlKtmVAMdVn48yDeGjcSI1yD/RYxAtOGyUW0WrvwJdSVt2TJG2UE8l344LgXX4MsWDu2UNmijZxnRbphy98wfAV6zWPJCTHDd3Ycc/XQaeIhyx7fgnk687EXyOXg9fT6WgYeDdvo7TBsuCVROdRRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVbW3KJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVbW3KJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a4LBXYki27Iw3lqB/pTygYlgLg3nJE1FNCs2jI/+2z8=;
	b=PVbW3KJTTVI8eV8ojrmKZHcvmhykrM4mToQ3L7LtBZLiCP8AHErrhC5F1eKK2XYFBTzaE8
	rzGcWrVNxvWMMnD8IpyG/CVKUp1UUNshs8N0lRAJGhJXJVzDcqm3Z6omBaofLHwfnpE0ls
	H4pyHWey+edn4qXHABi290OcytS8I7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-qENJM4qXM86sjcBr5k938g-1; Tue,
 06 Oct 2026 09:03:11 -0400
X-MC-Unique: qENJM4qXM86sjcBr5k938g-1
X-Mimecast-MFC-AGG-ID: qENJM4qXM86sjcBr5k938g_1791291791
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D44F4195E917
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:03:10 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E89F81956047;
	Tue,  6 Oct 2026 13:03:09 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 00/17] libsepol: add public API for policy introspection
Date: Tue,  6 Oct 2026 15:01:58 +0200
Message-ID: <20261006130215.128405-1-jjanasek@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi all,

This series adds a public, stable libsepol API for read-only
introspection of a loaded/compiled policydb: iterators and
accessors for types, roles, users, classes/permissions, booleans,
conditionals, AV rules, MLS/category sets, contexts, ocontexts
(initial SIDs, fs/port/node/... contexts), filename transitions,
range transitions, role rules, permissive types and policy
capabilities, plus a small "record" layer that snapshots the above
into owned, independently-freeable structures.

This is the first time this series is posted to the list; it was
developed and self-reviewed out-of-tree against an older base and
has just been rebased onto current upstream/main before this
posting (see "Testing" below for what that rebase involved).

Posting this as RFC because it adds a sizeable new public ABI
surface and I would like design-level feedback before going through
a full review cycle. Specifically:

 - Is libsepol the right place for this, or would a separate
   library be preferable?
 - Does the record/iterator split (snapshot "record" structs vs.
   zero-copy iterators) make sense as a general shape for this kind
   of API, and are the naming conventions reasonable?
 - Is the libsepol.map.in symbol-versioning approach in patch 17
   acceptable for a surface this size?
 - Is landing this as one 17-patch series reasonable, or would
   maintainers prefer it split into smaller, independently
   mergeable increments (e.g. per policy-object family)?

Motivation
----------
SETools (https://github.com/SELinuxProject/setools) and other
policy-analysis tools currently reach into libsepol's internal,
unstable headers (policydb.h, hashtab.h, ebitmap.h, ...) to walk a
loaded policydb, because there is no supported public way to do
this. That couples those tools tightly to libsepol's internal data
structures and breaks whenever those structures change. This series
gives such consumers a real, documented, ABI-stable surface instead,
without exposing anything from policydb.h directly.

Series organization
--------------------
The 17 patches are organized bottom-up and are individually
bisectable (each one builds and passes its own tests standalone):

 - Patches 1-2 add shared iterator/utility infrastructure (hashtab
   iteration, string-list helpers, MLS/category-set and common
   permission iterators) with no public API surface yet.
 - Patches 3-10 add the public "record" and iterator APIs themselves,
   one policy-object family at a time (types, users, roles, classes,
   policy properties/constants, context resolution), each paired
   with its own test coverage.
 - Patches 11-14 add the remaining rule/ocontext-level iterators
   (AV rules, conditionals, booleans, ocontexts, filename
   transitions, range transitions, role rules, permissive types,
   polcaps) and their tests.
 - Patches 15-16 add broader record-API and tier-2 integration tests
   that exercise the APIs together against realistic policies.
 - Patch 17 wires everything into libsepol.map.in and adds the
   umbrella <sepol/sepol.h> include, so the new symbols are only
   exported for real once the whole surface exists.

Testing
-------
 - Full CUnit suite: 134 tests, 856142 assertions, 133 passed. The
   one remaining failure (test-downgrade.c, MLS policy downgrade) is
   a pre-existing, environment-specific issue reproduced identically
   against an unmodified upstream/main checkout and is unrelated to
   this series.
 - Every commit in the series was verified to build standalone (via
   isolated `git archive` extraction + build), confirming
   bisectability is preserved end to end, including after rebasing
   onto current upstream/main.
 - While rebasing onto upstream/main, upstream commit "libsepol: drop
   support for policy versions before xperms_ioctl/xen_devicetree"
   removed POLICYDB_VERSION_CONSTRAINT_NAMES, which patch 8 (class
   iterator) referenced for a version-gated fallback in
   constraint_expr_datum_to_record(). That fallback is now dead code
   (type_names is unconditionally populated by
   constraint_expr_init()/type_set_read()/type_set_write() for every
   policy version libsepol still supports), so the gate and its
   now-unreachable test were removed as part of the rebase.
 - A handful of real bugs found during self-review were fixed and
   folded back into the commits that introduced them (not left as
   separate fixup patches), to keep each commit buildable and
   correct on its own:
    - libsepol: add public user iterator and accessors -- modules
      adding a sepol_user_t via the new API were not registered in
      policydb->scope[SYM_USERS], so link_modules()/expand_module()
      would silently drop them.
    - libsepol: add context resolution from policy values and SIDs
      -- policydb_sid_lookup_context() rejected a NULL sepol_handle_t,
      inconsistent with its sibling functions, which all tolerate it
      via the internal ERR()/msg_write() NULL-handle fallback.
    - libsepol: add public role record structure and iterator -- an
      ebitmap allocated by type_set_expand() was leaked on one error
      path; separately, the role flavor conversion switch had no
      default case, so a role_datum->flavor value outside
      {ROLE_ROLE, ROLE_ATTRIB} (read unvalidated from the binary
      policy) would silently report the zero-initialized ROLE_ROLE
      default instead of being rejected.
    - libsepol: add tier-2 integration tests -- filename_trans
      iteration had no test coverage; added one.
 - Code was run through clang-format-diff (-style=file) restricted to
   the lines each commit actually touches, to avoid reformatting
   large unrelated pre-existing regions of incrementally-extended
   files (policydb.h, ebitmap.h, hashtab.h, ...); verified
   token-for-token equivalent to the pre-formatting tree modulo
   whitespace/line-wrapping.
 - Ran clang-tidy (bugprone-*/cert-*/clang-analyzer-* checks) over
   every new source file; findings were either pre-existing house
   style shared with the rest of libsepol (e.g. the `_SEPOL_*_H_`
   include-guard naming, or assigning malloc/realloc's void* result
   straight to a typed pointer) or the role-flavor default-case gap
   above, which is now fixed.
 - Ran the full suite under GCC's AddressSanitizer+UndefinedBehavior-
   Sanitizer (-fsanitize=address,undefined). This caught a real,
   if minor, UB issue in 5 of the new test files (test-iter-types.c,
   test-iter-roles.c x2, test-iter-users.c, test-iter-classes.c):
   qsort() is declared with a nonnull `base` argument, but several
   tests called it unconditionally on a get_*() output array that is
   legitimately NULL when the count is 0, which is UB per the
   standard even though nmemb==0 makes it harmless in practice on
   every libc tested. Guarded each call with nmemb > 0. No
   AddressSanitizer/UBSan findings remain (0 leaks, 0 runtime
   errors) after the fix.
 - git send-email --dry-run against this series flagged 3 non-ASCII
   em-dash characters left over in comments (classes.c,
   av_rule_internal.h, policydb.h); replaced with plain ASCII
   hyphens for consistency with the rest of this (pure-ASCII) code
   base.

AI assistance disclosure
-------------------------
Portions of this series (notably test scaffolding and some iterator
boilerplate) were drafted with assistance from Cursor
(https://cursor.com), an AI coding tool, under my direction and with
my review. All code was read, tested, and is submitted under my own
Signed-off-by. Per current kernel-adjacent convention for AI
assistance, affected commits carry an "Assisted-by: LLM Cursor"
trailer rather than a Co-authored-by/Signed-off-by for the tool
itself.

Looking forward for review.

jan janasek (17):
  libsepol: add hashtab iterator and string list utilities
  libsepol: add MLS, category set, and common permission iterators
  libsepol: add public type record structure and iterator
  libsepol: add test infrastructure and type iterator tests
  libsepol: add public user iterator and accessors
  libsepol: add public role record structure and iterator
  libsepol: add public class record structure
  libsepol: add public class iterator and tests
  libsepol: add policy properties API and public constants
  libsepol: add context resolution from policy values and SIDs
  libsepol: add AV rule, conditional, and boolean iterators
  libsepol: add AV rule and conditional iterator tests
  libsepol: add ocontext iterators for initial SIDs and named contexts
  libsepol: add filename transition, permissive, polcap, range
    transition, and role rule iterators
  libsepol: add record API tests for type, role, class, and user
  libsepol: add tier-2 integration tests
  libsepol: add symbol map entries and umbrella header for new public
    API

 libsepol/include/sepol/av_rule.h              |  119 +
 libsepol/include/sepol/booleans.h             |   29 +
 libsepol/include/sepol/cat_set.h              |   40 +
 libsepol/include/sepol/class_record.h         |  253 ++
 libsepol/include/sepol/classes.h              |   69 +
 libsepol/include/sepol/common_perm.h          |   54 +
 libsepol/include/sepol/conditional.h          |  109 +
 libsepol/include/sepol/constants.h            |  231 ++
 libsepol/include/sepol/context.h              |   42 +
 libsepol/include/sepol/filename_trans.h       |   42 +
 libsepol/include/sepol/flask.h                |   34 +
 libsepol/include/sepol/mls_iter.h             |   80 +
 libsepol/include/sepol/ocontext.h             |  513 ++++
 libsepol/include/sepol/permissive.h           |   33 +
 libsepol/include/sepol/polcap.h               |   41 +
 libsepol/include/sepol/policydb.h             |   29 +
 libsepol/include/sepol/policydb/avtab.h       |   33 +-
 libsepol/include/sepol/policydb/ebitmap.h     |   18 +
 libsepol/include/sepol/policydb/flask_types.h |   55 +-
 libsepol/include/sepol/policydb/hashtab.h     |   15 +
 libsepol/include/sepol/policydb/policydb.h    |   68 +-
 libsepol/include/sepol/policydb/services.h    |   19 +-
 libsepol/include/sepol/policydb/util.h        |   22 +-
 libsepol/include/sepol/range_trans.h          |   55 +
 libsepol/include/sepol/role_record.h          |   79 +
 libsepol/include/sepol/role_rule.h            |   41 +
 libsepol/include/sepol/roles.h                |   57 +
 libsepol/include/sepol/sepol.h                |   59 +-
 libsepol/include/sepol/sid_table.h            |   43 +
 libsepol/include/sepol/type_record.h          |   95 +
 libsepol/include/sepol/types.h                |   84 +
 libsepol/include/sepol/users.h                |   65 +-
 libsepol/src/av_rule.c                        |  328 +++
 libsepol/src/av_rule_internal.h               |   60 +
 libsepol/src/boolean_record.c                 |   41 +-
 libsepol/src/booleans.c                       |  174 +-
 libsepol/src/cat_set.c                        |   60 +
 libsepol/src/cat_set_internal.h               |   10 +
 libsepol/src/class_record.c                   |  950 ++++++++
 libsepol/src/classes.c                        |  581 +++++
 libsepol/src/common_perm.c                    |  143 ++
 libsepol/src/conditional_public.c             |  261 ++
 libsepol/src/context.c                        |  279 ++-
 libsepol/src/context_record.c                 |   62 +-
 libsepol/src/filename_trans.c                 |  123 +
 libsepol/src/hashtab.c                        |   48 +
 libsepol/src/initial_sids.h                   |   29 +
 libsepol/src/kernel_to_common.h               |   22 +-
 libsepol/src/libsepol.map.in                  |  379 +++
 libsepol/src/mls_iter.c                       |  154 ++
 libsepol/src/ocontext.c                       | 1058 +++++++++
 libsepol/src/permissive_iter.c                |   65 +
 libsepol/src/polcap_iter.c                    |   67 +
 libsepol/src/policydb_public.c                |  203 ++
 libsepol/src/private.h                        |   23 +
 libsepol/src/range_trans.c                    |  119 +
 libsepol/src/role_record.c                    |  316 +++
 libsepol/src/role_rule.c                      |  117 +
 libsepol/src/roles.c                          |  253 ++
 libsepol/src/services.c                       |   33 +
 libsepol/src/sidtab.c                         |   78 +
 libsepol/src/type_record.c                    |  351 +++
 libsepol/src/types.c                          |  552 +++++
 libsepol/src/user_record.c                    |  100 +-
 libsepol/src/users.c                          |  416 +++-
 libsepol/src/util.c                           |  113 +-
 libsepol/tests/helpers.c                      |    5 +
 libsepol/tests/helpers.h                      |    5 +
 libsepol/tests/libsepol-tests.c               |   10 +
 libsepol/tests/policies/test-iter/iter.conf   |  136 ++
 libsepol/tests/test-av-rule.c                 |  733 ++++++
 libsepol/tests/test-av-rule.h                 |   10 +
 libsepol/tests/test-context-api.c             |  289 +++
 libsepol/tests/test-context-api.h             |   10 +
 libsepol/tests/test-iter-classes.c            |  220 ++
 libsepol/tests/test-iter-classes.h            |    7 +
 libsepol/tests/test-iter-roles.c              |  165 ++
 libsepol/tests/test-iter-roles.h              |    7 +
 libsepol/tests/test-iter-types.c              |  137 ++
 libsepol/tests/test-iter-types.h              |    7 +
 libsepol/tests/test-iter-users.c              |  115 +
 libsepol/tests/test-iter-users.h              |    7 +
 libsepol/tests/test-iter.c                    |  117 +
 libsepol/tests/test-iter.h                    |   10 +
 libsepol/tests/test-records.c                 | 1630 +++++++++++++
 libsepol/tests/test-records.h                 |   10 +
 libsepol/tests/test-tier2.c                   | 2100 +++++++++++++++++
 libsepol/tests/test-tier2.h                   |   10 +
 88 files changed, 15535 insertions(+), 299 deletions(-)
 create mode 100644 libsepol/include/sepol/av_rule.h
 create mode 100644 libsepol/include/sepol/cat_set.h
 create mode 100644 libsepol/include/sepol/class_record.h
 create mode 100644 libsepol/include/sepol/classes.h
 create mode 100644 libsepol/include/sepol/common_perm.h
 create mode 100644 libsepol/include/sepol/conditional.h
 create mode 100644 libsepol/include/sepol/constants.h
 create mode 100644 libsepol/include/sepol/filename_trans.h
 create mode 100644 libsepol/include/sepol/flask.h
 create mode 100644 libsepol/include/sepol/mls_iter.h
 create mode 100644 libsepol/include/sepol/ocontext.h
 create mode 100644 libsepol/include/sepol/permissive.h
 create mode 100644 libsepol/include/sepol/polcap.h
 create mode 100644 libsepol/include/sepol/range_trans.h
 create mode 100644 libsepol/include/sepol/role_record.h
 create mode 100644 libsepol/include/sepol/role_rule.h
 create mode 100644 libsepol/include/sepol/roles.h
 create mode 100644 libsepol/include/sepol/sid_table.h
 create mode 100644 libsepol/include/sepol/type_record.h
 create mode 100644 libsepol/include/sepol/types.h
 create mode 100644 libsepol/src/av_rule.c
 create mode 100644 libsepol/src/av_rule_internal.h
 create mode 100644 libsepol/src/cat_set.c
 create mode 100644 libsepol/src/cat_set_internal.h
 create mode 100644 libsepol/src/class_record.c
 create mode 100644 libsepol/src/classes.c
 create mode 100644 libsepol/src/common_perm.c
 create mode 100644 libsepol/src/conditional_public.c
 create mode 100644 libsepol/src/filename_trans.c
 create mode 100644 libsepol/src/initial_sids.h
 create mode 100644 libsepol/src/mls_iter.c
 create mode 100644 libsepol/src/ocontext.c
 create mode 100644 libsepol/src/permissive_iter.c
 create mode 100644 libsepol/src/polcap_iter.c
 create mode 100644 libsepol/src/range_trans.c
 create mode 100644 libsepol/src/role_record.c
 create mode 100644 libsepol/src/role_rule.c
 create mode 100644 libsepol/src/roles.c
 create mode 100644 libsepol/src/type_record.c
 create mode 100644 libsepol/src/types.c
 create mode 100644 libsepol/tests/policies/test-iter/iter.conf
 create mode 100644 libsepol/tests/test-av-rule.c
 create mode 100644 libsepol/tests/test-av-rule.h
 create mode 100644 libsepol/tests/test-context-api.c
 create mode 100644 libsepol/tests/test-context-api.h
 create mode 100644 libsepol/tests/test-iter-classes.c
 create mode 100644 libsepol/tests/test-iter-classes.h
 create mode 100644 libsepol/tests/test-iter-roles.c
 create mode 100644 libsepol/tests/test-iter-roles.h
 create mode 100644 libsepol/tests/test-iter-types.c
 create mode 100644 libsepol/tests/test-iter-types.h
 create mode 100644 libsepol/tests/test-iter-users.c
 create mode 100644 libsepol/tests/test-iter-users.h
 create mode 100644 libsepol/tests/test-iter.c
 create mode 100644 libsepol/tests/test-iter.h
 create mode 100644 libsepol/tests/test-records.c
 create mode 100644 libsepol/tests/test-records.h
 create mode 100644 libsepol/tests/test-tier2.c
 create mode 100644 libsepol/tests/test-tier2.h

-- 
2.55.0

