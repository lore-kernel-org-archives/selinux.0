Return-Path: <SRS0=zZcK=O3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71DC43387
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 19:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208C92184C
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 19:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="L3qSkN43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeLRTT6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:19:58 -0500
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:28037 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLRTT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Dec 2018 14:19:57 -0500
X-EEMSG-check-008: 368225820|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2018 19:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1545160794; x=1576696794;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8SvVqawHSZjdREZ1yydm3RqzA+n94C8+Cv+tGmHbzOg=;
  b=L3qSkN436I1+4LAAF5SeiC/b3g1q0PrFjgZJojBX4qcUBY5WuiwZd6pN
   nGd5RWr3TPD2OS2Kgh262gUsVNwz9FIzCFYVLrS4KMOXMJL8GuIzj06VE
   LtBMaA97lrMQdQZHb6oMAUC2YOEP8DQuvnhORoEg7ugDp2ekATBGzaCiQ
   3jyEP7r8HtiVWFthRm6FwJW/iR2gd3rUuC+TtKASlD91SwO4wCrcoBJ1M
   119bOEanVoijQYf7DqUCub/Z3g/GiyLZJtbK+QEloVXua314u4ZxI0MTC
   0ZUbnGhajWpKlqBlnxmQFs8bCBOgvtMXp9oe8kuy3nR4IPcCNTqazH4oc
   g==;
X-IronPort-AV: E=Sophos;i="5.56,370,1539648000"; 
   d="scan'208";a="18852186"
IronPort-PHdr: =?us-ascii?q?9a23=3A5Em5GBXAtYn0PwK6Ekc3rK3m5qrV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRWGuadThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJrrhApDKLnjYlrfuZ6?=
 =?us-ascii?q?py5FBHxQop099Q+pJUBasdIP7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKUHK?=
 =?us-ascii?q?CZNKLSsVmV5uMgOOSMeoAVtyjnK/Q/5P7hk2U5mVkDcqmtx5cXb2q4Hvt+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmVOzlkkCCUTpIanaqRa08+zU7BJujDYfEQYCtmqKO0D?=
 =?us-ascii?q?2nEZ1RY2BMEkqMHmvwd4WYR/cMbzqfLdNukjweUrihVpch1Qq1uQ/kxLpoMP?=
 =?us-ascii?q?DU9jcbtZ39zth14fPclRUo+TxzFcSd3HmHT3tokWMQWz82wKd/rFRhyleByq?=
 =?us-ascii?q?V4gOJXFcZV5/xXVgc2L5ncz/Z1C9rqQALOYs+JSEq6QtWhGTwxStMxwt4QbE?=
 =?us-ascii?q?ZzAdqiiAvO3yq3A7APmb2EGp00/rjA0Hj2IsZ302zG27U5j1k6XstPMnWrhq?=
 =?us-ascii?q?5l+AjVAY7GjV6Zmr22eqQZxC7M+3uMzWqBvE1CVw5wS6rFDjgjYR7xq9jj60?=
 =?us-ascii?q?GKari1D70sPwgJncmHLbBMY9bkpU9LSPfqJJLVZGfnyEmqAhPd/a+BdIrnfS?=
 =?us-ascii?q?0m2SzZDEUV21QI8W2uKRk1BiDnpXnXSjNpCwS8MAvX7eBipSbjHQcPxAaQYh?=
 =?us-ascii?q?gkjuDt9w=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C0AABfRxlc/wHyM5BjHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VopgTUzJ4N8lBRPAwaBCC2JI443gXs4AYFLgnUCglsiNgcNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkAYJhAQEBAQIBIwQRQRALDgoCAiYCAlcGDQYCAQGCXz+BdAUIpzx8M?=
 =?us-ascii?q?4VAhG6BC4s0F3iBB4ERJ4JriAmCVwKQGTeQVAmRWgYYjl6CeZtACyaBVisIA?=
 =?us-ascii?q?hgIIQ+DJ4InF447IQMwgQUBAY1gAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2018 19:19:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBIJJkJs028928;
        Tue, 18 Dec 2018 14:19:49 -0500
Subject: Re: [RFC PATCH 3/3] selinux: do not override context on context
 mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20181213141739.8534-1-omosnace@redhat.com>
 <20181213141739.8534-4-omosnace@redhat.com>
 <a779b0e5-79d5-8a10-8372-488de5f8345f@tycho.nsa.gov>
 <CAFqZXNvVw0tfxYAphm-Yibhy5JoeP2SzvUb_QDRPnNtJRTCGcA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6324b07-3a40-01c3-78a9-45032d9c107f@tycho.nsa.gov>
