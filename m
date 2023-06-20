Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BA1EB64D7
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 09:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFTJC1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFTJCX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 05:02:23 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA110FE
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687251730; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=JaDudUWtHiOhF7+OGM86yXFxT5cE0wmUYvaXa0K1nI8Ix6LOYhtvxthQxvXfPxY4tT5bC+2FgfWj9sDfY9dXDCziVF41120dsO5uE+5TOzWp3RmQm1MUY+aqKLL8Quzp92Svl4o7XUhrtjIjFqX3yPwPxdpHPSwPGV4bs/SH4+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687251730; h=Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=R7a9qO6mijN/VML4N9uswLohlPQaYoTaYK9ZUqJaOu0=; 
        b=hXAn/HCSrxoJw82HzRvaTpnkK6PRvCxUcdX8iOEXQ5GwPLW0kflMDvBwbBjIqLj/n9K1TzojXhPBJPSYC00T8XKj2znxO5LJ7ijuhGS4R+fut1Yx1ehdgHE8veRokbEQ6fFhokmqXyOeX8Hyh6G3ac1u2p7VkLt5Pg4c9UMVzKQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687251730;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
        bh=R7a9qO6mijN/VML4N9uswLohlPQaYoTaYK9ZUqJaOu0=;
        b=eAvpI7akK/FdjqIC+T+EnFxv76wv69C1iEgj9KlLfJFOgwIwbWNB7Uv30h4gwOA6
        qZeC+svdEqDUlxFy8ZVlqJJWTxcR2pmShnAgx9m4V/FOcitNoG0fiCsa3AAwGIo0l9I
        KYDRQm8WB1QCH3uf4VDIFRPvejgFUcBddDPYZxGk=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687251727783617.5420088994258; Tue, 20 Jun 2023 11:02:07 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [213.175.37.12])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id D0FC82081F76;
        Tue, 20 Jun 2023 09:02:06 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 0/8] checkpolicy,libsepol: add prefix/suffix matching to filename type transitions
Date:   Tue, 20 Jun 2023 11:01:15 +0200
Message-Id: <cover.1687251081.git.juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, filename transitions are stored separately from other type
enforcement rules and only support exact name matching. However, in
practice, the names contain variable parts. This leads to many
duplicated rules in the policy that differ only in the part of the name,
or it is even impossible to cover all possible combinations.

This series implements equivalent changes made by this kernel patch
series [1].

First, this series of patches moves the filename transitions to be part
of the avtab and avrule structures. This not only makes the
implementation of prefix/suffix matching and future enhancements easier,
but also reduces the technical debt regarding the filename transitions.
Next, the last three patches implement the support for prefix/suffix
name matching itself by extending the structures added in previous
patches in this series and adding the support to CIL in the last of the
triple.

Even though, moving everything to avtab increases the memory usage and
the size of the binary policy itself and thus the loading time, the
ability to match the prefix or suffix of the name will reduce the
overall number of rules in the policy which should mitigate this issue.

[1]: https://lore.kernel.org/selinux/20230601170302.nrhuay2wh44g6sh4@jmar=
cin-t14s-01/


Changelog:

v2:
- rebased to the latest upstream main
- added syntax examples to commit messages (suggested by Jim)
- removed the "match_" prefix from keywords and dropped the
  "match_exact" keyword (suggested by Jim, discussed with Ondrej)
- fixed the bug Jim found [2] where the output to conf and CIL did not
  work
- reworked avtab entry skipping when writing older versions of the
  policy
- fixed bug where expand_terule_helper() skipped next entries after
  filename transition entry
- fixed memory leak in filenametr_destroy() found by Christian in the
  kernel version of the code [3]

[2]: https://lore.kernel.org/selinux/CAP+JOzS1nhxF8EttikRtYBW2QtW=3Dck+P4=
mC2dovgP4kp-g9WQQ@mail.gmail.com/
[3]: https://lore.kernel.org/selinux/CAJ2a_DecaSa1Z7HiRs4sGUGx3AyKwhFA41E=
hAo+BViv-qA9ndg@mail.gmail.com/


Juraj Marcin (8):
  checkpolicy,libsepol: move transition to separate structure in avtab
  checkpolicy,libsepol: move filename transitions to avtab
  checkpolicy,libsepol: move filename transition rules to avrule
  libsepol: implement new kernel binary format for avtab
  libsepol: implement new module binary format of avrule
  checkpolicy,libsepol: add prefix/suffix support to kernel policy
  checkpolicy,libsepol: add prefix/suffix support to module policy
  libsepol/cil: add support for prefix/suffix filename transtions to CIL

 checkpolicy/checkmodule.c                  |   9 +
 checkpolicy/module_compiler.c              |  12 -
 checkpolicy/module_compiler.h              |   1 -
 checkpolicy/policy_define.c                | 211 +-----
 checkpolicy/policy_define.h                |   3 +-
 checkpolicy/policy_parse.y                 |  13 +-
 checkpolicy/policy_scan.l                  |   4 +
 checkpolicy/test/dismod.c                  |  39 +-
 checkpolicy/test/dispol.c                  | 106 +--
 libsepol/cil/src/cil.c                     |   6 +
 libsepol/cil/src/cil_binary.c              |  63 +-
 libsepol/cil/src/cil_build_ast.c           |  26 +-
 libsepol/cil/src/cil_copy_ast.c            |   1 +
 libsepol/cil/src/cil_internal.h            |   4 +
 libsepol/cil/src/cil_policy.c              |  17 +-
 libsepol/cil/src/cil_resolve_ast.c         |  10 +
 libsepol/cil/src/cil_write_ast.c           |   2 +
 libsepol/include/sepol/policydb/avtab.h    |  19 +-
 libsepol/include/sepol/policydb/hashtab.h  |   8 +
 libsepol/include/sepol/policydb/policydb.h |  50 +-
 libsepol/src/avrule_block.c                |   1 -
 libsepol/src/avtab.c                       | 338 +++++++++-
 libsepol/src/conditional.c                 |   6 +-
 libsepol/src/expand.c                      | 153 ++---
 libsepol/src/kernel_to_cil.c               | 182 ++---
 libsepol/src/kernel_to_common.h            |  10 +
 libsepol/src/kernel_to_conf.c              | 178 ++---
 libsepol/src/link.c                        |  57 +-
 libsepol/src/module_to_cil.c               |  86 +--
 libsepol/src/optimize.c                    |   8 +
 libsepol/src/policydb.c                    | 479 +++-----------
 libsepol/src/policydb_validate.c           | 101 +--
 libsepol/src/services.c                    |   5 +-
 libsepol/src/write.c                       | 735 ++++++++++++++++-----
 34 files changed, 1553 insertions(+), 1390 deletions(-)

--=20
2.40.0

