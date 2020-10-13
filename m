Return-Path: <SRS0=hBaa=DU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A9C8301D
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D7E20678
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FEFVCX/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgJMBPY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 21:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgJMBPX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 21:15:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C383C0613D2
        for <selinux@vger.kernel.org>; Mon, 12 Oct 2020 18:15:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u8so25939863ejg.1
        for <selinux@vger.kernel.org>; Mon, 12 Oct 2020 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sriivWtFoi5P+y8iWJ5C09llKR2ed5ZfEWA0LWNTcX0=;
        b=FEFVCX/+dW0jLiNqAckex96To29CxPbhIc7UTFOe0z+RQV99pfU/Af/e5mVJzEMMZc
         yZV2KTN4Or/psTLBPFoNUIV+h+2wW9m/JeVTeXuDaf6qQWYyDnZm/aPp88kNHzneG0W+
         hzKWDEg8HoQukkKfcdtaTKALIeBTBU8cgB0aUSQ/ZxfaBf/rxyOASCe2xAOAc+GT/uKm
         2aL1gyUZyZI3HyiSk7ypyGMzclmztpl2lsQ3BrTWvjfqUtkZv3yF7WPYSoRLau9qklwB
         9OxEirsQTJLkm4oIeOHhhGgel7FkdW0uatT3lLfnI80iLjLBDUZRjxfqtZTSEH8OXxGN
         Y3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sriivWtFoi5P+y8iWJ5C09llKR2ed5ZfEWA0LWNTcX0=;
        b=Pnse1SAx/Eb5VoX41KE9v5eOmOMhJbCBBNcBsrYyVMrVbCtWT5ItG04Ygq7JVv0iZM
         Fqlkz4qSEWzIBX4cRF2Mrt8/rq0HpmRi5VV7sIr+yNZudVQJH2rQVDN8f49cjHevZcg5
         lVlomeT0X3WtDMmDSIMBZlHjv73VIKeOqti931UYdFuVlNbLuply9hVvTR1kBcCgYnQa
         0V02OswnHgm1AaQkeIWpSKqLkrWU+OKVMvWrTLTcUeO8hWhqNuhQED/MT5OytI6JraXg
         KHvTZJSg0vLU8ZExAww78k3Y/ajIhaa5D/PlslgbBLVIqjPailBXY0RId1OoEQukPWon
         GVOQ==
X-Gm-Message-State: AOAM533xNnjvAD4QUzmOmcZ3RIU7QK4GKYhL/VNoo62qwO37FhsZzzYQ
        +TncaYEP7OzbouE30lGlUA2dhFOmX5Sx/jj+r3aLj9UvMwhR
X-Google-Smtp-Source: ABdhPJyw/aW8jICPx6dj38zdbA20PH/TsVqvNiFW5OZM0kDyyH+4I1k5Dt3wS6ximU1UKip6HnGt+bXeausBm+/2rEE=
X-Received: by 2002:a17:906:c444:: with SMTP id ck4mr29111638ejb.398.1602551719875;
 Mon, 12 Oct 2020 18:15:19 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Oct 2020 21:15:09 -0400
Message-ID: <CAHC9VhShMEWOQFWOnbDuZDN9D397QbZaSuGs95AddSc_LQA1rg@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

A decent number of SELinux patches for v5.10, twenty two in total.
The highlights are listed below, but all of the patches pass our test
suite and merge cleanly against your tree.  Please merge for v5.10.

- A number of changes to how the SELinux policy is loaded and managed
inside the kernel with the goal of improving the atomicity of a
SELinux policy load operation.  These changes account for the bulk of
the diffstat as well as the patch count.  A special thanks to everyone
who contributed patches and fixes for this work.

- Convert the SELinux policy read-write lock to RCU.

- A tracepoint was added for audited SELinux access control events;
this should help provide a more unified backtrace across kernel and
userspace.

- Allow the removal of security.selinux xattrs when a SELinux policy
is not loaded.

- Enable policy capabilities in SELinux policies created with the
scripts/selinux/mdp tool.

- Provide some "no sooner than" dates for the SELinux checkreqprot
sysfs deprecation.

Thanks,
-Paul

--
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5=
:

 Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20201012

for you to fetch changes up to 0d50f059c4cdc9e436f6f4db8779ac0795bfdadf:

 selinux: provide a "no sooner than" date for the checkreqprot removal
   (2020-09-29 16:50:57 -0400)

----------------------------------------------------------------
selinux/stable-5.10 PR 20201012

----------------------------------------------------------------
Colin Ian King (1):
     selinux: fix allocation failure check on newpolicy->sidtab

Dan Carpenter (1):
     selinux: fix error handling bugs in security_load_policy()

Daniel Burgener (4):
     selinux: Create function for selinuxfs directory cleanup
     selinux: Refactor selinuxfs directory populating functions
     selinux: Standardize string literal usage for selinuxfs directory name=
s
     selinux: Create new booleans and class dirs out of tree

Lakshmi Ramasubramanian (1):
     selinux: Add helper functions to get and set checkreqprot

Ondrej Mosnacek (1):
     selinux: simplify away security_policydb_len()

Paul Moore (1):
     selinux: provide a "no sooner than" date for the checkreqprot removal

Peter Enderborg (1):
     selinux: add basic filtering for audit trace events

Randy Dunlap (1):
     selinux: delete repeated words in comments

Stephen Smalley (9):
     scripts/selinux,selinux: update mdp to enable policy capabilities
     selinux: encapsulate policy state, refactor policy load
     selinux: move policy commit after updating selinuxfs
     selinux: refactor changing booleans
     selinux: avoid dereferencing the policy prior to initialization
     selinux: permit removing security.selinux xattr before policy load
     selinux: convert policy read-write lock to RCU
     selinux: move policy mutex to selinux_state, use in lockdep checks
     selinux: access policycaps with READ_ONCE/WRITE_ONCE

Thi=C3=A9baud Weksteen (1):
     selinux: add tracepoint on audited events

kernel test robot (1):
     selinux: fix memdup.cocci warnings

.../ABI/obsolete/sysfs-selinux-checkreqprot        |   2 +-
MAINTAINERS                                        |   1 +
include/trace/events/avc.h                         |  53 ++
scripts/selinux/mdp/mdp.c                          |   7 +
security/selinux/avc.c                             |  29 +-
security/selinux/hooks.c                           |  17 +-
security/selinux/include/conditional.h             |   2 +-
security/selinux/include/policycap.h               |  20 +
security/selinux/include/policycap_names.h         |  18 +
security/selinux/include/security.h                |  63 +-
security/selinux/selinuxfs.c                       | 259 ++++--
security/selinux/ss/avtab.c                        |  49 +-
security/selinux/ss/avtab.h                        |   1 +
security/selinux/ss/conditional.c                  | 155 ++++
security/selinux/ss/conditional.h                  |   2 +
security/selinux/ss/hashtab.c                      |  53 ++
security/selinux/ss/hashtab.h                      |   6 +
security/selinux/ss/services.c                     | 875 ++++++++++-------
security/selinux/ss/services.h                     |   5 +-
security/selinux/ss/sidtab.c                       |  10 +
security/selinux/ss/sidtab.h                       |   2 +
21 files changed, 1130 insertions(+), 499 deletions(-)
create mode 100644 include/trace/events/avc.h
create mode 100644 security/selinux/include/policycap.h
create mode 100644 security/selinux/include/policycap_names.h

--=20
paul moore
www.paul-moore.com
