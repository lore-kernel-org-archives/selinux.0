Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FBAC48BE0
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BA06136D
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFKAGp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:06:45 -0400
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:36244
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhFKAGp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623369888; bh=rb2fXltPwQq5+Vj3ydbMJMYoY0K87Z00n2zKQ+t8zuQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=uTBpUVAfJTIZbOlbFEfeTl/WvxdrSpc5iaimZof+IKRN5sypF9OFbNN0xq2uBeoRUFhbM+i29jtVygX1Kf64e8GBFzCAQ/eWFxiGIukfAvhOy7mbznwDxFLX3Q4X2Bg3VBtDYz3a3gctzP5/p+D0NLtbZvEPluTBkQaHxjPlvAkwY/VLSY4N2SPgJXw7q5JLwZYlQMlet29EEa56SmnozrtYry7CxbvT3IaSQlUCemsXHzS7RdIZWwkc1I2Wjry1DoYgCtlTfpG1ra1nBdpz7t1DrQK+q1NPhnyar3QFgp546iD8VE5Aqb8azMhCR8zzZlfe0xX9VgtGPneSTPMyNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623369888; bh=ktd8AkhxZj8rfKiz1tt4r+3rtJ9m64dM9+q7ljFPb4D=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tjACP7S6ZrKe2z21TFsdYR5C5wCUWui39vwyezh0/keJbvtGn5OQuolCnnO6gVVHY894Bs5w68Wuij5zpUuSxClYy93zn7el55XWyIU6Wdg1dA3S/8txwUh3N4ejWavio6+VxDlNq6YgaKQ3+ut4WAjHG2D/BGUCIeGw1y7crhJ4YbkGoMSI3FZo1+y+nkSGmRw5OB3C1SOKs12FpNZHyXuh/mL7sZgZFxjfqD6OzLxloW8M5fdotcJ3rsolrG1yHv8zwPUd19Tj/VNZl7Ux3ovjjjZEElmt6yRMXtgfQeOjf033eNGKZk5yKNjBtobBWkeX41SUyjXX4Im/ZaRKqw==
X-YMail-OSG: mPgS_VIVM1kl_C3x.iA3d7fo.6HNQtAH6bTko1oXzDTrwvVpKKhWnCdHlUBHgVG
 q29lEoT4gRm8gbMmUHNvM63ecVDE.me_vGnbbaYgbeuNUuxJa_V5ML1qRVEU1UhsMKI4GAaNlcgD
 hhJVJNH0Qv9cMdZfnl8IY9HHq2tGx2sEBVuKMRwF17aHi1V2lmbQB3.w7JAiSjqLZLNWMtqMcuW2
 FjuxwpCucuRWRaKxtpa4m3YhB1l6gk7yCYQzg.SQsaTXD5wyEgDKewbBaySVADBH03FvRv6tA9wY
 6Me2EuD5DVD5RR5OHgWOORS5G.J6Bts21E3F6A8Nm_zWebny4jgzrsPAS9RYjQUBJ4bZUm3aKVXs
 L3TCG032cqP1xJs9tyn8j.yicui3Yh4RwGPUkMhs_aPKre5uAnul9IUxK9S0auDWIE84ohgJVcwP
 VfsATwnagkPlHT1VK2hkEbnBKPvFE3rtF92NKcvE6TpQMrhEJApFeLIptFC3MPmfXoOPTM8o2M_6
 oAk8sfGAZiT70xFmsJWQiMa9hR0Ga5fTfmGZO8Yx4oT2cD1.WdJKYFaYzlgWVrQEEl3EcI3MNdLv
 NKCEz9mKNlyOgn7onHoVsXTLsRnAo1rfp1DXW5Ymf4F.OEBetH4ZvnJu4gMgAIEagaOwvi7oF0Xj
 6rCEzsmNzXEbgMQ8PEvMOtXiIdkNlAQCav8ZW1q_JXayFXAJLs3PcUnDTkTHUE51w7hZLPJ6I2dz
 cz92wxmYD._7rttRpKSIpCk0ZrZe5yF413fVHnE0y7sNwk_XGqV210TStzgw2lFF50DnR5RHk5dk
 xDxGV9TcT5F1NedZJ2iN8HMtenbcSDtT0f_pDz4dnDhcUCqiZQgPALY8E.tGZmgQ77xam4Hbo8lF
 iYLSmmpO1wvGIaPPM6g2xwRzJUiG30b5TjS3KFSZ2stEZFJrnJRoJ77DNAvcbFJ1l7rc4VRr5j9q
 nPYvn3LITTzqdktA9ZJMHxedKzEArifJObuUxMCWkuG9FmV9SMWZ.OzkVC_F5CsBLMHmfTvNlQ.x
 OcznWWyTEkatJ8mA6IO_SjwI1XE5l361XayWjkXaB2SHqIttvG8lxG8bKxTxlZarX0UKPEpHgPbR
 xNzX4ZNbodx.0ZvF4dzMyW3_XMhdTWaL8G.sZU9as5d9zzWP1xsheCcrwkAV_0WiX8Ml_JK4femW
 HNaLOVrBDfW4nI7fV2LApxBG9mDpnP..nokzuGXnOXHYoMpTcHnUSQPRr1.tkcLW1Hl75uRjUCGL
 anQ2rfAA848Zcer1KXq5gWj45zVW3Iex_MXuL9MnLe8o1GIC_YziI5MERqVQky1XBDIaNU25Q.5v
 VGhU8xlYZ4XLMUX8qxu8N6nrkRizZef4ucn1LpY4xdQlwSoFF0UCFDL.2WjiFL_r1Ohnfshaz9FI
 7DragaZC41FQqaj65WGmgTDoDQ1IehZ1GFiZ6kd_sfGOmfedNtq4XJ_5ENFCQ3PUaG_WDCVTxDit
 A961bSqQ7mWhP3EQ5jTj5r4HRrQfiBRDhf2blr.VsDFLhEH9x3MS8WNW5hzk4yaZ.PNcrYohBy9U
 fqYVlVXPAFaR5TiZr_Km8OliyI.QUIQ7SqMIAV8H0B1jmyJZLyYeViVhbjADu.L4MlwA6KOdLF54
 _CE7D7I8OcOlHh_JJ4H.x_UzZ6ssBVMZc6zzmo8guKG3ScEe_NtZpFoi4JPRvQHcSlyZy4lDup1z
 eyiSp7SMMTomos_EcrdQODLqR6XP3xRXMRNAmCZgY4e4n4rWeaKV6L2qui8HoUwzDCnA.gxeflh9
 lKN6lMGms.0AakLQUCrpWkQmdjdGkiwea9MoBYrZO6zt8zQvlCt1AoQyIGIx4s5sdI8r4s_8MIHe
 0CGVHkAgFsbsbkIWkQkl.nltw2hvAXXt6fwAiapE9vRHUdyMJWUYOVuv4cbIb6leYCy6HAvf9Xeq
 Uu10Nty.pHtKT8yBumA_9SBrNiHo8s0lmmAR2Vr9jnDoJuLsrnm16qVhHgjlglAD11yaLPansIHk
 aHuezA9nKgehldCf0VMNYXdCIKXdQRR11NNp1ySM7ow4k2cFNvgc3aF6PMwkAet0F1Nx8u1FVtCT
 EhFTJ2ljgS0_0hsqvEOXRScz9l84Qy1fByjgaeaHLFYGHVH24c1AwEVi.YReJRYgEcYoqAGa41Gq
 RArd5IvR_KgesYvgBRa3JERruybaO5t4U82k7AzQYzmYtSLZYZpnmmu80aOKShvTEp9TIE2pShl7
 5DMeqMl5Q_GsppP5uc91uKqENkVY3YuJrzKF5naGFsoyEBHY6OFkxtCpGY.fI5UOFjs6PjULXUqh
 UBSNgDLrR78sIyo0emSZhbWTQpE2i6xOMCuQtzOtVxT2mmOrMdcLj.PR4iZ68_uNyqtBEhip5Tlh
 UPpkZ8D3gq34iB1G6W0jw21t7sHEebR63Q91xDmBAwoXm4nfwaJmYGNO.07oBuANFujz.JFt.Se_
 XBcoqb.0IK3ssGVJxw8mnBra3nOfNAUlQLe61EWQFAIS0rfmNUn_rL8__lAsdX4WJnRdlxInGMxs
 QDiB3xnIkwERw33rKZiaRb3umepMIY8Q4JOVQa7_bWXtPEzvTCN2dSpfMsarrE6Sl7XGnfPDanMh
 E9cTo9EJYr4mzgbwgXd4sIKsrWE6UiMgoSXOK5CaRhpE0PlOsIXAMgOD02vD8UrsKdGKbHQiUYXt
 lJNgeiEPtio2vSpOeyISovGJyXINk.Vqrzd0Zp3icDzLiMOPOzNGuNLxtZClcvTnekWzGa3A665s
 ca5lOEwgKbmCHSmFDCzWWXuX0uaYmWyGJT38bHLBgvxPtIp3lDSljiB92BZCG0GH32PUANLi5Rak
 86.qC1dIO3dVpN9aBUxuDSjDj_Vm.HPR_3GSrmj2eBx8YDFvxHgp55Afv_FyVxRbtAEATwXH0Apj
 xh1yXqdfq0_pLzVZu7XlgmaCWo1qkXcGqcnqoe02ySyDdRWWjaNkGItilSc7KU9bjmggwGYQKfgl
 r4MBJjSlFSj_wStH8AnvA87dqdRGDCvfxeNElYbTszdh0xd3g.K6k5yoUSG4XoNhqle7SIcbm5rV
 XeAa2ABY4Pxu4IjuaNI1wQaf_RCaPpoRAoAGu6EE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:04:48 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a570e9ad0f0290634777c5ec99999293;
          Fri, 11 Jun 2021 00:04:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 00/25] LSM: Module stacking for AppArmor
