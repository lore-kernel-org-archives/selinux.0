Return-Path: <SRS0=Zlcp=RJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56644C4360F
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 18:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BFC20652
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t7GUHGGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCFSEb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:04:31 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:40215
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbfCFSEb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Mar 2019 13:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551895468; bh=csf78HO1KxYYJ2kr1KJ7HVhplHaItVMFVWMMz9e1rCU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=t7GUHGGikTE9thWzd2QEN0SKuHacornis4E/5viSI1YGSHNgBC25HLoPUPKVGsxrgAHNMGTufq1zw0TT+LzsiQqMgxoDZI4UtEzDxL3NN1707N7qS1K0YwKvbOTPWBkj1kFpTix3he0RWEC5IKb8tAv5e8E7V0Xp4TiFJPeqbsNDbZybor6a94T9iJ0DIOZydVoIJLh8f8hr4RXh5cLuH7svGHZ4X0Pw0rVXF4T/DAciideMHYDN/rdZ0TfgtqRcdYA9OYLf3Frz/JnrgL6KKGKrZSq8y68Gyo7jfaNVugh65Nr9CwXGl2LYiv+3E7qY4raMsFV2DLewm+G/e2U0pA==
X-YMail-OSG: YNI65H4VM1m7O_667vExtDT2NnBCMYo5_7aX7FQ0pGYvFZtUXqoKotwYwLj2q6X
 8KK5xeBPOe0EBxlHsIBE7Gix9iqaEayuyjBfuJRpqRRonl.2v56OemRIXslDXSUqYeW3DwHCJ9Nl
 WQJhBN3FsKVjAynm_ox7d.DTASxQ5ftPsmMnMnlV7eWuyngZOt3PgKWMRWoRmWWwC9s8NvzMOQTi
 QWhBGfNKgiT02VgcBpt8byt3R8svQOGKxUwq13J_9.EhO6NtcF_yRHU4cA5OaDNGe6SqYq85SDCo
 SKMDjbGeAYTNvMohAlsIofQVGRqMbbEz7f.4GA4vgLSYucMwKsHVlMXEcpb07msu7Sex8HJ_ERxD
 bRTIFkuITdrzf3t9aVsezeC22OLomiv7DIOkw4Xz9X8Hi3AoKK6.oQCO0Gzt9tHYdbKuBKi1rcAt
 h.o.0I2qxAJf1qTwxw07zbyWZTutq_AsTFr2wqjHTkYaQr5_r.A5iOX94kVrWzsKzkvS2aGg5Q13
 ls_9CxtzNuFejq0eYi6Qli0ZsAEyTJpMh.laHDZs4rr2xusTSjcxLKAs6eLF1VCUTUnptPL1W8VE
 PRhMHaHrJb4ncGdvZPuhfg0xdwa6dzls3FuwK.Y1.HFWQqz84DvCEm34JOLNMrq6k4IEwTh1yLHB
 rmaGW3Avo_yZB05gfwCwk7G.3PyPSfOPYVsFmPOP86fQGAWkaRE6Y8ZOa_wYsqTREpH4VizApoVU
 _ncr.NXEt8bvFdUZ58e5JuX6wk4CegW4GdYtdb7pantU80z5K2seexSNNlxRfIH9GU47gs6hzIql
 6TTlTmxaQy43tZRpVLRWcx4kn4cFMppNyIf4CfQTrcG.9y3wUPhIehns2KF5IITvJfwD3GEFoxRO
 vykLYp90RMNVrrRtuAK5wJgemRM16Shzn0XB70EB6Baf8U.TLW75SWqoxZ7HsUJ_yd8A8QsL7dYS
 SjtZ2To7uyjOgIYMxm9R8Hu7R012KTpnAyScyeQDL7LIytV9k54hEGaPa_llcTUN6bA2NS1cAoBl
 pvG2H3FM5Z8OBZb1G0AWDEFa8Cavy3gM2sGlQ1k74R.PtluYUZTudDmYCR4xAqEKpsDFWMYqCBRL
 41Dz2Rz2qnTE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Mar 2019 18:04:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b10016b4b51151b092ee4cc05b51e59e;
          Wed, 06 Mar 2019 18:04:27 +0000 (UTC)
Subject: Re: [PATCH v7 0/7] Allow initializing the kernfs node's secctx based
 on its parent
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190222145718.5740-1-omosnace@redhat.com>
 <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7f92ac61-c72b-ab31-c757-c2ac1bcf7b08@schaufler-ca.com>
