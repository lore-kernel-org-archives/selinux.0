Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE4C77B73
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjEaLcg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjEaLcg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:32:36 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7511133
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685532728; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=fRxITmRKpPLbEUqaGkfbpFYRFwanXddeXc0ve3FAvLiXx9b+FxzPLzZVo/584j8hQaAQD7W0r8/flYAFlKGy4leBqbbe6mK9xaoQZSPen6WiYP/x2vazYCJbXRCPANzNzMrBb0hqnIXefvoTvSdjEOl15rcl6OUJX9K8gp36amo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685532728; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=/UGXa5qw5N/ksgv7sYz4O5MbVRX+9A7VFhFFnBIwiX0=; 
        b=HRN+unp0IAPMtxF3R0wBn8OXNUBOlL/+vlRGAWmWckrZQz9qPTe1yVOUnGV5tmEcEUHU3ODa+CpFfvJGC3MLgPxcTAbh1y9znGGy0GmTKSTYT/6EyEui4PmCMHyRE1QK6//F+nwvX85VhfOt6MEeF34+kvmKpqw6XEYA15yfJ4Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685532728;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=/UGXa5qw5N/ksgv7sYz4O5MbVRX+9A7VFhFFnBIwiX0=;
        b=XZQUYkRoL9EpHL8jvbabWLWJxXNrHWxHsgCTwJn1zKc10T9XlGKYTtnUtFBHB3gp
        5bclBrsxh1ovsESpvZ6Z1MuuT92u0NXJ/cFuTx80npYcL0xmp7lv7iBnH2zZ/foxig1
        yMmMpnpawat03QyfZjwstivNP03jYclhji2pUw0M=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685532726616140.56641963717607; Wed, 31 May 2023 13:32:06 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id B8CBE2081F76;
        Wed, 31 May 2023 11:32:05 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: [PATCH 0/5] selinux: add prefix/suffix matching to filename type transitions
Date:   Wed, 31 May 2023 13:29:23 +0200
Message-Id: <20230531112927.1957093-1-juraj@jurajmarcin.com>
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

First, this series of patches moves the filename transitions to be part
of the avtab structures. This not only makes the implementation of
prefix/suffix matching and future enhancements easier, but also reduces
the technical debt regarding the filename transitions. Next, the last
patch implements the support for prefix/suffix name matching itself by
extending the structures added in previous patches in this series.

Even though, moving everything to avtab increases the memory usage and
the size of the binary policy itself and thus the loading time, the
ability to match the prefix or suffix of the name will reduce the
overall number of rules in the policy which should mitigate this issue.

This implementation has been successfully tested using the existing and
also new tests in the SELinux Testsuite.

Juraj Marcin (5):
  selinux: move transition to separate structure in avtab_datum
  selinux: move filename transitions to avtab
  selinux: implement new binary format for filename transitions in avtab
  selinux: filename transitions move tests
  selinux: add prefix/suffix matching support to filename type
    transitions

 security/selinux/Kconfig            |  17 +
 security/selinux/Makefile           |   2 +
 security/selinux/include/security.h |   4 +-
 security/selinux/ss/avtab.c         | 814 +++++++++++++++++++++++++++-
 security/selinux/ss/avtab.h         |  16 +-
 security/selinux/ss/avtab_test.c    | 745 +++++++++++++++++++++++++
 security/selinux/ss/conditional.c   |   6 +-
 security/selinux/ss/hashtab.h       |   6 +
 security/selinux/ss/policydb.c      | 421 +-------------
 security/selinux/ss/policydb.h      |  25 +-
 security/selinux/ss/services.c      |  80 ++-
 security/selinux/ss/symtab.c        |   3 +
 12 files changed, 1677 insertions(+), 462 deletions(-)
 create mode 100644 security/selinux/ss/avtab_test.c

--=20
2.40.0