Date:   Thu, 10 Jun 2021 17:04:10 -0700
Message-Id: <20210611000435.36398-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20210611000435.36398-1-casey.ref@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v27: Fixes for landlock (patch 02)
     Rework the subject audit record generation. This version is
     simpler and reflects feedback from Paul Moore. (patch 22)
v26: Rebase to 5.13-rc1
     Include the landlock security module.
     Accomodate change from security_task_getsecid() to
     security_task_getsecid_obj() and security_task_getsecid_subj().
v25: Rebase to 5.12-rc2
     Incorporate feedback from v24
     - The IMA team suggested improvements to the integrity rule
       processing.
v24: Rebase to 5.11-rc1
     Incorporate feedback from v23
     - Address the IMA team's concerns about "label collisions".
       A label collision occurs when there is ambiguity about
       which of multiple LSMs is being targeted in the definition
       of an integrity check rule.  A system with Smack and
       AppArmor would be unable to distinguish which LSM is
       important to an integrity rule referrencing the label
       "unconfined" as that label is meaningful to both.
       Provide a boot option to specify which LSM will be used in
       IMA rules when multiple LSMs are present. (patch 04)
       Pull LSM "slot" identification from later audit patches in
       in support of this (patch 03).
     - Pick up a few audit events that need to include supplimental
       subject context records that had been missed in the
       previous version.
