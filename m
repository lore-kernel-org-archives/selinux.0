Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29203770D
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706530; cv=none; b=gdk95QTd1QtCHuhKitdzHV9oSbAgPS0ukS7tWXCYN8MR3KE5MtQGXP6lfGRsm2spAGeWR0V6lDgXPHJKsF/mxAEzutDxbElsYhpwDQG/jUnp0q+VkKD94f/Fprf9S7uElYsNzLMqRMmzt/PGknJ+MJeiE9T6bazR/7Sdtt08Frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706530; c=relaxed/simple;
	bh=0z2zOhitNdS35k9zlFDkduBCO+2ju+ErpOklSD83GpM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=km5S4AIGazji/IXa9BREIO/vGVchG2eq6pYixIyHMRULYuLvkTpOI/f6QWIT5HP5+PfSFE4viM++dKPwTnUa01whVY0eN0Q9Yky0H+JUtb6EJNWTijpaooXfhWOGsnU7OM72qzvwI7kFLo4+lNPufkQgpXm/5L27z5P8Geogjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CfavE2aP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CfavE2aP"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a358ec50b7cso164701566b.0
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706527; x=1707311327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kEJnOXawBciPuvYEJKF1n9zosoHWl0e1Gprph7GkwU=;
        b=CfavE2aP4wq06szpPGBdUEwzGqdByhXOjOW2X1SFvxyKBTSGh283SPjzInsgPkJeNm
         ygoA4AlbQpnwnvLyGPdqUlNs0kNW392ptO+7JFsl/17kwHmqXJYN+eMkhk6Ox6AYmxQM
         G+HRZWlimIkgR7CShdlnTT3e9Ti4gkQiAqrf5XvWQJtQGj/W3RpSwPlc2o2aGJj91/FD
         +E/zDwGdMXqYmoZV7Y7NTfgVzsZi20VzpIljGAe2qS4aw31u+qothzhOxrIOtgVvlXQk
         ZiwVsm5ongVB0m78mA5iDuukhAfCBzAomAJBZ5BNu7Vo6nztZm1ryUiqoW9s7fDJBQci
         bDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706527; x=1707311327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kEJnOXawBciPuvYEJKF1n9zosoHWl0e1Gprph7GkwU=;
        b=MZdFC3fSt3+68LKKZqQ73vQ9Qmct5bn7TgqJsI3c1mIyDVdETXmR3xVkazsO40kDZx
         UYdtxPf/heTSReh0QJ7P7QWSzwGl3CrRn/oty87xAG0zSL7VnTsjnnGI21pyvRczkd4q
         LBo21zy3GR3blj7K976KUInx5nw8lnSTJyshPU72or6pujMVe+u6GbcZcXN0B+kV1VbA
         Uy95z+g5fWJAKjREpW5bfPxTR9+XpQcMQ11wNQlxOgByUHP0gr/V4VeztCn0/4kPaCSO
         0Gz76mGcVijXWxckx7wYUARexeCA6NHGwgALbegedqRHpuohrbzkajgK6KBVJRzKvWKs
         5Cqg==
X-Gm-Message-State: AOJu0YyuRKGXaC8bBp0TqEF7bwwUf93uh2AL78CI+Matng6ULsx/ySNg
	67yYOzyDUgyOPxpUxrDBefuBm9O0usE36cRHtT5Cqzw4LXIM9cITWNG8YVNY
X-Google-Smtp-Source: AGHT+IEUEUcV5c96DUxn3USbbLmT0v41VJ6Jqw4nm7mrNnFPaRQ0woDHVcFGTLw86PzYhF8MsQu0Cw==
X-Received: by 2002:a17:906:e28c:b0:a36:4d6c:f85c with SMTP id gg12-20020a170906e28c00b00a364d6cf85cmr1579237ejb.16.1706706526822;
        Wed, 31 Jan 2024 05:08:46 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:46 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 0/9] libselinux: rework selabel_file(5) database
Date: Wed, 31 Jan 2024 14:08:26 +0100
Message-ID: <20240131130840.48155-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Fedora 39 (pre-compiled regular expressions are omitted on Fedora):
    file_contexts.bin:           599034  ->   430211  (bytes)
    file_contexts.homedirs.bin:   21275  ->    13491  (bytes)

Debian Sid (pre-compiled regular expressions are included):
    file_contexts.bin:          7790690  ->  3646256  (bytes)
    file_contexts.homedirs.bin:  835950  ->   708793  (bytes)

(selabel_lookup -b file -k /bin/bash)

Fedora 39 in VM:
    text:      time:       3.1 ms  ->   3.6 ms
               peak heap:   2.33M  ->    1.81M
               peak rss:    6.64M  ->    6.37M
    compiled:  time:       1.8 ms  ->   1.7 ms
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

Fedora 39 in VM:
      28.3 s  ->   3.6 s
Debian Sid on Raspberry Pi 3:
      94.6 s  ->  12.1 s

(restorecon -vRn -T0 /)

Fedora 39 in VM (8 cores):
      31.1 s  ->   2.5 s
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
 libselinux/src/avc_sidtab.c                   |   68 +-
 libselinux/src/avc_sidtab.h                   |    4 +-
 libselinux/src/hashtab.c                      |  234 --
 libselinux/src/hashtab.h                      |  117 -
 libselinux/src/label.c                        |   56 +-
 libselinux/src/label_backends_android.c       |    2 +-
 libselinux/src/label_db.c                     |    2 +
 libselinux/src/label_file.c                   | 2216 ++++++++++++-----
 libselinux/src/label_file.h                   |  972 +++++---
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
 27 files changed, 3771 insertions(+), 1562 deletions(-)
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
2.43.0

