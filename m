Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F0C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00842222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fZ8lp1TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgBNXmK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:42:10 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:44388
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgBNXmK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723728; bh=qhvqF6Jn+QOAUnOLxEZbn7Blt9ezJQXRBkS262eUScM=; h=From:To:Cc:Subject:Date:References:From:Subject; b=fZ8lp1TMmN8fTm0NRPQm/gMbiOPBxzY3jgBT+6pw6+a+sWc5xcgFXBCE3NaLJwFwODDjuEAiq+JvE8WSjtAn9uXWEJiN1vX8pb1/Aw3Nqrs876dp4E8iAHXEYdv7coRSsK84jslhvoljx2utt7vw3GYmJixH0m932D0lSkipBzrCtPdm/hjV0AuZx/uyuSM94bXeSABIpgW3Zekz63k9CMOgZrSnIt66ckgVQpHJahbYveQVXYKEb3wNQdXbhPweEPjfN/952j428uVS9nNLWdxePwcMagHS9yCLuOIc/nbtPhKuBjtmIjqK9kSiWS91dVF843zTAu5H46D4G53XLQ==
X-YMail-OSG: 4k5rzw4VM1kcLri2LxtU28ysOvWjG8xCebopa6LXmKsGkGM075HCzqJIsQdaGBO
 Fug587oeY8OXvxCwdWbbh3TwxoBkV0vvy77uLvIKVgDMbXZLEoJ1OAvZpmswBOAxZYljeFEeepFJ
 PXvfzDfCAXeDeXVl.EFqLqxEd7Y.5oIbgGTU5lXYlReteB38tC.fykcIkYysM6_0XfjLFGbKjtEx
 bvBCXDtCq6kAuLiZ800t3K7wQ9J9zenL5WtCtpcys5q.Kv5HfRWLKBnofpPfAMCHYx6JXTCXna..
 DJ50Nyg6mWVInsK1I.IMqOKaD_I.C1Gtobub.SnQZiOYHMuiVMZHeeVU8ZDO_GAqMiecU1ySxzbm
 _IUedDOxtHCtxaj32KzIehbYw_jz80gabHcqdqrw1COcSUY.zTUr5QLdTcf2Vkl1Ri4v6qbAWKV1
 xXJWnr8pI89cWi2FU_IsLbvKsUbYv2JH07e_LRA_Ud5c.4f.He44zSoUUnIUWsmxOmYs9u_kbEse
 Z1EIyiacy7tJzxOTmw5lYgzqd4ZK1xC0HUsqyUFPb1DTFiRTbqC9PUQ9EqnA7FSFm7dfPelcCr.d
 biWn6Z5O0HRJ7XpBK7T_nwu8BpCLOZax9Ub7gTsxPDJWaLBYvImkoROQKbGF7tNtg2BgfzGlmVpj
 cL6IHe6_jFItwTlYLUX2Nedz3OIqImWGu7Xal1iSANZ4CwiZw5o2q6SZtmTVHFLZRzX_A2B0JoDZ
 0yAyy6zp_uiYDxNW4EocELI8ASsZEq84kS0aXRSfalxdB9uGQJc_4NwslermYFgNvv7VJ6geopCj
 O2CQFbTezTE.RyIAL3LL8Qu0VY7AunUzkvN13s3U48wVRNcMTjoI2EAkv4LHAHH1NovpCA26iGcy
 1Ou6x076aMOc630wVXnx0lwD_w7fBzHqklRKKXBpbU7fhFtwcUEatT6okltXYuYF88Dpvf_Oie3R
 qWak0c22XIRNgqD0WHBJI1L5q_BbefoAq7U0O2gPYqi2WGjFqNZV31YF3lKDQsyZspityADfyU2V
 l0pdqWNbqRUtsbZQ7WT883lKl1kcRf.HTuWUzWsfNtcV6ANelXzMYWIpCz641YsJLOt345OY4.k8
 Cz.1zrSXfyED79_a8YGSZ9JHkLdOk7hebVimRXRpuaL_SuvR7Nova8_uz8tBiTSP9dye4.6tYEb.
 qlxf2WTVPMu0JiPOSvNtylqlAGBwWcba9ufDlDtURQifpM_pEJGNkmZYrAqTeeeTj2fEi7j1jFqd
 7au3pGiKWJwAgphf7h_IPgDwhh4qiU9sEaN0zzLb6mThQ0TijRSamcJjsezTU5HF_NnCWZZxJAgd
 q5hMRmQ7gQIf9935tG5SWo5wUjzc7kO51AEUgbLm3PvjqTjjDaxPs9XfWBxWhaqr039HiV0sdw3w
 9pK.tbxxaWzsyRf55OjAFqZ4GK09kqFy70As9wbE0.sq8ZpeKSL9ug6Vqi26GxD4afyNNYEr02Wm
 _fG7tKaM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:42:08 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4657fbe77e4c20ee04927285b6183fa3;
          Fri, 14 Feb 2020 23:42:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 00/23] LSM: Module stacking for AppArmor
Date:   Fri, 14 Feb 2020 15:41:40 -0800
Message-Id: <20200214234203.7086-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200214234203.7086-1-casey.ref@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v15: Rebase to 5.6-rc1
     - Revise IMA data use (patch 0002)
     Incorporate feedback from v14
     - Fix lockdown module registration naming (patch 0002)
     - Revise how /proc/self/attr/context is gathered. (patch 0022)
     - Revise access modes on /proc/self/attr/context. (patch 0022)
     - Revise documentation on LSM external interfaces. (patch 0022)

