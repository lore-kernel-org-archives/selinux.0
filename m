Return-Path: <SRS0=nm5n=YW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD5ACA9EAE
	for <selinux@archiver.kernel.org>; Tue, 29 Oct 2019 14:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5BD2087E
	for <selinux@archiver.kernel.org>; Tue, 29 Oct 2019 14:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aPanIaCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbfJ2Oxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:53:44 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:49906 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389398AbfJ2Oxo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Oct 2019 10:53:44 -0400
X-EEMSG-check-017: 26346869|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,244,1569283200"; 
   d="scan'208";a="26346869"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Oct 2019 14:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572360821; x=1603896821;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4QxKrpUVXbEzUFN7KoxZbl5znmw7oMLlq4MufkEBlcY=;
  b=aPanIaCoZr70jUBr/vndiFgELGUaM0uXdJG+kWfxb6wRtqcsJ9vMminH
   t4NBHBSeFi32Gs0cUtgxiDNJ98uJxzLhZ6triB0L+CUIs8l8YMYV0t5u4
   s4MLFXUogBfebkJbvlt/59Rp0oLYCrZfoauBKAmRenui1Ol0ykSERx9Zd
   gr1pMogynS2Jfoz3Wa+1hpk4vVdiQ5Qy9XKVJfAoOjZmGBZ1In/PjyKzW
   Saqfgf6d+XEelqYI9ovSLYoF8BAN38CIVSQAQ/hZp528goScermuckYJq
   bisr45vRqQZ2M/DFDadEmdSG62I4PiJYm5u07JYmzoB1MQyVbCpsh8ura
   A==;
X-IronPort-AV: E=Sophos;i="5.68,244,1569283200"; 
   d="scan'208";a="34817215"
IronPort-PHdr: =?us-ascii?q?9a23=3AAdjM0xH4DRbrKZ1agQSqHJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8W5bnLW6fgltlLVR4KTs6sC17ON9fm4ACdev96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdutULjYdtK6s8yw?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUSx5QnxgLfa/yac4eT+B7sSOGRITJ+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kLqQvmtCwAeQ/Mg?=
 =?us-ascii?q?QUWWiU5f+826H58U38QbVKiuU6kqjfsJ/EOcQWvrO1DgBa34o56xuzEi2q3M?=
 =?us-ascii?q?oXkHUZNl5JZQqLj43zNFHPJPD4A+2/g1OpkDpz3PDJI6bhD47RLnnDjLjhfb?=
 =?us-ascii?q?F951RayAoo199T/Z1UCrYfIP7rQE/+qMTYDgMlMwyz2+voFM9y1pgAVmOPGa?=
 =?us-ascii?q?KZK7/dsV+S6eIyLemMYJEauCzkJ/c5/fHil2M2mVgYfaOxx5sYdGi4Huh6I0?=
 =?us-ascii?q?WeeXfjns0OEXwUsQs+VuDqk0GNUT5JaHavUaI84i80CJi9AIfCQICtnKKO3C?=
 =?us-ascii?q?OhEpJKYWBGD0iGEW30eIWcR/cMdCWSL9djkjwBUrihUZUh1RC1tALhzbpoNO?=
 =?us-ascii?q?/U9TMZtZ7509h1/eLTnwko9TNoF8Sdz32NT2Zsk2MMRj822r1/oENkxleYz6?=
 =?us-ascii?q?d3n+FYFcZS5/NVUgY2LJvcz+tnBNDvXgLOYMyESEipQtq4GzE9VNExzMEUY0?=
 =?us-ascii?q?Z7BdqiigrP3y2wA78aj7aLHoA78rrA33jtIMZw023G27clj1knRMtPKGKni7?=
 =?us-ascii?q?Vh9wjcGYHJiV+Vl6W0eqQG2i7C6mODwXCJvEFCXw56Sb/FUmwHZkvKsdT54V?=
 =?us-ascii?q?vPT7ywBrs5KQtO1cmCKqxJatDykVpGRO3jONPbY2KwhmewAAyExrSWbIrlY2?=
 =?us-ascii?q?8dxjnSCFAYkwAP+naLLQo+BiCho2LYFjBuF1XvY0P2/ul4s3O0UEk0whqWYE?=
 =?us-ascii?q?J70bq1/RgVhf2ARPwJ2rIIojsuqzJxHFylxdLZF8KApxZ9fKVbed49+ElI1W?=
 =?us-ascii?q?TWtwxgP5ygKbluhl0AfARtuUPhyRF3B55BkcQzqHMqyxRyJryC3FNabTyY3o?=
 =?us-ascii?q?3wOqfNJWXo+hCgdbTa2lPG0NyO4KcA9Ow4q0n/vAGuDkci629o08RR03aH/p?=
 =?us-ascii?q?XFFhcSUZboXkYy8Bh6oKvabTcn64zI0n1sNPr8jjiX8NsyCfpt8R2gdspRNK?=
 =?us-ascii?q?6eXFv5GtYXFuC1I+wjhlatYwhBN+kU/6kxaYfufPKd1b/tJ+1glS+oiWldyI?=
 =?us-ascii?q?F7zk+IsSF7T6qA3ZMC2euZxSOBXjLxjRGmqM+z0YRFYywCW3GywjX+BZJAI6?=
 =?us-ascii?q?h1cZsPBE+wLMCtgNZznZjgXzhf7lHnT0gL3M6vZAq6cVPwx0tT2F4RrHjhnj?=
 =?us-ascii?q?G3nBJulDR8lbaSxCzDxazZcRMDPmNaDD15gUzEPZm/j9dcWlOhKQcuik32tg?=
 =?us-ascii?q?7B26FHqfEnfCHoSkBScn2zdjozXw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CqBQDzUbhd/wHyM5BaChwBAQEBAQcBAREBBAQBAYF9g?=
 =?us-ascii?q?XQsbFUyKoQoj1oBAQEBAQEGgREliWOPSoFnCQEBAQEBAQEBASsJAQIBAYRAA?=
 =?us-ascii?q?oNXJDgTAgwBAQEEAQEBAQEFAwEBbIU3DII7KQGCbAEBAQECASMVQRALGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz8BglIFIA+xenWBMoVOgzyBQgaBDiiMERh4gQeBOAyBY?=
 =?us-ascii?q?X4+gmICAoE0E4Mogl4ElVdhlzKCLoIzhF2EV0SIfgYbmVyOP4gskzAigVgrC?=
 =?us-ascii?q?AIYCCEPO4JsUBAUhnmKbyUDMAGBBAEBjHcCJAQDghIBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Oct 2019 14:53:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9TErYiM031644;
        Tue, 29 Oct 2019 10:53:35 -0400
