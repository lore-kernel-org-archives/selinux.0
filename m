Return-Path: <SRS0=dC8r=XB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F9BC00307
	for <selinux@archiver.kernel.org>; Fri,  6 Sep 2019 13:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A168208C3
	for <selinux@archiver.kernel.org>; Fri,  6 Sep 2019 13:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gPsXOq2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393379AbfIFNqo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:46:44 -0400
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:27705 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbfIFNqn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Sep 2019 09:46:43 -0400
X-EEMSG-check-017: 22216824|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="22216824"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Sep 2019 13:46:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567777600; x=1599313600;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=m20ndDD36AD4PpeTk/GaTWzxtcwygQ5Y0G7LA03covA=;
  b=gPsXOq2SDu1TZtGLEceASgOc69LFwsjb/GLxvK/R/xNRcUOLFi1JwNuY
   FdFGBi0KgHn7YlRtO/UQQff+9VheaBeqJELIDXKE/BQMMpVUMJejSDka3
   xTYzJvKRu0UIZ7jR7Pi/2z6reYw+jYreJxSVMLUTOEwo3Wyj/CJFGTNFV
   XqJexnpRBSRXEWqFtFN5NAGNb0LaaLwSMQ1Z04QI68Fr3KPZJuL5/95Ru
   zVmgtD3I5A+dX/0bP2lRboUKGgjHDVs4nEZXSB24FhaBaSgKJ4nu0QQ7c
   qqNKFkEUWAs7cqwNsf+u9wPUqz4NXecXe/w7l+arzTe93w3N6jMsc0AMS
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="32475802"
IronPort-PHdr: =?us-ascii?q?9a23=3AbmcKvhcTT46MfNFyn7wNBQEvlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YhKN2/xhgRfzUJnB7Loc0qyK6vqmADNRqsva+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLq8Ubg49vJqkxxx?=
 =?us-ascii?q?bHv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtig9yr0Do5?=
 =?us-ascii?q?G7fS4KxYwoxx7ed/yHc5WI7Qn5WOmNJjd4gXRoc6+8iRaq6UWs1+LxW8au3F?=
 =?us-ascii?q?tKsyZJiMfAu38T2xDJ98SKTOZ28F271jaVzQ/T7/lJIUUzlaXGNZEs2qUwlp?=
 =?us-ascii?q?8PsUTbGS/2hVn2gLeWdko6/uio7PzqYqn8qZ+GNo90lxr+Pr4yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eugz73s4Vf1QLBLjv0yiqXZsZbaKtoHpqOhHgNY3Yku5wy/Aju7yt?=
 =?us-ascii?q?gUg3YKIExfdB6al4TpPkvBIPH8DfexmVSslzJryujdPrL8GZXANWTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzzctF6J5OBbEBJ+zzVlfrtNPEFh85LxC0w+H/BdphzIweQnyAA6?=
 =?us-ascii?q?+CPaPJrVCI5vggI/SCZI8Rpjn9MeEp6OL0gnMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9cDFGcKuRA+TPbriF2ZSjNTYWy9X6ci6TE6Eo6mCp3DRo+1irybwC?=
 =?us-ascii?q?i7BoFWZnxBCl2UFXfodoOEW+oDaS6LOc9ujCALVaW7S48gyRGvtBb2y79gLu?=
 =?us-ascii?q?XJ5y0YsYzs2cNr5+3cix4y7yZ4D8eD3GGXSWF7gGcISyUx3KBlrkx30k2D3r?=
 =?us-ascii?q?Rgg/xECdxT4OtEUhwkOp7Yzux6Dc3yWw3ac9eXR1apXM+mDSsyTt0v2d8OZV?=
 =?us-ascii?q?hyG9G4ghDExSqqDKcfl6aXC5ws7qLcw3/xKt5hxHncz6kukVknTtFUNWK6hq?=
 =?us-ascii?q?5w7RXTB4DNk0qHjaanbqUc3CjR9GidyWqCpl1XUAl1Ua/dR3AQelPWrcjl5k?=
 =?us-ascii?q?PFV7KuCqooPRVaycGeLatKbd7pgE5aS/fjItTeZGexm2atBRaN3L+Ma5Dqe2?=
 =?us-ascii?q?oF1iXHFEcEixwT/WqBNQUmBCehpGLeDDp0GVLtZEPs8fNxqHWgTkAqyQGHdF?=
 =?us-ascii?q?Fu2KCz+h4Sg/ycSu8c0agAuCs7tzp0G1O91crMC9WcvwphYLlcYdQl7Vdfy2?=
 =?us-ascii?q?3ZsQN9PoGhL6Bkn1IecBp4v1no1xppDoVNiskqoGouzAp1N6KXzklNdyiC0p?=
 =?us-ascii?q?DzJ73XMHP98Aqpa6HIwF3e0s6W8L8V6Psks1XjoB2pFk06/nV/ydZVzn+c64?=
 =?us-ascii?q?7SDAUITJLxVl879x19p7HdeCky+ZnY2mFrMamx4Xf+3IcCDfAo216bdNdWLa?=
 =?us-ascii?q?2AGRW6R8YTHMW/APchm1G0YBYJJqVZ/eg/OMbwM7OE3amxJud7tDSviGlGpo?=
 =?us-ascii?q?dn3QbE8yt6V/6NxJsO3uuZwhrCUjDwkVOsmt74lJoCZjwIGGe7jy/+C8oZfa?=
 =?us-ascii?q?B2fIAWGU+wLMCtgNZznZjgXzhf7lHwKUkB3ZqSZReKb1H7lTZV3EATrG3vzT?=
 =?us-ascii?q?C01BRogjopqeyZxyWIzOP8IklUclVXTXVv2A+/abO/iMoXCQ3xNFkk?=
