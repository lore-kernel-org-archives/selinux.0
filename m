Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB690C282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715FB205F4
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ocJDFuuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfFDRMU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:12:20 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:41060 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfFDRMU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Jun 2019 13:12:20 -0400
X-EEMSG-check-017: 717043231|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="717043231"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Jun 2019 17:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559668320; x=1591204320;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QMwajf2ot7Hl/CIFOdQkB7VpEqChE0eQF8gXuh6xYz8=;
  b=ocJDFuuQe4/mNIhEt0fQ5CM2wvQeui3YRcYMOVRGPkFqMxR7E5Tk6SY+
   czTUgd26Ns6mh4/YzMvZPKH21PQjWDTWyAVS6QID0y+C45irhgoKcCBY2
   IfGTXoxm6WTFZhEYUGDTUIav059CuZfAEpj+R6WrGHPGMJYgYy0/UyjpE
   ZSYVZ1+J3+yrjQ++Af7ENq6ty50SScqtWCVFyuSfa4TtRxfETmmKx4kMm
   QzblLyQnQ6md9Wk3slFr5s761BTKSTgDXXR4gvy4CWe0KhtL9oQYUoNJ9
   ANcsvBlu5LU7As0SGLKgBJiwcPfqnYwh3x46WRC2qXVfluVQBamJTUdiK
   A==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="28546115"
IronPort-PHdr: =?us-ascii?q?9a23=3AsTK7TBcaBwSziW5RgfvNSCZdlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+bRKN2/xhgRfzUJnB7Loc0qyK6vmmADdRqs/Z4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajIVmJ6o+1x?=
 =?us-ascii?q?fFvnhFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9V1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nxLMGvp?=
 =?us-ascii?q?u7czILyJQh3xPfZP2Hc5SI4hL+T+mdOyt3hHVgeL+5mh288lCgx/XhWsS731?=
 =?us-ascii?q?tGtCpInsTWunwT2BHf9NKLRuZ780y8wziAzRrT5ftBIU0skKrbLIMuzaAom5?=
 =?us-ascii?q?oItETDAjf2mELrjK+Kbkkk+van6+DgYrj+up+TLZV0igDjMqQ1gMC/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qHs/VblT7lQi/02k63ZvIjbJcQduKG5HxdY3pss5huwFTur0M?=
 =?us-ascii?q?kUkWMZIF9KZh6LlZXlN0nLIP/iDPe/h1qskC1sx/DDJrDhGYjCLmPYnbf9fb?=
 =?us-ascii?q?dy905cyA0pwdBZ/JJbEKsNIP30Wk/vrNDYFAM2MxSow+b7D9Vwzp8RVniUAq?=
 =?us-ascii?q?CHMKLfqkSI6f4vI+aWeY8VtjL9JOY/5/L3kXA2g0URcrWu3ZsScHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCXsFsRAlTOP0iFyOSyVTaGqyX60m+zE7BoamApnZRo22gbyB2j?=
 =?us-ascii?q?u7EYNSZmxcFl+MFnLofZ2eW/gQcCKSPtNhkjscWLijTo8h0guutBX7y7p8Ne?=
 =?us-ascii?q?fU/DcXtZf929h0/eHTkgsy9TNsBcSHz26NV310nn8PRzIu2KB/oEp9ykqM0K?=
 =?us-ascii?q?RhmPxXC8Bc5+5TUgc7KZ7dz/V2C9X1Wg3cY9eJTEipT864ATE+UN0x2cUCY0?=
 =?us-ascii?q?VjFNW4iBDMwS6qD6USl7yRC5w+6rjc0GTpJ8Zh13bG07Esj0I4TctLNG2mgL?=
 =?us-ascii?q?N/9gfICo7XnEWWibyqeb4f3CHT7meDy3SBvEVCXA53S6XFUmgVZlHKotTh+k?=
 =?us-ascii?q?PCU7iuBKwkMgRf18GCMbdFatrujVVFX/rsJNTeY3i2m2e1BBaI27aMYJDte2?=
 =?us-ascii?q?UH0yXXEFIEnBwL/XaaKQg+AT+so2DZDDxuE1LjeUHs8e5+qHyhSE801B+Fb0?=
 =?us-ascii?q?t62rWp4BEVg/ucS/US3r0Yoighry94E0q639LTE9CAvRZufL1AYdMh51dKzX?=
 =?us-ascii?q?rZuBJ7PpyvMqBih1gefx10v0zwzRV3DJtPkcwxoXMr1QZyLaWY0E1feD+Cxp?=
 =?us-ascii?q?D/IL7XKnTo/B+1caLW3E/R3MyU+qcX8P44sUnsvBm1Fko+9HVqy8FV3GGB5p?=
 =?us-ascii?q?XOFwcSSYj+Ulsz9xRjorHaZS4955nK2nF2Laa0tTrCiJoVA74Oww2tbp9kO6?=
 =?us-ascii?q?ONCQH2HtdSU8OnM+E7s0OibhsZMuRf7us/NoWtcP7QnOagNf1tjXS9hmRO/Y?=
 =?us-ascii?q?5531ik9ixgR+qO1JEAh7ma2wydTTbnpFGot83234deanVaGmu51DihH4Nae7?=
 =?us-ascii?q?dzYZdODGCiPsm67stxioSrWHNC8lOnQVQc14vhYheWblrgzSVO2kkN53+qgy?=
 =?us-ascii?q?21y3pziT56gLCY2Xn13+n6dBcBclVOTW1mgEakdZO4lPgGTUOoaE4vjxLj6k?=
 =?us-ascii?q?HkkfsI7J9jJnXeFB8bNxP9KHtvB+7p7euP?=
