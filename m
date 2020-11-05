Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E9C55178
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D36420867
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N18GxrRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgKEAtj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:49:39 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:43403
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733303AbgKEAti (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 19:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537376; bh=TLzmnef1shGNdKxW2HuAZYuoA/LXmsS9GPz9FvrJ3k0=; h=From:To:Cc:Subject:Date:References:From:Subject; b=N18GxrRH2yW8AJUiGRRIrZVG9tPnrvh9QoZgv4zEqDK3aezA7qcfsu2kNnFMGjp0rMARXb07YTa/FqiPj6Spfwpg9fIdZ3jtKazsCUtFm9q0BZ1eHnOHpkompsuFw6uW8PKAukJzkCbmZmtU+7bXclgLnyX+rTttDaFELUWTfbDvVqgciA7EneHnnqfH2O3VkfbaOxana32MO1JBGgtr2LVRunt/s7gvxzVdfUmSVhlEHmfTTWrq8C3DTgGSlWiBOnRrHlnR5TcBcxKA8RPEybjDtEwsRGX1QIPP4y6vL9cAilwO/RNwku2geCNBTM5d+PgbeJHbk+UG0txDFb76Fg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537376; bh=SKFV7976f4PhbR75q6fCaiUhYAeySakUInagcOYWRYe=; h=From:To:Subject:Date; b=I1dCa/QXf6oIMDojYm2B0MMBwkObkNOJswpQzknfs47Bc3ds+gIw8UUvaInDMk1x9lM4JMYTfqEZN2TB5UpaSa070Dh/+3N8YojJ3H7vlnsvLt7EOfa5d9Aoc3lR3dqbXVI42uddO8pXTgq6n17jJy6KthB9UxncB2kjKhJIK69QuFvo0EiCpBW91SNvOZFkUmwfFNG9QqwShRWmoATSZH3TEzzh28thujlH9kzbAgoTb5PFszPvfhEvzIwBZDWTMVftz0a0C8l7oAaZRTVnbV69yd5xXod7VaPT+F7dD6PuBuxAJlBjcEw0Nqoflf/oIT91uVszVepOvd5ZYDyoPg==
X-YMail-OSG: E.WQ41oVM1mrkLi_VIqSPLeb9fGAspZsj8bpN2fnXMjrVRLgBFO_YYUtS8KYhuo
 FBrCxdIc2iPFkhtDzUtBzfRVxQMUsYj0H6jv3xUWFHRruzHTMt2AUqCbn11kfoEsHJOhkla.eW2T
 MWVvp4nX3qDn4RHy8ghiEKKlVwauOydo1jBaLQ0i2IutwOr5lrwMWHkQRsyydDbQolJopGERY0V5
 bEGcAg77TJEvFF51972aNXk3ioCkIcboQ.aSWsm4iGuk8k93xKu7.yEKqgpVte5wM9L4bgm51GDK
 jxhtqeddGV.6vmhSEvsM27583KDrR6r3iiCjG1DIf1PwH8ThF_heuEh3OVLEfuZnHmpsP.lzKESl
 k7nqXb0VoEOcLgnK7GwS_Iqu3PcDWijigQzQNsZ8ZwX5ZgZ7SgnVQNAQuWNQ4VrbEmW4X.MzFn2R
 4rop_xCEYqFu0M46dfpoDIs8FdmgU2j9RGx5YzaXLrkrKKkFoCWGnU3pe05OfLxP1f99g6x4ZO02
 52Nr82kO1KFkNR6KltggxkJ6Q0GLpfT1YqFLKADQeIEvFHsOmiNdjzGWlfTGVWa7lXpovWfqq5FO
 v1_gp69KiLoqd3A3_bzyJlYwAueQpxa6JC1nmnoObzar4OtkXWqlzSODb1AZx4_zXURYFeRHMJnz
 rV88v0Bg6WMhM965hGNQm561dwbq2GlARRCkBtCvsnEdb.O2x7Zo.K4A7C0rHfcjw9H.cwKNGM7M
 djvwRVcI86FBE55Km52tJ5UADx69NTG2dbjPzBAYtntkY4vJBIYowzZKBPbQayBqXjJTPMEBuK9D
 tvIIcmm78fMih396x6xgJmWifIoNks4bCxquXkD7N1bPPRZ5DXHJEC5qd07KCc4qPFTbTr64o_z.
 oSGNutsqhUDeKgZX2Kq97s2rXO_YfcgVLI5M9JnX97QjGCPeONt99zb5jr.IlofS155bOoi.gQBd
 C9roFWPCrMP83q3yTc9E2dx0IJEpMltGZBmt0vcWzyaZqX1GwfabwiaxCF_9S3oEi0tT4CzChcCG
 IMoTsZ_drJgu0DH4WE.xuTJOMTFomCgamt4OQ9s8f8GJof9mtC83JkxdZ6ioKmf4cAxvpqu6nsrR
 9bNu2iBFsAsefltkoeGkaq_9hJN9tesQEWMvf6levPyD_dfdPo3wj.PcfY_TP2OJwBLFEwRkrvWo
 HDaoAK08wLh_w1Vn.xDulgbAaGNSiyATghbPwATYNFnt42j57Jj47uBzr_6BM9vlt2ouwZYVGnBq
 h5hGS2B.wxnTgs9WTsIDxJZ55o125vxVdl9u9eD_ZEJdVJ28jGgFag6WUnikmRJz0qn_q0qHayeF
 NumBn9bFNcdP2_X5h50va7HNTT02alUSiXvP87b6HaDvC7_kSKRJuR9_xCSXrxIU4kABxNyEkFTP
 DYqdG4W0pGaK6n3Sc4.i3bXXXyQrVYUlRX.js6RdOFUIuSenaoW1rH9RIno.hLdBUHW5b0MhpGQ8
 SxGELuN80iOIlOKV6s00ocLBr6Dl79XyRYMjzGWu4sdjsLntIuCPC6N5ClAg.jVtRSzNCToLdoWn
 kjHuL3PtV0waLtpiPJYhBjIgZ5cnu7eIfMOByqdodc2p4x0wnh7KjOZd2AOK33.VmqNgb.RHsrxH
 c4.UDNK5CNisvZnwhmT9hl6ESXyXbogqPbLd6iV1xNsORJjltCuq6Z1czJeUh4.FDi9tsBPyVBVx
 BmhY7uZKXGdTj.8bxBcWpyGRkJSFFrTGJgzKxtqIzPJ1e50VklXvUrbB72ow3XXLFCr8k.SbRQuD
 5E7RddxdbQqPVBbacJ68s1EWn6o8Ur73yYOTgqupVDPrx2mv1X5ohp420KjHf4DLW2nP6XKK2nMv
 VBML6xgzj3VBMISDBUQC8K3smkodsdPD5n07QGm9vQMUu.OTJQolVQbRlDP27_tGCP2T74wdBWT_
 XB0tNZAhXTh5yfpMwHDWX.L0LhufsWnLt3uZAx.kSXtEQ7FOi3A3Mep9LeFHugll.5VAADR7s2Si
 A6PMiofhRetLHXMVizVWwA6kmKZ0T0gKG3KnfBhrWSf8PDPpeh1oY7PH8vWY4eKXNkRei4FVUMm.
 RLjU1YcRfD6a3Ch.DL5D.VOO3auxiWjEOWnMrk3TBfONmOpbRfGMnn0a_yjwDCGF9rNQnChm0dzD
 arvp7S3eeOinVpn2a1zWU_d8x3enbewUOfJVXOPIX_6rHJiUx.i0WWOa544GCjfQF0ol88O2oCnV
 g1PTyWctnI8zvSyA0PB._IchVBwrIUklZ3Cq6lxc7VxxraacXP66O06JHUojxA9Kobn71.R8n6V7
 IlmTR1Fxapb0UH4X.FGgiHZEw2SIKk5bT02IqAs9U.BADtmj3OO736OCPFyq1eCd0UwpQ.Cf0AbI
 a3VyNoHgxtKwSqq_Xq7sj.mcfterFcru9JltSqnHCbDjxM2G54bFQWRt1zb7n6VDIU6FiRlI2t7B
 lqAIqmP_mQLuNj0c5lOd7eEJx4S8giGgbfuS75Zt0sULtN62ijkJg702hCPpq.OSGXAnpjTL1iMi
 .YK6vZ4ehQn2Ni5JDe4caRMC_dL20DqZ9aLk5aIGgQ1HfxoKR5OYAVL5X2mnxWmyyTZvdoLupATg
 cnifO.g2E4.d4TI_JnjadNXmenAwXlgvvTCrJ5B7NpvNIBww_xf5NbQGGB1x0VD7DImVK7f7hLHM
 bX8JCVfC1_4Z2ckf.dMMK_FpndOK1L7OIjuTMDzkOXGjtsN8T7u90YEuBkhLvrHQcPKm28ZH.Ehq
 Zvs2XkPDdu.OmGSFKzlMVjNJhkcJxGs5TxDsAux6UaGxuMchBKGsdZ8QliO5DHGdwqxzi904y3yw
 fR.OTrfcZ_9CrNW_7GSP2KMKIkpXqmDy3Q9EIpushOiKM2.z54RuUIp2ViA1uHcqUqo1skd54rF1
 MghiVuecJbN8qrstneoxXJBO6zJSIAd9y3b14Qn5EQzJm5X4Xx5tzDR6HCAt2xTJ4pRSSs0Y2RQG
 J9qmZ2N.zZt87shSqLGvqz14fk7n1EBCTMlOLlCHaYMQ_5EOTJInGidafGeGhq46qIs8n8ni0UQr
 zBO16hgrd1b83xATvqYsjeQCgZoEuMoUoQGgdsdooYvc.fnpU2bk5svMpBmoFWk9dwJOQlY9e68D
 GJsgvkG.dmE8iz1wzQO2xi.gG5FcsuBfiANsS9MIP9s9aHrpzMZZEIZ_Y.fmpMQsIk9lcNi71Gbi
 525R26UxTrm._AMMqu_CIJzOh2XxdVyIPrt_s6XcdgiTPBZbpTXXmhODvTRG53y_51qlYPuYFSps
 kAo7I4zWQLS.Lq3pmqIG4gogPgLq6h.nk4VOG4Ifmuc.8NReiYzAHy97joOYl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 00:49:36 +0000
Received: by smtp409.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 56e6caf5ffb099db3d670b83d8fbedf1;
          Thu, 05 Nov 2020 00:49:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 00/23] LSM: Module stacking for AppArmor
Date:   Wed,  4 Nov 2020 16:49:01 -0800
Message-Id: <20201105004924.11651-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201105004924.11651-1-casey.ref@schaufler-ca.com>
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
