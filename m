Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90086C07E8E
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjHNNVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHNNUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230BF10E5
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9923833737eso573353466b.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019239; x=1692624039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFDU3qpzeDqr5Rh+c8Q8r3N1WTj9dOVEyb/DwIVlu3U=;
        b=drBVgChOxLfLC6zRfFeJQ0RYh8ABzfN1k+Kw41470Oz8sQles6mb8g/ubZohPqx6vx
         SqG8jAGpkQQuCNviyhqANxDfL+lnPIFy87J4bfyAwKYY8KF0s6e0gH1wKNiqM6PX033D
         nVuNv11jmwAOlecSpAzQDjngbgVeYAK1hO+8KS+cGKFe2z/o0C6hQOj9x9OqB07vfMUE
         VDbEQm8RV3ycj0TEVn1MDJ4JIkmPWb3VJRQO3Celq+m7z0TVGsB/YsxdzLvQSTKU3/eH
         O24PVxDiisKjPnzBTCPtkBoFYrFAEsiPPZMutA4lGs3Zp18OqTCLdf6yef/IxgDq4Bzb
         BFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019239; x=1692624039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFDU3qpzeDqr5Rh+c8Q8r3N1WTj9dOVEyb/DwIVlu3U=;
        b=b6ljRRlBBbaYpAMIHyc1ypq2x2g+NDlh450t/+gkYjGkn04uSKnIp5YzhOzKugESON
         AIAChfXLJbXAbTZ9E9i8UsKqGiaV49lUhY9DG3kjXdHKEjRAt5ExoKxXh7CZ2cafgRJh
         6FghKVPb9fJ+nzSfbGL1YwBhXXvNf7msWNXup9QjoSUr9o1pBn/q/YztbJSB6TCNOEBa
         n8IfyVb6sLHpMvbg/P0IIy6aHyx2AskzxgmjdAMf/D+mqCj9NdSbrJJbvcuXC0yEv/rw
         dDshk6mTHOwPRJUJWkROgZp6xa9HlTbAcqnnlh2QhpGbBbaPZplS83/4prkS/GucOy9J
         bDyg==
X-Gm-Message-State: AOJu0Yw8/vsOVZDCbRHB8nQt52LaOvojxu0urEtjcn8NmvZONdIS0KT0
        S0ZvExKsy51M4KkkwQ/+hb6Jx/5E/I94rGKuaZg=
X-Google-Smtp-Source: AGHT+IHmLiR3sUoQloRpoMXOOU6G5GLQ86pQoinQZnUpML7sQPthvGkznHKSv0dfEi45XSvcaTshig==
X-Received: by 2002:a17:906:1d:b0:99c:e38d:e47d with SMTP id 29-20020a170906001d00b0099ce38de47dmr9161316eja.27.1692019239356;
        Mon, 14 Aug 2023 06:20:39 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 00/27] libselinux: rework selabel_file(5) database
Date:   Mon, 14 Aug 2023 15:19:58 +0200
Message-Id: <20230814132025.45364-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
Store the specifications in a tree structure (since the filesystem is a
tree) to reduce the to number of specifications that need to be checked.

Since the internal representation is completely rewritten introduce a
new compiled file context file format mirroring the tree structure.
The new format also stores all multi-byte data in network byte-order, so
that such compiled files can be cross-compiled, e.g. for embedded
devices with read-only filesystems (except for the regular expressions,
which are still architecture-dependent).

The improved lookup performance will also benefit SELinux aware daemons,
which create files with their default context, e.g. systemd.

#  Performance data

## Compiled file context sizes

Fedora 38 (regular expressions are omitted on Fedora):
    file_contexts.bin:           596783  ->   575284  (bytes)
    file_contexts.homedirs.bin:   21219  ->    18185  (bytes)

Debian Sid (regular expressions are included):
    file_contexts.bin:          2580704  ->  1428354  (bytes)
    file_contexts.homedirs.bin:  130946  ->    96884  (bytes)

## Single lookup

(selabel -b file -k /bin/bash)

Fedora 38 in VM:
    text:      time:       3.6 ms  ->   4.7 ms
               peak heap:   2.32M  ->    1.44M
               peak rss:    5.61M  ->    6.03M
    compiled:  time:       1.5 ms  ->   1.5 ms
               peak heap:   2.14M  ->  917.93K
               peak rss:    5.33M  ->    5.47M

Debian Sid on Raspberry Pi 3:
    text:      time:      33.9 ms  ->  19.9 ms
               peak heap:  10.46M  ->  468.72K
               peak rss:    9.44M  ->    4.98M
    compiled:  time:      39.3 ms  ->  22.8 ms
               peak heap:  13.09M  ->    1.86M
               peak rss:   12.57M  ->    7.86M

## Full filesystem relabel

(restorecon -vRn /)

Fedora 38 in VM:
      27.445 s  ->   3.293 s
Debian Sid on Raspberry Pi 3:
      86.734 s  ->  10.810 s

(restorecon -vRn -T0 /)

Fedora 38 in VM (8 cores):
      29.205 s  ->   2.521 s
Debian Sid on Raspberry Pi 3 (4 cores):
      46.974 s  ->  10.728 s

(note: I am unsure why the parallel runs on Fedora are slower)

# TODO

There might be subtle differences in lookup results which evaded my
testing, because some precedence rules are oblique.  For example
`/usr/(.*/)?lib(/.*)?` has to have a higher precedence than
`/usr/(.*/)?bin(/.*)?` to match the current Fedora behavior.  Please
report any behavior changes.

If any code section is unclear I am happy to add some inline comments.