X-IPAS-Result: =?us-ascii?q?A2AQCAAgYXJd/wHyM5BbCh0BAQUBBwUBgWeBaQUqbVMyK?=
 =?us-ascii?q?oQhj1wGgTaJcI8/gWcGAwEBAQEBAQEBASsJAQIBAYQ/AoI3IzgTAgwBAQEEA?=
 =?us-ascii?q?QEBAQEGAwEBbIUuDII6KQGCZgEBAQECASMVPAUQCxgCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYF2BQ8PpxYBgUCBMoVLgzeBQwY1VyiLeBh4gQeBOIFtSTU+gmECAoE0E?=
 =?us-ascii?q?4MjglgElHsBXpZfgiqCK4RShEpDiGEGG5h7jX2IAJJ1IYFYKwgCGAghDzuCb?=
 =?us-ascii?q?IFKgQQXgQQBDII+im8kAzABgQUBAY0XAiQEA4InAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Sep 2019 13:46:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x86DkYAQ001732;
        Fri, 6 Sep 2019 09:46:35 -0400
Subject: Re: [PATCH v8 00/28] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey.schaufler@intel.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
References: <20190829232935.7099-1-casey@schaufler-ca.com>
 <13e1badc-12d2-8ae1-2b98-d9a6a80a615d@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f995037d-dfe0-365e-8e1a-1a0286139af0@tycho.nsa.gov>
Date:   Fri, 6 Sep 2019 09:46:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13e1badc-12d2-8ae1-2b98-d9a6a80a615d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 3:13 PM, Casey Schaufler wrote:
> On 8/29/2019 4:29 PM, Casey Schaufler wrote:
>> This patchset provides the changes required for
>> the AppArmor security module to stack safely with any other.
> 
> What more needs doing before we can land this airship?
> The only outstanding issue I know about is the uses of
> current_security() in SELinux, and Stephen has a patch
> for that. I could see rebasing it, as security-next is
> a little bit behind the times, but that's just merge work.
> We could bikeshed the "compound" context format if we
> have to, and argue about what capabilities are required
> for /proc/self/attr/display if we must.
> 
> If there's objection to the number of patches (28 > 15)
> there are reasonable ways to squash them. If there's objection
> to the amount of change there are rational stages.
> 
> I'm heading off on holiday, and will be limiting my
> screen time for the next couple weeks. Think about it.

