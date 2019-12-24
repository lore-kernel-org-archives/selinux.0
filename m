Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98595C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4345920679
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gB3spiY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLXX6J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:58:09 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44878
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfLXX6J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577231886; bh=OtaIQSn9oe5r8vrbuednpTqnKfEwuFReYT3gIDy7pXg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gB3spiY78jCl48y6+AxiB+vsW3w0z9QNzgqJ5gQpYsUaY65IPDVeH/FY+jn7SFHpuJ5Nd1a9vKb9x9ks9MNlq/TldwoPFbSLlkW/ErEMnTHLqU2Rg+QPnUcD18wbLLAn8HihJvFUgCNa5hM+H4PlWxBM3pkYDXcA1TCPb7aD68ASsnJdMsVhu1ixpxoiKoQgIS74wQsuPIZRjcG1MIbhtMG6ydkUhwcSZGsHI8kosyPS2AyjdO1Gon5yMyaosRZ+6wcRy7152zCTTT5C0JPqJqOcmSj3Tkj1+xgvhRsnH2BNb05dAz5gSrGIg6TZI1TawxK8BTgGCO0nqoxBtCKeOw==
X-YMail-OSG: KeayBmYVM1kKY9jWC28QRNrBVTmwtZUC_BNqFzL9mSiAsGQMOZp_hzivS4gL8w.
 CuWvRaZ9BB9bulC5W_we39F4VEC._viHu7QAXPfTeIsg3.VFyyouunjr3iKxD384pPDXpOLGFYc8
 E5CwViXbL9z2_mlfgoZSl1qRBTCGMnaN.61ZiN_BZyAbuwxYB9.JaRNsWhPJ8_RiPJK9bAT450IZ
 DuvFDQSaF7YXsEtyLGnScNooClmHaUC9HCtWo1fJYMtNdfF2KGeQn6.EgnTz0V0LYaK209IxgoLl
 .92fnUgqKkt05vATZQPbIKd8CNFx.PAEqPBJ97oJqieN1iFApKtwXepzVYY56bpHOEM_1Rp8uapT
 Aht2RyQW_mY4U71eiS92hrvgAoBO..aD8nvgV77bwFVfUQ5KXZkctzsCv5YXyYjA2FCIvHbCv5YC
 993xJaHV0yBmywbe8mphWrSJXQ_Ye..zAggrn08rovmm1lKWNBU_y_7SSA4U6SA2q0x_HgfpEU.w
 DwEjRgJ2o1Saa4bDiNwhtXqeKMgLDFsYznuQh_jsWTX6S39HuyP9aHVR5i1uAXnZrBfmaIoiwffD
 govQpshbmwlGqZ1m0OVPmpeLuwqC6vo6AGwuqQ5Hd5ufgmHyNZT9H.q9rO1eo9Ua9YfMBzBjnfSK
 LlFAwaZLOY.mxhFuA5BHhTv9gfj2OIo5._kKKmemXYeuADImiieWWEAbGBHDm2.zquNgnuSF6MAG
 nyotNFSBpq1_dawr54ZRmLpOCoV5.8uozZgmJDtiCFA2mf5YX38ZP7hmdYHReTHBFTfOp6vpkNnC
 SvY_YfsvzE0GxWmWRyvqzX2hkKwir_MPn33Mp4exanXI2Xsn.t2NB7ZT19.BNEcqxs9MfQV1OPvH
 sMBZw6bVRRw_O3NCAYU1RWKqDl8lxV56fEs_fGe6kQE5k2s0g5UiO2O_J6iau9LGaw79FgCmVz2g
 zvXQQqbqPN.r1Bwom6SEIXQate5xjdBoMmkWy5V3EG_jTFCvKay1CtrVuevjU3Qe3p6WmmuQdIF_
 IAEN7Hy_x9r5M2N4Hc6DsfHj1AgFKs_E2Opo8_a6bHPEZgKcHC7Im4ZZYIRQO3Co8.kaPfKSxXje
 782NHziuPh86ZzLWcOCIb816t3cbiDPeoc1Vxb29abdbk3tHnv6s0I7Xrpp76_EpviSrrwJhhLhX
 f3zBrxk_YlrdVGvkOH2EoUsfX1A8ur2.rJZzWTERS6BH4UTFmtyrfBf6_pK2Lmvu4yaKiqoeakLr
 ajEeNcj7e2gSLUgl_rLusG1X3iOjkFMcRcUnwo2Tg.MV8WHNGSAGqSvrciyOwYsZ4yuI6nzT6Buh
 P.DpTA6wRSEAPYj6teYlb2Kup5UzU.uDyl00F64s42S36_sky2bQcVoXMC4dHt4Uu0TN8mQd9S0H
 LpFiS2uiTN_nDfAVywz2OEsYAzQeO_zzgKEFa3lB5PDIs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:58:06 +0000
Received: by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca7617ed5ad5f5e46541d2d65c6347d;
          Tue, 24 Dec 2019 23:58:05 +0000 (UTC)
