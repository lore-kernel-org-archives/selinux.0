Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56432C433DF
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5B02074F
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SLEw3G++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgJLUTf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:19:35 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:38060
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbgJLUTf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602533972; bh=xqxaB1ahhpjQ2+gNhyX9O8eqGj6X9aW75Qxjivy+fJI=; h=From:To:Cc:Subject:Date:References:From:Subject; b=SLEw3G++FNh0kPjXzuan4LwO2i01vbkRBoDqndEhtmDcPKRhk0s2V6C4C8si9aUSzW+IrZgOxoKIXi8WIRUqCWoPo36Qc0zXW0Qkc33Dotqdi9h1fHLxpp+4mXLPfVg0JRYD0pXQ7i3Iycv2Hsr2sZwJSsXeVzlOsPWcyzmNHZ1yZGA+MprX3d0aWianpgk61kpE5wEL6EwbNxRinPzJLKkkVYwtH2bxrTLlZZxEiudnCPkHpbTlD3dO46Y2Cs9O3AZ8wFBJGCEbGpUnePgG+HF0DMS3Ofk5fPgIvl8g64yAXmiS0ktCnGAf9HtqgqbQMKCefKaJB98w4OhIB8HgFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602533972; bh=1Lf3x05M0fbH4CToqiG9JTLnvr8GDMlR/ict3+/d8xK=; h=From:To:Subject:Date; b=Mvh+XMduX7SwaHkwASWmkWUfLK0CQTAmlyL/dxMyqxMVAydvVIETNmxEUuPKJA+7ZnKahW3Zj4dzETJNSLq1l+w7q9z4PLmZfruVeqXxArA2wbZCz799RUGqQiGf3FY5llXlzy5wXZBT9gBKBHCuJJRsU0NB78qS2o/yAd2WkN6ORo5yVAZrOX84y8FTCXfNI85L1cFMXG8+XoHuHjvwlZEGUBfNufhkRKKK4uq5bvXzxsJDxYsU9QBM9bOJsQ753IxHD/u3kByG+kj58Wj9SrTcTG2Ux9F1emH+/UGdRVULNl8qWc3iLA12x7/koPd9GMBZLkwMU31GG6nOhwKzOQ==
X-YMail-OSG: H8.5ZxsVM1mQbAcayJfB0CeBoTuwhjAGmk.z_Ohp.QTcPF8tggwz0tBgj7FixvB
 A3cXmhbkZHqhsc4qsUf1jRBobqKu9v4oOpR_0vbUCE.6qyy0hLRJSiWIbI_iE38o4UbRW9Lhgh.o
 IKKzEULt1hhmo3TU0kU9HZJKF2NxmUheEI_hczcf7V2o12naGcJjaQNEKK2cy.EXiR.QNBXUYcpN
 1f5sGZ4FVXmKNLVKy_6KyBJhTgJcTyH3_HMuwCpeXC5TEd_TpJF1GKthPs608ZRV93KOt5qd_810
 z4xUsBFro52xrtaGx6BJecMyuFV6DCZegDNpCO1bh93kLkee9n21RN9DZNQMlQCTV0AjruAgjXA5
 VnAIHA5CA0_qBo7Va7Rt.sMeDKRz14Nuxh1FO6ifQFgX8r5ARRkYF9j_ABcJp5VAgpiAZ0uTzokK
 UuzH3__EnY3T9bzX22b1zv1bv4FPPf0foGRuqJPdmCSQaWc3ydKPPH8JWiisjJllq4CiqJ8l0Bwp
 1qToOwA_t7H1B8O_459Kd5oFuRajWTZf4c4a.jj3K2ww.jgxCAJzSGLfHTVd5dp4AKmFgOfCIhag
 U2DNi5PbJ.Bx8PTfwPXa0QJrBq.o9ui67s.PGjEppOvZ_OW7fS4AI623itVnARohs0JXYJXoo4hA
 bswEyfNNyhFjt1sKr49kUV2Afm5XSjYO_8pSqARHBANhIt.Un3V1vtaEZZPKfMBINHnVr23WHyip
 YN34fS6WsEUEBFbn.ZOED_c1yKlHOVc32z_LwORRLMETBxm9nyB6tLnkOt_2hjFddUTSqP8SktFj
 o97seMBiEKGt4jptzWSpDNhJ9FS4Jv1GQXzdVWFpoHd0NKQ8c2G7qPMZQoCWU2FcLEDaD9FNLP03
 dINjxebBku13V9viRvOwUkWdr.ikALAOxmSrXp8WNvh8JxwJs_ytY95zeB6u0ml3Lobrhbu5tE3f
 IAeLNycvG0h1DKhMz7kP_Cn.R9v7TT4DfpB76N9JL8Ju2vCzck94wEgx7m5Iv6yxnDzKb48qqeVA
 4WcLVlTbzVKqxRn2HwfiJrYgXRabqFKVYQZShnmce5QkFRa.VBe9aUhqQLxdUixXcoiE1om5AA36
 44_yZxBTuZaBiNVLqwRSL1RMsZar0G1AAFRvzKQOhsm2PdY6itPxUeIpkkHSul3dBt9Ycn20qipC
 icVhWc9C0BtLSCIa3gFB1.FPZXS1tGQ56rvDdMN1qALUPJlDBXCLvtvneS7GV.7sV1KklzCbRtgy
 fqXwU06FSdwQJoEdzBROqoyd19cT3TxCTB6ia4bz2ff2sqO_KDJjM8vx2yJcEJx.94nY2i2BHZfX
 rKzS_Hukd6e4MQhTBMRxvptVIkTTQ1XJ6dmu5eI90GISNFM1Pf_E1ks.pS2EPhxlD4rAVNFSW.QE
 PFFmE5v_LRyNWaL_kqlYSNrKbU9TXLhCqHpE0UkNrgIbyfOzsbPZNBBYXGPw1ioN48B3HJ4C1k8E
 knbh1E2W2C5LtVOZzwG1LJZqDkV_SyAc9KaP1bwgdWTQzsPDkRyA.LRnadvcEEIusFsHI0Kxlvlu
 hxi2SFzfSrgHSkEgW0ZGdRZE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:19:32 +0000