v23: Rebase to 5.10-rc4
     Incorporate feedback from v22
     - Change /proc/*/attr/display to /proc/*/attr/interface_lsm to
       make the purpose clearer. (patch 0012)
     - Include ABI documentation. (patch 0012, 0022)
     - Introduce LSM documentation updates with the patches where
       the interfaces are added rather than at the end. (patch 0012, 0022)
     Include more maintainers and mail lists in To: and Cc: directives.
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

Patch 01 moves management of the sock security blob
from the individual modules to the infrastructure.

Patches 02-03 introduce a structure "lsmblob" that will gradually
replace the "secid" as a shorthand for security module information.
At this point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the kernel that
used secids. A "slot" is allocated when a security module requests
one.

Patch 04 provides mechanism for the IMA subsystem to identify
explicitly which LSM is subject to IMA policy. This includes
a boot option for specifying the default and an additional option
in IMA rules "lsm=".

Patches 05-13 change LSM interfaces to use the lsmblob instead
of secids. It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 14 provides a mechanism for a process to identify which
security module's hooks should be used when displaying or
converting a security context string.  A new interface
/proc/self/attr/interface_lsm contains the name of the security
module to show. Reading from this file will present the name of
the module, while writing to it will set the value. Only names
of active security modules are accepted. Internally, the name
is translated to the appropriate "slot" number for the module
which is then stored in the task security blob. Setting the
display requires that all modules using the /proc interfaces
allow the transition. The interface LSM of other processess
can be neither read nor written. All suggested cases for
reading the interface LSM of a different process have race
conditions.