X-IPAS-Result: =?us-ascii?q?A2BhBgBDpfZc/wHyM5BmHQEBBQEHBQGBZYFnKmpSMiiEF?=
 =?us-ascii?q?JNTAQEBAQEBBoEICCWJUJEICQEBAQEBAQEBASsJAQIBAYRAAoJSIzgTAQMBA?=
 =?us-ascii?q?QEEAQEBAQMBAWwcDII6KQGCZgEBAQECASMPAQVBEAkCGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QEagkU/AYF2BQ8Piz2baoExhUeDJoFABoEMKItaF3iBB4E4DIFhfj6CYQICh?=
 =?us-ascii?q?GmCWASLNhgDh1KVYgmCEIIZhCiET4ggBhuCI4Z1hAKJXY0KgWmFJZEkIYFYK?=
 =?us-ascii?q?wgCGAghDzuCbIIWBAEXg02KbyMDMAGBBQEBkEoBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Jun 2019 17:12:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x54HBwXw001557;
        Tue, 4 Jun 2019 13:11:58 -0400
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190602165101.25079-1-casey@schaufler-ca.com>
 <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov>
 <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2a9049a7-6259-5ae0-2790-0aaf337c51a4@tycho.nsa.gov>
Date:   Tue, 4 Jun 2019 13:11:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/4/19 12:14 PM, Casey Schaufler wrote:
> On 6/4/2019 5:29 AM, Stephen Smalley wrote:
>> On 6/2/19 12:50 PM, Casey Schaufler wrote:
>>> This patchset provides the changes required for
>>> the AppArmor security module to stack safely with any other.
>>
>> Please explain the motivation
> 
> I'll add some explanation for the next revision.
> It won't be anything that I haven't posted many times
> before, but you're right that it belongs in the log.
> 
>> - why do we want to allow AppArmor to stack with other modules,
> 
> First, is there a reason not to? Sure, you can confuse
> administrators by implementing complex security policies,
> but there are lots of ways to do that already.

There are costs to doing so, e.g.
- greater complexity in the security framework,
- possibly greater memory and runtime overheads,
- potential user confusion (which security module(s) caused a given 
failure?)
- potential distro maintainer burden (similar to above, but performing 
triage when any given permission denial can have multiple causes beyond 
just DAC + one module, weird interactions among modules, etc)

It isn't free so there should be a cost/benefit analysis.

> 
> AppArmor provides a different security model than SELinux,
> TOMOYO or Smack. Smack is better at system component
> separation, while AppArmor is better at application isolation.
> It's a win to use each to its strength rather than trying to
> stretch either to the edge of what it can do.
> 
>> who would use it,
> 
> Can't name names, but there have been multiple requests.
> 
>> how would it be used,
> 
> As mentioned above, Smack for system separation, AppArmor for
> application isolation.

Can you provide a concrete example of how combining the two yields a 
smaller, simpler configuration overall than using them individually?

> 
>> what does it provide that isn't already possible in the absence of it.
> 
> It's not necessary that something be impossible to do any
> other way. The question should be whether this provides for
> a better way to achieve the goals, and this does that.
> If I tried the come up with something that's impossible I
> would expect the usual "you can do that with SELinux policy"
> argument. We know we can do things. We want to have the tools
> to do them better.
> 
>> Also, Ubuntu fully upstreamed all of their changes to AppArmor, would this still suffice to enable stacking of AppArmor or do they rely on hooks that are not handled here?
> 
> Some amount of merging will likely be required. But that's
> always going to be true with parallel development tracks.
> That's why we have git!
> 
>> Please explain the cost of the change - what do we pay in terms of memory, runtime, or other overheads in order to support this change?
> 
> Do you have particular benchmarks you want to see?
> When I've supplied numbers in the past they have not
> been remarked on.

A combination of micro and macro benchmarks exercising multiple kernel 
subsystems would be good.  Kernel build time isn't sufficient.

