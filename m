Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375EC06513
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689C321882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UEnYH3jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCVZp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:25:45 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:39816
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726988AbfGCVZp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189144; bh=Pde3iHPa0yx8AIgjuwjqruyKzPtj4PyPwRJUa2Mkbu4=; h=From:To:Cc:Subject:Date:From:Subject; b=UEnYH3jtZrQYbO7NLVJqs9lh768vaJ+FnUDSOQeTcsUE02q95YjB0Ne8mYSLhet3By/8ODJ8RscekebYOcoPs/aapbi83yZAs6SUybD+ob0lcqtRdBwy2K5Uu8u2DCJO87tl/CroigHe7Yknlw2B0txL/9b8AhKu0oYiEO7hm3Ld8kiEJK8qjCTHZK05W/DES23QShg35Tq/PPitJg3JG7pVk95EqSewvqH+4R6xoujhYbJcOGd1xfGEOkVZpzQCI5nQUrqU+1DvytGiObwU4ES7XLiJb1gX3aHrPKbHJpPgVG0zU6gOY7P+AfR3X2g3gtE0qnVuA2BhJHg4j2hQrg==
X-YMail-OSG: yDB5q_sVM1nahhetukeNX0Uz2U5ibQKcVgiA4IjItmQFGeNDEfRi2noOlN4ExjQ
 U_SGiP9dyXKJDAtDLb3oJTLJF0iE_lxFVo6D3VXeOKNeRB7xNDj5GdyxNDhilZx1QjIo_kbih1fg
 3QJxA.s3H8Fqe9BazX2zlCG4ihFynxyDjFAO6y1ykLxssSjm_xTtFgbg1l5nm1h3vqr_wiwTMa..
 9_ymMnaGsehHRESt7C4Qs24x73NA6KRLdUvRFMw5ZsOXO_FpSmYePLBQX7unze46lsM2uFxJfXPz
 p08NXiJj21.54ZZPik1bRtibn6UT9MEpLXpucx2Bj7blTn2N16MUs.fHIB1larmzfJYtiSQCkX95
 t_f60t3HWXZMInAAmH2kvysTaq8Du.ySJTQ43g08gc0otkRqz6RCxga9iIpBhOogrydsJ0ZNPz7B
 mSQyY_QZzGfVwlCZqWOq5hBikX.iZA.gmGph_.r6c2DqLnutXXwIGIP4OInaaEALzeTiC9ZfzOQl
 _G8t2WQ7jSGGbL3wXdckWxEjFG0x3FjbcUjQYK4ZwS4O6rD8KropsXhdspkTIYj2yrJ1udVgrrf0
 FW27QemmwHtGlvjHYkSmbgDSji10HhhK0dMhPhVpqqDWGfY9EtiOQhJHn0LaKtObjMluvuL_0hGd
 GFvlyXpm4mUD51khquysm2pyl2iUNRmqkLRnSLqQoqCxqr_Gp.tcLGTInHD8MDPePxYX7rWeKWKa
 rHxOKZZO0_NpR0J4HE1VTqvzKHYRUFBmShS2ci2gKYfw2klc1NhXRvY1BAMPC1ocaznjb5RcWPAJ
 QkKpnrDk8N7GYw5Vkn_tOwjM46zaO2XW9YhEns1Wm_OHgr3.RZ8Csb.qt4isePZxfRnENn_E80YJ
 MQBrpZ_EIHXpDP_4gi08ZXgOv1VI9IY3tAazq6Kb9YGjuYUCFEPijVjpez9.xJJDjuFEESE_jj.O
 vmOuSX0b1Uhq0AghKxSJNICWxsb9WvHM4B9zvRDfZp20bIpYjdNl8bnnwvzE0f5lP6rUZKWbq9wI
 KCsCTzNucoor5Hy2CJgOnmw43chYyw8xBqyZzuJZWMT1M4sCqOij1rQxeQovzjq6z7naNQGszIga
 K0TK7tw__MPRt7Jzq.3tZ5pVYTnjO0WO4vFBQfVOWL6BgX3zB9xVR8l.KkQJaixyzEBIPsqgY3w6
 uVCChfK.QXk2LqvYy7BSMRkjDPa0iN_9xc.IPWwR3bdI75lTLlSGZaxHZPDg_Z6Ai8JAbPZfYA5s
 QRsJTQP1JeLkN2zjDt1N9zQS6HyX7..6kSwvWVsIiJ5GxLmZbk3MaJC1D521PGEK549c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 3 Jul 2019 21:25:44 +0000
Received: by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 65d8826dfc020e8c34ff6376721f657c;
          Wed, 03 Jul 2019 21:25:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 00/23] LSM: Module stacking for AppArmor
Date:   Wed,  3 Jul 2019 14:25:15 -0700
Message-Id: <20190703212538.7383-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v5: Incorporate feedback from v4
    - Initialize the lsmcontext in security_secid_to_secctx()
    - Clear the lsmcontext in all security_release_secctx() cases
    - Don't use the "display" on strictly internal context
      interfaces.
    - The SELinux binder hooks check for cases where the context
      "display" isn't compatible with SELinux.

v4: Incorporate feedback from v3
    - Mark new lsm_<blob>_alloc functions static
    - Replace the lsm and slot fields of the security_hook_list
      with a pointer to a LSM allocated lsm_id structure. The
      LSM identifies if it needs a slot explicitly. Use the
      lsm_id rather than make security_add_hooks return the
      slot value.
    - Validate slot values used in security.c
    - Reworked the "display" process attribute handling so that
      it works right and doesn't use goofy list processing.
    - fix display value check in dentry_init_security
    - Replace audit_log of secids with '?' instead of deleting
      the audit log

v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patches 0001-0003 complete the process of moving management
of security blobs that might be shared from the individual
modules to the infrastructure.

Patches 0004-0014 replace system use of a "secid" with
a structure "lsmblob" containing information from the
security modules to be held and reused later. At this
point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the
kernel that used secids. A "slot" is allocated when
a security module requests one.
The infrastructure is changed to use the slot number
to pass the correct secid to or from the security module
hooks.

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

Patches 0017-0020 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 0021.

Finally, with all interference on the AppArmor hooks
removed, Patch 0022 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

Patch 0023 adds checks to the SELinux binder hooks
which verify that if either "display" used is SELinux
both are.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". Better benchmarks are in the
works.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v5-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  24 +-
 fs/kernfs/dir.c                         |   5 +-
 fs/kernfs/inode.c                       |  35 +--
 fs/kernfs/kernfs-internal.h             |   3 +-
 fs/nfs/nfs4proc.c                       |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  28 +-
 include/linux/security.h                | 169 +++++++++---
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  34 +--
 kernel/audit.h                          |   5 +-
 kernel/auditfilter.c                    |   9 +-
 kernel/auditsc.c                        |  83 +++---
 kernel/cred.c                           |  12 +-
 net/ipv4/cipso_ipv4.c                   |   6 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 +-
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |   5 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  95 ++++---
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 |  65 ++---
 security/commoncap.c                    |   7 +-
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  36 +--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/loadpin/loadpin.c              |   8 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 445 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                | 201 ++++++++-------
 security/selinux/include/objsec.h       |  18 ++
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   7 +-
 security/smack/smack.h                  |  19 ++
 security/smack/smack_lsm.c              | 156 ++++++-----
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 security/tomoyo/tomoyo.c                |   8 +-
 security/yama/yama_lsm.c                |   7 +-
 53 files changed, 1167 insertions(+), 614 deletions(-)
