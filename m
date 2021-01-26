Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF5C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9022067C
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbhA0AoJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 19:44:09 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:36793
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbhAZRCL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 12:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680484; bh=4fJ9nR5iMD/v+xby75iZ7GhUe5QdBMqHxANIgQvIOY8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=K2DTsZLCgvT0esXUjBJjb+J6b5E1jyJL7dn3rBMyPmVNpAyJpssN8vhGJlgYA6meom1qR8nbaOgrwKRkbdenpaYPEeBbCqVJV8PgFjuljfD/cxS1zEnVXFhS4Rbq0tLNLO3nvpo1x17GgQKs4mssnt5Eh3M0m0F+/EMun20JCLbpUo9/rxefyWoA8eZpL/iigdXN64ZzeLzKG77Idpf3WTZjGCAIQbVcD2ANqWu+Cc7NNRaK0eiI1A03FL8TvjRRA4V1Mv7b55JTOXwrpnISpBaeVjepO2ey8RYcEZBAuPLb/U1RhcyrHn8xl5fvMVrP1q0zg8eoETOGWmlrcrwSPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680484; bh=2OHamaX32PIgufiEHn0O3nWZPVPARn9sbu2c3CsqXiw=; h=From:To:Subject:Date:From:Subject:Reply-To; b=Zjvn0w1YqOJ5UdKnc5BZMAPVGPgwI9MkQ1JZCFJn8uiH7w1iccRzaoFqxxbatYLymyeDsYrqOh+iG2Rvv54O9VcbTFac2Ie62N0YHM/Yg+w3zDFlhRo04Gt39A14RtsWSrZ4D9jA8726ON8ggWzEP+lDAeCyP4P9x/JBtserHDWwD9B5IKV3GoP5h6jLXXET7/+zoYBKIE+sBtQWuD351aaeJ7Mo3KqFpPKv+6iH+0RvNVudDOzoQzeLOpB5dof8SAm+ahd0wil+o92U86JSWnzMvHc4jaZaDnsjrCiq+Fv12uFKoCjTRKSiwBbizB9NaRULmLzRph/iQtHqtVvlIQ==
X-YMail-OSG: jmqHbvgVM1nLIngHKZ7MJ7v5qIuhrUGQPr3.54ThNPEWuPt9JWfNET7bG.ZLWjM
 dblgL0RHQeBLM8tApgX83i5mfXMODe6g04P444KNnY8lDJ_tI9hVuglFozdm6T6tgAqhgKTNMt1F
 Cj0FVeMHPGtJMbJ_ob8Wck61GZf9Uk.RMQiPKAFjtC3XEKiIu8QZuTuWxLqb8eTfoOyCG0T90dNU
 Gy3Mp18Eh1UNUgjgSZkPj45Wg.4VoKno4RtIOesEHpw7FUJi7bbi1aiJLPlAxMS5EAcvW4rB5F6.
 AyO3DCqimgVNahHpQXa_.rbOKPwqSRZWu4Gr1qwM_CHrQW1hDEQsTnYOEUtLdLYS4AgO.ihyrC2V
 xYBtdgVNwHK0GI1j_BrCVe_Bv8VaZcl_oSgfrnvgIoPyXbTc3jR8gP_2ybgw9Ea5Yeglgy3siboy
 7jBzkolnOMm7_kV.vgtJuE06pQfbyIm1TV6rvYBJg6HOsQhvWCMOj3Hd6wWTgA6T7jMNW1.drxc1
 vmfiIi2vnqiVEmo3XwtGYmJIopKHRe9VlCSZtzYzc0.aF_KNINtQZVf2vLDvfYGCLQxrSuTY1OjU
 jkRPnvzXzf0aHOjXVwbkyMVded_1uPoSZh8h.KhOGcj3dbhqEBgi6uOS6.EgLc6Coqx8HfUbs_Pu
 tzD9pzKEW7rMwoJHdeB8B5EkvQFoRF61.VMvN1qG3uFSNO1ypCeChRYQj0jGJv.WepIYPcTPuFcC
 HsTXvPSBEwdE4K5vaWx8lnabamhbBAzetwAEMQNNondV7TWdKfL.knSgsDOAscIXvqbraiADj4kz
 251E0yrcnwt9ROv1WZAiJqu9xrnsz4e54HwbsijsgT.J4Bt6Hz7zH_b12TTCJrWgVvG0Scircbo_
 OTV1Fk8xC.I_hZFFXfheNzCEqHpD6DaQhqYx24imzVkLBf_iMFmZEKmisKbxxAGIdc56bI7EQKQ0
 avyNPd2UhJhIhTqHFgeVuYOiqABBc0rANu7_HZ4s.cbDg0fm.DIykWxjXhp0P9B_BpatixjXFtDx
 c53wSY9D3PvKpIqvV2vrFRDp0cGcvhLeJer8URpNf2YCVZ0J.Uof37Bv3QmLmf.ayp.QZy5X29aV
 wqEOwLA8j716NCaawxsretFKGH9bwgLx5PNhJkWAtdT1w9w3JZq.OGfYtb0YVICyWgNKp9NtglH1
 SJ79edvkexe.POpEEBHC.U0jER2wFyb2iHLeY28WYyOrxs.dB37waQPhhW2HwC8yBigYSz7Sd8xz
 4CRsJ5vf2rRVXscpKzVmk3s1CTgFt4NZORPV3QOOVFzBYYuuNtenx1DH38i5VIUe_fwqMN0_TN4e
 B3lk_XKADPc.NfXfC9HDi7M7EyfzNeoikkNlaecq65.Qn0PJPSFBMt._Pkko8IePqlvg3FeVo7nA
 bX_0RuZ9i.MVz5V.iebrJCblmphPDFE889kzqPzYGiwwr73SLb2Q9C24oo7uLJcGzEt8Pai8esSg
 XRngkPi_ZPUtEigpr851lZzX2QQn2rAvn0NegJV4eGg9BaQsAshnhaI1HJoZ8ecHZefmh7slHQg0
 9VTkfFstgd0ptj8ntmMR._Bo4DoDYlhd35VclUPWd34.ld4ghJPm2dbK6Kq.pSOknRnkTqsy16gL
 Ctq99v1wW01uqNKVRz7orry1XHmPS8Vi2Tr16ULURlpkHNQIKA_ztdxL6xGeSEPE7kcLJ0B.K.F3
 p.XM3jyIHh2mcia39_3lc1rZa.HSk3Y1O9RjHiGl7VXQGyslhA5PItMs3IuN7uefdAVVjaq4ZmLt
 HBGvYVRAwWTgooNq0SQRWDdhSEAjYACDnpI5.4naUsI3leUB5IGKQWD8enBWNUChRDa8CkoatiBA
 66.jwwB1K.EsO_vdnwK37RtXzwFGwcAJktTmCWPLKnJIAiAOJJVr0tphUdiuNrT6ahZS0nJl._5i
 Xkj88bAdRp8It3SxALaRnbfq4UewMYYdjeaLZPoyDJWf2osN7Q9z4M5ZrQKHDnSZgJBWFUesNv_u
 CoXPX0DdaxI0DjBLXNdVRRE9_GbVPylr0bqrsaktRu6IPOAtIsFxJn.jFVUJh3WBszVPMeWYRHf3
 HYwP_.z7zq4uyeXGpU9jmc3T6.S_KT63R.NhMTXPXarVylSiYvm8XpsfnLnwAqUi681DsgsRNwVZ
 f9wF360ooa7q6JZJ7vY5zfEylE6ctZfDW2pLpj4yus7ew_kpb_m_NgHRe_gLqwHJ.CXmXWLGfiNm
 MP2PxTk7tBFx_qDace93dSvgQ9kFB2t_.i9MpBBSLmOuMs5zP3cWI2cGchqMGui2UPiIAIXmPXZa
 IRHRhGkESuosg3t4b8MyN8lkf1.M86AopkKJJUNw.VngD17OwN3hX7lj3QvQL2k.3ZLI.eS5j_1j
 wLxeIHjzvrfCQgmR8BNfYpaZF3uG_zkuGgfN1kIvJedNWLwbZZf6lANpUYKgbQOwwC2Ia4NAG35T
 WNL_2aRBeFIH7c3iEmtPiaPYjV1oDZ4zyOXq99PWXecRNXomWxt0C7VJct.WpzZofPrOf4fv7UnT
 MbMBeE490gr1Pwt29e40bTURur6hj40VwMLYRmC_gSr0UfW5HqaF7CTrt2ecoZFO63JEt8O8EiKW
 EenTwx6VMK0uivCuvrD8r0VH5kvrWRaM2Jtero4EtgAVMdu6Ai0tXt2t.rWgW.vHKPSkQRAEn_Fo
 2jSZh.ySsg22cFFXx5Pk9NexpR.CmSTxqzfMJyBeJdxkMpmIW41ZbSrcYlUooH_Ala4Whyrk6.k0
 AZ3kys_C5LBPLuJDOf5hXPyai2RORmDFhXvsLaERpgDmjsHlxUEECL6NmfY1xuGrCRx0u3vZdMx8
 6NKf7DZfK1ixWVpasbpKT_nh68Fdl1gh.MTic7zh268umtO8WzK3GuJd4s.YTYHgHiBxQ_Hxrqj1
 dFMI93JN2ELH6ode.i20o78i87abCFBkFhN1OsFmnpcHiu5tKM2innwwn6PvmcwGGdMj6wBZf8Mn
 crSbGdj31bbBJti.A21buKKVOzc9Zb2f86HAcm3GFM6llQoXLIg6eBnxd_QyIfPehhreEvv_lViX
 UPYNyjRLAdPX6Tg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:01:24 +0000
