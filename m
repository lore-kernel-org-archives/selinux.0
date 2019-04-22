Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF48C10F11
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 12:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7512077C
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 12:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="e0g2jaiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfDVMsn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:48:43 -0400
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:1225 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVMsm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 08:48:42 -0400
X-EEMSG-check-017: 188434355|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Apr 2019 12:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555937315; x=1587473315;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8rG8/cI7vO6XZgC60wGLH/UFNyqt/9tBy8t95cLKm2I=;
  b=e0g2jaiwlydj4sbyUtVwbfAtJrHybmJKN5dKYKsqTYiWfES9d5HvS5jD
   CM3ZvPxJY9deIkK68yMxi+St2s1mqaxvarRqdLmBvEwpvao/OgNKibPTv
   1NEARumEix1rjP7I+RmGFYhCZplS/NHXPNVIbtXrAMM727ar4zV9e7qM3
   pwWOkNqpMg7EtD2u/5Fc8edgV/QpFYbvU/c9trts5bgKLQ7FwIHa9eSjK
   FyH53OzaixeZ9Qc6dt855/4cMj4lI3hvnbpCRuIa6lpCJhMgc0k+cIBXn
   JkD7a0D/Z8+gxADrM9pEPob2Vx2G5sLe32bGba7wdtWGHqfkilew1cldv
   A==;
X-IronPort-AV: E=Sophos;i="5.60,381,1549929600"; 
   d="scan'208";a="26579649"
IronPort-PHdr: =?us-ascii?q?9a23=3Ai7XF/B0f5e5PWiIrsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesVLvTxwZ3uMQTl6Ol3ixeRBMOHsqsC17Sd7vioGTRZp8rY6DZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq9QajZFtJ6swxR?=
 =?us-ascii?q?fEomdEcPlSyW90OF6fhRnx6tqs8JJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XvnnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Gg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+WuiRJjJ4i2hkeLK5nxuy/kmgyvH8Vsmpy1?=
 =?us-ascii?q?lGtDZKkt7Jtn0Lyhfd6dCHR+Ng8kqu1juDzQDe5vxeLUwqmqfXNYQtzqM2m5?=
 =?us-ascii?q?EOq0rMBDX2l1/zjKKOc0Uk/fWn5Pr/b7X9o5+cK5d0igbjMqQygsC/Afo3Mg?=
 =?us-ascii?q?wJX2WD5eSzzqfj/UzkQLVRlPE2jqnYv4zaJcQcvKK5BRNa0p0/5BqlCjem0d?=
 =?us-ascii?q?AYkWEGLFJDZh2Hk5DkN0zBLf33F/uyg0mgnC11y/3JILHtGIjBImDGkLj7fL?=
 =?us-ascii?q?Z970BcyBA0zdBa/59UEawOIOnoV0/ttN3XEh85Mwuuz+bhE9VyzJkSWW2IAq?=
 =?us-ascii?q?+HKK/Sq0OH5vozI+mQY48YoCryJOI+5/HwjX40gkQdcrWp3ZQNdXC4EPBmLF?=
 =?us-ascii?q?uDYXb1ntgOC30GsRY5TOzvkFeCSyJcZ26uX6Ig4TE2EJ6pAp3YRo+zgL2Nxj?=
 =?us-ascii?q?y7EYFWZm9cF1CMH3PoeJueW/oXaSKSJNNhnSIAVbS7V4Ah0hSuvhfgy7V7Nu?=
 =?us-ascii?q?rU5jEYtZX72dh34u3Tkgsy9SZ1D8SGyGyNSXt7nmYWSD83xqx/plZ9ylib26?=
 =?us-ascii?q?hin/NYDcBT5+9OUgoiMZ7czup6C839Ww7YZdeGVkqpQsi8ATEwUtIww8YCY0?=
 =?us-ascii?q?N6G9q/kxDD2zSlDqQLl7yEGpM06LjQ33vvKMZnzXbJyq0hg0MhQstVOm2snr?=
 =?us-ascii?q?R/+BTLB47Vj0WZkL6ndb8C0y7J9WeDy3eOvU5DXQ5uXqXKQ2ofalHVrdvn/E?=
 =?us-ascii?q?PCSaGhCbA9PgtG086CJbNAasf1glVeWPfjJNPebnqpm2iqGBaIwqiBbJLwdG?=
 =?us-ascii?q?UA2CXREU0EkwcU/XacKwcyHDuuo2XbDG8mKVW6SEr3/Pg2k3i7R1I6ywyQJx?=
 =?us-ascii?q?lq3qG46zYOjvyVVv0X06hBsy5noDJxShL11NvNBsvGvAFhdbhSZd4nyFZByW?=
 =?us-ascii?q?/d8Qd6O9joLaVlnEQfaCxxtkbj1lNwEIoE2cwrqm46iRF/Ir+C0U9QMjaf0Y?=
 =?us-ascii?q?30N5XJJWTouhOicajb3hfZytnSsrwC7PU+tkXLog6kDAwh/m9h3t0T1GGTot?=
 =?us-ascii?q?3yBRcWGbf2VVw6v0xirqzeSjE0+oeR0HprK6TyuTjHjYEHHuwgny28cs9fPa?=
 =?us-ascii?q?XMLwr7F8kXFoD6M+Axs0S4ZRIDeuZJ/eg7ON3wJKjO47KiIOs1xGHutm9A+o?=
 =?us-ascii?q?0olxvXpic=3D?=