Date:   Tue, 18 Dec 2018 14:22:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvVw0tfxYAphm-Yibhy5JoeP2SzvUb_QDRPnNtJRTCGcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/18 10:50 AM, Ondrej Mosnacek wrote:
> On Thu, Dec 13, 2018 at 5:25 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/13/18 9:17 AM, Ondrej Mosnacek wrote:
>>> Ignore all selinux_inode_notifysecctx() calls on mounts with the
>>> SECURITY_FS_USE_MNTPOINT behavior.
>>>
>>> This fixes behavior of kernfs-based filesystems when mounted with the
>>> 'context=' option. Before this patch, if a node's context had been
>>> explicitly set to a non-default value and later the filesystem has been
>>> remounted with the 'context=' option, then this node would show up as
>>> having a different context.
>>>
>>> Steps to reproduce:
>>>       # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
>>>       # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
>>>       # ls -lZ /sys/fs/cgroup/unified
>>>       total 0
>>>       -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
>>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
>>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
>>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
>>>       -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
>>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
>>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
>>>       # umount /sys/fs/cgroup/unified
>>>       # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
>>>
>>> Result before:
>>>       # ls -lZ /sys/fs/cgroup/unified
>>>       total 0
>>>       -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
>>>       -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads
>>>
>>> Result after:
>>>       # ls -lZ /sys/fs/cgroup/unified
>>>       total 0
>>>       -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
>>>       -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
>>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>    security/selinux/hooks.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index d6d29ec54eab..0ca5ed30afe1 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -6620,6 +6620,13 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>>>     */
>>>    static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>>>    {
>>> +     struct superblock_security_struct *sbsec = inode->i_sb->s_security;
>>> +
>>> +     /* Do not change context in SECURITY_FS_USE_MNTPOINT case */
>>> +     if ((sbsec->flags & SE_SBINITIALIZED) &&
>>> +         (sbsec->behavior == SECURITY_FS_USE_MNTPOINT))
>>> +             return 0;
>>> +
>>>        return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
>>>    }
>>
>> Wondering if we ought to take this into selinux_inode_setsecurity() and
>> return -EOPNOTSUPP in that case.  We already return -EOPNOTSUPP from
>> selinux_inode_setxattr() if (!(sbsec->flags & SBLABEL_MNT)) and that
>> should precede other calls to selinux_inode_setsecurity() IIRC.
> 
> Maybe, but see below. In selinux_inode_setsecurity() we should indeed
> check for SBLABEL_MNT, but only if it is called directly as a hook
> (but I'm not sure if it is worth it in this case, since as you say, a
> prior selinux_inode_setxattr() failure should always prevent this hook
> from being called). selinux_inode_notifysecctx() has a bit different
> semantics, IMHO.
> 
>> Should we just be checking SBLABEL_MNT here instead?
> 
> I don't think so. IIUC, the purpose of selinux_inode_notifysecctx() is
> to adjust the sid that has been assigned by selinux_d_instantiate() by
> the label that is 'stored' for the particular node internally by the
> filesystem. I would say the fact whether we want to use the stored
> label depends on the sbsec->behavior value (BTW, shouldn't we also
> return 0 in case of SECURITY_FS_USE_TASK? or even
> SECURITY_FS_USE_TRANS?). I understand the SBLABEL_MNT flag more as an
> indication of whether we want the user to allow setting the label
> explicitly (and probably also implicitly via tsec->create_sid).

selinux_inode_notifysecctx() provides the filesystem with a way to push 
a label for an inode to the security module as opposed to having the 
security module pull it via __vfs_getxattr.  The latter doesn't work 
well for NFSv4.2 security labeling nor for sysfs, albeit for different 
reasons.

SBLABEL_MNT is not so much whether we want to allow the user to do it 
but rather whether the filesystem and policy make it safe to do so.  It 
is set mostly based on the ->behavior with exceptions for the 
whitelisted filesystem types.  The same flag is checked in 
selinux_inode_init_security(), where we are returning a label for a 
newly created file.

Not sure we want to create two different ways of determining whether the 
filesystem supports labeling.

> 
>> And do we need to separately check SE_SBINITIALIZED?
> 
> I'm not sure, but other places in the code check that flag before
> checking sbsec->behavior, so it seemed to me as the right thing to do.
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.
> 

