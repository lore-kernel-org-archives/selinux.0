Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32AAC0015E
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 20:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjHKUAo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKUAo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 16:00:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F3171F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 13:00:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so37799651fa.0
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691784041; x=1692388841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OED1F+xOHlsXGVFl2n3XiUj29FWn8QyIsDcJHcoFHnk=;
        b=ZLaHQLASxWQR51Emlv8/tkJrOBvT+igkXwcihQ6GctiHjaalpQGGPxr7yOJcpGPkdy
         3X+Dtljk5ZY6R3NLnQ0rooRQEFeNCBJ9qcm9HzaUSOhK1BdSWs43HGf4oeTYPup5KUjp
         n7Fkz19PvVTpCwn6AUIbMYSqy1kYIqfS8sIYyE6relyIsFsOQY8DrUqPYfVP5y2zfGnq
         YdO0LsqcL3Wl3rQn/qoujaPA+qwjdpFfbkcLIyWLjqzfL+ErYQKrHtAHsuoYhkeBTAwB
         Z8FFC6JQghucb6Dm0oihtccntH5lIAtMUMUIGoDfZIhTo7IzkBB2qSdYZWFVpbTxWo1r
         jeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691784041; x=1692388841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OED1F+xOHlsXGVFl2n3XiUj29FWn8QyIsDcJHcoFHnk=;
        b=Gkfwv5V0WFAY8mm76jCVzK2Np/QxRNdrR/986iO0QeCcF1u4FzU2TrUttiQMKGRjAl
         9LYoxOrPstux7VR7HXlLUSFvfSJnHukcZMCrK/coXvY+DWF+1csvBF+B/kOqC2+SHyYF
         NTRBBtTixQmkhSEku9gwYD0gLEf2hgMSNM/O6nTKWLttdEwBKmVxbFPbm83n4LnDUphN
         emH/B9HN9kGOYy+rWtE0VVV046J311SMxTJ4fM7UEsdBkh9NZQMdIO0P7e/O8GRaCcte
         FuExkXm1p2XpbZSkZ4UUQMtbChM3R+c8mrebevBjxr46V7DSU3Ft1sxfZ90rPzHiVK5g
         ByYg==
X-Gm-Message-State: AOJu0YxsoIZLSvS6XnLSP0yrKcXJ+nSOBtH3tY+CqIHgyD4lgnKXN+Tw
        eISAqSV4Nu3JK68r4QdEWwJb/1wN5Y27GY4nIRgnOpkK
X-Google-Smtp-Source: AGHT+IGuljwkbfOnBMvty0GFG2bHSfwLVioKk4TXm0+lYiimcTDWs3PV0dHxSLD7TX+uiBAkB2+j/hrc73M/CI8q/uk=
X-Received: by 2002:a2e:3216:0:b0:2b5:8a21:5627 with SMTP id
 y22-20020a2e3216000000b002b58a215627mr2461198ljy.51.1691784040727; Fri, 11
 Aug 2023 13:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230811162731.50697-1-cgzones@googlemail.com>
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Aug 2023 16:00:29 -0400
Message-ID: <CAP+JOzReqXcZ=UAss2KesRXam9YpK6xNWMGD7OVYREUB8HnU0A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/24] libselinux: rework selabel_file(5) database
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patch 23 does not seem to have made it to the list.
Jim