> 
>>
>>>
>>> A new process attribute identifies which security module
>>> information should be reported by SO_PEERSEC and the
>>> /proc/.../attr/current interface. This is provided by
>>> /proc/.../attr/display. Writing the name of the security
>>> module desired to this interface will set which LSM hooks
>>> will be called for this information. The first security
>>> module providing the hooks will be used by default.
>>
>> Doesn't this effectively undo making the hooks read-only after init, at least for the subset involved?  What are the security implications thereof?
> 
> Any mechanism, be it a separate set of hooks, a name used to
> do list look ups, or an sophisticated hash scheme will have that
> impact for the processes that use it. This scheme has the best
> performance profile of the mechanisms I experimented with and
> avoids all sorts of special cases.
> 
>>
>>> The use of integer based security tokens (secids) is
>>> generally (but not completely) replaced by a structure
>>> lsm_export. The lsm_export structure can contain information
>>> for each of the security modules that export information
>>> outside the LSM layer.
>>>
>>> The LSM interfaces that provide "secctx" text strings
>>> have been changed to use a structure "lsm_context"
>>> instead of a pointer/length pair. In some cases the
>>> interfaces used a "char *" pointer and in others a
>>> "void *". This was necessary to ensure that the correct
>>> release mechanism for the text is used. It also makes
>>> many of the interfaces cleaner.
>>>
>>> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>    drivers/android/binder.c                |  25 ++-
>>>    fs/kernfs/dir.c                         |   6 +-
>>>    fs/kernfs/inode.c                       |  31 ++-
>>>    fs/kernfs/kernfs-internal.h             |   3 +-
>>>    fs/nfs/inode.c                          |  13 +-
>>>    fs/nfs/internal.h                       |   8 +-
>>>    fs/nfs/nfs4proc.c                       |  17 +-
>>>    fs/nfs/nfs4xdr.c                        |  16 +-
>>>    fs/nfsd/nfs4proc.c                      |   8 +-
>>>    fs/nfsd/nfs4xdr.c                       |  14 +-
>>>    fs/nfsd/vfs.c                           |   7 +-
>>>    fs/proc/base.c                          |   1 +
>>>    include/linux/cred.h                    |   3 +-
>>>    include/linux/lsm_hooks.h               |  91 +++++----
>>>    include/linux/nfs4.h                    |   8 +-
>>>    include/linux/security.h                | 133 +++++++++----
>>>    include/net/af_unix.h                   |   2 +-
>>>    include/net/netlabel.h                  |  10 +-
>>>    include/net/scm.h                       |  14 +-
>>>    kernel/audit.c                          |  43 ++--
>>>    kernel/audit.h                          |   9 +-
>>>    kernel/auditfilter.c                    |   6 +-
>>>    kernel/auditsc.c                        |  77 ++++----
>>>    kernel/cred.c                           |  15 +-
>>>    net/ipv4/cipso_ipv4.c                   |  13 +-
>>>    net/ipv4/ip_sockglue.c                  |  12 +-
>>>    net/netfilter/nf_conntrack_netlink.c    |  29 ++-
>>>    net/netfilter/nf_conntrack_standalone.c |  16 +-
>>>    net/netfilter/nfnetlink_queue.c         |  38 ++--
>>>    net/netfilter/nft_meta.c                |  13 +-
>>>    net/netfilter/xt_SECMARK.c              |  14 +-
>>>    net/netlabel/netlabel_kapi.c            |   5 +-
>>>    net/netlabel/netlabel_unlabeled.c       | 101 +++++-----
>>>    net/netlabel/netlabel_unlabeled.h       |   2 +-
>>>    net/netlabel/netlabel_user.c            |  13 +-
>>>    net/netlabel/netlabel_user.h            |   2 +-
>>>    net/unix/af_unix.c                      |   6 +-
>>>    security/apparmor/audit.c               |   4 +-
>>>    security/apparmor/include/audit.h       |   2 +-
>>>    security/apparmor/include/net.h         |   6 +-
>>>    security/apparmor/include/secid.h       |   9 +-
>>>    security/apparmor/lsm.c                 |  64 +++---
>>>    security/apparmor/secid.c               |  42 ++--
>>>    security/integrity/ima/ima.h            |  14 +-
>>>    security/integrity/ima/ima_api.c        |   9 +-
>>>    security/integrity/ima/ima_appraise.c   |   6 +-
>>>    security/integrity/ima/ima_main.c       |  34 ++--
>>>    security/integrity/ima/ima_policy.c     |  19 +-
>>>    security/security.c                     | 338 +++++++++++++++++++++++++++-----
>>>    security/selinux/hooks.c                | 259 ++++++++++++------------
>>>    security/selinux/include/audit.h        |   5 +-
>>>    security/selinux/include/objsec.h       |  42 +++-
>>>    security/selinux/netlabel.c             |  25 +--
>>>    security/selinux/ss/services.c          |  18 +-
>>>    security/smack/smack.h                  |  18 ++
>>>    security/smack/smack_lsm.c              | 238 +++++++++++-----------
>>>    security/smack/smack_netfilter.c        |   8 +-
>>>    security/smack/smackfs.c                |  12 +-
>>>    58 files changed, 1217 insertions(+), 779 deletions(-)
>>>
>>