Received: by smtp414.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 04485177919a3ecad1f74d40d8424cc2;
          Mon, 12 Oct 2020 20:19:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 00/23] LSM: Module stacking for AppArmor
Date:   Mon, 12 Oct 2020 13:19:01 -0700
Message-Id: <20201012201924.71463-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201012201924.71463-1-casey.ref@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v21: Rebase to 5.9-rc4
     Incorporate feedback from v20
     - Further revert UDS SO_PEERSEC to use scaffolding around
       the interfaces that use lsmblobs and store only a single
       secid. The possibility of multiple security modules
       requiring data here is still a future problem.
     - Incorporate Richard Guy Briggs' non-syscall auxiliary
       records patch (patch 0019-0021) in place of my "supplimental"
       records implementation. [I'm not sure I've given proper
       attestation. I will correct as appropriate]
v20: Rebase to 5.9-rc1
     Change the BPF security module to use the lsmblob data. (patch 0002)
     Repair length logic in subject label processing (patch 0015)
     Handle -EINVAL from the empty BPF setprocattr hook (patch 0020)
     Correct length processing in append_ctx() (patch 0022)
v19: Rebase to 5.8-rc6
     Incorporate feedback from v18
     - Revert UDS SO_PEERSEC implementation to use lsmblobs
       directly, rather than allocating as needed. The correct
       treatment of out-of-memory conditions in the later case
       is difficult to define. (patch 0005)
     - Use a size_t in append_ctx() (patch 0021)
     - Fix a memory leak when creating compound contexts. (patch 0021)
     Fix build error when CONFIG_SECURITY isn't set (patch 0013)
     Fix build error when CONFIG_SECURITY isn't set (patch 0020)
     Fix build error when CONFIG_SECURITY isn't set (patch 0021)

