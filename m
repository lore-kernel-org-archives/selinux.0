Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8221D9A62
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831609; cv=none; b=S59Ivk+KAQItsq4UbGww9pEyM0qmE/gmRhpD9eQszQKFA6mcqpndzJ7ZQLTDIdNNoZCwYE5qy4V+FdHIdDz0VVZVxqtuCFph49Q3u22olI6DVxPWMNAsksBnMnRmKOD669zzyYHoha8g/15lb20SP2l+Tth7PPQDcnUG/rjtB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831609; c=relaxed/simple;
	bh=QLLaLt4D80Qq9LfkN70XynF2z3lBaBnE7LzslLO47lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqoRW2e49RYDZyrdCbnXVMwtcRM+4FptiSy/l5/Zwb1zKoWAV7c7qUYpX+ZD6mvbuLxnl0rhYNd+mRAzM1X1jEvE6vaU1PS/cgoDvXP1KKt/8xombWMkUYU3/xlwSWI9rlzijMePVw+DBFsZ4743HhIdKgjOAQ2fQ0jClCQOT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=RtXfk8fP; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="RtXfk8fP"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831604;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BTPbrgQvGfElV1X7wI95tKF05u5FeGHrejTdKDXqrSo=;
	b=RtXfk8fP6Ati9WhWKt0YptElo3ygh1EjoUw8HCyzJKHWSZMVwzyYdnO7zlZ5ij+JF5c5DZ
	G5tuB69liZvtsn+KLCdE+XH8Rsifecl+SGH4jj2FYHs7TJDmL/o9mkUOmDrK6E7TKPlBax
	JUUVwcqoKfaxSwep31iOzXWgCT/1n+jGPgsWQHc48jz0XuLkBZxsDgZz0ZThdq+407KnOC
	m4XSHNJ9RsL7y2LN/1t7Xbpn4GUu6N8oq8NHaVDFFK3SnxXeCXm0yU/1wuU4DBEj53f7Ho
	y8EtIWIPKyV+rYqyJDNvSw1vwCIJnc4Vx9VyYbHcDi2hgK+dKir+iXkhXjCKgw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 0/9] libselinux: rework selabel_file(5) database
Date: Tue,  5 Nov 2024 19:33:10 +0100
Message-ID: <20241105183319.250410-1-cgoettsche@seltendoof.de>
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

Currently the database for file backend of selabel stores the file
context specifications in a single long array.  This array is sorted by
special precedence rules, e.g. regular expressions without meta
character first, ordered by length, and the remaining regular
expressions ordered by stem (the prefix part of the regular expressions
without meta characters) length.

This results in suboptimal lookup performance for two reasons;
File context specifications without any meta characters (e.g.
'/etc/passwd') are still matched via an expensive regular expression
match operation.
All such trivial regular expressions are matched against before any non-
trivial regular expression, resulting in thousands of regex match
operations for lookups for paths not matching any of the trivial ones.

Rework the internal representation of the database in two ways:
Convert regular expressions without any meta characters and containing
only supported escaped characters (e.g. '/etc/rc\.d/init\.d') into
literal strings, which get compared via strcmp(3) later on.
Store the specifications in a tree structure to reduce the to number of
specifications that need to be checked.

Since the internal representation is completely rewritten introduce a
new compiled file context file format mirroring the tree structure.
The new format also stores all multi-byte data in network byte-order, so
that such compiled files can be cross-compiled, e.g. for embedded
devices with read-only filesystems (except for the regular expressions,
which are still architecture-dependent, but ignored on architecture mis-
match).

The improved lookup performance will also benefit SELinux aware daemons,
which create files with their default context, e.g. systemd.

Fedora 41 (pre-compiled regular expressions are omitted on Fedora):
    file_contexts.bin:           567248  ->   413191  (bytes)
    file_contexts.homedirs.bin:   20677  ->    13107  (bytes)

Debian Sid (pre-compiled regular expressions are included):
    file_contexts.bin:          7790690  ->  3646256  (bytes)
    file_contexts.homedirs.bin:  835950  ->   708793  (bytes)

(selabel_lookup -b file -k /bin/bash)

Fedora 41 in VM:
    text:      time:       7.2 ms  ->   3.5 ms
               peak heap:   2.33M  ->    1.81M
               peak rss:    6.64M  ->    6.37M
    compiled:  time:       5.9 ms  ->   1.6 ms
               peak heap:   2.14M  ->    1.23M
               peak rss:    6.76M  ->    5.91M

Debian Sid on Raspberry Pi 3:
    text:      time:      33.4 ms  ->  21.2 ms
               peak heap:  10.59M  ->  607.32K
               peak rss:    6.55M  ->    4.46M
    compiled:  time:      38.3 ms  ->  23.5 ms
               peak heap:  13.28M  ->    2.00M
               peak rss:   12.21M  ->    7.60M

(restorecon -vRn /)

Fedora 41 in VM:
       9.6 s  ->   1.3 s
Debian Sid on Raspberry Pi 3:
      94.6 s  ->  12.1 s

