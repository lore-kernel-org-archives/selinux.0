Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF5C001B0
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHKQ1v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHKQ1u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354D19AE
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf3f59905so297160266b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771268; x=1692376068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AHC5LcEqoSHnJ9KyfVb1vCGPPsI8kwv6fzvKpFXpak=;
        b=ZlVKlWDAh+59k+7SH6RJVCExuK34ub6Myq52CpeZxzssVo68AKNEDndH7RCmHXsesd
         58gulB44tffac3KENJ7Afe1pvYdOBRLlm9fy8WidGGGR1v6XGCCdw6SizeYWpaBZQLK2
         4xXR6zOB67RNrN0sC/drb9nX4e9VTVaDW9YwyVQFb9X+iISXsNR1Pwa4fcK84qNL9GYH
         uLTJ4CDgDqmqk3fi2WCcKh3t9M6/Qod1lbSJIeBgC2hUA8fCj3d85LTc4MC0kdng5D8T
         3CMSPbdiD3MQThD1fKVbSkINF4+X75GzmYN3SNuIThIuffLoxvz89a7ZVUntaQxtuWgn
         K98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771268; x=1692376068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AHC5LcEqoSHnJ9KyfVb1vCGPPsI8kwv6fzvKpFXpak=;
        b=GOkNLzupKVujks/tOOI5mwEzOHd1YSU3ngA65paLljhGBYdCtbGarPZ9r5P0CS9t44
         nHWF139UBwhw4TiqKvWkBTMW8CSKSB0rLbrT0Bgn8eev3rGO18CiRISWefuvoB5400lJ
         bpzqLwza/2NON/9gaCJ3RiLfbGq8aCvAgQt347ESB1tn6GnKCTILHCRMeD77kbUwD+3r
         iuaCSCp/RefEFNCQCVF4bwoMQ52NLcxQ6yMzESwL2ThTuJx9VWia1n9IW7vwSNycXDOG
         PY9YKXe7wswII6mF73LhjDm0M8Gf9lk/igO4lD6P877Mg67nEVx/T3u+sa7hwLyTUtEJ
         eIrg==
X-Gm-Message-State: AOJu0YxGFKWCDW4SEEgo47zCwtjRLYfJ01dexRYPKI7uv71+asbdIuh7
        7YBvg4bwOrTXbkhTlhO7LJDk8FLUHcaviw==
X-Google-Smtp-Source: AGHT+IEhZgNiJa3DCqQV0mDNwRgmgu58MNBzqg0J+vrzuKK8R1lgmCrhlDyDiXGJMqcYVpKAOr/dXA==
X-Received: by 2002:a17:906:2259:b0:99b:ed27:9f4c with SMTP id 25-20020a170906225900b0099bed279f4cmr2073326ejr.69.1691771267877;
        Fri, 11 Aug 2023 09:27:47 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 00/24] libselinux: rework selabel_file(5) database
Date:   Fri, 11 Aug 2023 18:27:07 +0200
Message-Id: <20230811162731.50697-1-cgzones@googlemail.com>
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

Patches 1-4 have been proposed already:
https://patchwork.kernel.org/project/selinux/list/?series=772728

Patch 5 has been proposed already:
https://patchwork.kernel.org/project/selinux/patch/20230803162301.302579-1-cgzones@googlemail.com/

Patches 6-22 are cleanup and misc fixes which can be applied own their own.

Patch 23 is the rework

Patch 24 is removing unused code after the rework in patch 23

This patchset is also available at https://github.com/SELinuxProject/selinux/pull/406


Christian Göttsche (24):
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
  libselinux: rework selabel_file(5) database
  libselinux: remove unused hashtab code

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
 libselinux/src/label_file.c                   | 2107 +++++++++++------
 libselinux/src/label_file.h                   |  893 ++++---
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
 39 files changed, 2854 insertions(+), 1647 deletions(-)
 delete mode 100644 libselinux/src/hashtab.c
 delete mode 100644 libselinux/src/hashtab.h
 create mode 100644 libselinux/utils/selabel_compare.c
 create mode 100644 libselinux/utils/selabel_nuke.c

-- 
2.40.1