v18: Rebase to 5.8-rc3
     Incorporate feedback from v17
     - Null pointer checking in UDS (patch 0005)
     Match changes in IMA code (patch 0012)
     Fix the behavior of LSM context supplimental audit
     records so that there's always exactly one when it's
     appropriate for there to be one. This is a substantial
     change that requires extention of the audit_context beyond
     syscall events. (patch 0020)

v17: Rebase to 5.7-rc4

v16: Rebase to 5.6
     Incorporate feedback from v15 - Thanks Stephen, Mimi and Paul
     - Generally improve commit messages WRT scaffolding
     - Comment ima_lsm_isset() (patch 0002)
     - Some question may remain on IMA warning (patch 0002)
     - Mark lsm_slot as __lsm_ro_after_init not __init_data (patch 0002)
     - Change name of lsmblob variable in ima_match_rules() (patch 0003)
     - Instead of putting a struct lsmblob into the unix_skb_parms
       structure put a pointer to an allocated instance. There is
       currently only space for 5 u32's in unix_skb_parms and it is
       likely to get even tighter. Fortunately, the lifecycle
       management of the allocated lsmblob is simple. (patch 0005)
     - Dropped Acks due to the above change (patch 0005)
     - Improved commentary on secmark labeling scaffolding. (patch 0006)
     - Reduced secmark related labeling scaffolding. (patch 0006)
     - Replace use of the zeroth entry of an lsmblob in scaffolding
       with a function lsmblob_value() to hopefully make it less
       obscure. (patch 0006)
     - Convert security_secmark_relabel_packet to use lsmblob as
       this reduces much of the most contentious scaffolding. (patch 0006)
     - Dropped Acks due to the above change (patch 0006)
     - Added BUILD_BUG_ON() for CIPSO tag 6. (patch 0018)
     - Reworked audit subject information. Instead of adding fields in
       the middle of existing records add a new record to the event. When
       a separate record is required use subj="?". (patch 0020)
     - Dropped Acks due to the above change (patch 0020)
     - Reworked audit object information. Instead of adding fields in
       the middle of existing records add a new record to the event. When
       a separate record is required use obj="?". (patch 0021)
     - Dropped Acks due to the above change (patch 0021)
     - Enhanced documentation (patch 0022)
     - Removed unnecessary error code check in security_getprocattr()
       (patch 0021)

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

Patches 0002-0011 replace system use of a "secid" with
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

Patch 0012 provides a mechanism for a process to
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

Patch 0013 Starts the process of changing how a security
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

Patches 0014-0016 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 0017. This is not strictly
necessary as there can only be one security module that
uses Netlabel at this point. Using a lsmblob is much
cleaner, as the interfaces that use the data have all
been converted.

Patch 0018 adds checks to the binder hooks which verify
that both ends of a transaction use the same "display".

Patches 0019-0021 add addition audit records for subject
and object LSM data when there are multiple security modules
with such data. The AUDIT_MAC_TASK_CONTEXTS record is
used in conjuction with a "subj=?" field to identify the
subject data. The AUDIT_MAC_OBJ_CONTEXTS record is used in
conjuction with a "obj=?" field to identify the object data.
The AUDIT_MAC_TASK_CONTEXTS record identifies the security
module with the data: "subj_selinux=xyz_t subj_apparmor=abc".
The AUDIT_MAC_OBJ_CONTEXTS record identifies the security
module with the data: "obj_selinux=xyz_t obj_apparmor=abc".
While AUDIT_MAC_TASK_CONTEXTS records will always contain
an entry for each possible security modules, AUDIT_MAC_OBJ_CONTEXTS
records will only contain entries for security modules for
which the object in question has data.

An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=UNKNOWN[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor==unconfined
    subj_smack=_

An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=UNKNOWN[1421] 
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

Patch 0022 adds a new interface for getting the
compound security contexts, /proc/self/attr/context.
An example of the content of this file is:

    selinux\0one_u:one_r:one_t:s0-s0:c0.c1023\0apparmor\0unconfined\0

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.9-rc4-v21

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