Patch 15 Starts the process of changing how a security
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

Patches 16-18 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 19. This is not strictly
necessary as there can only be one security module that
uses Netlabel at this point. Using a lsmblob is much
cleaner, as the interfaces that use the data have all
been converted.

Patch 20 adds checks to the binder hooks which verify
that both ends of a transaction use the same interface LSM.

Patches 21-23 add addition audit records for subject and
object LSM data when there are multiple security modules
with such data. The AUDIT_MAC_TASK_CONTEXTS record is used
in conjuction with a "subj=?" field to identify the subject
data. The AUDIT_MAC_OBJ_CONTEXTS record is used in conjuction
with a "obj=?" field to identify the object data.  The
AUDIT_MAC_TASK_CONTEXTS record identifies the security module
with the data: "subj_selinux=xyz_t subj_apparmor=abc". The
AUDIT_MAC_OBJ_CONTEXTS record identifies the security module
with the data: "obj_selinux=xyz_t obj_apparmor=abc".  While
AUDIT_MAC_TASK_CONTEXTS records will always contain an entry
for each possible security modules, AUDIT_MAC_OBJ_CONTEXTS
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

Patch 24 adds a new interface for getting the compound security
contexts, /proc/self/attr/context.  An example of the content
of this file is:

    selinux\0one_u:one_r:one_t:s0-s0:c0.c1023\0apparmor\0unconfined\0

Finally, with all interference on the AppArmor hooks removed,
Patch 25 removes the exclusive bit from AppArmor. An unnecessary
stub hook was also removed.

The Ubuntu project is using an earlier version of this patchset in
their distribution to enable stacking for containers.

