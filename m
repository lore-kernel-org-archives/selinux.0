Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D658C282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9642070B
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 20:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PvxMmhZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFDUek (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:34:40 -0400
Received: from uhil19pa14.eemsg.mail.mil ([214.24.21.87]:23506 "EHLO
        UHIL19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFDUej (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Jun 2019 16:34:39 -0400
X-EEMSG-check-017: 58595285|UHIL19PA14_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Jun 2019 20:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559680477; x=1591216477;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Gu0SFmDDlTT2lLMk1e+LWp1gsU810jbO7RkYMDEstb4=;
  b=PvxMmhZQdPqRps3u5QUHy2MEsJqezr4gvoUywu3QsntPjRtuQMs5B/nR
   xx5+qOy1d2ILcdZpIfti7B2gzAVNhE4VhuT20V9Rdo1rjFlwSg+CHpLMI
   Bes5jDRzhuGsJlOdNhgUBJbBNJyf9Zw7b7dlJ7wtCajv8EbUzhquGGXGH
   neyq+AHs0jMqHQ+8iisWB7OmTyjOMwGedPdQmbuu9vVGrLEscWwNL/Ayo
   6/cvMkevBArOIikyT5Ida8awVEvfvBIAzPmTyI+LgrPDATEgOA2w3yPcI
   ZMmueVJVUJaKPJIFMePNrg87tb2KIu7lgINxuEeUicU3amPPRHIpPn2iT
   A==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="28562418"
IronPort-PHdr: =?us-ascii?q?9a23=3AOr+SAhMv7klAAmMluhcl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/jypMbcNUDSrc9gkEXOFd2Cra4d0qyP7/irADRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+roQjeqsUajpZuJroswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZCcKyJU7xx7fdvyIaJKE7Q7kVOaUJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kB3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OUHSA+eugzrHj+Ez5QLFSgv03lKnWrozaKNwGqqO2DAJZyIYu5wulAzu439?=
 =?us-ascii?q?kUg2MLIE9ddBKClYfpOlXOIP7iDfe4hlShiCxryO3dPrD6HpXMLmTMkLfmfb?=
 =?us-ascii?q?pn7U5c0xA8wcpQ55JTFLENOOjzVVPptNzEEh85NBS5zPr9B9VmyIwfWXmCAr?=
 =?us-ascii?q?SFP6PSq1CI++wvI+2Sa48PoTryN+Iq6+Tygn8+nF8XZbOp0ocPaHCkAvRmJF?=
 =?us-ascii?q?2Ubmb2jdcaD2gLvhAyTPf2h12CSzFTeniyX6Yi6TEhE4+mDIHDRpyzj7yFxi?=
 =?us-ascii?q?u0AppWZmVeAFCWDXjob5mEW+sLaC+KIM9hlzsEVaK7S48gzhGjrwn6xKBiLu?=
 =?us-ascii?q?XK+y0Ur5Xj1MJ65+fLjxE96SR0D9iB02GKV2x0mmIIRzkr3KFwuEB90UmM3r?=
 =?us-ascii?q?Rlg/xCFNxT+/NIXh4/NZ7b0uN6FtTyVRzac9eXR1apXM+mDSsyTt0v2d8OZV?=
 =?us-ascii?q?hyG9G4ghDExSqqDKcfl6aXC5ws7qLcw3/xKt5my3nY0Kkhjl8mQtZANGC9mK?=
 =?us-ascii?q?5/+BbcB5TTn0Waiamqb6Ic0zDJ9GuZymqOpk5YWhZqUarZRXAfelfWrdPh60?=
 =?us-ascii?q?PBUbChF68nPRdGyc6FKatHccHmjVVcRPfkPdTeYn+xm2KqCRaP3LOMY5Lge3?=
 =?us-ascii?q?8B0yXFFEgEjwcT8G6ENQg5BiehpXjSDD5pFVLveUzs9/J+p229TkIv0w6FdU?=
 =?us-ascii?q?th172z+h4UmfOTUfcT0qgYtycmrjV+BEy90M7OC9qcuwphe71RYcsj71dB2m?=
 =?us-ascii?q?LZqg19Ppq5I6BhmFEeaQJ3sF3q1xhsC4VMiMwqrHQ0zAVsM66Yy0lOdzCF3Z?=
 =?us-ascii?q?DqILLbMG/y8w61Z67UwlHUyMyW9bsX6PQkt1XjuxmkFlI4/HV619lYyGOc6Y?=
 =?us-ascii?q?/XDAoWSJ7xV0E39x9gp77EeCUy+4TU1Xg/eZWz5xTLwN84TNAuyh+9cdNSKu?=
 =?us-ascii?q?vQHwbpHtwyHMOuIfEkn1WzKxkNeutV8fhwd8ivbPaXnrWgPO99kjarl0xG5p?=
 =?us-ascii?q?xw1gSH8C84AuzN2Iwfwuqw2AKCWja6i02u9ojzmIZZdXQJE2Gi0yn4FctUYa?=
 =?us-ascii?q?FveYsjF2ijOYu0y894ipqrXGRXsBa4ClcH3tK5UQSdYka73gBK00kT53u9ln?=
 =?us-ascii?q?iW1Ttxxgo1o7Kf0SqG+OHrcB4KKyYfX2V5pUv9KoizydYBVQ6naBZ/x0jt3l?=
 =?us-ascii?q?rz26UO/Pc3FGLUW0odOnGtfmw=3D?=
X-IPAS-Result: =?us-ascii?q?A2B2AwBr1fZc/wHyM5BmHAEBAQQBAQcEAQGBZYFnKmpRA?=
 =?us-ascii?q?TIohBSTVwEBBoEILYlQkQgJAQEBAQEBAQEBKwkBAgEBhEACglIjOBMBAwEBA?=
 =?us-ascii?q?QQBAQEBAwEBbBwMgjopAYJnAQUjDwEFQRAJAhgCAiYCAlcGAQwGAgEBGoJFP?=
 =?us-ascii?q?wGBdhQPi0WbaoExhUeDJ4FABoEMKItbF3iBB4E4gW1+PoJhAgKEaYJYBIs2G?=
 =?us-ascii?q?AOHUpViCYIQghmEKIRPiCAGG4IjhnWEAoldjQqBaYUlkSQhgVgrCAIYCCEPO?=
 =?us-ascii?q?4JsghYEAReDTYpvIwMwAYEFAQGQSAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Jun 2019 20:34:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x54KYYI6002479;
        Tue, 4 Jun 2019 16:34:34 -0400
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190602165101.25079-1-casey@schaufler-ca.com>
 <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov>
 <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com>
 <2a9049a7-6259-5ae0-2790-0aaf337c51a4@tycho.nsa.gov>
 <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2bc09037-b0e0-7e55-8d4f-42b857ee7d7a@tycho.nsa.gov>
Date:   Tue, 4 Jun 2019 16:34:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/4/19 3:58 PM, Casey Schaufler wrote:
> On 6/4/2019 10:11 AM, Stephen Smalley wrote:
>> On 6/4/19 12:14 PM, Casey Schaufler wrote:
>>> On 6/4/2019 5:29 AM, Stephen Smalley wrote:
>>>> On 6/2/19 12:50 PM, Casey Schaufler wrote:
>>>>> This patchset provides the changes required for
>>>>> the AppArmor security module to stack safely with any other.
>>>>
>>>> Please explain the motivation
>>>
>>> I'll add some explanation for the next revision.
>>> It won't be anything that I haven't posted many times
>>> before, but you're right that it belongs in the log.
>>>
>>>> - why do we want to allow AppArmor to stack with other modules,
>>>
>>> First, is there a reason not to? Sure, you can confuse
>>> administrators by implementing complex security policies,
>>> but there are lots of ways to do that already.
>>
>> There are costs to doing so, e.g.
>> - greater complexity in the security framework,
> 
> Taking blob management out of the modules and
> into the framework makes simplifies the modules.
> 
>> - possibly greater memory and runtime overheads,
> 
> Possibly reduced memory and runtime overheads, as well.
> 
>> - potential user confusion (which security module(s) caused a given failure?)
> 
> That's not new. I've seen countless cases where users blame
> SELinux or Smack when the problem is with mode bits and/or
> capabilities. Not to mention that a good 50% of current Linux
> users don't understand any of the security mechanisms to
> begin with.
> 
>> - potential distro maintainer burden
> 
> Selection of security modules and how they are configured
> has always been a burden for distro developers and maintainers.
> Nothing new here.
> And, they knew the job was dangerous when they took it.
> 
> 
>> (similar to above, but performing triage when any given permission denial can have multiple causes beyond just DAC + one module, weird interactions among modules, etc)
> 
> Yama has been widely accepted by distros, and civilization
> has yet to have officially been declared ended.
> 
>> It isn't free so there should be a cost/benefit analysis.
> 
> Some benchmarking is definitely in order, but most
> of what's you're calling out as downside is hypothetical
> or based on assumption.
> 
>>
>>>
>>> AppArmor provides a different security model than SELinux,
>>> TOMOYO or Smack. Smack is better at system component
>>> separation, while AppArmor is better at application isolation.
>>> It's a win to use each to its strength rather than trying to
>>> stretch either to the edge of what it can do.
>>>
>>>> who would use it,
>>>
>>> Can't name names, but there have been multiple requests.
>>>
>>>> how would it be used,
>>>
>>> As mentioned above, Smack for system separation, AppArmor for
>>> application isolation.
>>
>> Can you provide a concrete example of how combining the two yields a smaller, simpler configuration overall than using them individually?
> 
> Smack + AppArmor is a simpler, smaller model than the Smack policy
> used in Tizen 2.

Not very compelling given that not even Tizen is using that policy 
anymore.  But even taking that as an example, have you actually done the 
work to craft a working configuration of Smack + AppArmor that meets the 
same security goals as the Tizen 2 policy and confirmed that it is in 
fact smaller and simpler?  Won't it just move the size/complexity from 
Smack rules to AppArmor profiles?  And those might be larger...

> 
>>
>>>
>>>> what does it provide that isn't already possible in the absence of it.
>>>
>>> It's not necessary that something be impossible to do any
>>> other way. The question should be whether this provides for
>>> a better way to achieve the goals, and this does that.
>>> If I tried the come up with something that's impossible I
>>> would expect the usual "you can do that with SELinux policy"
>>> argument. We know we can do things. We want to have the tools
>>> to do them better.
>>>
>>>> Also, Ubuntu fully upstreamed all of their changes to AppArmor, would this still suffice to enable stacking of AppArmor or do they rely on hooks that are not handled here?
>>>
>>> Some amount of merging will likely be required. But that's
>>> always going to be true with parallel development tracks.
>>> That's why we have git!
>>>
>>>> Please explain the cost of the change - what do we pay in terms of memory, runtime, or other overheads in order to support this change?
>>>
>>> Do you have particular benchmarks you want to see?
>>> When I've supplied numbers in the past they have not
>>> been remarked on.
>>
>> A combination of micro and macro benchmarks exercising multiple kernel subsystems would be good.  Kernel build time isn't sufficient.
> 
> Do you have preferences, or better yet, facilities
> for running them? I am, alas, running on finite resources
> and benchmark contributions, especially in areas where you
> have specific concerns, would be most welcome.
> 
>>
>>>
>>>>
>>>>>
>>>>> A new process attribute identifies which security module
>>>>> information should be reported by SO_PEERSEC and the
>>>>> /proc/.../attr/current interface. This is provided by
>>>>> /proc/.../attr/display. Writing the name of the security
>>>>> module desired to this interface will set which LSM hooks
>>>>> will be called for this information. The first security
>>>>> module providing the hooks will be used by default.
>>>>
>>>> Doesn't this effectively undo making the hooks read-only after init, at least for the subset involved?  What are the security implications thereof?
>>>
>>> Any mechanism, be it a separate set of hooks, a name used to
>>> do list look ups, or an sophisticated hash scheme will have that
>>> impact for the processes that use it. This scheme has the best
>>> performance profile of the mechanisms I experimented with and
>>> avoids all sorts of special cases.
>>>
>>>>
>>>>> The use of integer based security tokens (secids) is
>>>>> generally (but not completely) replaced by a structure
>>>>> lsm_export. The lsm_export structure can contain information
>>>>> for each of the security modules that export information
>>>>> outside the LSM layer.
>>>>>
>>>>> The LSM interfaces that provide "secctx" text strings
>>>>> have been changed to use a structure "lsm_context"
>>>>> instead of a pointer/length pair. In some cases the
>>>>> interfaces used a "char *" pointer and in others a
>>>>> "void *". This was necessary to ensure that the correct
>>>>> release mechanism for the text is used. It also makes
>>>>> many of the interfaces cleaner.
>>>>>
>>>>> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> ---
>>>>>     drivers/android/binder.c                |  25 ++-
>>>>>     fs/kernfs/dir.c                         |   6 +-
>>>>>     fs/kernfs/inode.c                       |  31 ++-
>>>>>     fs/kernfs/kernfs-internal.h             |   3 +-
>>>>>     fs/nfs/inode.c                          |  13 +-
>>>>>     fs/nfs/internal.h                       |   8 +-
>>>>>     fs/nfs/nfs4proc.c                       |  17 +-
>>>>>     fs/nfs/nfs4xdr.c                        |  16 +-
>>>>>     fs/nfsd/nfs4proc.c                      |   8 +-
>>>>>     fs/nfsd/nfs4xdr.c                       |  14 +-
>>>>>     fs/nfsd/vfs.c                           |   7 +-
>>>>>     fs/proc/base.c                          |   1 +
>>>>>     include/linux/cred.h                    |   3 +-
>>>>>     include/linux/lsm_hooks.h               |  91 +++++----
>>>>>     include/linux/nfs4.h                    |   8 +-
>>>>>     include/linux/security.h                | 133 +++++++++----
>>>>>     include/net/af_unix.h                   |   2 +-
>>>>>     include/net/netlabel.h                  |  10 +-
>>>>>     include/net/scm.h                       |  14 +-
>>>>>     kernel/audit.c                          |  43 ++--
>>>>>     kernel/audit.h                          |   9 +-
>>>>>     kernel/auditfilter.c                    |   6 +-
>>>>>     kernel/auditsc.c                        |  77 ++++----
>>>>>     kernel/cred.c                           |  15 +-
>>>>>     net/ipv4/cipso_ipv4.c                   |  13 +-
>>>>>     net/ipv4/ip_sockglue.c                  |  12 +-
>>>>>     net/netfilter/nf_conntrack_netlink.c    |  29 ++-
>>>>>     net/netfilter/nf_conntrack_standalone.c |  16 +-
>>>>>     net/netfilter/nfnetlink_queue.c         |  38 ++--
>>>>>     net/netfilter/nft_meta.c                |  13 +-
>>>>>     net/netfilter/xt_SECMARK.c              |  14 +-
>>>>>     net/netlabel/netlabel_kapi.c            |   5 +-
>>>>>     net/netlabel/netlabel_unlabeled.c       | 101 +++++-----
>>>>>     net/netlabel/netlabel_unlabeled.h       |   2 +-
>>>>>     net/netlabel/netlabel_user.c            |  13 +-
>>>>>     net/netlabel/netlabel_user.h            |   2 +-
>>>>>     net/unix/af_unix.c                      |   6 +-
>>>>>     security/apparmor/audit.c               |   4 +-
>>>>>     security/apparmor/include/audit.h       |   2 +-
>>>>>     security/apparmor/include/net.h         |   6 +-
>>>>>     security/apparmor/include/secid.h       |   9 +-
>>>>>     security/apparmor/lsm.c                 |  64 +++---
>>>>>     security/apparmor/secid.c               |  42 ++--
>>>>>     security/integrity/ima/ima.h            |  14 +-
>>>>>     security/integrity/ima/ima_api.c        |   9 +-
>>>>>     security/integrity/ima/ima_appraise.c   |   6 +-
>>>>>     security/integrity/ima/ima_main.c       |  34 ++--
>>>>>     security/integrity/ima/ima_policy.c     |  19 +-
>>>>>     security/security.c                     | 338 +++++++++++++++++++++++++++-----
>>>>>     security/selinux/hooks.c                | 259 ++++++++++++------------
>>>>>     security/selinux/include/audit.h        |   5 +-
>>>>>     security/selinux/include/objsec.h       |  42 +++-
>>>>>     security/selinux/netlabel.c             |  25 +--
>>>>>     security/selinux/ss/services.c          |  18 +-
>>>>>     security/smack/smack.h                  |  18 ++
>>>>>     security/smack/smack_lsm.c              | 238 +++++++++++-----------
>>>>>     security/smack/smack_netfilter.c        |   8 +-
>>>>>     security/smack/smackfs.c                |  12 +-
>>>>>     58 files changed, 1217 insertions(+), 779 deletions(-)
>>>>>
>>>>
>>

