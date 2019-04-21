Return-Path: <SRS0=vE6x=SX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B0C10F14
	for <selinux@archiver.kernel.org>; Sun, 21 Apr 2019 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1658420821
	for <selinux@archiver.kernel.org>; Sun, 21 Apr 2019 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZV72Y0J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfDURdT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:33:19 -0400
Received: from sonic310-49.consmr.mail.bf2.yahoo.com ([74.6.135.223]:44850
        "EHLO sonic310-49.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbfDURdT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Apr 2019 13:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555867997; bh=Mc7tJ9Q2k/C1qeDYbHpNOeJttr7iI7Qt4YrHyBKfvEs=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=ZV72Y0J/M9/3yqNipzO3A08r7EpYD4cX+ziqGAeVNmS9vBONGY+lSM3t/nXiMOcOZlColdkE0j01y7BCaer+0hNaf7Vup3mznY1rZi91RrIJx2To+aKwMuMjPjHtNHzHqI60TkjP96o2ZdpDryuydWY5IViN1aGmdk2uxzrJ/vaeFqOp1nS9zJPfx0rDM69axuuWDIrdiqsqRdpx+DXXq6lFOWKIFb3wdJGucxKDpBM5WapAtnEdxUWGY2Ev+3g69VvxOtN3tqLWSdx3jPAyEToUe9nweggW6CFx4YTfgCGoWJo47Bt6WCpBAkYMuQXTzd1i+AThlinpKNU6hdKF+Q==
X-YMail-OSG: CuC.Db8VM1m_dNLiFaJrne3Vm8XZRoqG35Or.BKYTdXMbzE4Ge28UHJ7V6R3gTN
 sG4lqtc6sC3wxfPdURMs_EOGLJH2HM6BuyF2kdjHFvNZ9COayHiGiiltktyUv1GrQSgo.B89KjDL
 T85y.Iy.7tn4ivF8BlYoLDOfTfrOWQdIswk_CvdugLGQkLfwkFTNa8ApnwFWei5kMEWstCpucs43
 Gb0BPUgYq3b.2Ic5h08OfAsyWKzI9vk2E9fmW4WWHhuOveFDV.v_7HWojXN_2IolGAR2e2C_KQvM
 GFrx9y9gbdnYRxBhkDdA_dQKY2Ze0_ugQImYzjosn33Tj1jNk6ZtSusJ4IwlsWBeuBI1S5isf4Nf
 cX3tGqOGuY.iSmAxMGLXcebjfHopT.ZrKGEyxUp18iFX.7i8DHUwVZWG6WpBFssxlYBMg1ZP0gUI
 zCz2GBFDxIt4G3OBvBLuFW0kvETQe3PXtXNxpkBlGDrexG8EqtAeOSLN.OWAR8ROHfoxt.8ZdI80
 bztb7D6zSVrRfdxIIptXoTFXa178_9E7XkNMzYaXpg3T1VpHDLDvnJU1b8Gk.LQFqHBw9b3ybAxL
 lEZSMHa7KjyG9oAU97sLEGHsPp37lRlHKImfv67XEE2DN3xSKDeq8mT8jLjYtFDj_tfvnIiZwbdF
 0InFeKdXQ_2Cgk9yeuc3UdpPItxiYo0R44N6_dYP5Mnbl76j6zpewUUmA5OQ_VtVR4yAvJ2MXKNE
 vbfV94kycgzuK6zaaok.plO2hPmPm4UtuS.wu4E5AtHDiIYBRV5q_4KunpRO75jHEdbEtQYKrvIg
 Kk5oiWutqYo3OWb0wHETu0TF4EutYAd7K1XnKOOxEGQUlXQWYXRkI4uM9x4oSvlz12Ic2MrzSrH1
 l8yC1E5HMPB7S8wyFsH35qRouQIsVqziW3kcT30OIymsci7oGoZ0qw4AieFZFomnyMERPTlPO9S8
 TBqCSuv5h5W4LTSCf0byWozLsV0sv3ozyKaxIMNyZ_1qjcOlM4j0JLB7s.Yw4fhQaoWOrC2d71AL
 h9xBw.M35HtDSDknjWra0Uj4rCb.pNMoq7n_spbgaUe36iiTPCoTaUoJULGlV2sLX82IKBci2roj
 5ebHVlMR.GxoEzkFaINAbQn9FEB7AtXY.SVN1iYqV4kefXCCqQg7SfZfyxosRRx6zUPBbdxILx7o
 1nIwyP6IKVtFIVNu6K02SU9qY6iKe4Mdpm6au2NY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Apr 2019 17:33:17 +0000
Received: from 104.129.192.81 (EHLO [172.26.55.93]) ([104.129.192.81])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7845fdff32bc001f32116070b394611b;
          Sun, 21 Apr 2019 17:31:16 +0000 (UTC)
Subject: Re: [PATCH 00/90] LSM: Module stacking for all
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey@schaufler-ca.com
References: <20190419004617.64627-1-casey@schaufler-ca.com>
 <6c9c3782-a168-c435-0caf-311c2d21d174@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <dbf99650-b53e-f197-aeb8-ed6fd9031837@schaufler-ca.com>
Date:   Sun, 21 Apr 2019 10:31:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6c9c3782-a168-c435-0caf-311c2d21d174@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/19/2019 8:27 AM, Stephen Smalley wrote:
> On 4/18/19 8:44 PM, Casey Schaufler wrote:
>> This patchset provides the changes required for
>> the any security module to stack safely with any other.
>>
>> A new process attribute identifies which security module
>> information should be reported by SO_PEERSEC and the
>> /proc/.../attr/current interface. This is provided by
>> /proc/.../attr/display. Writing the name of the security
>> module desired to this interface will set which LSM hooks
>> will be called for this information. The first security
>> module providing the hooks will be used by default.
>>
>> The use of integer based security tokens (secids) is
>> generally (but not completely) replaced by a structure
>> lsm_export. The lsm_export structure can contain information
>> for each of the security modules that export information
>> outside the LSM layer.
>>
>> The LSM interfaces that provide "secctx" text strings
>> have been changed to use a structure "lsm_context"
>> instead of a pointer/length pair. In some cases the
>> interfaces used a "char *" pointer and in others a
>> "void *". This was necessary to ensure that the correct
>> release mechanism for the text is used. It also makes
>> many of the interfaces cleaner.
>>
>> Security modules that use Netlabel must agree on the
>> labels to be used on outgoing packets. If the modules
>> do not agree on the label option to be used the operation
>> will fail.
>>
>> Netfilter secmarks are restricted to a single security
>> module. The first module using the facility will "own"
>> the secmarks.
>
> Is it expected that enabling all security modules with this change 
> will yield permission denials on packet send/receive (e.g. sendmsg() 
> fails with permission denied), even without any configuration of 
> NetLabel or SECMARK?  That's what I see.

Yes.

Smack is much more aggressive about using labeled networking
than SELinux. Smack tells Netlabel to label networks, whereas
SELinux expects them to be unlabeled. Smack has the concept of
an "ambient" label, which is applied to unlabeled packets, and
for which packets are sent unlabeled. SELinux only uses netlabel
for the MLS component, whereas Smack uses it for the entire
label. In short, it's amazing if there's a case where they do
agree.

You can make the default configuration work better by specifying
that the Smack "floor" label be treated more like the unconfined_t.

	# echo _ 0 0 0 > /sys/fs/smackfs/cipso2
	# echo NotFloor > /sys/fs/smackfs/ambient

Will result in a situation where the two MAC systems will agree
much more often.


>
>>
>> git://github.com/cschaufler/lsm-stacking.git#stack-5.1-v2-full
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   drivers/android/binder.c                |  25 +-
>>   fs/kernfs/dir.c                         |   6 +-
>>   fs/kernfs/inode.c                       |  31 +-
>>   fs/kernfs/kernfs-internal.h             |   3 +-
>>   fs/nfs/inode.c                          |  13 +-
>>   fs/nfs/internal.h                       |   8 +-
>>   fs/nfs/nfs4proc.c                       |  17 +-
>>   fs/nfs/nfs4xdr.c                        |  16 +-
>>   fs/nfsd/nfs4proc.c                      |   8 +-
>>   fs/nfsd/nfs4xdr.c                       |  14 +-
>>   fs/nfsd/vfs.c                           |   7 +-
>>   fs/proc/base.c                          |   1 +
>>   include/linux/cred.h                    |   3 +-
>>   include/linux/lsm_hooks.h               | 119 +++---
>>   include/linux/nfs4.h                    |   8 +-
>>   include/linux/security.h                | 159 ++++++--
>>   include/net/af_unix.h                   |   2 +-
>>   include/net/netlabel.h                  |  18 +-
>>   include/net/scm.h                       |  14 +-
>>   kernel/audit.c                          |  43 +--
>>   kernel/audit.h                          |   9 +-
>>   kernel/auditfilter.c                    |   6 +-
>>   kernel/auditsc.c                        |  77 ++--
>>   kernel/cred.c                           |  15 +-
>>   net/ipv4/cipso_ipv4.c                   |  13 +-
>>   net/ipv4/ip_sockglue.c                  |  14 +-
>>   net/netfilter/nf_conntrack_netlink.c    |  29 +-
>>   net/netfilter/nf_conntrack_standalone.c |  16 +-
>>   net/netfilter/nfnetlink_queue.c         |  35 +-
>>   net/netfilter/nft_meta.c                |   8 +-
>>   net/netfilter/xt_SECMARK.c              |   9 +-
>>   net/netlabel/netlabel_kapi.c            | 125 ++++--
>>   net/netlabel/netlabel_unlabeled.c       | 101 +++--
>>   net/netlabel/netlabel_unlabeled.h       |   2 +-
>>   net/netlabel/netlabel_user.c            |  13 +-
>>   net/netlabel/netlabel_user.h            |   2 +-
>>   net/unix/af_unix.c                      |   6 +-
>>   security/apparmor/audit.c               |   4 +-
>>   security/apparmor/include/audit.h       |   2 +-
>>   security/apparmor/include/net.h         |   6 +-
>>   security/apparmor/include/secid.h       |   9 +-
>>   security/apparmor/lsm.c                 |  64 ++--
>>   security/apparmor/secid.c               |  42 +-
>>   security/integrity/ima/ima.h            |  14 +-
>>   security/integrity/ima/ima_api.c        |   9 +-
>>   security/integrity/ima/ima_appraise.c   |   6 +-
>>   security/integrity/ima/ima_main.c       |  34 +-
>>   security/integrity/ima/ima_policy.c     |  19 +-
>>   security/security.c                     | 653 
>> +++++++++++++++++++++++++++-----
>>   security/selinux/hooks.c                | 310 +++++++--------
>>   security/selinux/include/audit.h        |   5 +-
>>   security/selinux/include/netlabel.h     |   7 +
>>   security/selinux/include/objsec.h       |  43 ++-
>>   security/selinux/netlabel.c             |  69 ++--
>>   security/selinux/ss/services.c          |  18 +-
>>   security/smack/smack.h                  |  34 ++
>>   security/smack/smack_access.c           |  14 +-
>>   security/smack/smack_lsm.c              | 388 ++++++++++---------
>>   security/smack/smack_netfilter.c        |  48 ++-
>>   security/smack/smackfs.c                |  23 +-
>>   60 files changed, 1855 insertions(+), 961 deletions(-)
>>
>
