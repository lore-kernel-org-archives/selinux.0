Return-Path: <SRS0=duOh=PS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44968C43387
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09800206B7
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 19:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Qvotra03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfAJTgA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:36:00 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:41691 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfAJTgA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 14:36:00 -0500
X-EEMSG-check-017: 667239237|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="667239237"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2019 19:35:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547148957; x=1578684957;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TXA8A0o5TQaZtjtCRUfY2MRpcPJxmYZ83zYI2FWVPgM=;
  b=Qvotra03iG+HINVTR733P5K5ghrxjS+6932xu4vJQXZiGd4bkyvVjLXH
   DqGLnyOIb3dsVfhJYar3FwKCvNCX5o0+v71vipFVW+9zRsd4VhaJbZhsr
   8L5br08rTVEmFBoln5KZ5Ifyveszuew831Zhs3hKWUhKJuPxaePHc4l2D
   Wd0uMO7APaTQpZdN52alOF7C2wA9Itr4rvgF3X8pr8/yI4Addsk7asU0P
   F8Mby390WC90l37ukYcebiemWnD4j2o6E46APSniOnKKOKpD4gu68Op1m
   tur8YYNJWvzWiySD27uGPNdfJOVX+vR4unZ9et5dwyv+EkcMWvnRLpoar
   w==;
X-IronPort-AV: E=Sophos;i="5.56,462,1539648000"; 
   d="scan'208";a="19422498"
IronPort-PHdr: =?us-ascii?q?9a23=3A82MdfR024doS7jDasmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXI/7xwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5YTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDs27ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb9CjEJtVrS6aNo12T9shQ252oiY6zKMJuZ?=
 =?us-ascii?q?qhcCgN0pQnyBjSYOGEfYiQ+h/vSemcLDhiiH9lZb6znQi+/Ee+xuHmS8W51k?=
 =?us-ascii?q?tBoDBfndnWrH8N0gTe6s2ASvRg4EiswS2P1wXP6uFcJkA0iLbbJ4YhwrEukp?=
 =?us-ascii?q?oTtlzOHjPsl0Xsja+Wa14k9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLf3vQEDxr8LXDx8iPgyv3+nnCM9y1p4QWWKLHK?=
 =?us-ascii?q?CZKrrevkOS6e41P+aMY4oVsi7nK/c5//7ukWM5mVgFcKmyw5QXbHG4HvJ7I0?=
 =?us-ascii?q?SWenfsnNgBHnkQvgYkT+zllkeCUThNaHa2Ra484Ss7CI2+B4fZWo+tmKCB3D?=
 =?us-ascii?q?u8HpBOYmBGC1aMEWrndomdQPcDdj6dItJ7kjwFSbigS5Yt1RSptADn1rpnKv?=
 =?us-ascii?q?Tb9zYGtZLsytd1/ffflRIs+jxuCcSSzWWNQ3tznmMSSD88xLp/rlBlylefza?=
 =?us-ascii?q?h4hORVFcBR5/5SUQc1K4Tcz+pkBND2QA7Bec2JSFm+SNW8HT4xVs4xw8MJY0?=
 =?us-ascii?q?tlH9WijxbD3zelArMMmbyLH4E7/bzC33fvI8Zw0GjG1KY/gFk8WMdPNnOphr?=
 =?us-ascii?q?R59wfNA47FiUKZl7ylda4Exi7C6H+DzXaSvEFfSAN/TarFXWoYZkvLtdT5/V?=
 =?us-ascii?q?jPT6GhCbs5KAtN082CJbVQat3vk1pGQO3vONPEY2K+yC+MAkOjz6iBfcLRcG?=
 =?us-ascii?q?UUwSvZBVJMxwsa5nuXHRM1Bi68rWbTFnllHBTkZEa6taFlpXe6SFIk5x+FYl?=
 =?us-ascii?q?cn1Lev/BMRw/uGRKA9xLUB7Rw9pi10EVD15NffD96NtkI1Z6lHSc8s61dAk2?=
 =?us-ascii?q?TCvkpyOYL2fPMqvUIXbwki5xCm7B5wEIgV1JFz9H4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AEBAC4nTdc/wHyM5BkHAEBAQQBAQcEAQGBZYFbKWZPM?=
 =?us-ascii?q?yeEAJQITAEBAQEBAQaBCAgliSyOX4FnMgYBhEACgiUiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjopAYJmAQEBAQIBIw8BBUEFCwsYAgIRFQICVwYBDAYCAQEXgkg/AYF0B?=
 =?us-ascii?q?QgPrhmBL4QuAYEThGoFgQuLNBd4gQeBEScMgWF+hDwSARIBC1OCSoJXApB1k?=
 =?us-ascii?q?CZaCYcZimAGGJF8iW6FDo1CIWVxKwgCGAghDzuCOAE0EoIUFxOITIVdIQMxA?=
 =?us-ascii?q?YEDAQGGew4XgicBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2019 19:35:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0AJZmSb028656;
        Thu, 10 Jan 2019 14:35:48 -0500
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
 <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
 <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2612c523-084a-7652-58ca-9e062b80138e@tycho.nsa.gov>