Subject: Re: [PATCH v12 00/25] LSM: Module stacking for AppArmor
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
References: <20191224231915.7208-1-casey.ref@schaufler-ca.com>
 <20191224231915.7208-1-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <65812b4b-f792-d420-9379-09842009cd7e@schaufler-ca.com>
Date:   Tue, 24 Dec 2019 15:58:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/2019 3:18 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.

Apologies all around. My script for sending v13 messed up.

>
> v12: Rebase to 5.5-rc1
>      Fixed a couple of incorrect contractions in the text.
>
> v11: Rebase to 5.4-rc6
>      Incorporate feedback from v10
>      - Disambiguate reading /proc/.../attr/display by restricting
>        all use of the interface to the current process.
>      - Fix a merge error in AppArmor's display attribute check
>
> v10: Ask the security modules if the display can be changed.
>
> v9: There is no version 9
>
> v8: Incorporate feedback from v7
>     - Minor clean-up in display value management
>     - refactor "compound" context creation to use a common
>       append_ctx() function.
>
> v7: Incorporate feedback from v6
>     - Make setting the display a privileged operation. The
>       availability of compound contexts reduces the need for
>       setting the display.
>
> v6: Incorporate feedback from v5
>     - Add subj_<lsm>= and obj_<lsm>= fields to audit records
>     - Add /proc/.../attr/context to get the full context in
>       lsmname\0value\0... format as suggested by Simon McVittie
>     - Add SO_PEERCONTEXT for getsockopt() to get the full context
>       in the same format, also suggested by Simon McVittie.
>     - Add /sys/kernel/security/lsm_display_default to provide
>       the display default value.
>
> v5: Incorporate feedback from v4
>     - Initialize the lsmcontext in security_secid_to_secctx()
>     - Clear the lsmcontext in all security_release_secctx() cases
>     - Don't use the "display" on strictly internal context
>       interfaces.
>     - The SELinux binder hooks check for cases where the context
>       "display" isn't compatible with SELinux.
>
> v4: Incorporate feedback from v3
>     - Mark new lsm_<blob>_alloc functions static
>     - Replace the lsm and slot fields of the security_hook_list
>       with a pointer to a LSM allocated lsm_id structure. The
>       LSM identifies if it needs a slot explicitly. Use the
>       lsm_id rather than make security_add_hooks return the
>       slot value.
>     - Validate slot values used in security.c
>     - Reworked the "display" process attribute handling so that
>       it works right and doesn't use goofy list processing.
>     - fix display value check in dentry_init_security
>     - Replace audit_log of secids with '?' instead of deleting
>       the audit log
>
> v3: Incorporate feedback from v2
>     - Make lsmblob parameter and variable names more
>       meaningful, changing "le" and "l" to "blob".
>     - Improve consistency of constant naming.
>     - Do more sanity checking during LSM initialization.
>     - Be a bit clearer about what is temporary scaffolding.
>     - Rather than clutter security_getpeersec_dgram with
>       otherwise unnecessary checks remove the apparmor
>       stub, which does nothing useful.
>
> Patche 0001 moves management of the sock security blob from the individual
> modules to the infrastructure.
>
> Patches 0002-0012 replace system use of a "secid" with
> a structure "lsmblob" containing information from the
> security modules to be held and reused later. At this
> point lsmblob contains an array of u32 secids, one "slot"
> for each of the security modules compiled into the
> kernel that used secids. A "slot" is allocated when
> a security module requests one.
> The infrastructure is changed to use the slot number
> to pass the correct secid to or from the security module
> hooks.
>
> It is important that the lsmblob be a fixed size entity
> that does not have to be allocated. Several of the places
> where it is used would have performance and/or locking
> issues with dynamic allocation.
>
> Patch 0013 provides a mechanism for a process to
> identify which security module's hooks should be used
> when displaying or converting a security context string.
> A new interface /proc/self/attr/display contains the name
> of the security module to show. Reading from this file
> will present the name of the module, while writing to
> it will set the value. Only names of active security
> modules are accepted. Internally, the name is translated
> to the appropriate "slot" number for the module which
> is then stored in the task security blob. Setting the
> display requires that all modules using the /proc interfaces
> allow the transition. The "display" of other processess
> can be neither read nor written. All suggested cases
> for reading the display of a different process have race
> conditions.
>
> Patch 0014 Starts the process of changing how a security
> context is represented. Since it is possible for a
> security context to have been generated by more than one
> security module it is now necessary to note which module
> created a security context so that the correct "release"
> hook can be called. There are several places where the
> module that created a security context cannot be inferred.
>
> This is achieved by introducing a "lsmcontext" structure
> which contains the context string, its length and the
> "slot" number of the security module that created it.
> The security_release_secctx() interface is changed,
> replacing the (string,len) pointer pair with a lsmcontext
> pointer.
>
> Patches 0015-0017 convert the security interfaces from
> (string,len) pointer pairs to a lsmcontext pointer.
> The slot number identifying the creating module is
> added by the infrastructure. Where the security context
> is stored for extended periods the data type is changed.
>
> The Netlabel code is converted to save lsmblob structures
> instead of secids in Patches 0018-0019.
>
> Patch 0020 adds checks to the binder hooks which verify
> that if both ends of a transaction use the same "display".
>
> Patches 0021-0022 add addition data to the audit records
> to identify the LSM specific data for all active modules.
>
> Patches 0023-0024 add new interfaces for getting the
> compound security contexts.
>
> Finally, with all interference on the AppArmor hooks
> removed, Patch 0025 removes the exclusive bit from
> AppArmor. An unnecessary stub hook was also removed.
>
> The Ubuntu project is using an earlier version of
> this patchset in their distribution to enable stacking
> for containers.
>
> Performance measurements to date have the change
> within the "noise". The sockperf and dbench results
> are on the order of 0.2% to 0.8% difference, with
> better performance being as common as worse. The
> benchmarks were run with AppArmor and Smack on Ubuntu.
>
> https://github.com/cschaufler/lsm-stacking.git#stack-5.4-rc6-v11-apparmor
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |   1 +
>  arch/mips/include/uapi/asm/socket.h     |   1 +
>  arch/parisc/include/uapi/asm/socket.h   |   1 +
>  arch/sparc/include/uapi/asm/socket.h    |   1 +
>  drivers/android/binder.c                |  26 +-
>  fs/ceph/xattr.c                         |   6 +-
>  fs/nfs/nfs4proc.c                       |  22 +-
>  fs/nfsd/nfs4xdr.c                       |  20 +-
>  fs/proc/base.c                          |   2 +
>  include/linux/audit.h                   |   1 +
>  include/linux/cred.h                    |   3 +-
>  include/linux/lsm_hooks.h               |  37 +-
>  include/linux/security.h                | 175 ++++++++--
>  include/net/af_unix.h                   |   2 +-
>  include/net/netlabel.h                  |   8 +-
>  include/net/scm.h                       |  15 +-
>  include/uapi/asm-generic/socket.h       |   1 +
>  kernel/audit.c                          |  72 +++-
>  kernel/audit.h                          |   9 +-
>  kernel/audit_fsnotify.c                 |   1 +
>  kernel/auditfilter.c                    |  10 +-
>  kernel/auditsc.c                        | 127 ++++---
>  kernel/cred.c                           |  12 +-
>  net/core/sock.c                         |   7 +-
>  net/ipv4/cipso_ipv4.c                   |   6 +-
>  net/ipv4/ip_sockglue.c                  |  12 +-
>  net/netfilter/nf_conntrack_netlink.c    |  20 +-
>  net/netfilter/nf_conntrack_standalone.c |  11 +-
>  net/netfilter/nfnetlink_queue.c         |  26 +-
>  net/netfilter/nft_meta.c                |  13 +-
>  net/netfilter/xt_SECMARK.c              |   5 +-
>  net/netlabel/netlabel_kapi.c            |   6 +-
>  net/netlabel/netlabel_unlabeled.c       |  97 +++---
>  net/netlabel/netlabel_unlabeled.h       |   2 +-
>  net/netlabel/netlabel_user.c            |  13 +-
>  net/netlabel/netlabel_user.h            |   6 +-
>  net/unix/af_unix.c                      |   6 +-
>  net/xfrm/xfrm_policy.c                  |   2 +
>  net/xfrm/xfrm_state.c                   |   2 +
>  security/apparmor/include/apparmor.h    |   3 +-
>  security/apparmor/include/net.h         |   6 +-
>  security/apparmor/lsm.c                 | 117 +++----
>  security/commoncap.c                    |   7 +-
>  security/integrity/ima/ima.h            |  15 +-
>  security/integrity/ima/ima_api.c        |  11 +-
>  security/integrity/ima/ima_appraise.c   |   6 +-
>  security/integrity/ima/ima_main.c       |  42 +--
>  security/integrity/ima/ima_policy.c     |  19 +-
>  security/integrity/integrity_audit.c    |   1 +
>  security/loadpin/loadpin.c              |   8 +-
>  security/safesetid/lsm.c                |   8 +-
>  security/security.c                     | 593 +++++++++++++++++++++++++++++---
>  security/selinux/hooks.c                | 109 +++---
>  security/selinux/include/classmap.h     |   2 +-
>  security/selinux/include/objsec.h       |   5 +
>  security/selinux/include/security.h     |   1 +
>  security/selinux/netlabel.c             |  25 +-
>  security/selinux/ss/services.c          |   4 +-
>  security/smack/smack.h                  |   6 +
>  security/smack/smack_lsm.c              | 124 ++++---
>  security/smack/smack_netfilter.c        |   8 +-
>  security/smack/smackfs.c                |  10 +-
>  security/tomoyo/tomoyo.c                |   8 +-
>  security/yama/yama_lsm.c                |   7 +-
>  64 files changed, 1372 insertions(+), 560 deletions(-)