X-IPAS-Result: =?us-ascii?q?A2CPBgBWt71c/wHyM5BmHAEBAQQBAQcEAQGBZYFnKmhRM?=
 =?us-ascii?q?yiEDpMoTAEBBAaBCAgliUiQfisRAYRAAoYcIzgTAQMBAQEEAQEBAQIBbBwMg?=
 =?us-ascii?q?jopAYJnAQUjDwEFUQkCGAICJgICVwYBDAYCAQGCXz8BgXQUikKbZYEvhUeEY?=
 =?us-ascii?q?YELJ4tKF3iBB4E4DIJfPoJhAoRrglcEimKHKIFskmAJggqGD4wVBhuCaZIrg?=
 =?us-ascii?q?zyISJZJIYFWKwgCGAghD4MnCYIRF4NMim8jAzCBBgEBj2oBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Apr 2019 12:48:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3MCmWvN019821;
        Mon, 22 Apr 2019 08:48:32 -0400
Subject: Re: [PATCH 00/90] LSM: Module stacking for all
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
 <6c9c3782-a168-c435-0caf-311c2d21d174@tycho.nsa.gov>
 <dbf99650-b53e-f197-aeb8-ed6fd9031837@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fc27e666-5446-08b3-48c3-a4871d06bb68@tycho.nsa.gov>
Date:   Mon, 22 Apr 2019 08:46:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dbf99650-b53e-f197-aeb8-ed6fd9031837@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/21/19 1:31 PM, Casey Schaufler wrote:
> On 4/19/2019 8:27 AM, Stephen Smalley wrote:
>> On 4/18/19 8:44 PM, Casey Schaufler wrote:
>>> This patchset provides the changes required for
>>> the any security module to stack safely with any other.
>>>
>>> A new process attribute identifies which security module
>>> information should be reported by SO_PEERSEC and the
>>> /proc/.../attr/current interface. This is provided by
>>> /proc/.../attr/display. Writing the name of the security
>>> module desired to this interface will set which LSM hooks
>>> will be called for this information. The first security
>>> module providing the hooks will be used by default.
>>>
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
>>> Security modules that use Netlabel must agree on the
>>> labels to be used on outgoing packets. If the modules
>>> do not agree on the label option to be used the operation
>>> will fail.
>>>
>>> Netfilter secmarks are restricted to a single security
>>> module. The first module using the facility will "own"
>>> the secmarks.
>>
>> Is it expected that enabling all security modules with this change 
>> will yield permission denials on packet send/receive (e.g. sendmsg() 
>> fails with permission denied), even without any configuration of 
>> NetLabel or SECMARK?  That's what I see.
> 
> Yes.
> 
> Smack is much more aggressive about using labeled networking
> than SELinux. Smack tells Netlabel to label networks, whereas
> SELinux expects them to be unlabeled. Smack has the concept of
> an "ambient" label, which is applied to unlabeled packets, and
> for which packets are sent unlabeled. SELinux only uses netlabel
> for the MLS component, whereas Smack uses it for the entire
> label. In short, it's amazing if there's a case where they do
> agree.
> 
> You can make the default configuration work better by specifying
> that the Smack "floor" label be treated more like the unconfined_t.
> 
>      # echo _ 0 0 0 > /sys/fs/smackfs/cipso2
>      # echo NotFloor > /sys/fs/smackfs/ambient
> 
> Will result in a situation where the two MAC systems will agree
> much more often.

