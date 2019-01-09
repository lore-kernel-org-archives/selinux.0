Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB4FC43612
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 22:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607D02075C
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 22:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r6Ac6Nmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfAIWEJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:04:09 -0500
Received: from sonic301-28.consmr.mail.gq1.yahoo.com ([98.137.64.154]:35461
        "EHLO sonic301-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbfAIWEI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 17:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547071447; bh=MV/NjZ3veQSJ484nN0ej46gXmad/AJDC0d6Vc6OVSSg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=r6Ac6Nmrfk+q7rJCexJyQtjn1T9M59S/eOUHysZH0TiTl7a5lCgibODZ7Yn+IucPPFglkKq6oVjBmYY7zED7nSsZcmSeSqOxTrBbENCM+2e6zbu3HMwvVcNd0IjsGXd66krP4tt46igeaug84ebXgNSInNEvJ+OEGUO5EPQMOmgkPMd24r2QYiSKcwhaXeoXc6mDIUHsXZECoSZ6Yj5C54ZF7of6aDobEc68OvggU2N32gQscRcmlb7o85J6xA+B40E38fPqYbhB+TXxzVi6ezKzONbUXEYgWuxIWiqw4/acerApV2VtISD0uqi4YrOjkVhd/Juhffs0je7dc1rFNw==
X-YMail-OSG: mPTyl.sVM1mq6P.Y0KPB2P133z9MnZndO3n.wK82JI8NksOZikI..ddjZM0bvmP
 ZoI27OqpSzh.RAX3aMrlzYxPLHlrTcd5lrGolKlrSMEi4_glDCgYW2gj69xIiK9lSkBwOmkXYnZq
 N9pxTMIqVL6dbdEZCYxG4av18mtsc_QEgEWDoiPcGct3XEJSnEvyknbh5DdPj5ZLtBtmYLSALcer
 Zn9vET_RZl2SjWc27cy2x_sD95PYdgli6dEOpJZS0FaXt2bWNooHQ_nfhb3ch8M8jH4.XjTYUkbm
 PyRjmX6gF3p7.Luiyb1RVPItpXZaV1B8WryHxE4.9xWvsgqOilSeSXEEebG0SrwgypYCc08UpdTD
 8z30LRz94tF_EaiNS7WdAKbT3H6WFmHHXPfreAJgCgU97yhpYHor0dFxnvgfqc3kOPQ0R9TgX5BH
 2HXG1GBLUWbVCE9PufQb0fKhZrMbpc.PswoCammiK1A5B7Qdzzi50GlEeXTdLf9IiVTuRRu0Ee0l
 XvJzH7BE5P6ycuzWG7SB8wrJIBYXzvnxwbeuuQ21EGAP1aUP.KclOyoV6EzXJ9Jk7zuSmtjFdMze
 HzXbH2UeiA36sJNn_hS3TPi.BiNLMp8K6GqoPw3VLqd1IiAlS25w1IzmNXRzS2fRHM4S4wFS_4aB
 QKvIleTBgSs_s2mJWgnsfPQZv2fivLsrBFwWbyrJQzhQyR21wMDl7uycZbZY_PhwLGgyedMiKwJC
 jAXZaJoRKfWU8bLygQnxB7tKoFkVu720.2.OOHQCMPCc39DdUSq6_EnEeyMgVwi5Zaz9FcN2P_Gr
 4ZfvyteYJOE2L7bIZsX4lCCQsDtIOzHYP.cd3rokK6RniuV2lJls1IDM9LF4CkMZTP3FIrzRaGHL
 PGNHWN2NA5Nx0tOg_cljfAykeZPELTZXM7cQxg_BgoxvJ_3d1r0Q_.P1HSgBDa3CjSpkfdtQF4qZ
 06YhQkgIj_uDdQ1yahRqBr2dgxg26riXB_2wivQPd3u2GWsjWGr3OD7wYadhwcAaLlnZ.A8pVSX8
 4RjIo39SmtdxVx_u3ypLSCAgEQTsO2_08o2QDG5rqiCOSJGj9BwqPh.t4a5T3WMcId9sWMs5hO.1
 1AGkX10ZP1MG5lg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Wed, 9 Jan 2019 22:04:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 537ec8c434a0c5d2dd0f590256ce6091;
          Wed, 09 Jan 2019 22:04:03 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
Date:   Wed, 9 Jan 2019 14:03:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/2019 12:37 PM, Stephen Smalley wrote:
> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>> Changes in v2:
>>> - add docstring for the new hook in union security_list_options
>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>    implemented
>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>>
>>> This series adds a new security hook that allows to initialize the security
>>> context of kernfs properly, taking into account the parent context. Kernfs
>>> nodes require special handling here, since they are not bound to specific
>>> inodes/superblocks, but instead represent the backing tree structure that
>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>
>>> The kernfs nodes initially do not store any security context and rely on
>>> the LSM to assign some default context to inodes created over them.
>>
>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
>> and expected filesystem behavior?
>
> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
>
> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.

OK, so as I said, this seems like a bug in kernfs.

>
>>
>>> Kernfs
>>> inodes, however, allow setting an explicit context via the *setxattr(2)
>>> syscalls, in which case the context is stored inside the kernfs node's
>>> metadata.
>>>
>>> SELinux (and possibly other LSMs) initialize the context of newly created
>>> FS objects based on the parent object's context (usually the child inherits
>>> the parent's context, unless the policy dictates otherwise).
>>
>> An LSM might use information about the parent other than the "context".
>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
>> to determine whether the Smack label of the new object should be taken
>> from the parent or the process. Passing the "context" of the parent is
>> insufficient for Smack.
>
> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.

Right. But I'll point out that there is nothing to prevent an
LSM from using inode information outside of the xattrs (e.g. uids)
to determine the security state it wants to give a new object.

I suggest that the better solution would be for kernfs to
use inodes like a real filesystem. Every special case like this
results in special cases like this special hook. It's hard
enough to keep track of the general case in the Linux kernel.

>
>>
>>> This is done
>>> by hooking the creation of the new inode corresponding to the newly created
>>> file/directory via security_inode_init_security() (most filesystems always
>>> create a fresh inode when a new FS object is created). However, kernfs nodes
>>> can be created "behind the scenes" while the filesystem is not mounted
>>> anywhere and thus no inodes exist.
>>>
>>> Therefore, to allow maintaining similar behavior for kernfs nodes, a new LSM
>>> hook is needed, which would allow initializing the kernfs node's security
>>> context based on the context stored in the parent's node (if any).
>>>
>>> The main motivation for this change is that the userspace users of cgroupfs
>>> (which is built on kernfs) expect the usual security context inheritance
>>> to work under SELinux (see [1] and [2]). This functionality is required for
>>> better confinement of containers under SELinux.
>>>
>>> The first patch adds the new LSM hook; the second patch implements the hook
>>> in SELinux; and the third patch modifies kernfs to use the new hook to
>>> initialize the security context of kernfs nodes whenever its parent node
>>> has a non-default context set.
>>>
>>> Note: the patches are based on current selinux/next [3], but they seem to
>>> apply cleanly on top of v5.0-rc1 as well.
>>>
>>> Testing:
>>> - passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
>>>    current Rawhide kernel (5.0.0-0.rc1.git0.1) [4]
>>> - passed the reproducer from the last patch
>>>
>>> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
>>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/log/?h=selinux-pr-20181224
>>> [4] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/842855/
>>>
>>> Ondrej Mosnacek (3):
>>>    LSM: Add new hook for generic node initialization
>>>    selinux: Implement the object_init_security hook
>>>    kernfs: Initialize security of newly created nodes
>>>
>>>   fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
>>>   fs/kernfs/inode.c           |  9 +++----
>>>   fs/kernfs/kernfs-internal.h |  4 +++
>>>   include/linux/lsm_hooks.h   | 30 +++++++++++++++++++++++
>>>   include/linux/security.h    | 14 +++++++++++
>>>   security/security.c         | 10 ++++++++
>>>   security/selinux/hooks.c    | 41 +++++++++++++++++++++++++++++++
>>>   7 files changed, 149 insertions(+), 8 deletions(-)
>>>
>>
>
>

