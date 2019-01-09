Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C03C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 20:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D6221773
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 20:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="d30LU/OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfAIUfQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:35:16 -0500
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:33170 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfAIUfQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 15:35:16 -0500
X-EEMSG-check-017: 373075143|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2019 20:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547066111; x=1578602111;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Us/la2pXFfxu1kTfRA7EU4ItsYKLWj9/RCaUQj+XdPw=;
  b=d30LU/OS+Om/okysF9g7r8a3WXi2McyfbuYGfjJpbnOxNKmf5xKig3lX
   drQMBKRDSXtHVMZmy5xuEPv3h3zpxkEfvcGQ04GzHsDnBpiu0NWkWJYtP
   vxj2UILGBrmLXNZmUXC3vHsNyNWs54CM8S+T7hJ/ITxOWlE2fxz16dXbG
   U1kqy7JkqrLhgjC18zX9lsgkCGAw8nwv2wFRoRYh6Il/nuhnIz/ZHzo6F
   lRBAeOYYTJc4H93NpY6MFsfKoLxxxWm7hHo7rOC6InQj7/4g65elmhaXX
   J+Au5KzKCSIbN6eNGawS2L2V95KsJ2+tcy7T4fWhoCH55DfzUc2WnB16B
   A==;
X-IronPort-AV: E=Sophos;i="5.56,458,1539648000"; 
   d="scan'208";a="19381674"
IronPort-PHdr: =?us-ascii?q?9a23=3AsOVrpxWpikGS+XLgKroVTR+aA+/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRGFuKdThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpVrozxql0TphW8GAasHvvixCJWiH/43aM00O?=
 =?us-ascii?q?ovHg/J0wMiA90Av2/ZrMn3OaoITey50KfFwDfFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNuS+aMI52TdkjQ2FuoCs60KMJto?=
 =?us-ascii?q?O7fCcQ1JQr3QLQa/uCc4SQ4RLsSvyRITFmi3JhYr6/gAyy8Ue4xu3ySMa7zV?=
 =?us-ascii?q?FKrjBfndnNsHAN2QbT5dKbRft5+UehxCuA2xrU6uFeLkA4jaXbK589wr4wi5?=
 =?us-ascii?q?ocql7PETPxmEXziqKda0Yq+vCw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?UIQmOV4/6z1Kf58k38WLhKi/o2nbTHv53CPsQbo7K5AxdS0oY+9xazFzem38?=
 =?us-ascii?q?ocnXkANF9FZAiIj5LoO1HTO/D0F+u/glSwnzdrwPDKJLvhDYnWLnffirvheL?=
 =?us-ascii?q?d960pExAoyy9BQ+Y5UB6kcLP/8VUL9rtzVAgIjPwCqzOvrFs9x2p4GVWKKGK?=
 =?us-ascii?q?CZMafSsVGS5uIoJumBfJQVtyvmK/U++/7vjWM2mV8afaWz25sXc2q3Eu5pI0?=
 =?us-ascii?q?Wef3rgms0BHnsSvgoiUOzqj0WPXiJJaHapQa095io2CJm6AofDXI+tnbKB3C?=
 =?us-ascii?q?OlEZ1Mf2xJFkqDHW30eIWDXvcGcDiSLdN5kjwYSbihTJcs1RartA/90LpnKP?=
 =?us-ascii?q?Db9TEGup/4zth6+fDclREo+jxoFciSz2aNT2RslGMSWzA2xLx/oVB6ylqbyq?=
 =?us-ascii?q?h3nfhYFd1V5/NUXQY3LoDcz+NkBNDoQA7BfcmGSEygQtq4BTE9VNUxw8UBY0?=
 =?us-ascii?q?xlAdWtkgjD3za2A78Sj7GLHIY78r/Y33XqP8Zy0WvG1K04g1kjRctPMnemib?=
 =?us-ascii?q?Bl+wfPAI7Jll2Tl7y2eqQEwC7N6GCDwHKKvEFZVg5wTKrEUWkEZkTIsdv5+1?=
 =?us-ascii?q?nCT76yCbUnKwdBzMmCJbZXat3tk1pLX+njONvAbGKrgWuwBgiHxqmKbIX0f2?=
 =?us-ascii?q?URxiLdCFILkwoL53aJKRA+Bju9o2LZFDFuGkjvbF3j8el9qHO2VUs0zwCMb0?=
 =?us-ascii?q?182Lu19BkVheGaS/wOxL0EpCYhqzJyHFqn2NLWEdWArRJ7fKpAedM9/EtH1W?=
 =?us-ascii?q?XBugxhPJytNKNiiUAEcwRxoUzu0w97CoJakcgltHkq1hZ9KbqE0FNdcDOVxZ?=
 =?us-ascii?q?TwOrzRKmnv8xGjcqDW2krD39mI5KcA9vA4pk79vAGmCEUi6W9r09pL3HuG4J?=
 =?us-ascii?q?XFEg4SXYj2UkYt+Bhwv6vabTUl54PIyX1sNrG5vSPN29IzA+sl1w6gf8xEPa?=
 =?us-ascii?q?OaGw/9DdcaC9KtKOM0gVipaAwLPORI+K4zJcOmeKjO5Kn+F+97kSPutm9H6Z?=
 =?us-ascii?q?1z1k+Wv353Q/XFzr4eyPGRwwWDWi25h17nucfyz8QMQjceBGe9gQ3jH4hYba?=
 =?us-ascii?q?BxNdIMDGC1JcS8y/1kipLtUmIe/1mmURdOw8KteByPf3Tj0gBKk0cau3qqnW?=
 =?us-ascii?q?2/1TMw2wkgs67X+SvJ2emqIAIOJ2pjXGB/iRLpJo+ugpYRW03+PCYzkx7w3l?=
 =?us-ascii?q?r336hWouxEKmDXRUpZN3ztI3pKTrq7tr3EZdVGrpwvr3MEA6yHfVmGR+ul8F?=
 =?us-ascii?q?Mh2CT5Ej4bnWhleg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DyAQD1WTZc/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?WZPMyeEAJQGTAEBAQEBAQaBNYksiFeGA4FnMgYBhEACgh8iOBIBAwEBAQEBA?=
 =?us-ascii?q?QIBbBwMgjopAYJmAQEBAQIBIxVBEAsYAgIRFQICVwYBDAYCAQGCXz8BgXQFC?=
 =?us-ascii?q?A+sRYEvhC0BAwcBAYEHhHAFgQuLNBd4gQeBESeCa4MFGQICGIECMVOCSoJXA?=
 =?us-ascii?q?pA5N5AiWgmHGYFGiRgGGJF3iWyFCo06IYFWKwgCGAghDzuCOAEBATISgj6DO?=
 =?us-ascii?q?IUUhV0hAzABAYEDAQGHCIJMAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2019 20:35:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x09KZ849024182;
        Wed, 9 Jan 2019 15:35:08 -0500
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
Date:   Wed, 9 Jan 2019 15:37:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/19 12:19 PM, Casey Schaufler wrote:
> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>> Changes in v2:
>> - add docstring for the new hook in union security_list_options
>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>    implemented
>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>
>> This series adds a new security hook that allows to initialize the security
>> context of kernfs properly, taking into account the parent context. Kernfs
>> nodes require special handling here, since they are not bound to specific
>> inodes/superblocks, but instead represent the backing tree structure that
>> is used to build the VFS tree when the kernfs tree is mounted.
>>
>> The kernfs nodes initially do not store any security context and rely on
>> the LSM to assign some default context to inodes created over them.
> 
> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
> and expected filesystem behavior?

