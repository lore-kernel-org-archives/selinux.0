Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F4CC55178
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D050020825
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V7Ag5C2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbgKDXmp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:45 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45881
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732865AbgKDXmo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 18:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604533361; bh=TLzmnef1shGNdKxW2HuAZYuoA/LXmsS9GPz9FvrJ3k0=; h=From:To:Cc:Subject:Date:References:From:Subject; b=V7Ag5C2XNIfX0CLM0AaQAx4vstHtsKg8WJGqyg2Y1HIbG4yMEU9wkISRJRJLilhBHs7Kiv9rmcjndBLwehbtxYPHNSz6wef+48+pfiQctr+q3rkZw48FC2x6MJr56wNNs4x7Itk36lo2MXD0WocXQwwg3QfBkXMe0nHLSvdGRpjK+NnUX6stfJsTr+Y4eZSZrcWO5tYF87iDxI0Kq8amSs/FmVSaUgtGmZJg50XxkqaF4Ku91yItt5YcBBqEXgz8Pz4sneAIfH6mZZc6uLfv/7EtYNULC30QaOARWU2pboQllQOTDzM9Rsd9Z16/ib4ELTidVfSO/7o/7eoSEHmjNQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604533361; bh=/KaSTWvvtC2GwQ817NFLxB0ys2o1CukkhEr2/YCZNct=; h=From:To:Subject:Date; b=RVjU2WAIOaDdnduJ6eMGK01X4zQJgiRS4drsMUq0TsZFe8X8pJTuf/VpdL56zQzm6N4AEyEDl2I4YI7bNkkV1Z+jj8ZUcAuuTiyx5I+RRm5CjY0ntbsvJ+9VDw+fDEfoR1YuokkLQyMpfiZCBf/x6avkahW9v9F0awV/bb1iibMvgzY8gkzzZyWwC3F+484ymOcqtQlUwaeAypyjSYqkHU6vqBXZkn2TfiQBeDLA2HRWvRA6cqmc/DzwYYIB3hf+zya2EUC1/Idj/AkeJB1q/GhQ2RZLFL1H/rcDpw1YIi2keQ/IAh3KWVZf9ecXf3B1saThpBPqsc06xZbvOI/HcA==
X-YMail-OSG: j9Wts.sVM1mkIHiE1d48mJ2WZRxCGdukfigivuw1xuJpE2U1a9Lo7TnbEqSBLj4
 hYCRv.Lge3DL7A8WbeYUA_z87wgiBgZGYTRoIWuKFN3eE7ogy._90y0jE1MUo.AuFIns6N.IFano
 5RoShjLI5VAOZi3rXMvgOVhSISkjpzIK6mpXHd6cs1BqR7xjUDkapmWbXTsyLfcaWvREh_bUUjS9
 jg25wchmtr1Y1vaVfFh1191c9cSmBq1IN6cUrKU.0bctrdfrtUFOdrGNBMMYrEQwUELhFF11Czrz
 .YQAUxzqdhCKnp6IyX7uYMFSLDFb0ufCk1ZgM3J4SPEfi9jb8y70jMeznlaAW3IbHCwz4lVq9WKw
 90fMOqYP4wq4JKIA2cHCcI_3RBd_JZhRR9jfcwixgVALcmPxVlYqKgJ7sfFaxXx06_mrM1xloWHa
 hwUfSMyGaDlLbXF10N7pgpa5QEAmhn36psqeUstrWSF4yC1Of8FKG7z73sFvORMm28KL0.Ak.urV
 Z6jDeeLxe0CKmmsJ942dxhqqYHgUVMPgbEXTSe3fodtEXiNXcjaGuUOp.juFsmUq_xZ9iN7bIfMO
 aiISmGK_GprM20DECR0qoJpmgUlxrcRuqtQr64.72CRhcMNwt3YY5hy6h7HqBSGnZam83pYItncw
 aRSv8VzAjFPpzCeduOVHEKHJ3jqSCXBZnzAXcbEJbGevkO7zZ8lki0jiiBCCd6TNLWKFJBwjJibR
 L9cX83yd_xhHnaCY00jpDf2fXzebwy49K2WWXRmrtvFxGc2SJl6MTW3RmMkej6HLH.FJETNFJISH
 K2R5LZyCo1qNCpDu3APAVrL5hNOkDgOrVPxysjhTsbj8R2KDpeREIrf4KLUO.2V4CHRUfTx9tjkJ
 Agm7MYECj8GxmQ8WlQ4TvcJI7fXiDDqKD9Z4EIIsa3bvHsDmiKJDZtz4o8F2A7tmXIARquZhF4TR
 FOVCHn3hK8HPCuPNtoZr0A_6byT8m_G4_CQg6JSJXURuEo3IC9f_.znue4iUepTCF3BBBhW0V8Tp
 _qkzoBVIj55q9saDeFtdc_BoU5mA2XysuqDmt_2Sf2MJDjXfdKHmzCnnkEmNJmCbtx4llmKUr5Ao
 Hw1sOSxD5ZTbjzTYQBKi65Reffqv9vhlUO4swd40lPY0HKeKO7HRkVsOOxDk6c_2gQTaeTKu5t3c
 nAij8Fbf6Ovhu5uRgUrwvVjW15nzIA7q_.sn2ElnaMOsbrgZy2Ue40x4b.t7MGLic4LQVmBDHLnF
 l4TYCbXxfnTe5tA9a00Q98vGjHRajGvFPNa4AwKZiL9YX7yVT3Wq.53UKihC00hSUbYS..vHIAmJ
 sUmdBftHe1DTsl3CwDmE5jwajFfDkrQYNqAeLECmi.WDoRMv3E.wfw2gwT.Lgu1IZKIWBd1oWvBf
 gkL0o0C6hG.kxxGB3qKY.g2wFcOtmndBIMkbD8bHw2r6B0VTAOe_yggrm_56Cu2DiWWu_3qofcAA
 K77qtzU9QaKUqUpVeLT5FLKsWDorO1sZ1Pr6W9FOe9Xk1lgWcO3GH3nxBEjgswxvn0m7xBHydYoR
 d1uF37dPSuiDygudOZEUFx34Hfm7oVCU2JxOdyrR.G1wBV_bwJINYFAXL7Qujxl2V4_GjHxOk5K_
 efvPKqnRK6cYMK9TN1IW9F.8KI4bZAqVW.K6Qk55TQnJizLfSvXHps14FriiLVY9aNoVM2NM.CpB
 DX.TcCxdnJKxttBQRGMK5K8e.J9ZMgrCZxypyBosA0SMTs4ImJcD02_0zSeOxw2NrvZsWp4ZV6GL
 AJl0t7_82ye8T6zdVFnYANNkFSrJMAmvANHE3qT_GQ7vE1LQop3F7KMvQcTHGjF0AkiPaxiGSsSM
 0_yXbLnQp9pdU5MQJFcx.jbr9uIQbT3L6qmKIQBu0PejwlVn3Qvs3jZBIafWpT.qNSFJM1QOmvMW
 1kkG6LTzXjXbbTVcpxlBczhPg198z7i4TOkAQpY9IfeCpsGuRckOYzIaVRAZjeR2KxDU0dABG.IM
 uSvH9lRKKm_5deWYFoXU500dPgDrhQicZco6TjqsipBQTkonz3Hr.HtcSaOpigIAbsSu9E7NRGjk
 u8EncGvI4zKarpfIMInmiT_HbkNgYqy42lZHNmwoM9JHYvj913HXuC4p82Mm6XU8W11HLFgtZp_x
 YTE6cIA596R1XTCySO3OBp2qxedGQaWWVEL08M6Kg.wvUHYuajkWzlfvphdjcIVoZVY.Kn.BE7I.
 CBDFDozeY.NJdHwv9Wg64bv_F8uzEkFI_jv5FpeYdfeBv4UNpPNEt_7ge.D2PEfjj7tFsPhANBHZ
 har7ONVB.eyJivOHb.CiaD3iQ6EeYk9h.wxGrKEmzLUZgRfPP42Aja.CD7vBHOfydI_mwvskwtdt
 qIuVjs6MOUdSKach.qZ1cpgHsY89clINJ6N2NzfRWvDbgNlK9P3jz9mdABz3uoq1MRacPqaIbTsw
 DQYstK3mSh8GlWIB9kvXmHaUJ6GJ1479No4LuwVAlVubeE0XzCkv_M1iEmPW0sF8szy.okPC1piq
 H7ahocjVjb74zzJcdv03W63YjzTh6jGdUeInNCF7ZjsYwH.efUcLuImVMEy7Uq0fUjfXLjsKiehb
 TxTNwp7QpceFP.mV.kh5uLV5QzcN86mwlOA7qmBfL7pgHx9KLAWN0VktJlaE6B2nR4Dsu.FfzhVH
 D7aueh9DOaACLhYirgDzN_9slPEOFtH_q9tsEW_4XWyMa1qa_v15ZiUey226mr3.m_vGsFixynv.
 UL6.w.6xTohM0jqWj1wEVcNqqK1NqpPiZJAL29EWDLl0cGn80bnVcVzgIxl2LDX59VRTQY0jvxkD
 PIN9vPS5d5fec.gxmT592Wk4Njhws7l9iQQcjiQzBk8eEeJzVU7SZA_utlbul6Hk_tQrr3VUWX1Y
 2JIO1o9U26thVyr1Boq_KHibe4rvh6cF6kXuMfkdQwkonWv7fNOkuV58XG8sOLuKh5I3bC43hcfk
 yNH3w3ToiRvhG0ZzynR7dtlA.lBGMYhQnmVonY2UAkN2jDMhIV_8uqZWc26L_u_DjMFz_j0kiLXV
 KPHRj_evS_gKMhNUp_68cTFEX_ldhkAQ6rKg1gPHOooL29a62OIPZZYRruWQobypMo0OMN6XcDSz
 7MnzUOPAPvQHPgb3eq9rjzEwH.II0WW7pyp2HkPCc9QGE4JswQo4iiY17RCb_jUxKQlMsR5unhX.
 krFKMndp_j9gqXNYWjqWfgzxWp1JdICKmV._oXa_EW.BjGXwS_WBIzfXvGdGuGUEdzlZajYWfG3I
 14FBDxW4GF.ReUIbHxcx7YAk7R79dSILj.QwT52qbx7UK8sJFYfsq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2020 23:42:41 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9ca2493eb23dea32ac9aeee63a76b233;
          Wed, 04 Nov 2020 23:42:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 00/23] LSM: Module stacking for AppArmor
Date:   Wed,  4 Nov 2020 15:40:51 -0800
Message-Id: <20201104234114.11346-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201104234114.11346-1-casey.ref@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v22: Rebase to 5.10-rc1
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

https://github.com/cschaufler/lsm-stacking.git#stack-5.10-rc1-v22

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
