Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA57ECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9652086A
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nZnnrnjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfJON0C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:26:02 -0400
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:48428 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfJON0C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:26:02 -0400
X-EEMSG-check-017: 35489063|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="35489063"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571145934; x=1602681934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z53wDAeq9dsacAxKE0B7HMBcAxuX6CAijviwYb62+vg=;
  b=nZnnrnjX1UtbkXDqn5Tm2bWkXkGoj/yKyt5qCPRO0hP7VyR4DeZX1de4
   6RLexCNSnhzMr5ugW8qCFOeOuwEPJX/jdMfp6j2+434PIbZ1V0zeGMgEU
   pdegKB0fyVCE+dMojHrUxR5ZeFcuxJqR7/DFVGHh9KSWXo5qYos9fsArm
   AUZYNbCkDGfEbMnubl+vpvUos+PV+7drqM7rAXJO1C+2F7eDe4fbabyhA
   bnq4yBxeE14egMzljGF7sd1dKrUwMUM4nLGWUudt9Wg82hqBkwbgAE8WN
   L6bXwn8Tvti39Q4r3siihz1S1auZgvT/QQHy7RCCWfbw4GLRU6frpm3gQ
   A==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156606"
IronPort-PHdr: =?us-ascii?q?9a23=3AYcxXAxCLKzFpXDb4235CUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT9p8bcNUDSrc9gkEXOFd2Cra4d0KyJ6Ou9ByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhe7oAveusQWgIZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLmhycdMz4y7X/ZhMp+gqlGpB6tvgJzzorRbIyTKfFwfL7SfckCSG?=
 =?us-ascii?q?RBQMhfSiJPDIC7YYQAAOQMJvpUoornqlcStxayGRWgCeXywTFInH/22qg63v?=
 =?us-ascii?q?w8HwHawgMgB9IOv2rSrN7oKakSVPq6zK3MzTrdb/JdxDDw6JPVfRA6uvyMQb?=
 =?us-ascii?q?JxftbRyUkoDQ/FiE6Qppb/MzOa0eQNrXGW4ux9XuyhjG4nrht+ojmpxso0iY?=
 =?us-ascii?q?nGmJgVylba+iV92oo1Ise4SEFjbd6rEZtQqyGaN5ZtTc84X25ovyM6x7sbsp?=
 =?us-ascii?q?C4ZCgH0IkryhHQZvCdc4WE/wjvWPieLDtmnn5pZbSyjAuo/0e60O3zTMy03U?=
 =?us-ascii?q?5PripCj9bDqGgA1wfW6sibUvt9+Vqh2SqX2wDT9O5EJUc0mLLHK5E72L4wl4?=
 =?us-ascii?q?cTsV/ZEi/qmET5kK+WdkI+9uiu9+vneanpqoWZN491jgHyKqUumsqhDuQkKg?=
 =?us-ascii?q?UCQmeW9Oum2LDj4EH1WqtGg/IonqXDrZzWPcEbqbS4Aw9R3IYj8RG/DzK+3d?=
 =?us-ascii?q?QDgHYHN0lIeA6Hjof1O1HOJ+r0DfGkg1u2ijtryPfGPqP5DpXXMnfDiKvhfa?=
 =?us-ascii?q?p660NE0Ao8181f55ZPB7EZOv3zR0vxuMXdDh8+NAy02fjoBM9h2YMZXGKFGr?=
 =?us-ascii?q?WZP7/KsV+U+uIvJPGBZJQLtzb5Kvgl4ePujHAilF8Dcqmmw4EXZGq7Hvt4OU?=
 =?us-ascii?q?WZZ2TjgtMbHWcNpAo+Q7+itFrXSjNXZnCvT4oi6TwhToGrF4HOQsaqmrPS8j?=
 =?us-ascii?q?28G8htem1eCl2KWUztfoGAVuZEPDmeOed9gzcEUv6nUIZn2haw4lypg4F7J/?=
 =?us-ascii?q?bZr3VL/ano08J4sqiJxBw=3D?=