Date:   Thu, 10 Jan 2019 14:37:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/19 12:54 PM, Casey Schaufler wrote:
> 
> Resending after email configuration repair.
> 
> On 1/10/2019 6:15 AM, Stephen Smalley wrote:
>> On 1/9/19 5:03 PM, Casey Schaufler wrote:
>>> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
>>>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>>>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>>>>> Changes in v2:
>>>>>> - add docstring for the new hook in union security_list_options
>>>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>>>>      implemented
>>>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>>>>>
>>>>>> This series adds a new security hook that allows to initialize the security
>>>>>> context of kernfs properly, taking into account the parent context. Kernfs
>>>>>> nodes require special handling here, since they are not bound to specific
>>>>>> inodes/superblocks, but instead represent the backing tree structure that
>>>>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>>>>
>>>>>> The kernfs nodes initially do not store any security context and rely on
>>>>>> the LSM to assign some default context to inodes created over them.
>>>>>
>>>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
>>>>> and expected filesystem behavior?
>>>>
>>>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
>>>>
>>>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
>>>
>>> OK, so as I said, this seems like a bug in kernfs.
>>>
>>>>
>>>>>
>>>>>> Kernfs
>>>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
>>>>>> syscalls, in which case the context is stored inside the kernfs node's
>>>>>> metadata.
>>>>>>
>>>>>> SELinux (and possibly other LSMs) initialize the context of newly created
>>>>>> FS objects based on the parent object's context (usually the child inherits
>>>>>> the parent's context, unless the policy dictates otherwise).
>>>>>
>>>>> An LSM might use information about the parent other than the "context".
>>>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
>>>>> to determine whether the Smack label of the new object should be taken
>>>>> from the parent or the process. Passing the "context" of the parent is
>>>>> insufficient for Smack.
>>>>
>>>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.
>>>
>>> Right. But I'll point out that there is nothing to prevent an
>>> LSM from using inode information outside of the xattrs (e.g. uids)
>>> to determine the security state it wants to give a new object.
>>
>> If that's a real concern, the hook could pass the ia_iattr structure in addition to the simple_xattrs list and the security module could use any inode attributes it likes in making the decision.  Effectively it would be passing the entire kernfs_iattrs structure, but probably not directly since that definition is presently private to kernfs.
> 
> Yes, it's a real concern. And no, just passing all of the kernfs internal data
> out in j-random formats does not pass muster. Al Viro was commenting the other
> day on how bad the LSM infrastructure interfaces are. The original proposal here
> is already big, cluttered and inadequate. Adding more to it to make up for its
> shortcomings should be sending up red flags
I don't quite see how the original patch set or hook can be called big 
and cluttered.  Switching the handling of security xattrs in kernfs to 
use simple_xattrs (a natural and seemingly straightforward cleanup) and 
passing the entire simple_xattrs list to the hook interface would allow 
you to support SMACK64TRANSMUTE, which was the one actual inadequacy you 
identified.  You claim that someone might need/want the parent uid/gid 
too, but there are no in-tree security modules that do so nor any 
submitted AFAIK, and if that situation arises, all we need to do to 
support it is to add the iattrs.  Obviously they can all be wrapped up 
in some larger structure if desired. At that point the security modules 
would have access to all of the inode attributes supported by kernfs.

> I've been wallowing in the LSM infrastructure for the past seven years.
> Interfaces like this one, that propagate the idiosyncrasies of both
> the caller (kernfs) and one potential callee (SELinux) are much too
> common. I understand that there is a problem that needs a solution.
> This isn't it.
The solution sketched above should be capable of supporting the needs of 
any current security modules and of being easily extended for others if 
the need arises.

> 
> 
>>> I suggest that the better solution would be for kernfs to
>>> use inodes like a real filesystem. Every special case like this
>>> results in special cases like this special hook. It's hard
>>> enough to keep track of the general case in the Linux kernel.
>>
>> Feel free to propose an implementation if you like, but doing a complete rewrite of kernfs internals seems a bit out of scope.
> 
> If this issue points out a serious problem with the kernfs implementation
> then I would expect that addressing the problem at its source would be in
> everyone's best interest. Did anyone even look at the possibility? If I
> said that I would do that, how long would you be willing to wait for it?

I don't know that it points to a serious problem with kernfs.  But I'll 
let you convince the kernfs maintainers of that. Meanwhile, we have a 
proposed solution that solves the problem for all in-tree security 
modules.  I see no reason to hold that up. Don't over-design.

