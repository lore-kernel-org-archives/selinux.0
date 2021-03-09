Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35A9C433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F7765239
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhCIOm4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:42:56 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:46195
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhCIOmy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 09:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615300974; bh=wZ1Xiqiu0mgMcTS41V9zta0hIm27ulffmIObK1asfTw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=G20Aecda+YSRtbY4wNk44Zgl/vl9Ifk+MLljTmlNPrKQ5GALSRPqOJCUuijCAtvL/3N9lpBdhAhTEfNSiyGYUifnkn0BGzzIaJxNUWI0jHjREG92uLPnfmc8YOPECn0bTjvNAifgFxxXAjBaMcuYCpHLXxtHpS40WnEmczQUEXVoJRLw5FNXgQr6pbpx8AD6bwtTLNnFunNzs99P2y9RgyE4jiqgIDGp8gvt4ZbPSn3dbsb9uURk3IC+3bB5I4+rYHfd6qyPKcFfnrPRZ1Qa8HnwqMFC1zGiujw95YzV6Rqr2mUtN9M6xgUADs6xtyRsFyHt9K0mhgN0Jj2Ekglajw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615300974; bh=EG2bq4/x9Dynovq1kFXAnzi3/pPwrMfpkqY5ID45cJp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iBjCQPKKr4HcDSBuT5ENXD7tz7PGrCbn6F/r5pSR2U5E61ttp1ECPmWY/blmbrY/nGI1OcPnqBADIjiytoYm/bWuSESeC5G5Yg9fTTvlUB3jrS/O5Dpw07TY75El/OWwo6sknzYKIfhwaVs4Z4+qgGCFDC/i3Oqs+qHaAEDtJJoIn4pSGjaquGDcrQh8ckA41W728nOHEifl9iGKf7nrWAx0E+0Tj9mOLSVdEbMDHVUN69l76V98OKyMuOq8IKsx8twfAi8nX84PgvkgZ15bUwdDybGvu1YwyULDTF6XNhLbZfU4Hkr4UMUdUk9V0lrlPN91KUH/C/fnnNjdY76mkw==
X-YMail-OSG: 2ITkABIVM1mGcpif3It.1rcgXTUh.6nK.uPey_aPokXhchnpmCxNEhuUg36FEE2
 1tYuqtmNhOezryYJNHIzZEVKGgVPiROnej3tq4GU4vP6Y4PopTB.7BcAiZx87cYyyjOk_mUMf7c9
 gCyRISlaWfMqzlDj5sQ8495IPSDZU15UDuykXOtQOd8KZEH_Zf25SJhhWi_eMHbmRFweuSDBHn7o
 cTHH6rtw19fDLA2UwG_V0UkHCar5sUyN8g3gr4IGLWXgxBP65NzHFeh.QzeMv0x2klhDbGMEc_GS
 ysuM0VuyobJw6c6eWszv4ZbPOcIkuB4gjYHCkCPw3OTI6MpPbsgzXXz6_6U6qHzN3A_ZwbR8lr__
 3VzQkeom34Y7.IB5qXfBWniUEqC53ghZEFyIP1a3J6VWgvo3hExd09UXHpeaJwqoJaVKS_TrgZEk
 uZNHUQrfTX4dAsmjOPuVmgLtuz01xGSS9KGKGStm1e56E6_UC9jYj4zVo7jjXxOdZY.Oh71lkCz9
 P5boTRaRNSRHI2jTBDXifGaGCcVd1WxTygrxmZOS3ZAaBOYwT2_J.XXeISRRCGdQS5IrJBGqYj2k
 fyBg6Va4JHw8NnymLpbx8KRPR9IFLqS2FVjUCSqS41640cY2dzsItvzLqnmPSa6OtAUSJWmlda_d
 Z8qVATk_OLFDvRxPgvAMousotRuJ.QoCwOmPH1f75s7fHfclh7Uy7I2AFEUSuzpifBCJ298Vd78z
 aPdg9U7ZkY.UhrRxbJQbiOvZODbOEp15077BTobEgm1Gz7Y8NDujrsFa2ieVmXyDizH1jeff90Zv
 KSpeFip_vSQms4A2kyzT2jN3cd_pz1M8OZ0INZRQg0I_PddRl8cQrv67Fe7SJzJXYdPm2oKvM9B9
 a8O8Fbp89H1Xf5wLMnt02uOswd5Ih3JTuwzJeQ.XA9l_2CE8PMuDHz.KMxgvkPEOi5XyyxzLSVXs
 K6N8ZFQOKVl4Xj8fo2zmKXX_8L4.2nzSOe2BuAH6lRy3muP5duagh7oFAhEoqdyhLvJPe2_Nba8r
 xYlLEQa6v.tUYLAvZVtiF3uSOWsdwRSsjKpJqgN7XmYhoUE.qroDSVeGbyOYJ3P1LN0IgQ0_NFKy
 tqpqaVG1Iy69wU._CIYf9T7rje3soAijcPLGZ.qtJCGrUxDtLBWCuD9FIoqVAx5sK_Q9PDYTYuNh
 YfbuTOFCcI7fGXQ8ac9qnyWlH7uWt9qxQp0uub8KDf25iqNOTHDKZzPOJxjWdNmQ8cEq5LzfvK4o
 Ei3JeTvgYNTMDCK4tEPyXDyXgQYHQuTnCrdRl2CaH57ylBkQRNQFKexTYG2LvAC.Ek.7F7N6lN3C
 BruKQBz4pOLTf3c2xuXEasTTzISIP_I4ooooWulkUFW5tpk_Lc1JveKe.luEmBSNqlYArV6hHtTR
 Qp4DZ33CwdXPzUX8jVMi407F4M6GvD4WECzScAPm_6_sjq_yaJa.UnyeVNfQHUmxQPOtHwyYzSbu
 VukAoJPCQLpiQ_7he0xZfkxkUqT5Tb8lIVwxTqFoH4sePomS6RlNA6VDClB.MBJy3rOgKz9hqEyd
 xwpNyqlIkmO2PA85aYfFaHLQcimEupMmp_ql.s7gW6Lc3rqXqMzjOIBT2ka8jikY0KIoAYZaVwMi
 9er5CYey4ditSc4Sc671Tsp.CvIm.PEOBoE9V1b_pn5sFKrGYwSFySKMcL5IXDldOJtB1xjhkIyr
 kAr5_ouElrKZ..olmwJv5eAbrDyCoTMGAF6IE_vEaeDdRIhNVXxNK4JWTaUo7BRl8ErhoxC6XIzF
 hf93gUfAYOfo2jn8IPTF8suR5lAx7jYGLqkrmQFBJm3QnxDYEdCwA8KpVFt3KBH50QofHAwsAv0f
 Z97uwLZ5teXfSY6NaEElLocAWUaZoGCJhdcdysdaQFtFeJJ7aRhT5XGoec8zSIa6vvvxZmkrWGkq
 f3_qnSNVDoKvtAO8wZsRAd4w19GQbzFYHjgZ.t3bfNUQQsAzO5m20S7OIsx0xWFdCMX4k_MKrQKF
 fjdSq_CJRQyVIMmpnuO3_bsRtyn9D8ZCU_5xcYBh4kKEwyksNtpg4Qp3XhkYPXOettDVl1KbEd1b
 AS0tvzc1qDlEwhej3TUjhvKVtnDJW0WndYfdJKjlWk57I.1SU78SmA8GW_YSXUM.uTh9GDlT9gjV
 lrrZq0KjG5AW8oQNvZR27NLkm_jnZQhz8.QeCilCKotnggSZnci2IqgVYPApg89BysDMreRLlwjP
 TPkETpXbfNpy95ZuhEMykGUIvgjOAc2o_1.iFPgf5WFWxn7LeGWrp.BR1qETZDeYvd36B46ufkDX
 QzEBpRH8XNnCq3MOoek45vNx3KD.MYA22L5WjdCwOc9IXtrfvTaCfHin2NTbzxJEaWT6zThigR3d
 ZBq8qKKp.RvCRmjsdKZ286UxAa2RuYrhXdGhG5lDLAQbTRgBMJVGPOHzfP_xj11nSG0OH6dEeA9h
 7NeQiOm1zqAeO83ZFq6duZCzI0RNLEymbGcFi1pq1n32.vnifc3FT0WyOq3ST30YTuqMpr9wL142
 Ju4KszPIURTNwR_x7ZzCVBNXXEFXkEOZ3yez.qNcU2CxwpaH5uhRrlzvC2.NRMmkbtX3.s9WS_AC
 I28UylNkMiis4ccjGimmESODY3OSOPHbgoPSdxZz5Edsah87zFXp8XthzLfa4Zrm.1n8AsiAV0sb
 OwFKtJr4R49JT7EuqQu9PuAgz4EP_ZIsIcP6KYiNFZagmDX4xNn7s2SUVxy21l74IWYsfcJJRZ6Z
 1MdsKb8ffPDXVBNwNoOfcOBoINdADjivCBs6t7Z2syQWvxENWNhK6Xt5becaghX_tMHuh433JNg2
 akbP5Te1k69heF39wGFIcUIRx6Xn2PbFG4rb2Ou0MYFD42z5gbdtkdfLbwYeMKvuj6HnwmjojB_w
 59DdInwSgmOqcOEr9EFgCX02z9UKilCuiWuoTMZ07WI7MA9RvBPio7tt783rxBs84hD16m4kjcr.
 fDwfHwByk9d1qDqo0kF3LUvJGiRNgtQSfHUx447Cvl0PP4pygJC6zAVm01KuryPbKiljVjjlj1hZ
 zTy6Z4k09Fqt2_s1kHeoQfyc8hddoy5dZEG.SSZ8zBH1s
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:42:54 +0000
Received: by smtp405.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 039e5a905c2e81e627ea7f0769d84669;
          Tue, 09 Mar 2021 14:42:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 00/25] LSM: Module stacking for AppArmor
Date:   Tue,  9 Mar 2021 06:42:18 -0800
Message-Id: <20210309144243.12519-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210309144243.12519-1-casey.ref@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.12-rc2-v25

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
  Audit: Add new record for multiple process LSM attributes
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
 security/integrity/ima/ima.h                  |  10 +-
 security/integrity/ima/ima_api.c              |  13 +-
 security/integrity/ima/ima_appraise.c         |   9 +-
 security/integrity/ima/ima_main.c             |  58 +-
 security/integrity/ima/ima_policy.c           |  87 ++-
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
 67 files changed, 1734 insertions(+), 629 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-context
 create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

-- 
2.29.2