On Fri, Aug 11, 2023 at 12:45=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently the database for file backend of selabel stores the file
> context specifications in a single long array.  This array is sorted by
> special precedence rules, e.g. regular expressions without meta
> character first, ordered by length, and the remaining regular
> expressions ordered by stem (the prefix part of the regular expressions
> without meta characters) length.
>
> This results in suboptimal lookup performance for two reasons;
> File context specifications without any meta characters (e.g.
> '/etc/passwd') are still matched via an expensive regular expression
> match operation.
> All such trivial regular expressions are matched against before any non-
> trivial regular expression, resulting in thousands of regex match
> operations for lookups for paths not matching any of the trivial ones.
>
> Rework the internal representation of the database in two ways:
> Convert regular expressions without any meta characters and containing
> only supported escaped characters (e.g. '/etc/rc\.d/init\.d') into
> literal strings, which get compared via strcmp(3) later on.
> Store the specifications in a tree structure (since the filesystem is a
> tree) to reduce the to number of specifications that need to be checked.
>
> Since the internal representation is completely rewritten introduce a
> new compiled file context file format mirroring the tree structure.
> The new format also stores all multi-byte data in network byte-order, so
> that such compiled files can be cross-compiled, e.g. for embedded
> devices with read-only filesystems (except for the regular expressions,
> which are still architecture-dependent).
>
> The improved lookup performance will also benefit SELinux aware daemons,
> which create files with their default context, e.g. systemd.
>
> #  Performance data
>
> ## Compiled file context sizes
>
> Fedora 38 (regular expressions are omitted on Fedora):
>     file_contexts.bin:           596783  ->   575284  (bytes)
>     file_contexts.homedirs.bin:   21219  ->    18185  (bytes)
>
> Debian Sid (regular expressions are included):
>     file_contexts.bin:          2580704  ->  1428354  (bytes)
>     file_contexts.homedirs.bin:  130946  ->    96884  (bytes)
>
> ## Single lookup
>
> (selabel -b file -k /bin/bash)
>
> Fedora 38 in VM:
>     text:      time:       3.6 ms  ->   4.7 ms
>                peak heap:   2.32M  ->    1.44M
>                peak rss:    5.61M  ->    6.03M
>     compiled:  time:       1.5 ms  ->   1.5 ms
>                peak heap:   2.14M  ->  917.93K
>                peak rss:    5.33M  ->    5.47M
>
> Debian Sid on Raspberry Pi 3:
>     text:      time:      33.9 ms  ->  19.9 ms
>                peak heap:  10.46M  ->  468.72K
>                peak rss:    9.44M  ->    4.98M
>     compiled:  time:      39.3 ms  ->  22.8 ms
>                peak heap:  13.09M  ->    1.86M
>                peak rss:   12.57M  ->    7.86M
>
> ## Full filesystem relabel
>
> (restorecon -vRn /)
>
> Fedora 38 in VM:
>       27.445 s  ->   3.293 s
> Debian Sid on Raspberry Pi 3:
>       86.734 s  ->  10.810 s
>
> (restorecon -vRn -T0 /)
>
> Fedora 38 in VM (8 cores):
>       29.205 s  ->   2.521 s
> Debian Sid on Raspberry Pi 3 (4 cores):
>       46.974 s  ->  10.728 s
>
> (note: I am unsure why the parallel runs on Fedora are slower)
>
> # TODO
>
> There might be subtle differences in lookup results which evaded my
> testing, because some precedence rules are oblique.  For example
> `/usr/(.*/)?lib(/.*)?` has to have a higher precedence than
> `/usr/(.*/)?bin(/.*)?` to match the current Fedora behavior.  Please
> report any behavior changes.
>
> If any code section is unclear I am happy to add some inline comments.
>
> The maximum node depth in the database is set to 3, which seems to give
> the best performance to memory usage ratio.  Might be tweaked for
> systems with different filesystem hierarchies (Android?).
>
> I am not that familiar with the selabel_partial_match(3),
> selabel_get_digests_all_partial_matches(3) and
> selabel_hash_all_partial_matches(3) related interfaces, so I only did
> some rudimentary tests for them.
>
>
> # Patches
>
> Patches 1-4 have been proposed already:
> https://patchwork.kernel.org/project/selinux/list/?series=3D772728
>
> Patch 5 has been proposed already:
> https://patchwork.kernel.org/project/selinux/patch/20230803162301.302579-=
1-cgzones@googlemail.com/
>
> Patches 6-22 are cleanup and misc fixes which can be applied own their ow=
n.
>
> Patch 23 is the rework
>
> Patch 24 is removing unused code after the rework in patch 23
>
> This patchset is also available at https://github.com/SELinuxProject/seli=
nux/pull/406
>
>
> Christian G=C3=B6ttsche (24):
>   libselinux/utils: update selabel_partial_match
>   libselinux: misc label cleanup
>   libselinux: drop obsolete optimization flag
>   libselinux: drop unnecessary warning overrides
>   setfiles: do not issue AUDIT_FS_RELABEL on dry run
>   libselinux: cast to unsigned char for character handling function
>   libselinux: constify selabel_cmp(3) parameters
>   libselinux: introduce reallocarray(3)
>   libselinux: simplify zeroing allocation
>   libselinux: introduce selabel_nuke
>   libselinux/utils: use type safe union assignment
>   libselinux: avoid regex serialization truncations
>   libselinux/utils: introduce selabel_compare
>   libselinux: parameter simplifications
>   libselinux/utils: use correct type for backend argument
>   libselinux: update string_to_mode()
>   libselinux: remove SELABEL_OPT_SUBSET support from selabel_file(5)
>   libselinux: fix logic for building android backend
>   libselinux: avoid unused function
>   libselinux: check for stream rewind failures
>   libselinux: simplify internal selabel_validate prototype
>   libselinux/utils: drop include of internal header file
>   libselinux: rework selabel_file(5) database
>   libselinux: remove unused hashtab code
>
>  libselinux/include/selinux/label.h            |    6 +-
>  libselinux/include/selinux/selinux.h          |    6 +-
>  libselinux/src/Makefile                       |   20 +-
>  libselinux/src/booleans.c                     |    8 +-
>  libselinux/src/compute_create.c               |    2 +-
>  libselinux/src/get_context_list.c             |   14 +-
>  libselinux/src/get_default_type.c             |    2 +-
>  libselinux/src/hashtab.c                      |  234 --
>  libselinux/src/hashtab.h                      |  117 -
>  libselinux/src/is_customizable_type.c         |    7 +-
>  libselinux/src/label.c                        |   40 +-
>  libselinux/src/label_backends_android.c       |    9 +-
>  libselinux/src/label_file.c                   | 2107 +++++++++++------
>  libselinux/src/label_file.h                   |  893 ++++---
>  libselinux/src/label_internal.h               |   17 +-
>  libselinux/src/label_media.c                  |    7 +-
>  libselinux/src/label_support.c                |   43 +-
>  libselinux/src/label_x.c                      |    7 +-
>  libselinux/src/load_policy.c                  |    2 +-
>  libselinux/src/matchmediacon.c                |    6 +-
>  libselinux/src/matchpathcon.c                 |   17 +-
>  libselinux/src/regex.c                        |   57 +-
>  .../src/selinux_check_securetty_context.c     |    4 +-
>  libselinux/src/selinux_config.c               |   12 +-
>  libselinux/src/selinux_internal.c             |   16 +
>  libselinux/src/selinux_internal.h             |    4 +
>  libselinux/src/selinux_restorecon.c           |    3 +-
>  libselinux/src/seusers.c                      |    6 +-
>  libselinux/utils/.gitignore                   |    2 +
>  libselinux/utils/matchpathcon.c               |   11 +-
>  libselinux/utils/sefcontext_compile.c         |  536 +++--
>  libselinux/utils/selabel_compare.c            |  119 +
>  libselinux/utils/selabel_digest.c             |    3 +-
>  .../selabel_get_digests_all_partial_matches.c |    2 -
>  libselinux/utils/selabel_lookup.c             |    3 +-
>  libselinux/utils/selabel_nuke.c               |  134 ++
>  libselinux/utils/selabel_partial_match.c      |    7 +-
>  libselinux/utils/selinux_check_access.c       |    2 +-
>  policycoreutils/setfiles/setfiles.c           |   16 +-
>  39 files changed, 2854 insertions(+), 1647 deletions(-)
>  delete mode 100644 libselinux/src/hashtab.c
>  delete mode 100644 libselinux/src/hashtab.h
>  create mode 100644 libselinux/utils/selabel_compare.c
>  create mode 100644 libselinux/utils/selabel_nuke.c
>
> --
> 2.40.1
>