(restorecon -vRn -T0 /)

Fedora 39 in VM (8 cores):
      10.9 s  ->   1.0 s
Debian Sid on Raspberry Pi 3 (4 cores):
      58.9 s  ->  12.6 s

(note: I am unsure why the parallel runs on Fedora are slower)

There might be subtle differences in lookup results which evaded my
testing, because some precedence rules are oblique.  For example
`/usr/(.*/)?lib(/.*)?` has to have a higher precedence than
`/usr/(.*/)?bin(/.*)?` to match the current Fedora behavior.  Please
report any behavior changes.

The maximum node depth in the database is set to 3, which seems to give
the best performance to memory usage ratio.  Might be tweaked for
systems with different filesystem hierarchies (Android?).

I am not that familiar with the selabel_partial_match(3),
selabel_get_digests_all_partial_matches(3) and
selabel_hash_all_partial_matches(3) related interfaces, so I only did
some rudimentary tests for them.

# Patches

Patches 1 and 2 introduce two helpers useful for developers and users.

Patches 3.5 tweak the sidtab code to be used in a later patch.

Patch 6 is the main rework.  Due to its complete rewrite it is too large
for the mailing list, so I added some developers in CC for this one and
the patch is available on GitHub (see below).  I'd like to refrain
splitting it since there are no trivial splitable parts and future reverts
or bisections will be more complicated.

Patch 7 is removing unused code after the rework in patch 6.

Patch 8 introduces new fuzzers for selabel_file(5).

Patch 9 improves thread-safety for concurrent selabel lookup.


This patchset is also available at https://github.com/SELinuxProject/selinux/pull/406

v3:
  - use sidtab_context_lookup() in sidtab_context_to_sid()
  - set errno to EINVAL on old compiled fcontext format file input
  - correctly compare regular expression specifications by considering
    their prefix-length
  - reorder calloc(3) arguments

v2:
  - add two fuzzers performing label lookup, one for textual and one for
    compiled fcontext definitions
  - various fixes, among others encountered via fuzzing
  - rename helper to unsefiles
  - add sidtab tweaks to store a context array in the binary fcontext format
    to deduplicate context strings
  - add thread-safety patch

Christian Göttsche (9):
  policycoreutils: introduce unsetfiles
  libselinux/utils: introduce selabel_compare
  libselinux: use more appropriate types in sidtab
  libselinux: add unique id to sidtab entries
  libselinux: sidtab updates
  libselinux: rework selabel_file(5) database
  libselinux: remove unused hashtab code
  libselinux: add selabel_file(5) fuzzer
  libselinux: support parallel selabel_lookup(3)

 libselinux/fuzz/input                         |    0
 .../fuzz/selabel_file_compiled-fuzzer.c       |  281 +++
 libselinux/fuzz/selabel_file_text-fuzzer.c    |  225 ++
 libselinux/include/selinux/avc.h              |    2 +-
 libselinux/src/avc_sidtab.c                   |   81 +-
 libselinux/src/avc_sidtab.h                   |    4 +-
 libselinux/src/hashtab.c                      |  234 --
 libselinux/src/hashtab.h                      |  117 -
 libselinux/src/label.c                        |   56 +-
 libselinux/src/label_backends_android.c       |    2 +-
 libselinux/src/label_db.c                     |    2 +
 libselinux/src/label_file.c                   | 2228 ++++++++++++-----
 libselinux/src/label_file.h                   |  972 ++++---
 libselinux/src/label_internal.h               |    7 +-
 libselinux/src/label_media.c                  |    1 +
 libselinux/src/label_support.c                |   26 +-
 libselinux/src/label_x.c                      |    1 +
 libselinux/src/regex.c                        |   55 +-
 libselinux/utils/.gitignore                   |    1 +
 libselinux/utils/sefcontext_compile.c         |  658 +++--
 libselinux/utils/selabel_compare.c            |  122 +
 policycoreutils/.gitignore                    |    1 +
 policycoreutils/Makefile                      |    2 +-
 policycoreutils/unsetfiles/Makefile           |   26 +
 policycoreutils/unsetfiles/unsetfiles.1       |   46 +
 policycoreutils/unsetfiles/unsetfiles.c       |  183 ++
 scripts/oss-fuzz.sh                           |   25 +
 27 files changed, 3793 insertions(+), 1565 deletions(-)
 create mode 100644 libselinux/fuzz/input
 create mode 100644 libselinux/fuzz/selabel_file_compiled-fuzzer.c
 create mode 100644 libselinux/fuzz/selabel_file_text-fuzzer.c
 delete mode 100644 libselinux/src/hashtab.c
 delete mode 100644 libselinux/src/hashtab.h
 create mode 100644 libselinux/utils/selabel_compare.c
 create mode 100644 policycoreutils/unsetfiles/Makefile
 create mode 100644 policycoreutils/unsetfiles/unsetfiles.1
 create mode 100644 policycoreutils/unsetfiles/unsetfiles.c

-- 
2.45.2