X-IPAS-Result: =?us-ascii?q?A2DTCwAuxaVd/wHyM5BmHgELHIFwC4F0LGxTATKTfAEBA?=
 =?us-ascii?q?QEBAQaLLpEvCQEBAQEBAQEBARsSBwECAQGEQIJtJDcGDgIMAQEBBAEBAQEBB?=
 =?us-ascii?q?QMBAWyFLQyCOimDIQFGhDQ/AYJSJQ+wT4Q4AYEUgy6BQgaBNIc1hFkYeIEHg?=
 =?us-ascii?q?RGGMQKCLoUfBI0HoEOCLIIxhFmOBQwbmUGWVJMoI4FYKwgCGAghD4MoTxAUh?=
 =?us-ascii?q?UKFFIVbJQOBNgEBkEEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:25:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4E010187;
        Tue, 15 Oct 2019 09:25:32 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 00/10] SELinux namespace series, re-based
Date:   Tue, 15 Oct 2019 09:25:18 -0400
Message-Id: <20191015132528.13519-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After a long hiatus, I have re-based the SELinux namespace series
on top of selinux/next based on v5.4-rc1, available from
https://github.com/stephensmalley/selinux-kernel/tree/selinuxns-v5.4-rc1
and posted here.  Thanks to Paul Moore who had earlier ported the
series up through v4.19-rc1.

I chose to drop the per-namespace inode and superblock security blob
patches from the series for the time being.  In part, this is due to the
fact that the original patch for per-namespace inode security blobs
requires a major rewrite to deal with the LSM stacking changes.
However, even apart from this issue, those two patches had known major
problems that made them unlikely in my view to survive in the final
implementation.  This does leave the series in an even less functional
state than before.

This series also does not include James Morris' separate RFC patch for
per-namespace security extended attributes on files,
https://patchwork.kernel.org/patch/10067875/
which would ultimately be needed if we want to fully support per-namespace
file security labels (not merely mappings of a single file label).

As before, this is unsafe, experimental code.  Use at your own risk.
The patches should be harmless no-ops up until the one that introduces
the ability to unshare the selinux namespace, but YMMV.

James Morris (1):
  selinuxns: mark init_selinux_ns as __ro_after_init

Peter Enderborg (1):
  selinux: Annotate lockdep for services locks

Stephen Smalley (8):
  selinux: rename selinux state to ns (namespace)
  selinux: support multiple selinuxfs instances
  selinux: dynamically allocate selinux namespace
  netns,selinux: create the selinux netlink socket per network namespace
  selinux: support per-task/cred selinux namespace
  selinux: introduce cred_selinux_ns() and use it
  selinux: add a selinuxfs interface to unshare selinux namespace
  selinuxfs: restrict write operations to the same selinux namespace

 include/net/net_namespace.h            |   3 +
 security/selinux/avc.c                 |  94 +++--
 security/selinux/hooks.c               | 512 +++++++++++++----------
 security/selinux/ibpkey.c              |   2 +-
 security/selinux/include/avc.h         |  16 +-
 security/selinux/include/classmap.h    |   3 +-
 security/selinux/include/conditional.h |   6 +-
 security/selinux/include/objsec.h      |  23 --
 security/selinux/include/security.h    | 185 ++++++---
 security/selinux/netif.c               |   2 +-
 security/selinux/netlabel.c            |  12 +-
 security/selinux/netlink.c             |  31 +-
 security/selinux/netnode.c             |   4 +-
 security/selinux/netport.c             |   2 +-
 security/selinux/selinuxfs.c           | 266 ++++++++----
 security/selinux/ss/services.c         | 543 +++++++++++++------------
 security/selinux/ss/status.c           |  42 +-
 security/selinux/xfrm.c                |  18 +-
 18 files changed, 1026 insertions(+), 738 deletions(-)

-- 
2.21.0