Not sure that should be required given that SELinux doesn't enable 
labeled networking at all by default, so there is no real conflict 
until/unless someone configures labeled networking for SELinux.  I'll 
defer to Paul on that question.

Given this restriction, to what extent have you tested Smack+SELinux 
together and what worked and didn't work?  Everything except for 
networking-related tests?

> 
> 
>>
>>>
>>> git://github.com/cschaufler/lsm-stacking.git#stack-5.1-v2-full
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>   drivers/android/binder.c                |  25 +-
>>>   fs/kernfs/dir.c                         |   6 +-
>>>   fs/kernfs/inode.c                       |  31 +-
>>>   fs/kernfs/kernfs-internal.h             |   3 +-
>>>   fs/nfs/inode.c                          |  13 +-
>>>   fs/nfs/internal.h                       |   8 +-
>>>   fs/nfs/nfs4proc.c                       |  17 +-
>>>   fs/nfs/nfs4xdr.c                        |  16 +-
>>>   fs/nfsd/nfs4proc.c                      |   8 +-
>>>   fs/nfsd/nfs4xdr.c                       |  14 +-
>>>   fs/nfsd/vfs.c                           |   7 +-
>>>   fs/proc/base.c                          |   1 +
>>>   include/linux/cred.h                    |   3 +-
>>>   include/linux/lsm_hooks.h               | 119 +++---
>>>   include/linux/nfs4.h                    |   8 +-
>>>   include/linux/security.h                | 159 ++++++--
>>>   include/net/af_unix.h                   |   2 +-
>>>   include/net/netlabel.h                  |  18 +-
>>>   include/net/scm.h                       |  14 +-
>>>   kernel/audit.c                          |  43 +--
>>>   kernel/audit.h                          |   9 +-
>>>   kernel/auditfilter.c                    |   6 +-
>>>   kernel/auditsc.c                        |  77 ++--
>>>   kernel/cred.c                           |  15 +-
>>>   net/ipv4/cipso_ipv4.c                   |  13 +-
>>>   net/ipv4/ip_sockglue.c                  |  14 +-
>>>   net/netfilter/nf_conntrack_netlink.c    |  29 +-
>>>   net/netfilter/nf_conntrack_standalone.c |  16 +-
>>>   net/netfilter/nfnetlink_queue.c         |  35 +-
>>>   net/netfilter/nft_meta.c                |   8 +-
>>>   net/netfilter/xt_SECMARK.c              |   9 +-
>>>   net/netlabel/netlabel_kapi.c            | 125 ++++--
>>>   net/netlabel/netlabel_unlabeled.c       | 101 +++--
>>>   net/netlabel/netlabel_unlabeled.h       |   2 +-
>>>   net/netlabel/netlabel_user.c            |  13 +-
>>>   net/netlabel/netlabel_user.h            |   2 +-
>>>   net/unix/af_unix.c                      |   6 +-
>>>   security/apparmor/audit.c               |   4 +-
>>>   security/apparmor/include/audit.h       |   2 +-
>>>   security/apparmor/include/net.h         |   6 +-
>>>   security/apparmor/include/secid.h       |   9 +-
>>>   security/apparmor/lsm.c                 |  64 ++--
>>>   security/apparmor/secid.c               |  42 +-
>>>   security/integrity/ima/ima.h            |  14 +-
>>>   security/integrity/ima/ima_api.c        |   9 +-
>>>   security/integrity/ima/ima_appraise.c   |   6 +-
>>>   security/integrity/ima/ima_main.c       |  34 +-
>>>   security/integrity/ima/ima_policy.c     |  19 +-
>>>   security/security.c                     | 653 
>>> +++++++++++++++++++++++++++-----
>>>   security/selinux/hooks.c                | 310 +++++++--------
>>>   security/selinux/include/audit.h        |   5 +-
>>>   security/selinux/include/netlabel.h     |   7 +
>>>   security/selinux/include/objsec.h       |  43 ++-
>>>   security/selinux/netlabel.c             |  69 ++--
>>>   security/selinux/ss/services.c          |  18 +-
>>>   security/smack/smack.h                  |  34 ++
>>>   security/smack/smack_access.c           |  14 +-
>>>   security/smack/smack_lsm.c              | 388 ++++++++++---------
>>>   security/smack/smack_netfilter.c        |  48 ++-
>>>   security/smack/smackfs.c                |  23 +-
>>>   60 files changed, 1855 insertions(+), 961 deletions(-)
>>>
>>