Performance measurements to date have the change within the "noise".
The sockperf and dbench results are on the order of 0.2% to 0.8%
difference, with better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-5.13-rc1-v27

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Casey Schaufler (25):
  LSM: Infrastructure management of the sock security
  LSM: Add the lsmblob data structure.
  LSM: provide lsm name and id slot mappings
  IMA: avoid label collisions with stacked LSMs
  LSM: Use lsmblob in security_audit_rule_match
  LSM: Use lsmblob in security_kernel_act_as
  LSM: Use lsmblob in security_secctx_to_secid
  LSM: Use lsmblob in security_secid_to_secctx
  LSM: Use lsmblob in security_ipc_getsecid
  LSM: Use lsmblob in security_task_getsecid
  LSM: Use lsmblob in security_inode_getsecid
  LSM: Use lsmblob in security_cred_getsecid
  IMA: Change internal interfaces to use lsmblobs
  LSM: Specify which LSM to display
  LSM: Ensure the correct LSM context releaser
  LSM: Use lsmcontext in security_secid_to_secctx
  LSM: Use lsmcontext in security_inode_getsecctx
  LSM: security_secid_to_secctx in netlink netfilter
  NET: Store LSM netlabel data in a lsmblob
  LSM: Verify LSM display sanity in binder
  audit: add support for non-syscall auxiliary records
  Audit: Add record for multiple process LSM attributes
  Audit: Add record for multiple object LSM attributes
  LSM: Add /proc attr entry for full LSM context
  AppArmor: Remove the exclusive flag

 Documentation/ABI/testing/ima_policy          |   8 +-
 Documentation/ABI/testing/procfs-attr-context |  14 +
 .../ABI/testing/procfs-attr-lsm_display       |  22 +
 Documentation/security/lsm.rst                |  28 +
 drivers/android/binder.c                      |  26 +-
 fs/ceph/xattr.c                               |   6 +-
 fs/nfs/nfs4proc.c                             |   8 +-
 fs/nfsd/nfs4xdr.c                             |  20 +-
 fs/proc/base.c                                |   2 +
 include/linux/audit.h                         |  35 +-
 include/linux/cred.h                          |   3 +-
 include/linux/lsm_hooks.h                     |  36 +-
 include/linux/security.h                      | 192 +++++-
 include/net/netlabel.h                        |  10 +-
 include/net/scm.h                             |  15 +-
 include/net/xfrm.h                            |  13 +-
 include/uapi/linux/audit.h                    |   2 +
 kernel/audit.c                                | 186 ++++--
 kernel/audit.h                                |   8 +-
 kernel/auditfilter.c                          |  35 +-
 kernel/auditsc.c                              | 145 ++---
 kernel/cred.c                                 |  12 +-
 net/ipv4/cipso_ipv4.c                         |  26 +-
 net/ipv4/ip_sockglue.c                        |  12 +-
 net/netfilter/nf_conntrack_netlink.c          |  24 +-
 net/netfilter/nf_conntrack_standalone.c       |  11 +-
 net/netfilter/nfnetlink_queue.c               |  38 +-
 net/netfilter/nft_meta.c                      |  10 +-
 net/netfilter/xt_SECMARK.c                    |   7 +-
 net/netlabel/netlabel_kapi.c                  |   6 +-
 net/netlabel/netlabel_unlabeled.c             | 103 ++--
 net/netlabel/netlabel_unlabeled.h             |   2 +-
 net/netlabel/netlabel_user.c                  |  17 +-
 net/netlabel/netlabel_user.h                  |   2 +-
 net/xfrm/xfrm_policy.c                        |   8 +-
 net/xfrm/xfrm_state.c                         |  18 +-
 security/apparmor/include/apparmor.h          |   3 +-
 security/apparmor/include/net.h               |   6 +-
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       | 105 ++--
 security/apparmor/procattr.c                  |  22 +-
 security/bpf/hooks.c                          |  12 +-
 security/commoncap.c                          |   7 +-
 security/integrity/ima/ima.h                  |  10 +-
 security/integrity/ima/ima_api.c              |  12 +-
 security/integrity/ima/ima_appraise.c         |   9 +-
 security/integrity/ima/ima_main.c             |  60 +-
 security/integrity/ima/ima_policy.c           |  87 ++-
 security/integrity/integrity_audit.c          |   5 +-
 security/landlock/cred.c                      |   2 +-
 security/landlock/fs.c                        |   2 +-
 security/landlock/ptrace.c                    |   2 +-
 security/landlock/setup.c                     |   5 +
 security/landlock/setup.h                     |   1 +
 security/loadpin/loadpin.c                    |   8 +-
 security/lockdown/lockdown.c                  |   7 +-
 security/safesetid/lsm.c                      |   8 +-
 security/security.c                           | 576 ++++++++++++++++--
 security/selinux/hooks.c                      |  99 +--
 security/selinux/include/classmap.h           |   2 +-
 security/selinux/include/objsec.h             |   5 +
 security/selinux/include/security.h           |   1 +
 security/selinux/netlabel.c                   |  25 +-
 security/selinux/ss/services.c                |   4 +-
 security/smack/smack.h                        |   6 +
 security/smack/smack_access.c                 |   2 +-
 security/smack/smack_lsm.c                    |  91 +--
 security/smack/smack_netfilter.c              |   8 +-
 security/smack/smackfs.c                      |  13 +-
 security/tomoyo/tomoyo.c                      |   8 +-
 security/yama/yama_lsm.c                      |   7 +-
 71 files changed, 1709 insertions(+), 623 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-context
 create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

-- 
2.29.2