v14: Rebase to 5.5-rc5
     Incorporate feedback from v13
     - Use an array of audit rules (patch 0002)
     - Significant change, removed Acks (patch 0002)
     - Remove unneeded include (patch 0013)
     - Use context.len correctly (patch 0015)
     - Reorder code to be more sensible (patch 0016)
     - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)

v13: Rebase to 5.5-rc2
     Incorporate feedback from v12
     - Print lsmblob size with %z (Patch 0002)
     - Convert lockdown LSM initialization. (Patch 0002)
     - Restore error check in nft_secmark_compute_secid (Patch 0006)
     - Correct blob scaffolding in ima_must_appraise() (Patch 0009)
     - Make security_setprocattr() clearer (Patch 0013)
     - Use lsm_task_display more widely (Patch 0013)
     - Use passed size in lsmcontext_init() (Patch 0014)
     - Don't add a smack_release_secctx() hook (Patch 0014)
     - Don't print warning in security_release_secctx() (Patch 0014)
     - Don't duplicate the label in nfs4_label_init_security() (Patch 0016)
     - Remove reviewed-by as code has significant change (Patch 0016)
     - Send the entire lsmblob for Tag 6 (Patch 0019)
     - Fix description of socket_getpeersec_stream parameters (Patch 0023)
     - Retain LSMBLOB_FIRST. What was I thinking? (Patch 0023)
     - Add compound context to LSM documentation (Patch 0023)

v12: Rebase to 5.5-rc1
     Fixed a couple of incorrect contractions in the text.

v11: Rebase to 5.4-rc6
     Incorporate feedback from v10
     - Disambiguate reading /proc/.../attr/display by restricting
       all use of the interface to the current process.
     - Fix a merge error in AppArmor's display attribute check

v10: Ask the security modules if the display can be changed.

v9: There is no version 9

v8: Incorporate feedback from v7
    - Minor clean-up in display value management
    - refactor "compound" context creation to use a common
      append_ctx() function.

v7: Incorporate feedback from v6
    - Make setting the display a privileged operation. The
      availability of compound contexts reduces the need for
      setting the display.

v6: Incorporate feedback from v5
    - Add subj_<lsm>= and obj_<lsm>= fields to audit records
    - Add /proc/.../attr/context to get the full context in
      lsmname\0value\0... format as suggested by Simon McVittie
    - Add SO_PEERCONTEXT for getsockopt() to get the full context
      in the same format, also suggested by Simon McVittie.
    - Add /sys/kernel/security/lsm_display_default to provide
      the display default value.

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

Patch 0001 moves management of the sock security blob
from the individual modules to the infrastructure.

Patches 0002-0012 replace system use of a "secid" with
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

Patch 0013 provides a mechanism for a process to
identify which security module's hooks should be used
when displaying or converting a security context string.
A new interface /proc/self/attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob. Setting the
display requires that all modules using the /proc interfaces
allow the transition. The "display" of other processess
can be neither read nor written. All suggested cases
for reading the display of a different process have race
conditions.

Patch 0014 Starts the process of changing how a security
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

Patches 0015-0017 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 0018.

Patch 0019 adds checks to the binder hooks which verify
that if both ends of a transaction use the same "display".

Patches 0020-0021 add addition data to the audit records
to identify the LSM specific data for all active modules.

Patch 0022 adds a new interfaces for getting the
compound security contexts.

Finally, with all interference on the AppArmor hooks
removed, Patch 0023 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". The sockperf and dbench results
are on the order of 0.2% to 0.8% difference, with
better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-5.6-rc1-v15

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/security/lsm.rst          |  22 ++
 drivers/android/binder.c                |  26 +-
 fs/ceph/xattr.c                         |   6 +-
 fs/nfs/nfs4proc.c                       |   8 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   2 +
 include/linux/audit.h                   |   5 +-
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  34 ++-
 include/linux/security.h                | 159 ++++++++--
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  15 +-
 kernel/audit.c                          |  78 +++--
 kernel/audit.h                          |   9 +-
 kernel/audit_fsnotify.c                 |   1 +
 kernel/auditfilter.c                    |  34 ++-
 kernel/auditsc.c                        | 139 +++++----
 kernel/cred.c                           |  12 +-
 net/ipv4/cipso_ipv4.c                   |  23 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 +-
 net/netfilter/nft_meta.c                |  12 +-
 net/netfilter/xt_SECMARK.c              |   5 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  98 +++---
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 net/xfrm/xfrm_policy.c                  |   2 +
 net/xfrm/xfrm_state.c                   |   2 +
 security/apparmor/include/apparmor.h    |   3 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/include/procattr.h    |   2 +-
 security/apparmor/lsm.c                 | 105 ++++---
 security/apparmor/procattr.c            |  22 +-
 security/commoncap.c                    |   7 +-
 security/integrity/ima/ima.h            |  15 +-
 security/integrity/ima/ima_api.c        |  11 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  42 +--
 security/integrity/ima/ima_policy.c     |  53 ++--
 security/integrity/integrity_audit.c    |   1 +
 security/loadpin/loadpin.c              |   8 +-
 security/lockdown/lockdown.c            |   7 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 525 +++++++++++++++++++++++++++++---
 security/selinux/hooks.c                |  99 +++---
 security/selinux/include/classmap.h     |   2 +-
 security/selinux/include/objsec.h       |   5 +
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   4 +-
 security/smack/smack.h                  |   6 +
 security/smack/smack_lsm.c              |  83 ++---
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 security/tomoyo/tomoyo.c                |   8 +-
 security/yama/yama_lsm.c                |   7 +-
 62 files changed, 1350 insertions(+), 556 deletions(-)
