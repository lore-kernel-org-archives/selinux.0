Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564AEC35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BDB2087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Yj0sApEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAXAXN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:23:13 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:39397
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729144AbgAXAXN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825391; bh=hNBPIXj0tBq97FpsCUdrG5AtpxjbbdPtjjd7Q38grys=; h=From:To:Cc:Subject:Date:References:From:Subject; b=Yj0sApEBDZBeZtGomBuj0LkvfQXRlrAL1KjEvLpbtdW7dvPxbFbhv76498AjyoAoNGTlFdLw7EY1vASVSplGAhVZs5eUkJ28+mG1ruxrp33rmt+q9v6D6GZFR9f9wzkRdlFWwxRHtfMeWuhGpGKFChnnaEKY/ohFNbXVZ7XnTF3rekKVDt3yirHLvzWOJz1CDq2Q3hAfEf6UBQudcmSdzDp+K73BQB9HjngRjlS+syV87HNYG51FlZnW+PLRol2LQ5MLbkZ5jaUHxL9T+0jYFb7KP7xDX4aIMSGOr9UH91jbdlouLd40ZgFyN7g0ObbERpke507DWhOxxS+ny7H/IA==
X-YMail-OSG: 0_DOLS0VM1mo_tlNFR_cJklgMRhP6Ub.LjSOnJW5vcafsBPySreWbcbooW.ARY_
 ZroqrFEbjirBCD0wX6IzURBjOwF6Rc6YrZCPeKukYlZkDhtcDrG0U2_OCzSNDSKZjmq72_CUflmq
 pfshp163wFpTCqNpRku53GFW9BDKrfZgFzmsyPdzfVhF5HPYvqBg_.2Gnx5_U63PBvmMxkd7TVnC
 geaOSNDWdsrGOgRTAc9HgBZtOa1TqLQrV1tbDdAPFuiUvX7_sYdZXbgoexGJ07ghiYjPOELrgFns
 ogRCrmRiWJ2_GgQTYSCGNql2ksW51J9eOPp_4wpIe_kgyQZsTQnhSKngx7XLheXPuGbadAdDNzej
 c2Oi8gvPXj1WE4DWorYmny8GU1.gGZYNNgYlf5tmM9auW5wWVZ98wCvOPHUyxkz_SAZIWvy1bJf.
 29UMNwL3xa5TiuuJ7ox7yavbTakRw31eHC8X7qqiX0rCPNwbPCcH1c7xyBHsDf8SsgyOPN2rwZcZ
 5H994GsBBtKehDjEfBYkvWRy1zZ3vU1zEl44oIdiXtW1RzGws44pQuin0pxgBUSDMf1vjWEy9Ceg
 9GuVGqpRIu2..75vIZr7bbvseY7iT7sRsQvoez7hd.YNxCmzpB5SyFYA0Avj62w0yBgw5KnX_T0k
 s7vN6fSoSbp6H1qNOVW76ED_mZNjK4JYv4mlFWzjuyy7IYH.whijkZaiDUp.3UtfZILIJhNOe65H
 pU2RzanMqrrHR6GYQKchKXEzNJeCHPhV_X1hV1jHZD4GADFmioF_qJK3GAuxV3FT24civitlb0bv
 NaUfnPVcGqPwbkk.i6E.zLziDtEm0TStPuMlHYwVmDVPCJEi154L4kIh1d2NztWzar5zW_zmSfT4
 nbGm0mgWFeI.Aedl7isdz4wS9qI_Y6cKQ0Zs8mxFz_dQpoD4BtZL5y5BgNQu21L6G875gxTIvKDW
 Q0qTPuZrThatnT4zw4h8oWAEL7VbnpK56dZCGeTfkZpk9BSjxPDh__t3LoR.ly90WSr3hgcgYgXz
 TJ622H3v8oY2_LjL6N3dryyj7veMg0cg5aRHFUNYd1BwQQXaXBRoiKldhO04p2xDbkIlUiPjFZZf
 WSET4fMiWoK6iwbAOOjaURX5PvhQp9VqpfQ75v10oRqIfFWLpljqY7F0.ZU2T1OFIIULBkS8wHXV
 BtS935kntGdV4vhnfHzoKzXuJKg6ia9uGZqxJDSV9P5hJBo4_z3GsD_Zber8gseh71Om0LSlQHkg
 LPQqxOjn_GTI5LUI0NWkNobB7w6H4mZItmyNV41oxDBETUhB80Sca4A_5fzvOP7oTaTAmeEDybno
 Y.tEMsQ4e8IGRRSa7P7XwDUPzj5.1knIREHXXoXrJWm6kDC8psP09P.r3RW871IR..ozFG_Ig9ff
 3.V0WhHSrmOrFvF.8mBRGaKGvk8cK.zw0WdoJj2kh7gA__CDFeRR_IufTwkLtJAV6rt9rGrba
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:23:11 +0000
Received: by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f59dd8f80be770f388a0f3ce229ce42;
          Fri, 24 Jan 2020 00:23:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 00/23] LSM: Module stacking for AppArmor
Date:   Thu, 23 Jan 2020 16:22:43 -0800
Message-Id: <20200124002306.3552-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200124002306.3552-1-casey.ref@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.5-rc5-v14

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
