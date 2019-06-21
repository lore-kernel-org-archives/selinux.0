Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A476C43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EA6205C9
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WIMzZIJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFUSwk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:52:40 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:43308
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfFUSwk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143158; bh=4ZQDO6rk1sXjQRA6SsNm0KiWT3YoBT8rHsDVxNCXFAA=; h=From:To:Cc:Subject:Date:From:Subject; b=WIMzZIJItKzvL7TGEOBK13dGqHWG7MB7cypB4rUip/lkXHNODT34VZwvZmE4UoOJ+00I7YzSE2MaghI91RYsRQ770qlFb/khin5SQmKfwgKfKopIO//nwgTKB1JAUhAF2mbvX9QOO0baUEptYyM3tKOtAl/Wh/rCYynjo3Eqilvy9Ro7TrxlTqwcGXoOCxrwBElNAm79vbGv03M/URnlS9jyRh24963xUg2IhyimYkmbcMZ4Hkh0P4GToiwmJ3oMv/8vi0MSx1KNibfqKEBCFM5uy5ZgAex1HqJvnubM5UdE5XL3H/qjesVn+Q0gpxTOONMN9XsY4GyKHXoBeUvzYw==
X-YMail-OSG: z4pJv78VM1kn0g8bFwILUjJcZUSZeNa7d7DPs7iCCXqRQigwyB3RH4.OawVjeuZ
 AIhKRqInROAA_Uod_mKWPJJeo5mAWNXMvTT4w1PRuX5Id2hWvQwEF.JQZSRSO6leoYmQleu8BHqt
 R52783jcw8UAQlhwdOAiySroxfpkRqYMK0ztP4TQAwjEYI1ZNl.DiQ9YrEebxkbd87YFcz7RzdA9
 i2MT78KBkdgZlE_HV8a2NhMaGOxMCM7fZtvd261VO1X.u9rWUBzWPcA0xHyPgieopZrMkFdh86Qe
 CTn5QsXmgk7jIPHf5JRDu94QFsRyMzfkX6zNriJT8hfIDgggKG1f8PVrtI0sJw4Q9rnFxxRACRzq
 AuTtaYAvhOIAApb7f0FXa34gIZYaKARm4dhUyTegPSoka1CtvHZ0NiWBv9gKnpvusE9y2fyzs_Hh
 0LZWE9kb62vQlAir2dlg8mrgWh.Vn2.Zl65BNQLYv0Fdouj5Xiek.BRAXULvKmQtzJdYYMfbn4rL
 PA3HwHxn0xWkgiU4Xc.BRzMAxUz7HvBIbs7iuKRAJ9QdBD8xggXLIYyfNVWJ4eON842bPbznNUvv
 Irm5hR7W5NWXg3pQtTW1xPs8KvgQ2y9QplD4EaY15kXtotOWiLXOnNR0zD5M6lbuyOOsJKkPBTu0
 cM0cpR9_pawXQ3xRoKSM7wSu4QifrU.7ZAKi.FvbCChjIN0KPMyVwAELiQ7DYLwPx2eitqWHvPqt
 cU.pt46ttQxZjOMAb77RhpwPCjtj9.cTYYn9r5hVl9nxj6c_Z5GPnc293S6BGHUvy_..Bx2Mj9rG
 rqyQWw10pkSXIBubcPzbQ2lV.rM0TC.gutr.ie9oKmpq.b0qIRK.9VxDKUL7EzOKZc23OySbGRmE
 2_167.dj7eKjUCHHhH6iJlK1_misgtzcK3s5Z76fzQYV0cwHqaRX3WIdz4SFT2Dv7aqLoem0TRTh
 XmWlXHiDWwEnbB9nvra9KJ5BBrUJ9NDII7TyhxSRnQlbPLVfn9MydXcTjEOWkH74.e.ys.2mFCK4
 y0CLK19iFTbbvfYTvO27de2UvCRehZXvHTraq_rOcQhWK_e82tjrUb5GngBO3Q31SSKNjWCnnCvt
 EowWmnKmgM9_nz3AzGfBV326Nw8krxwe0ryNbjlwDeTQj3cJOGkEhiLv29wbt6T1FyOG2AdlPkgK
 0v4HAaal0WifxnFCjhz2OYydS_F2oqt.ZeTeVSOZr8HAxrKi9iecPYQtGhEFJFm.48Cn1pbiU7MH
 6d58wB4JJndBCTTjdFH_x.gWB7MrcECJ46pdyJoOQhXjBtGQM3Iz3JO4Mag--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Jun 2019 18:52:38 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 122e533cfde98c3a149e6bf82aad3f9b;
          Fri, 21 Jun 2019 18:52:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 00/24] LSM: Module stacking for AppArmor
Date:   Fri, 21 Jun 2019 11:52:09 -0700
Message-Id: <20190621185233.6766-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patches 0001-0003 complete the process of moving managment
of security blobs that might be shared from the individual
modules to the infrastructure.

Patches 0004-0014 replace system use of a "secid" with
a structure "lsmblob" containing information from the
security modules to be held and reused later. At this
point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the
kernel that used secids. A "slot" is allocated when
a security module registers a hook for one of the interfaces
that uses a secid or a security context. The infrastructure
is changed to use the slot number to pass the correct
secid to or from the security module hooks.

It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 0015 provides a mechanism for a process to
identify which security module's hooks should be used
when displaying or converting a security context string.
A new interface /proc/.../attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob.

Patch 0016 Starts the process of changing how a security
context is represented. Since it is possible for a
security context to have been generated by more than one
security module it is now necessary to note which module
created a security context so that the correct "release"
hook can be called. There are several places where the
module that created a security context cannot be inferred.

This is achieved by introducing a "lsmcontext" structure
which contains the context string, its length and the
"slot" number of the security module that created it.
The security_release_secctx() interface is changed,
replacing the (string,len) pointer pair with a lsmcontext
pointer.

Patches 0012-0021 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

Patch 0022 provides a simple way for a security module
to know its "slot" number. The security_add_hooks()
initialization function returns the slot number, and the
security module need but stash the value for later use,
as is required by the Netlabel subsystem. The Netlabel
code is converted to save lsmblob structures instead
of secids in Patch 0023.

Finally, with all interference on the AppArmor hooks
removed, Patch 0024 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". Better benchmarks are in the
works.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v3-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  24 +-
 fs/kernfs/dir.c                         |   5 +-
 fs/kernfs/inode.c                       |  35 ++-
 fs/kernfs/kernfs-internal.h             |   3 +-
 fs/nfs/nfs4proc.c                       |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |   8 +-
 include/linux/security.h                | 165 ++++++++++---
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  34 +--
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   6 +-
 kernel/auditsc.c                        |  79 +++----
 kernel/cred.c                           |  12 +-
 net/ipv4/cipso_ipv4.c                   |   6 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 ++-
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |   5 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  95 ++++----
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 |  66 ++----
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  36 +--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/security.c                     | 396 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                | 164 ++++++-------
 security/selinux/include/objsec.h       |  18 ++
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   7 +-
 security/smack/smack.h                  |  19 ++
 security/smack/smack_lsm.c              | 154 ++++++-------
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 48 files changed, 1017 insertions(+), 612 deletions(-)