Subject: Re: [PATCH v10 00/25] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191024205228.6922-1-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ce6c4861-2767-89ab-bad5-f633a67b3fc9@tycho.nsa.gov>
Date:   Tue, 29 Oct 2019 10:53:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/19 4:52 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
> 
> v10: Ask the security modules if the display can be changed.
> 
> v9: There is no version 9
> 
> v8: Incorporate feedback from v7
>      - Minor clean-up in display value management
>      - refactor "compound" context creation to use a common
>        append_ctx() function.
> 
> v7: Incorporate feedback from v6
>      - Make setting the display a privileged operation. The
>        availability of compound contexts reduces the need for
>        setting the display.
> 
> v6: Incorporate feedback from v5
>      - Add subj_<lsm>= and obj_<lsm>= fields to audit records
>      - Add /proc/.../attr/context to get the full context in
>        lsmname\0value\0... format as suggested by Simon McVittie
>      - Add SO_PEERCONTEXT for getsockopt() to get the full context
>        in the same format, also suggested by Simon McVittie.
>      - Add /sys/kernel/security/lsm_display_default to provide
>        the display default value.
> 
> v5: Incorporate feedback from v4
>      - Initialize the lsmcontext in security_secid_to_secctx()
>      - Clear the lsmcontext in all security_release_secctx() cases
>      - Don't use the "display" on strictly internal context
>        interfaces.
>      - The SELinux binder hooks check for cases where the context
>        "display" isn't compatible with SELinux.
> 
> v4: Incorporate feedback from v3
>      - Mark new lsm_<blob>_alloc functions static
>      - Replace the lsm and slot fields of the security_hook_list
>        with a pointer to a LSM allocated lsm_id structure. The
>        LSM identifies if it needs a slot explicitly. Use the
>        lsm_id rather than make security_add_hooks return the
>        slot value.
>      - Validate slot values used in security.c
>      - Reworked the "display" process attribute handling so that
>        it works right and doesn't use goofy list processing.
>      - fix display value check in dentry_init_security
>      - Replace audit_log of secids with '?' instead of deleting
>        the audit log
> 
> v3: Incorporate feedback from v2
>      - Make lsmblob parameter and variable names more
>        meaningful, changing "le" and "l" to "blob".
>      - Improve consistency of constant naming.
>      - Do more sanity checking during LSM initialization.
>      - Be a bit clearer about what is temporary scaffolding.
>      - Rather than clutter security_getpeersec_dgram with
>        otherwise unnecessary checks remove the apparmor
>        stub, which does nothing useful.
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
> A new interface /proc/.../attr/display contains the name
> of the security module to show. Reading from this file
> will present the name of the module, while writing to
> it will set the value. Only names of active security
> modules are accepted. Internally, the name is translated
> to the appropriate "slot" number for the module which
> is then stored in the task security blob. Setting the
> display requires that all modules using the /proc interfaces
> allow the transition.
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
> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v10-apparmor