Date:   Wed, 6 Mar 2019 10:04:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/2019 7:54 AM, Ondrej Mosnacek wrote:
> On Fri, Feb 22, 2019 at 3:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> TL;DR:
>> This series adds a new security hook that allows to initialize the security
>> context of kernfs properly, taking into account the parent context (and
>> possibly other attributes). Kernfs nodes require special handling here, since
>> they are not bound to specific inodes/superblocks, but instead represent the
>> backing tree structure that is used to build the VFS tree when the kernfs
>> tree is mounted.
>>
>> Changes in v7:
>> - simplify the new security hook's interface
>>    - rather than trying to extract kernfs data into common structures, just
>>      pass the kernfs nodes themselves and add helper functions to
>>      <linux/kernfs.h> for accessing their security xattrs
>>    - in case other LSMs need more kernfs node attributes than the file mode
>>      (uid/gid/...), they can simply add new helpers to <linux/kernfs.h> as
>>      needed
>> - refactor "kernfs: use simple_xattrs for security attributes" to keep using
>>    a single common simple_xattrs structure
>>    - turns out having two separate simple_xattrs wouldn't work right (see
>>      the definition of simple_xattr_list() in fs/xattr.c)
>> - drop unnecessary initializations from inode_doinit_use_xattr()
>> - move the IOP_XATTR check out of inode_doinit_use_xattr()
>> - add two kernfs cleanup patches
>>    - these could be applied independently, but the rest of the patches depend on
>>      them, so I'd rather they stay bundled with the rest to avoid cross-tree
>>      conflicts
>>
>> v6: https://lore.kernel.org/selinux/20190214095015.16032-1-omosnace@redhat.com/T/
>> Changes in v6:
>> - remove copy-pasted duplicate macro definition
>>
>> v5: https://lore.kernel.org/selinux/20190205110638.30782-1-omosnace@redhat.com/T/
>> Changes in v5:
>> - fix misplaced semicolon detected by 0day robot
>>
>> v4: https://lore.kernel.org/selinux/20190205085915.5183-1-omosnace@redhat.com/T/
>> Changes in v4:
>> - reorder and rename hook arguments
>> - avoid allocating kernfs_iattrs unless needed
>>
>> v3: https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/T/
>> Changes in v3:
>> - rename the hook to "kernfs_init_security"
>> - change the hook interface to simply pass pointers to struct iattr and
>>    struct simple_xattrs of both the new node and its parent
>> - add full security xattr support to kernfs (and fixup SELinux behavior
>>    to handle it properly)
>>
>> v2: https://lore.kernel.org/selinux/20190109162830.8309-1-omosnace@redhat.com/T/
>> Changes in v2:
>> - add docstring for the new hook in union security_list_options
>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>    implemented
>>
>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>
>> The kernfs nodes initially do not store any security context and rely on
>> the LSM to assign some default context to inodes created over them. Kernfs
>> inodes, however, allow setting an explicit context via the *setxattr(2)
>> syscalls, in which case the context is stored inside the kernfs node's
>> internal structure.
>>
>> SELinux (and possibly other LSMs) initialize the context of newly created
>> FS objects based on the parent object's context (usually the child inherits
>> the parent's context, unless the policy dictates otherwise). This is done
>> by hooking the creation of the new inode corresponding to the newly created
>> file/directory via security_inode_init_security() (most filesystems always
>> create a fresh inode when a new FS object is created). However, kernfs nodes
>> can be created "behind the scenes" while the filesystem is not mounted
>> anywhere and thus no inodes can exist for them yet.
>>
>> Therefore, to allow maintaining similar behavior for kernfs nodes, a new
>> LSM hook is needed, which will allow initializing the kernfs node's
>> security context based on its own attributes and those of the parent's
>> node.
>>
>> The main motivation for this change is that the userspace users of cgroupfs
>> (which is built on kernfs) expect the usual security context inheritance
>> to work under SELinux (see [1] and [2]). This functionality is required for
>> better confinement of containers under SELinux.
>>
>> Patch 1/7 simplifies the kernfs_iattrs structure and patch 2/7 optimizes
>> kernfs to not allocate kernfs_iattrs when getting the value of an xattr.
>>
>> Patch 3/7 changes SELinux to fetch security context from extended
>> attributes on kernfs filesystems, falling back to genfs-defined context
>> if that fails. Without this patch the 4/7 would be a regression for
>> SELinux (due to the removal of ...notifysecctx() call.
>>
>> Patch 4/7 implements full security xattr support in kernfs using
>> simple_xattrs; patch 5/7 adds the new LSM hook; patch 6/7 implements the
>> new hook in SELinux; and patch 7/7 modifies kernfs to call the new hook
>> on new node creation.
>>
>> Testing:
>> - passed the reproducer from the commit message of the last patch
>> - passed SELinux testsuite on Fedora Rawhide (x86_64) when applied on top
>>    of current Rawhide kernel (5.0.0-0.rc7.git2.1) [3]
>>    - including the new proposed selinux-testsuite subtest [4] (adapted
>>      from the reproducer)
>>
>> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
>> [3] https://koji.fedoraproject.org/koji/taskinfo?taskID=32963825
>> [4] https://github.com/SELinuxProject/selinux-testsuite/pull/48
>>
>> Ondrej Mosnacek (7):
>>    kernfs: clean up struct kernfs_iattrs
>>    kernfs: do not alloc iattrs in kernfs_xattr_get
>>    selinux: try security xattr after genfs for kernfs filesystems
>>    kernfs: use simple_xattrs for security attributes
>>    LSM: add new hook for kernfs node initialization
>>    selinux: implement the kernfs_init_security hook
>>    kernfs: initialize security of newly created nodes
>>
>>   fs/kernfs/dir.c                     |  28 ++--
>>   fs/kernfs/inode.c                   | 166 +++++++++------------
>>   fs/kernfs/kernfs-internal.h         |   8 +-
>>   fs/kernfs/symlink.c                 |   4 +-
>>   include/linux/kernfs.h              |  15 ++
>>   include/linux/lsm_hooks.h           |  13 ++
>>   include/linux/security.h            |   9 ++
>>   security/security.c                 |   6 +
>>   security/selinux/hooks.c            | 223 +++++++++++++++++++---------
>>   security/selinux/include/security.h |   1 +
>>   10 files changed, 290 insertions(+), 183 deletions(-)
>>
>> --
>> 2.20.1
> Ping about this series... Casey, are you OK with this new version?

I'm still not wildly enthusiastic about it, but I can't
offer a better solution right now. You can add my

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

