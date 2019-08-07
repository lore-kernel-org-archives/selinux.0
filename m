Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9587BC433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A75217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tRCLYz2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfHGWmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:42:55 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:39334
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730561AbfHGWmy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217773; bh=wKMBaKflYkENEJsBVX1qSUry36vkc1gZV3dLcIF7/m4=; h=From:To:Cc:Subject:Date:From:Subject; b=tRCLYz2kgoouoiD8+ZkV2A8zfaWxwyvlx5TGdJUBQmG5UtHoXRBXl1i4x3OaPp5OlndCXepg3bOe3uYlqb9hoHSBqTu92Ij/cLw1qxcc9iPjx9MIYNWz4dRpe9XBtSnhJp1UcJaIG0qt/pEIwoSqxTjZEvD5X0I9MPrwRCI/l2V2syfKuq2Sa17q8VyleXlqp1/tInqPs+Zdej1XOW8Rq7xSQ5FuTA+9JMQ/C/k3NOsvImSIuCs4jXsVszmI/mRXfCuTFW86M3wBswhM2uKNwwtPTckk1ykhrS4/uQVQ/lYJLgwi9ljd+4g2bNe4dHX4sDHiUrAbFZSP+JBQNAZrUQ==
X-YMail-OSG: m4N_PzQVM1nNNMsV3DkCcPupi6cwBzpNH8RnRyB2Hly9QpUaaBOScTGw90YvJiB
 XyFFmvgfNHdV8ixnWZYHekzKpqtx3qq8GjcXWeGMUYdOSOjqcpIkB6DKz.Gda1ErnXrljh_A5mLi
 iw.TpDMN7QtcIerYaBOmYK2FpC3Z4attLSgPiuoFpMOD_SFVpbG.KUppouKACq3J.9y1VnIfR.Kn
 LZuOKqwredRgfaD2mbZCMAFneQw981Zf.n9qUIj7hYlBnJB96IZ7k7MFOPYAiX5pNM9ArIyv0l7A
 xMkSHaxoJrJeWD.7vb8ju8vw46FA6PMcKOlAnjFZjgdzwNVY94NsItXYCxGOacS7cNVL6_xPLxJs
 D2zWQd8ueZWBSoazRIdlG9j2wG_90SW2lDpJMTk88QZoh.8XKOrCxXjNLu9Id3OcMZ6iexAgq0xm
 dHrefFloVKAC_l047m57SxymlZNz88WOGuw6q6Vmdh6gSS98PygwK7rT05ut7vwSS0W08dCNEFPx
 QJW3edDI1OzA5NXnwZjZyY5RZAsplIhkAhSaIOcaBiJ3Ox5hV7qdY9k.RzGWk2zgo6C3nvY7QIRS
 6UvqWXbcAE4Fp4NaM8TGNUNDLrR0rzsWtP92i26a2I7QNZ6nrKRS2Wns.KaPlMeQRTuz0KeYBYkL
 VOZHcc8dkoXZTWCZtnHZ5LUito4dDm1xScOAYtBmOTsOCho3l2EFTCoKFKiHwwIjjGL91N1P3L.r
 dO0jLKusiUqF8hckffmd7dzc.7Wf9xHPa8tYeBg0mWDlWmNXyIQfGZuWKl1xX8ym1zD3VRVMhtbQ
 R1dyIvdNOLZ4Mmm3kmnJt1GRBvl7cTdOnkg1.yzPS.vZgSuYCXX._pJG0Rlko6hCUbOoo5st5cCY
 UPS_v.zh2QacRjRuiM5wOiXuRaDGShpmspnM3q5gS7QJ.GtPqeQ4o2PD4YZr8hVXp3YcYejVb7SL
 I._2sN1s7IZUL5AhcRQY_C3VRY6DSmPm0DrV_kS6JVtCRQed4RrwmEdxpEVAE_IChYWytOUgDqGA
 vSaeghPai4SkLDZ2F5Y4n5QQkRDoX7d2j3ztZOBX3rdWcmVXyZjs4Us_BIhYUjsHZNPVLCyC060o
 MyI3PLMNiZoZz_z4kbASS5DlY0uIRhqCQ1NlaW3dL1lo.9hWbqmtouU4Oyri5Gn3ojsVcppbkleN
 3NDh76SvhrvY7NAcwNVptoLXHBa_W9IfC4lTKKmy8xXjdwFK57M36lfKyH2x_V3VCkfBclPuNB8a
 zEluK0Gzh8m4kKKg3upWoLSAPZX27CXBOD0X0rHOsbUmBBiLeN5_2aaKYY77WEvB2Rj1mTw6KzRL
 3bv7_18xrjOOtOZ9GeUDWtJ4ie3j6diCm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:42:53 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 824faaf1f4a5ffbf9b87c6192a4b2124;
          Wed, 07 Aug 2019 22:42:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 00/16] LSM: Full module stacking