My $0.02, roughly in order from what I think will be the largest 
obstacles to merging to the smallest:

1) Changes outside of the security subsystem:
   1a) Userspace API changes e.g. /proc/self/attr/context, 
/proc/self/attr/display, and SO_PEERCONTEXT, likely needs vetting by 
linux-api and the latter by netdev, and audit record changes, needs 
vetting by linux-audit.
   1b) lsmblob changes to core kernel data structures and code, likely 
needs vetting by relevant subsystem maintainers e.g. netdev for 
unix_skb_parms and scm_cookie changes, linux-audit for audit changes, ...
    Whether or not these changes are deemed acceptable by their 
respective maintainers is key to whether this patch set is viable 
irrespective of what any LSM or security module maintainer may think.

2) Controlling setting of /proc/pid/attr/display:
    CAP_MAC_ADMIN isn't an appropriate check for this operation for 
SELinux. The security modules need to be able to provide their own 
access control logic for setting display just as with the other 
attributes, which they could do if you just called the hooks prior to 
setting the display.  At present, in SELinux, CAP_MAC_ADMIN is used only 
to control what processes can get or set file security labels that are 
unknown to the currently loaded policy, as a means of supporting package 
managers that might set down file security labels before loading new 
policy modules or OS image generators that might be generating a 
filesystem image with a policy that differs from the build host OS 
policy. The set of processes that need that ability are quite different 
from the set of processes that will need to set the display, and we do 
not want to conflate them in policy.  I think you are worried that if 
given the opportunity, the security module authors will just block 
setting the display to any value other than their own or setting it at 
all.  How about we just agree to not do that, and if you see a patch 
doing that you can NAK it?

3) Code review and testing by at least the major LSM maintainers:
   At least an Acked-by and preferably Reviewed-by and Tested-by lines 
from the major security module maintainers, not only for changes that 
directly touch the code of their module but all of the patches in the 
series.  Because any of these changes could break or undermine the 
security of any of the security modules.
   Testing also needs to cover new functionality that wasn't previously 
possible, e.g. the new userspace APIs, actual stacking of AA with other 
modules, etc.  So merely running existing testsuites isn't going to suffice.

