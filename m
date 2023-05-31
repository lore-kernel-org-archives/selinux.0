Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D77EC77B7A
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjEaLtn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaLtm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:49:42 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B45E5
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685533778; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=UdRkHItNDhFMrlqrjhBeMtujjqjM6pg5Ahzwp/ipHGEyrHzJ2zCsMyFy7GZXt2tmXMHpHxkUghQ9f7IM4V66IsFQpdBxIaMWlf4sQUbKSbyGsOgKjGhR5lDfxfHPiTzXzQJ3lnY4ryiAfYTZLPcJTnXiEzZ460ckn2c8QeNgDfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685533778; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=I2m36xCgbnZDu6HxHvsWZAeBTw66iVGiiORtvGMkUj8=; 
        b=FT667ER1+257Ha+Ho3WIm6eHDI6u1DtS/pO2XRdqeJzhTpHAmElVrT8IVegvcTET+16nsBCB4xUOxxe6JKSeQfy+/CBH1BCFTwCJJu2JcE3ae9kwuYt4QZYbqZfS0CGh06EZNKkQ5sLYVvUMhnj3XH/VnGyryv6PiCpud3yO8R0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685533778;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=I2m36xCgbnZDu6HxHvsWZAeBTw66iVGiiORtvGMkUj8=;
        b=Ug9OkIfIDIjBdMoov8sSTK/6JVmbyYvJj0byZwt/CS05scfT13t4Dj6Rg+gsV8am
        ouVZjjx1Uum/XpNVmrBv0fS3rkWHe/Fm2nTPjNr0+HE84FQMj7VlcOnZ5BUzMi+Dg7Q
        x2FZWHWYgmpP7twjjI8tMtqhtKXSOKBUeBlvNNb8=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685533776343352.75513890796105; Wed, 31 May 2023 13:49:36 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 873DC2081F76;
        Wed, 31 May 2023 11:49:35 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/8] checkpolicy, libsepol: add prefix/suffix matching to filename type transitions
Date:   Wed, 31 May 2023 13:49:06 +0200
Message-Id: <20230531114914.2237609-1-juraj@jurajmarcin.com>
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

[1]: https://lore.kernel.org/selinux/20230531112927.1957093-1-juraj@juraj=
marcin.com/

Juraj Marcin (8):
  checkpolicy, libsepol: move transition to separate structure in avtab
  checkpolicy, libsepol: move filename transitions to avtab
  checkpolicy, libsepol: move filename transition rules to avrule
  libsepol: implement new kernel binary format for avtab
  libsepol: implement new module binary format of avrule
  checkpolicy, libsepol: add prefix/suffix support to kernel policy
  checkpolicy, libsepol: add prefix/suffix support to module policy
  libsepol/cil: add support for prefix/suffix filename transtions to CIL

 checkpolicy/checkmodule.c                  |   9 +
 checkpolicy/module_compiler.c              |  12 -
 checkpolicy/module_compiler.h              |   1 -
 checkpolicy/policy_define.c                | 211 +-----
 checkpolicy/policy_define.h                |   3 +-
 checkpolicy/policy_parse.y                 |  15 +-
 checkpolicy/policy_scan.l                  |   6 +
 checkpolicy/test/dismod.c                  |  39 +-
 checkpolicy/test/dispol.c                  | 106 +--
 libsepol/cil/src/cil.c                     |   8 +
 libsepol/cil/src/cil_binary.c              |  63 +-
 libsepol/cil/src/cil_build_ast.c           |  25 +-
 libsepol/cil/src/cil_copy_ast.c            |   1 +
 libsepol/cil/src/cil_internal.h            |   5 +
 libsepol/cil/src/cil_policy.c              |  17 +-
 libsepol/cil/src/cil_resolve_ast.c         |  10 +
 libsepol/cil/src/cil_write_ast.c           |   2 +
 libsepol/include/sepol/policydb/avtab.h    |  19 +-
 libsepol/include/sepol/policydb/hashtab.h  |  14 +
 libsepol/include/sepol/policydb/policydb.h |  50 +-
 libsepol/src/avrule_block.c                |   1 -
 libsepol/src/avtab.c                       | 336 +++++++++-
 libsepol/src/conditional.c                 |   6 +-
 libsepol/src/expand.c                      | 149 ++---
 libsepol/src/kernel_to_cil.c               | 182 ++----
 libsepol/src/kernel_to_common.h            |  10 +
 libsepol/src/kernel_to_conf.c              | 178 ++----
 libsepol/src/link.c                        |  57 +-
 libsepol/src/module_to_cil.c               |  86 +--
 libsepol/src/optimize.c                    |   8 +
 libsepol/src/policydb.c                    | 479 +++-----------
 libsepol/src/policydb_validate.c           | 100 +--
 libsepol/src/services.c                    |   5 +-
 libsepol/src/write.c                       | 712 ++++++++++++++++-----
 34 files changed, 1534 insertions(+), 1391 deletions(-)

--=20
2.40.0