Date:   Wed,  7 Aug 2019 15:42:28 -0700
Message-Id: <20190807224245.10798-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide mechanisms for security modules that use network interfaces
to operate on the same system safely. Provide mechanisms for kerfs
to maintain information about all the security modules active on
a system. With these mechanisms in place, any combination of
existing security modules can be used. 

It is not clear that all issues with the integrity calls have
been addressed. Any review there would be much appreciated.
There should be a mechanism in netfilter to identify which
security module a given rule is associated with, but none is
proposed here. Instead, the module first registered is given
the secmark. Labeled NFS is an incomplete implementation,
missing the "LFS" data needed to identify the format of the
labels passed. The first registered assumption is made here
as well. The Netlabel restriction that all sent attributes must
be agreeable to all modules is reasonable. The implementation
is awkward, and insights into improvement would be most welcome.

It is important to be aware that while the mechanisms have
been made cohabitational, there is no guarantee that the policies
imposed by the security modules will be compatible. The handling
of unlabeled IP packets using Netlabel is very different in
SELinux and Smack. The use of capabilities is also very different
in those modules.

This has been tested on Fedora29 and Ubuntu19.04 using
unmodified policies. The SELinux test suite demonstrates
policy conflict issues when used with Smack.

Patches 0001-0002 change the secmark_refcount LSM interfaces
to call only the first registered security module's hooks.
Smack is modified to use these interfaces to determine if the
Internet Protocol secmark is meaningful to Smack.

Patches 0003 and 0009 refactor security_inode_init_security() to
accomodate integrity checking on multiple active security
attributes.

Patch 0004 updates security_inode_listsecurity() to provide
multiple security attributes instead of just one.

Patches 0005-0007 address NFS and kernfs. Labeled nfs has no
mechanism to identify what kind of label (e.g. CIPSO or Flask)
that is being sent across the wire, so an arbitrary choice must
be made on how NFS labels are handled. The module in lsmslot 0
is always used. Kernfs uses context strings to store security
attributes, so those are now saved in the "compound" format.

Patch 0008 provides infrastructure management of mount
option data.

Patch 0010 addresses the case where one security module may fail
to provide a valid secid on datagrams where another succeeds.

Patches 0011-0015 allow the LSM infrastructure to check whether
the security modules agree on network security attributes when
netlabel is being used.

Patch 0016 removes the exclusive flag from Smack.

A note on the "v7" designation: This depends on the stack-5.2-v7-apparmor
patches provided earlier. Since that is "v7" I've used the same number
here in the hopes that it will reduce confusion.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v7-full

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c                   |   3 +-
 fs/nfs/inode.c                      |   9 +-
 fs/nfsd/nfs4proc.c                  |   6 +-
 fs/nfsd/vfs.c                       |   5 +-
 include/linux/lsm_hooks.h           |  23 +-
 include/linux/security.h            |  30 ++-
 include/net/netlabel.h              |   8 +
 net/ipv4/ip_sockglue.c              |   4 +-
 net/netlabel/netlabel_kapi.c        | 120 ++++++++---
 security/security.c                 | 419 +++++++++++++++++++++++++++---------
 security/selinux/hooks.c            |  54 +++--
 security/selinux/include/netlabel.h |   7 +
 security/selinux/include/objsec.h   |   1 +
 security/selinux/netlabel.c         |  46 ++--
 security/smack/smack.h              |  17 ++
 security/smack/smack_lsm.c          | 128 +++++++----
 security/smack/smack_netfilter.c    |  45 +++-
 17 files changed, 689 insertions(+), 236 deletions(-)