> 
> Thank you.
> 
>>
>> v8: Incorporate feedback from v7
>>      - Minor clean-up in display value management
>>      - refactor "compound" context creation to use a common
>>        append_ctx() function.
>>
>> v7: Incorporate feedback from v6
>>      - Make setting the display a privileged operation. The
>>        availability of compound contexts reduces the need for
>>        setting the display.
>>
>> v6: Incorporate feedback from v5
>>      - Add subj_<lsm>= and obj_<lsm>= fields to audit records
>>      - Add /proc/.../attr/context to get the full context in
>>        lsmname\0value\0... format as suggested by Simon McVittie
>>      - Add SO_PEERCONTEXT for getsockopt() to get the full context
>>        in the same format, also suggested by Simon McVittie.
>>      - Add /sys/kernel/security/lsm_display_default to provide
>>        the display default value.
>>
>> v5: Incorporate feedback from v4
>>      - Initialize the lsmcontext in security_secid_to_secctx()
>>      - Clear the lsmcontext in all security_release_secctx() cases
>>      - Don't use the "display" on strictly internal context
>>        interfaces.
>>      - The SELinux binder hooks check for cases where the context
>>        "display" isn't compatible with SELinux.
>>
>> v4: Incorporate feedback from v3
>>      - Mark new lsm_<blob>_alloc functions static
>>      - Replace the lsm and slot fields of the security_hook_list
>>        with a pointer to a LSM allocated lsm_id structure. The
>>        LSM identifies if it needs a slot explicitly. Use the
>>        lsm_id rather than make security_add_hooks return the
>>        slot value.
>>      - Validate slot values used in security.c
>>      - Reworked the "display" process attribute handling so that
>>        it works right and doesn't use goofy list processing.
>>      - fix display value check in dentry_init_security
>>      - Replace audit_log of secids with '?' instead of deleting
>>        the audit log
>>
>> v3: Incorporate feedback from v2
>>      - Make lsmblob parameter and variable names more
>>        meaningful, changing "le" and "l" to "blob".
>>      - Improve consistency of constant naming.
>>      - Do more sanity checking during LSM initialization.
>>      - Be a bit clearer about what is temporary scaffolding.
>>      - Rather than clutter security_getpeersec_dgram with
>>        otherwise unnecessary checks remove the apparmor
>>        stub, which does nothing useful.
>>
>> Patches 0001-0003 complete the process of moving management
>> of security blobs that might be shared from the individual
>> modules to the infrastructure.
>>
>> Patches 0004-0014 replace system use of a "secid" with
>> a structure "lsmblob" containing information from the
>> security modules to be held and reused later. At this
>> point lsmblob contains an array of u32 secids, one "slot"
>> for each of the security modules compiled into the
>> kernel that used secids. A "slot" is allocated when
>> a security module requests one.
>> The infrastructure is changed to use the slot number
>> to pass the correct secid to or from the security module
>> hooks.
>>
>> It is important that the lsmblob be a fixed size entity
>> that does not have to be allocated. Several of the places
>> where it is used would have performance and/or locking
>> issues with dynamic allocation.
>>
>> Patch 0015 provides a mechanism for a process to
>> identify which security module's hooks should be used
>> when displaying or converting a security context string.
>> A new interface /proc/.../attr/display contains the name
>> of the security module to show. Reading from this file
>> will present the name of the module, while writing to
>> it will set the value. Only names of active security
>> modules are accepted. Internally, the name is translated
>> to the appropriate "slot" number for the module which
>> is then stored in the task security blob. Setting the
>> display requires CAP_MAC_ADMIN.
>>
>> Patch 0016 Starts the process of changing how a security
>> context is represented. Since it is possible for a
>> security context to have been generated by more than one
>> security module it is now necessary to note which module
>> created a security context so that the correct "release"
>> hook can be called. There are several places where the
>> module that created a security context cannot be inferred.
>>
>> This is achieved by introducing a "lsmcontext" structure
>> which contains the context string, its length and the
>> "slot" number of the security module that created it.
>> The security_release_secctx() interface is changed,
>> replacing the (string,len) pointer pair with a lsmcontext
>> pointer.
>>
>> Patches 0017-0019 convert the security interfaces from
>> (string,len) pointer pairs to a lsmcontext pointer.
>> The slot number identifying the creating module is
>> added by the infrastructure. Where the security context
>> is stored for extended periods the data type is changed.
>>
>> The Netlabel code is converted to save lsmblob structures
>> instead of secids in Patches 0020-21.
>>
>> Patch 0022 adds checks to the SELinux binder hooks
>> which verify that if either "display" used is SELinux
>> both are.
>>
>> Patches 0023-24 add addition data to the audit records
>> to identify the LSM specific data for all active
>> modules.
>>
>> Patches 0025-0027 add new interfaces for getting the
>> compound security contexts.
>>
>> Finally, with all interference on the AppArmor hooks
>> removed, Patch 0028 removes the exclusive bit from
>> AppArmor. An unnecessary stub hook was also removed.
>>
>> The Ubuntu project is using an earlier version of
>> this patchset in their distribution to enable stacking
>> for containers.
>>
>> Performance measurements to date have the change
>> within the "noise". The sockperf and dbench results
>> are on the order of 0.2% to 0.8% difference, with
>> better performance being as common as worse. The
>> benchmarks were run with AppArmor and Smack on Ubuntu.
>>
>> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v8-apparmor
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   arch/alpha/include/uapi/asm/socket.h    |   1 +
>>   arch/mips/include/uapi/asm/socket.h     |   1 +
>>   arch/parisc/include/uapi/asm/socket.h   |   1 +
>>   arch/sparc/include/uapi/asm/socket.h    |   1 +
>>   drivers/android/binder.c                |  24 +-
>>   fs/kernfs/dir.c                         |   5 +-
>>   fs/kernfs/inode.c                       |  35 +-
>>   fs/kernfs/kernfs-internal.h             |   3 +-
>>   fs/nfs/nfs4proc.c                       |  22 +-
>>   fs/nfsd/nfs4xdr.c                       |  20 +-
>>   fs/proc/base.c                          |   2 +
>>   include/linux/audit.h                   |   1 +
>>   include/linux/cred.h                    |   3 +-
>>   include/linux/lsm_hooks.h               |  39 +-
>>   include/linux/security.h                | 184 ++++++++--
>>   include/net/af_unix.h                   |   2 +-
>>   include/net/netlabel.h                  |   8 +-
>>   include/net/scm.h                       |  15 +-
>>   include/uapi/asm-generic/socket.h       |   1 +
>>   kernel/audit.c                          |  70 +++-
>>   kernel/audit.h                          |   9 +-
>>   kernel/audit_fsnotify.c                 |   1 +
>>   kernel/auditfilter.c                    |  10 +-
>>   kernel/auditsc.c                        | 129 ++++---
>>   kernel/cred.c                           |  12 +-
>>   net/core/sock.c                         |   7 +-
>>   net/ipv4/cipso_ipv4.c                   |   6 +-
>>   net/ipv4/ip_sockglue.c                  |  12 +-
>>   net/netfilter/nf_conntrack_netlink.c    |  20 +-
>>   net/netfilter/nf_conntrack_standalone.c |  11 +-
>>   net/netfilter/nfnetlink_queue.c         |  26 +-
>>   net/netfilter/nft_meta.c                |  13 +-
>>   net/netfilter/xt_SECMARK.c              |   5 +-
>>   net/netlabel/netlabel_kapi.c            |   6 +-
>>   net/netlabel/netlabel_unlabeled.c       |  98 ++---
>>   net/netlabel/netlabel_unlabeled.h       |   2 +-
>>   net/netlabel/netlabel_user.c            |  13 +-
>>   net/netlabel/netlabel_user.h            |   6 +-
>>   net/unix/af_unix.c                      |   6 +-
>>   net/xfrm/xfrm_policy.c                  |   2 +
>>   net/xfrm/xfrm_state.c                   |   2 +
>>   security/apparmor/include/net.h         |   6 +-
>>   security/apparmor/lsm.c                 |  85 ++---
>>   security/commoncap.c                    |   7 +-
>>   security/inode.c                        |  22 +-
>>   security/integrity/ima/ima.h            |  14 +-
>>   security/integrity/ima/ima_api.c        |  10 +-
>>   security/integrity/ima/ima_appraise.c   |   6 +-
>>   security/integrity/ima/ima_main.c       |  36 +-
>>   security/integrity/ima/ima_policy.c     |  19 +-
>>   security/integrity/integrity_audit.c    |   1 +
>>   security/loadpin/loadpin.c              |   8 +-
>>   security/safesetid/lsm.c                |   8 +-
>>   security/security.c                     | 632 +++++++++++++++++++++++++++++---
>>   security/selinux/hooks.c                | 213 +++++------
>>   security/selinux/include/objsec.h       |  18 +
>>   security/selinux/include/security.h     |   1 +
>>   security/selinux/netlabel.c             |  25 +-
>>   security/selinux/ss/services.c          |   7 +-
>>   security/smack/smack.h                  |  19 +
>>   security/smack/smack_lsm.c              | 185 +++++-----
>>   security/smack/smack_netfilter.c        |   8 +-
>>   security/smack/smackfs.c                |  10 +-
>>   security/tomoyo/tomoyo.c                |   8 +-
>>   security/yama/yama_lsm.c                |   7 +-
>>   65 files changed, 1503 insertions(+), 686 deletions(-)
>>
> 

