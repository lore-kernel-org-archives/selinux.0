Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD9C4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Mar 2022 22:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiCUWtk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCUWt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Mar 2022 18:49:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70A3DDCF0
        for <selinux@vger.kernel.org>; Mon, 21 Mar 2022 15:44:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pv16so32833926ejb.0
        for <selinux@vger.kernel.org>; Mon, 21 Mar 2022 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9C6i1V5W4MCeD/1gLMcJ+GxUdwOY2A6vsDcUchCpRHU=;
        b=h21Ke7djN8csNxDP0N2xUzZGpjd3brsfArHEu7cU+flfuHfn3v0Qyr+wOLxIHDFCH6
         AKO2Nkn2l++CSvp7bh98y0Ew0PaOUHaaN5+JBd8Mzrt+OtVqUz3Joomtfskoj7Z2WCz5
         TblZNEJThXjP3MnSTLuZ6knslhebdT0Ex1hEjlt5CJD/ickAO0dJxanf///Nv9q/hapJ
         BjBOIHWNXDn7OYSUsCggoG/uy9Yoyj0t1EleEP+48trZdChMtuA7CYKld/xSsKnB4bo0
         GH1CCYnG52Smn9ykPcCZFiplkUvwDPciyMQ5HZ1noQmiqo93cNtUqf+6dlijUv1KpJN4
         78Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9C6i1V5W4MCeD/1gLMcJ+GxUdwOY2A6vsDcUchCpRHU=;
        b=3XxsRbAP/+lPH/nxwqGVd634thMOKzUWzzjQbXHx5XtimPYqlX8LruV1BCSBvio3jV
         CVZpiJoFDC5lweXAhfxadGy6LZpfu7jqKkJxkqPN7GPojldiG309ESquFHBMpdqwMW7a
         dN9xMENHHr92ZFS1FvaOq9H2fXV7RpNO8dNz2eGPOEnYOeVCic8ih7SIrplAYPW6yIDI
         /LsO8V9jk0c+B4pl+nhM6yvvIDd3wl45XJtv1uR22ZBukoWFiKYbbV4PTkeCBjB+TFDA
         7yI/+cijqDiaAVwn1AVKVU4hCgjm624uoFCshBoIp7oBZDhjvwqOJxHWOeaAmj7UnFkk
         TyKg==
X-Gm-Message-State: AOAM531pB75xw21pZE30R7x8y33Fhg9zs2z6ycacctTGpTWUM7FYghrp
        6UvckP1hVlZ8nlBr2qrfgWztk45M6OGD+BpD3wbsNJi43wA3
X-Google-Smtp-Source: ABdhPJyiMez9ZfWnO8QSTwIMXiv9ZaXQhOY7r3oIbxQAI+nwTkPaLLqfCwO6rIX4TQN62sPtD15z8P7mdGRwCRoEAig=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr22563111ejc.701.1647900842214; Mon, 21
 Mar 2022 15:14:02 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Mar 2022 18:13:51 -0400
Message-ID: <CAHC9VhTA1O4J_dS9T_U-Vrmi-7JeHTM6fEOfS8JJBfvoNgDrfg@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Linus,

We've got a number of SELinux patches queued up for v5.18, the
highlights are below:

- Fixup the security_fs_context_parse_param() LSM hook so it executes
all of the LSM hook implementations unless a serious error occurs.  We
also correct the SELinux hook implementation so that it returns zero
on success.

- In addition to a few SELinux mount option parsing fixes, we
simplified the parsing by moving it earlier in the process.  The logic
was that it was unlikely an admin/user would use the new mount API and
not have the policy loaded before passing the SELinux options.

- Properly fixed the LSM/SELinux/SCTP hooks with the addition of the
security_sctp_assoc_established() hook.  This work was done in
conjunction with the netdev folks and should complete the move of the
SCTP labeling from the endpoints to the associations.

- Fixed a variety of sparse warnings caused by changes in the "__rcu"
markings of some core kernel structures.

- Ensure we access the superblock's LSM security blob using the
stacking-safe accessors.

- Added the ability for the kernel to always allow FIOCLEX and
FIONCLEX if the "ioctl_skip_cloexec" policy capability is specified.

- Various constifications improvements, type casting improvements,
additional return value checks, and dead code/parameter removal.

- Documentation fixes.

Please merge.
-Paul

--
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07=
:

 Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220321

for you to fetch changes up to cdbec3ede0b8cb318c36f5cc945b9360329cbd25:

 selinux: shorten the policy capability enum names
   (2022-03-02 11:37:03 -0500)

----------------------------------------------------------------
selinux/stable-5.18 PR 20220321

----------------------------------------------------------------
Casey Schaufler (1):
     LSM: general protection fault in legacy_parse_param

Christian G=C3=B6ttsche (11):
     selinux: check return value of sel_make_avc_files
     selinux: declare path parameters of _genfs_sid const
     selinux: declare name parameter of hash_eval const
     selinux: enclose macro arguments in parenthesis
     selinux: drop cast to same type
     selinux: drop unused parameter of avtab_insert_node
     selinux: do not discard const qualifier in cast
     selinux: simplify cred_init_security
     selinux: drop unused macro
     selinux: drop return statement at end of void functions
     selinux: use correct type for context length

GONG, Ruiqi (1):
     selinux: access superblock_security_struct in LSM blob way

Ondrej Mosnacek (3):
     selinux: parse contexts for mount options early
     security: add sctp_assoc_established hook
     security: implement sctp_assoc_established hook in selinux

Paul Moore (3):
     selinux: fix a type cast problem in cred_init_security()
     selinux: various sparse fixes
     selinux: shorten the policy capability enum names

Richard Haines (1):
     selinux: allow FIOCLEX and FIONCLEX with policy capability

Scott Mayhew (2):
     selinux: Fix selinux_sb_mnt_opts_compat()
     selinux: try to use preparsed sid before calling parse_sid()

Wan Jiabing (1):
     docs: fix 'make htmldocs' warning in SCTP.rst

Documentation/security/SCTP.rst            |  26 ++-
include/linux/lsm_hook_defs.h              |   2 +
include/linux/lsm_hooks.h                  |   5 +
include/linux/security.h                   |   8 +
net/sctp/sm_statefuns.c                    |   8 +-
security/security.c                        |  24 ++-
security/selinux/hooks.c                   | 299 ++++++++++++++------------=
---
security/selinux/ibpkey.c                  |   2 +-
security/selinux/ima.c                     |   4 +-
security/selinux/include/policycap.h       |  21 +-
security/selinux/include/policycap_names.h |   5 +-
security/selinux/include/security.h        |  31 +--
security/selinux/netnode.c                 |   9 +-
security/selinux/netport.c                 |   2 +-
security/selinux/selinuxfs.c               |   4 +-
security/selinux/ss/avtab.c                |   6 +-
security/selinux/ss/conditional.c          |   2 -
security/selinux/ss/ebitmap.c              |   1 -
security/selinux/ss/ebitmap.h              |   6 +-
security/selinux/ss/mls.c                  |   1 -
security/selinux/ss/policydb.c             |   4 +-
security/selinux/ss/services.c             |  10 +-
security/selinux/ss/sidtab.c               |   4 +-
security/selinux/xfrm.c                    |   2 +-
24 files changed, 255 insertions(+), 231 deletions(-)

--=20
paul-moore.com