Can you re-base on something more recent than v5.1-rc2 (that's the base 
for that branch currently)?
At present it won't even boot for me on modern Fedora.  Two key missing 
commits are:

e33c1b9923775d17ad246946fe67fcb9be288677 ("apparmor: Restore Y/N in /sys 
for apparmor's "enabled") - without this, dbus falls over (or at least 
dbus-broker in Fedora)

169ce0c081cd85f78388bb6c1638c1ad7b81bde7 ("selinux: fix residual uses of 
current_security() for the SELinux blob") - without this, selinux ends 
up dereferencing something other than its own security blob after these 
patches

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   arch/alpha/include/uapi/asm/socket.h    |   1 +
>   arch/mips/include/uapi/asm/socket.h     |   1 +
>   arch/parisc/include/uapi/asm/socket.h   |   1 +
>   arch/sparc/include/uapi/asm/socket.h    |   1 +
>   drivers/android/binder.c                |  24 +-
>   fs/kernfs/dir.c                         |   5 +-
>   fs/kernfs/inode.c                       |  35 +-
>   fs/kernfs/kernfs-internal.h             |   3 +-
>   fs/nfs/nfs4proc.c                       |  22 +-
>   fs/nfsd/nfs4xdr.c                       |  20 +-
>   fs/proc/base.c                          |   2 +
>   include/linux/audit.h                   |   1 +
>   include/linux/cred.h                    |   3 +-
>   include/linux/lsm_hooks.h               |  37 +-
>   include/linux/security.h                | 175 ++++++++--
>   include/net/af_unix.h                   |   2 +-
>   include/net/netlabel.h                  |   8 +-
>   include/net/scm.h                       |  15 +-
>   include/uapi/asm-generic/socket.h       |   1 +
>   kernel/audit.c                          |  70 +++-
>   kernel/audit.h                          |   9 +-
>   kernel/audit_fsnotify.c                 |   1 +
>   kernel/auditfilter.c                    |  10 +-
>   kernel/auditsc.c                        | 129 ++++---
>   kernel/cred.c                           |  12 +-
>   net/core/sock.c                         |   7 +-
>   net/ipv4/cipso_ipv4.c                   |   6 +-
>   net/ipv4/ip_sockglue.c                  |  12 +-
>   net/netfilter/nf_conntrack_netlink.c    |  20 +-
>   net/netfilter/nf_conntrack_standalone.c |  11 +-
>   net/netfilter/nfnetlink_queue.c         |  26 +-
>   net/netfilter/nft_meta.c                |  13 +-
>   net/netfilter/xt_SECMARK.c              |   5 +-
>   net/netlabel/netlabel_kapi.c            |   6 +-
>   net/netlabel/netlabel_unlabeled.c       |  97 +++---
>   net/netlabel/netlabel_unlabeled.h       |   2 +-
>   net/netlabel/netlabel_user.c            |  13 +-
>   net/netlabel/netlabel_user.h            |   6 +-
>   net/unix/af_unix.c                      |   6 +-
>   net/xfrm/xfrm_policy.c                  |   2 +
>   net/xfrm/xfrm_state.c                   |   2 +
>   security/apparmor/include/apparmor.h    |   3 +-
>   security/apparmor/include/net.h         |   6 +-
>   security/apparmor/lsm.c                 | 121 ++++---
>   security/commoncap.c                    |   7 +-
>   security/integrity/ima/ima.h            |  14 +-
>   security/integrity/ima/ima_api.c        |  10 +-
>   security/integrity/ima/ima_appraise.c   |   6 +-
>   security/integrity/ima/ima_main.c       |  36 +-
>   security/integrity/ima/ima_policy.c     |  19 +-
>   security/integrity/integrity_audit.c    |   1 +
>   security/loadpin/loadpin.c              |   8 +-
>   security/safesetid/lsm.c                |   8 +-
>   security/security.c                     | 586 +++++++++++++++++++++++++++++---
>   security/selinux/hooks.c                | 109 +++---
>   security/selinux/include/classmap.h     |   2 +-
>   security/selinux/include/objsec.h       |   5 +
>   security/selinux/include/security.h     |   1 +
>   security/selinux/netlabel.c             |  25 +-
>   security/selinux/ss/services.c          |   4 +-
>   security/smack/smack.h                  |   6 +
>   security/smack/smack_lsm.c              | 124 ++++---
>   security/smack/smack_netfilter.c        |   8 +-
>   security/smack/smackfs.c                |  10 +-
>   security/tomoyo/tomoyo.c                |   8 +-
>   security/yama/yama_lsm.c                |   7 +-
>   66 files changed, 1376 insertions(+), 580 deletions(-)
> 