sysfs / kernfs didn't support xattrs at all when we first added support 
for setting security contexts to it, so originally all sysfs / kernfs 
inodes had a single security context, and we only required separate 
storage for the inodes that were explicitly labeled by userspace.

Later kernfs grew support for trusted.* xattrs using simple_xattrs but 
the existing security.* support was left mostly unchanged.

> 
>> Kernfs
>> inodes, however, allow setting an explicit context via the *setxattr(2)
>> syscalls, in which case the context is stored inside the kernfs node's
>> metadata.
>>
>> SELinux (and possibly other LSMs) initialize the context of newly created
>> FS objects based on the parent object's context (usually the child inherits
>> the parent's context, unless the policy dictates otherwise).
> 
> An LSM might use information about the parent other than the "context".
> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
> to determine whether the Smack label of the new object should be taken
> from the parent or the process. Passing the "context" of the parent is
> insufficient for Smack.

IIUC, this would involve switching the handling of security.* xattrs in 
kernfs over to use simple_xattrs too (so that we can store multiple such 
attributes), and then pass the entire simple_xattrs list or at least 
anything with a security.* prefix when initializing a new node or 
refreshing an existing inode.  Then the security module could extract 
any security.* attributes of interest for use in determining the label 
of new inodes and in refreshing the label of an inode.

> 
>> This is done
>> by hooking the creation of the new inode corresponding to the newly created
>> file/directory via security_inode_init_security() (most filesystems always
>> create a fresh inode when a new FS object is created). However, kernfs nodes
>> can be created "behind the scenes" while the filesystem is not mounted
>> anywhere and thus no inodes exist.
>>
>> Therefore, to allow maintaining similar behavior for kernfs nodes, a new LSM
>> hook is needed, which would allow initializing the kernfs node's security
>> context based on the context stored in the parent's node (if any).
>>
>> The main motivation for this change is that the userspace users of cgroupfs
>> (which is built on kernfs) expect the usual security context inheritance
>> to work under SELinux (see [1] and [2]). This functionality is required for
>> better confinement of containers under SELinux.
>>
>> The first patch adds the new LSM hook; the second patch implements the hook
>> in SELinux; and the third patch modifies kernfs to use the new hook to
>> initialize the security context of kernfs nodes whenever its parent node
>> has a non-default context set.
>>
>> Note: the patches are based on current selinux/next [3], but they seem to
>> apply cleanly on top of v5.0-rc1 as well.
>>
>> Testing:
>> - passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
>>    current Rawhide kernel (5.0.0-0.rc1.git0.1) [4]
>> - passed the reproducer from the last patch
>>
>> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/log/?h=selinux-pr-20181224
>> [4] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/842855/
>>
>> Ondrej Mosnacek (3):
>>    LSM: Add new hook for generic node initialization
>>    selinux: Implement the object_init_security hook
>>    kernfs: Initialize security of newly created nodes
>>
>>   fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
>>   fs/kernfs/inode.c           |  9 +++----
>>   fs/kernfs/kernfs-internal.h |  4 +++
>>   include/linux/lsm_hooks.h   | 30 +++++++++++++++++++++++
>>   include/linux/security.h    | 14 +++++++++++
>>   security/security.c         | 10 ++++++++
>>   security/selinux/hooks.c    | 41 +++++++++++++++++++++++++++++++
>>   7 files changed, 149 insertions(+), 8 deletions(-)
>>
> 