The maximum node depth in the database is set to 3, which seems to give
the best performance to memory usage ratio.  Might be tweaked for
systems with different filesystem hierarchies (Android?).

I am not that familiar with the selabel_partial_match(3),
selabel_get_digests_all_partial_matches(3) and
selabel_hash_all_partial_matches(3) related interfaces, so I only did
some rudimentary tests for them.


# Patches

Patches 1-4 have been proposed already (this time all commits are signed-off):
https://patchwork.kernel.org/project/selinux/list/?series=772728

Patch 5 has been proposed already:
https://patchwork.kernel.org/project/selinux/patch/20230803162301.302579-1-cgzones@googlemail.com/

Patches 6-24 are cleanup and misc fixes which can be applied own their own

Patch 25 is the rework
Due to its complete rewrite it is too large for the mailing list, so I added
some developers in CC for this one and the patch is available on GitHub
(see below)

Patch 26 is removing unused code after the rework in patch 25

Patch 27 introduces new fuzzers for selabel_file(5)

This patchset is also available at https://github.com/SELinuxProject/selinux/pull/406


v2:
  - add two fuzzers performing label lookup, one for textual and one for
    compiled fcontext definitions
  - misc fixes uncovered via fuzzing


Christian Göttsche (27):
  libselinux/utils: update selabel_partial_match
  libselinux: misc label cleanup
  libselinux: drop obsolete optimization flag
  libselinux: drop unnecessary warning overrides
  setfiles: do not issue AUDIT_FS_RELABEL on dry run
  libselinux: cast to unsigned char for character handling function
  libselinux: constify selabel_cmp(3) parameters
  libselinux: introduce reallocarray(3)
  libselinux: simplify zeroing allocation
  libselinux: introduce selabel_nuke
  libselinux/utils: use type safe union assignment
  libselinux: avoid regex serialization truncations
  libselinux/utils: introduce selabel_compare
  libselinux: parameter simplifications
  libselinux/utils: use correct type for backend argument
  libselinux: update string_to_mode()
  libselinux: remove SELABEL_OPT_SUBSET support from selabel_file(5)
  libselinux: fix logic for building android backend
  libselinux: avoid unused function
  libselinux: check for stream rewind failures
  libselinux: simplify internal selabel_validate prototype
  libselinux/utils: drop include of internal header file
  libselinux: free elements on read_spec_entries() failure
  libselinux: set errno on label lookup failure
  libselinux: rework selabel_file(5) database
  libselinux: remove unused hashtab code
  libselinux: add selabel_file(5) fuzzer

 libselinux/fuzz/input                         |    0
 .../fuzz/selabel_file_compiled-fuzzer.c       |  279 +++
 libselinux/fuzz/selabel_file_text-fuzzer.c    |  223 ++
 libselinux/include/selinux/label.h            |    6 +-
 libselinux/include/selinux/selinux.h          |    6 +-
 libselinux/src/Makefile                       |   20 +-
 libselinux/src/booleans.c                     |    8 +-
 libselinux/src/compute_create.c               |    2 +-
 libselinux/src/get_context_list.c             |   14 +-
 libselinux/src/get_default_type.c             |    2 +-
 libselinux/src/hashtab.c                      |  234 --
 libselinux/src/hashtab.h                      |  117 -
 libselinux/src/is_customizable_type.c         |    7 +-
 libselinux/src/label.c                        |   40 +-
 libselinux/src/label_backends_android.c       |    9 +-
 libselinux/src/label_file.c                   | 2140 ++++++++++++-----
 libselinux/src/label_file.h                   |  913 ++++---
 libselinux/src/label_internal.h               |   17 +-
 libselinux/src/label_media.c                  |    7 +-
 libselinux/src/label_support.c                |   43 +-
 libselinux/src/label_x.c                      |    7 +-
 libselinux/src/load_policy.c                  |    2 +-
 libselinux/src/matchmediacon.c                |    6 +-
 libselinux/src/matchpathcon.c                 |   17 +-
 libselinux/src/regex.c                        |   57 +-
 .../src/selinux_check_securetty_context.c     |    4 +-
 libselinux/src/selinux_config.c               |   12 +-
 libselinux/src/selinux_internal.c             |   16 +
 libselinux/src/selinux_internal.h             |    4 +
 libselinux/src/selinux_restorecon.c           |    3 +-
 libselinux/src/seusers.c                      |    6 +-
 libselinux/utils/.gitignore                   |    2 +
 libselinux/utils/matchpathcon.c               |   11 +-
 libselinux/utils/sefcontext_compile.c         |  536 +++--
 libselinux/utils/selabel_compare.c            |  119 +
 libselinux/utils/selabel_digest.c             |    3 +-
 .../selabel_get_digests_all_partial_matches.c |    2 -
 libselinux/utils/selabel_lookup.c             |    3 +-
 libselinux/utils/selabel_nuke.c               |  134 ++
 libselinux/utils/selabel_partial_match.c      |    7 +-
 libselinux/utils/selinux_check_access.c       |    2 +-
 policycoreutils/setfiles/setfiles.c           |   16 +-
 scripts/oss-fuzz.sh                           |   25 +
 43 files changed, 3434 insertions(+), 1647 deletions(-)
 create mode 100644 libselinux/fuzz/input
 create mode 100644 libselinux/fuzz/selabel_file_compiled-fuzzer.c
 create mode 100644 libselinux/fuzz/selabel_file_text-fuzzer.c
 delete mode 100644 libselinux/src/hashtab.c
 delete mode 100644 libselinux/src/hashtab.h
 create mode 100644 libselinux/utils/selabel_compare.c
 create mode 100644 libselinux/utils/selabel_nuke.c

-- 
2.40.1