Received: by smtp411.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8f46fdf5312c7bc4d9cf88a41d199906;
          Tue, 26 Jan 2021 16:41:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v24 00/25] LSM: Module stacking for AppArmor
Date:   Tue, 26 Jan 2021 08:40:43 -0800
Message-Id: <20210126164108.1958-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210126164108.1958-1-casey.ref@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.11-rc1-v24

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
  Audit: Add new record for multiple process LSM  attributes
  Audit: Add a new record for multiple object LSM attributes
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
 include/linux/audit.h                         |  43 +-
 include/linux/cred.h                          |   3 +-
 include/linux/lsm_hooks.h                     |  36 +-
 include/linux/security.h                      | 185 +++++-
 include/net/netlabel.h                        |  11 +-
 include/net/scm.h                             |  15 +-
 include/net/xfrm.h                            |  13 +-
 include/uapi/linux/audit.h                    |   2 +
 kernel/audit.c                                | 175 ++++--
 kernel/audit.h                                |  11 +-
 kernel/auditfilter.c                          |  36 +-
 kernel/auditsc.c                              | 191 +++---
 kernel/cred.c                                 |  12 +-
 net/ipv4/cipso_ipv4.c                         |  26 +-
 net/ipv4/ip_sockglue.c                        |  12 +-
 net/netfilter/nf_conntrack_netlink.c          |  24 +-
 net/netfilter/nf_conntrack_standalone.c       |  11 +-
 net/netfilter/nfnetlink_queue.c               |  38 +-
 net/netfilter/nft_meta.c                      |  10 +-
 net/netfilter/xt_SECMARK.c                    |   7 +-
 net/netlabel/netlabel_domainhash.c            |   4 +-
 net/netlabel/netlabel_kapi.c                  |   6 +-
 net/netlabel/netlabel_unlabeled.c             | 106 ++--
 net/netlabel/netlabel_unlabeled.h             |   2 +-
 net/netlabel/netlabel_user.c                  |  23 +-
 net/netlabel/netlabel_user.h                  |   2 +-
 net/xfrm/xfrm_policy.c                        |  10 +-
 net/xfrm/xfrm_state.c                         |  20 +-
 security/apparmor/include/apparmor.h          |   3 +-
 security/apparmor/include/net.h               |   6 +-
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       | 105 ++--
 security/apparmor/procattr.c                  |  22 +-
 security/bpf/hooks.c                          |  12 +-
 security/commoncap.c                          |   7 +-
 security/integrity/ima/ima.h                  |  15 +-
 security/integrity/ima/ima_api.c              |  17 +-
 security/integrity/ima/ima_appraise.c         |   6 +-
 security/integrity/ima/ima_main.c             |  54 +-
 security/integrity/ima/ima_policy.c           |  97 ++-
 security/integrity/integrity_audit.c          |   6 +-
 security/loadpin/loadpin.c                    |   8 +-
 security/lockdown/lockdown.c                  |   7 +-
 security/safesetid/lsm.c                      |   8 +-
 security/security.c                           | 561 ++++++++++++++++--
 security/selinux/hooks.c                      |  99 ++--
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
 67 files changed, 1741 insertions(+), 634 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-context
 create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

-- 
2.25.4

