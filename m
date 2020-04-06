Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0014C2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71079206C3
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pRM1h3+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDFUua (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:50:30 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:33187
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgDFUu3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206228; bh=07RxbwAYxdKzaEWFrRtckoqoMx7n8almVlTczK2aHcA=; h=From:To:Cc:Subject:Date:References:From:Subject; b=pRM1h3+xHgu13IRHCyZUUqCH4ujc6o2FtucykmuPt0F2CYRdJOh+FUYT1eYm3J+dXzY5YJ8ClKq6NQzZIINWDDv53o1AeEDgQLkuHo7ckUwwILhw1Lw2PNs1qJ9cavxRnkoFCybWzF2JV+5SnjHJpc56KO5ecn4TDD2CfPXsEqb6KJWHhJIJr0yRta+NzHjQ+gUeJVfjbLlAlg5fxFKZ97CtSzXURBiJzat4NqM7l7HRHN0HwKc3O8AGELKENUkGKnF0G6DZ1GwyUDa69k/F8WGgIoH6GnzV1s0zk9+CR2quYWULFs0XvUB8JrWfjnZWfKdyKTVG98x9JkLRoZ7Z6Q==
X-YMail-OSG: sE.A1isVM1lElWCFY9OqyXeyw0sPRUXCQye0JDZNg5oUwbF23v08f5cJ1bE_Kvp
 ATfC2XceNFNDSRnDaY9Pdhn0K1C3g_1MiVdZafrE6AGPjeE19Wj7ZHDKunjfBxJp62VO3WhadHG5
 aCT5XQWkZIC5mtUUXNlGXWXt6RgH3rEv.HSuCW1xe9OLKAJv_7FZezjrJoN54LFOKHMzwVWYMc_8
 Qwb2keNnH4AsIbt8ltvdjXonVhlgaT0HK_PDt92fBhgbnx19VvkSihSZ9lJm4fkZKMyXAc25H8tE
 eeuyVcVN.oC4WsTJBvHESSG9PNFKJ8K0lZ.3PbrvueRRrd3c81ngJ2bISNuB_._lHtG8KHyeupDk
 pC0kH8LncjvLydil3yPtAf56NITL2v.gjoslAHaUH8J0ycg0wKMbBg4sZ1rioCukkw1O9lEPFeq7
 TGe7kf2G05rbEcU6QghPJmi.JheCcBm05OcAruttC1e6qjSG_Dz8Ewb3ProHjphSRklCWM47zaLH
 cZAS.h9g9JFvIg1ZWJqwBz1Jtc7pL3NEpIP_Z_m10h3xegXfnJ6iD3o_AQNRbiR1KliGdH4t9.9Y
 3FxMs0aL69Evpu4L2Eg_WhTxTIZfxgdzszp0RqIWHZu0q0HfeqHqQ2DNp2.1lndiNx90W_vrFK09
 O5cWB4HfApCkEkEfxnsimHGITPVtShR5pdZHhJ0KyGc0_1FQ_EEX3t6aWUpfQsX_5Y4PnCdFN8eB
 yeGUGrmU7As3P.PRUkeRmJh1e1GFL.ctlHRzLh0bE8Z0BymLtmD1aSK9bIygoBngKjyBCqwFrz9r
 224buOoYYch.y6fmPNLOQkDOwHPi7pbs4_vW0FlOVKeV4PTML.a2DxXJurPtCNOHPJnpEPjvGbhx
 Ap6i5YjzoWqwQBi0lYJ3SmSRCSMaVHQ_5KXOqk4v.NfykVxLvG6oPqHKdmDeSAnLjCZ.FP2rFgOR
 fdF.MefqQORj_quEH2lWeVpmqBVTSpqkwGZpA0cGKOS2nzxO35942kSqwgswakjkp87yeC.sdh63
 V5s0IY_4jXBEyN.Y9pi1ue.3dXumcjBsMvI6k0DQU7sNRzjuqJ4Vpr8DkT.NzzTb1eQvpM9KrR9M
 UuBc1xCjHXW4_0QpiMBwadTCtxGjFBbJD7DcI06O4P602oEWUPywPD_imr0k7HagLULCs_PjG82d
 a8EHhdrZrH0iwrNAukVnRgbASKr3sfDoe5A3t3iknAa1gMFAqVh0xzuvomZcatLJV0hFWAOVSiji
 54TzwFH_W709tSfnF35gf.DFlAlYMfaj2rj.cjKnbCZtQI4nkM9WY5M7DWz5qohaAMKFDdvpKJtV
 cTxWLoQh4d.i0AN63Cgx.OWfldRCKM.GvYLMpyCKZi3GF57s9LQn3w5udGsaoCCcb8qoS0SuAyIh
 O.j7MbkeJBdW4ulTz4aKSg3xKTtWjy9dqT5sgAPeL1DbqosXlj63iCqBcma9zx5U2KNV_I7Pz3Pb
 Ax1GFz5SnoQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:50:28 +0000
Received: by smtp414.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8a3b5f0da64a05ed9960d9fa5b4e2157;
          Mon, 06 Apr 2020 20:50:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 00/23] LSM: Module stacking for AppArmor
Date:   Mon,  6 Apr 2020 13:50:00 -0700
Message-Id: <20200406205023.42338-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200406205023.42338-1-casey.ref@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

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

Patches 0020-0021 add addition audit records
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

https://github.com/cschaufler/lsm-stacking.git#stack-5.6-v16

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
