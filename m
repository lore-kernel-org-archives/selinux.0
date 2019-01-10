Return-Path: <SRS0=duOh=PS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA07C43387
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ECA214C6
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YWhKIHoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfAJONw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:13:52 -0500
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:34366 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfAJONv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 09:13:51 -0500
X-EEMSG-check-017: 373459012|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2019 14:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547129627; x=1578665627;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5L3CYCARg5JwYdgMC3zUVSxzQO4Uet1KxAXThT5NrTs=;
  b=YWhKIHoRmPDb9zzDlkUppCBNKBoMW2ILPetvF5onOL8GwkG1jPxRAJTX
   mEaG24XAVHz++uuizw/9evQjUXh9viSWf/ZDpNc1HA6lmtdZlqHxAAL5f
   ta38IrwNX9kmI86EPnmkMVJRYivb0s0BwRf8ET48uUTvGKykQx2MGID5G
   mIQCHR8yCZyLca1epfOs/4dDV7yfWu/YPpYqVL1usAS++k+aDetYeZHXN
   HlYFZlahEnwkFloIBdR3fNdxcFnqTNcWDgImTTia3dKHzqHIBdhEXukxv
   kUfDrIMHqR4ZCD3cKz0C9z3yaBWkAZSk55zqeCfsOBWyr3+XU7e0MYynx
   w==;
X-IronPort-AV: E=Sophos;i="5.56,461,1539648000"; 
   d="scan'208";a="19400624"
IronPort-PHdr: =?us-ascii?q?9a23=3A2pEWlBc/WRUwbhg+4c3YLaVglGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2/ZhGN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMOddo4T7ulAArwaxBRO0Ce3y1DFIiH/406403e?=
 =?us-ascii?q?svHg7J3hAvEd0VvXTIr9j4LrseXfy7waTKyzjIcvNY2S366IjNah0vvO2MUq?=
 =?us-ascii?q?xoccrR10YvER7OgEiVqYP/OzOV0voCsmiG5OdnTuKglnUnphptojmv2sgsio?=
 =?us-ascii?q?7JipgTylDf7yp12ok1JdqmSENiZ9OvDZVetyafN4RsQ8MiRXlluDwkxbIbuZ?=
 =?us-ascii?q?60ZjQKxI47yB7YbvyLa4uI7Qz5VOaXPzh4gGhpeLWlhxa96USgxPPzWdSz0F?=
 =?us-ascii?q?ZQtCVFk9/Mtn4X1xPJ9seHTvx9/lq81jqV0ADT8O5ELVg7laraN54hwqMwmY?=
 =?us-ascii?q?EJvUvfGS/2nUP7h7KVeEU84uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg1NB?=
 =?us-ascii?q?UFUXKB9uSmzrLj+FX0QLBNjvIrjKbUqIvaJcEHpq6hBA9Vz5oj5w6/Dzi41N?=
 =?us-ascii?q?QYmmEKLE5fdxKdjojpJkrOLOrkDfa/n1uskDBry+rAPrL9GZXCMmLPkLLgfb?=
 =?us-ascii?q?Z580JcyQwzws5D559MF70ML/3+VlXxudDFFBM1LQO5z/j9BNlgzo8eXHiAAq?=
 =?us-ascii?q?6dMKPcq1+I4ecvLvGXZIAIozbwMOQl5v7ygn85nl8RZ6+p3YANZ3yiEfRmJF?=
 =?us-ascii?q?uZbWL2gtgdCWcKohY+TOvyhVKeSzFTfGi9XqIn6zEgFI2mDZ3MRp2jgLyFwi?=
 =?us-ascii?q?i7BIRaaXxcBVyWDXjocICEUe8WaC2OOs9hjiAEVb+5Ro8m0BGusxT6y7x9Ie?=
 =?us-ascii?q?XI5CIVrojj28Zo6O3Tjx4y6SZ4ANia02GIV2t0hH8HRycq3KBjpkxw0kyD3r?=
 =?us-ascii?q?Z8g/xZE9xT+vxIXxwkNZ7T0eN6Ecr+WgHfcdeTTlapXNGmDSs2TtIrzN8Ee1?=
 =?us-ascii?q?x9FMm6jhDfwyqqBKcYl6SRC5wp9qLRxGDxKNxgy3bCzaUhil4mQsxVNWK4nK?=
 =?us-ascii?q?Jw6w/TB4vRmUWDi6mqbbgc3DLK9GqbyWqOvUdYUBN/UKncRnAQeFfZrcnj5k?=
 =?us-ascii?q?PDU7+vCa0rMg5GycGfN6tKbsPmgE5YRPfsJtveeXi9m2SuChaSwLODco7qd3?=
 =?us-ascii?q?8a3CXHB0gOixoT8mqeNQgiGiehpHrTDDN0FV3xbEPs8ul+pWi/Tk81yQGKck?=
 =?us-ascii?q?Jg17Sy+h4Ig/yTVukc3q4FuCcmrTV4BlG938jZC9CYvQpuYL1cYc8h4FdAzW?=
 =?us-ascii?q?/Zqw59M4ejL698nF4edRp4v0f02xVwEIVAntAgrGk2wwpqNaKYzFRBeiuc3Z?=
 =?us-ascii?q?DxPL3XN2bz8Amha67Nx17RzsiW9bkL6PkjtVXjsx+mFlA4/3VkzdZVyX2c6Y?=
 =?us-ascii?q?vODAYIVpLxSEk3/QBgp77Geik9+5/U1Xp0PKaovT/CwdUpBPY9yha7ZNpfLq?=
 =?us-ascii?q?yEGxHoE8EABMihNvYqm163YRIAJuxS87Q0P8z1P8eBjYWiJ+tx1AmtjW1a7o?=
 =?us-ascii?q?RwyArY/CNnR//gxJ0FyuyW2gadEjz1ylymt5az0adCaSsfHCKazjPiDYVcZe?=
 =?us-ascii?q?UmeoMMEmGnKMCf3Nhyh5fxHXVf8QjnT0gL3M6vZAq6cVPwx0tT2F4RrHjhnj?=
 =?us-ascii?q?G3i3RMmiwt5o+Y2zbDi7D6fQcDEnZCWW0niFDrO4XyhNcfChuGdQ8swSC56F?=
 =?us-ascii?q?76yq4Tn6F2K23eUA8cZCTtB31zWau38LyZaohA741+4nYfa/i1fV3PEu21mB?=
 =?us-ascii?q?AdyS62WjIGmj0=3D?=
X-IPAS-Result: =?us-ascii?q?A2BGAABbUjdc/wHyM5BjGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFaKWZPMyeEAJQJTAEBAQEBAQaBCAgliSyIWIVzFIFnMgYBhEACgiUiN?=
 =?us-ascii?q?gcNAQMBAQEBAQECAWwcDII6KQGCZgEBAQECASMPAQVBBQsJAhgCAhEVAgJXB?=
 =?us-ascii?q?gEMBgIBAReCSD8BgXQFCA+QWptggS+ELgEDBwEBgQeEbgWBC4s0F3iBB4ERJ?=
 =?us-ascii?q?wyCX4MFGQICGIECMVOCSoJXApB1kCZaCYcZgUaJGgYYkXyJboUOjTIIKYFWK?=
 =?us-ascii?q?wgCGAghDzuCOAEBATISghQXE4M4hRSFXSEDMAEBgQMBAYZ7gkwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2019 14:13:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0AEDhFU018783;
        Thu, 10 Jan 2019 09:13:43 -0500
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
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
 <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
Date:   Thu, 10 Jan 2019 09:15:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/19 5:03 PM, Casey Schaufler wrote:
> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>>> Changes in v2:
>>>> - add docstring for the new hook in union security_list_options
>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>>     implemented
>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>>>
>>>> This series adds a new security hook that allows to initialize the security
>>>> context of kernfs properly, taking into account the parent context. Kernfs
>>>> nodes require special handling here, since they are not bound to specific
>>>> inodes/superblocks, but instead represent the backing tree structure that
>>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>>
>>>> The kernfs nodes initially do not store any security context and rely on
>>>> the LSM to assign some default context to inodes created over them.
>>>
>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
>>> and expected filesystem behavior?
>>
>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
>>
>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
> 
> OK, so as I said, this seems like a bug in kernfs.
> 
>>
>>>
>>>> Kernfs
>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
>>>> syscalls, in which case the context is stored inside the kernfs node's
>>>> metadata.
>>>>
>>>> SELinux (and possibly other LSMs) initialize the context of newly created
>>>> FS objects based on the parent object's context (usually the child inherits
>>>> the parent's context, unless the policy dictates otherwise).
>>>
>>> An LSM might use information about the parent other than the "context".
>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
>>> to determine whether the Smack label of the new object should be taken
>>> from the parent or the process. Passing the "context" of the parent is
>>> insufficient for Smack.
>>
>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.
> 
> Right. But I'll point out that there is nothing to prevent an
> LSM from using inode information outside of the xattrs (e.g. uids)
> to determine the security state it wants to give a new object.

If that's a real concern, the hook could pass the ia_iattr structure in 
addition to the simple_xattrs list and the security module could use any 
inode attributes it likes in making the decision.  Effectively it would 
be passing the entire kernfs_iattrs structure, but probably not directly 
since that definition is presently private to kernfs.

> I suggest that the better solution would be for kernfs to
> use inodes like a real filesystem. Every special case like this
> results in special cases like this special hook. It's hard
> enough to keep track of the general case in the Linux kernel.

Feel free to propose an implementation if you like, but doing a complete 
rewrite of kernfs internals seems a bit out of scope.

> 
>>
>>>
>>>> This is done
>>>> by hooking the creation of the new inode corresponding to the newly created
>>>> file/directory via security_inode_init_security() (most filesystems always
>>>> create a fresh inode when a new FS object is created). However, kernfs nodes
>>>> can be created "behind the scenes" while the filesystem is not mounted
>>>> anywhere and thus no inodes exist.
>>>>
>>>> Therefore, to allow maintaining similar behavior for kernfs nodes, a new LSM
>>>> hook is needed, which would allow initializing the kernfs node's security
>>>> context based on the context stored in the parent's node (if any).
>>>>
>>>> The main motivation for this change is that the userspace users of cgroupfs
>>>> (which is built on kernfs) expect the usual security context inheritance
>>>> to work under SELinux (see [1] and [2]). This functionality is required for
>>>> better confinement of containers under SELinux.
>>>>
>>>> The first patch adds the new LSM hook; the second patch implements the hook
>>>> in SELinux; and the third patch modifies kernfs to use the new hook to
>>>> initialize the security context of kernfs nodes whenever its parent node
>>>> has a non-default context set.
>>>>
>>>> Note: the patches are based on current selinux/next [3], but they seem to
>>>> apply cleanly on top of v5.0-rc1 as well.
>>>>
>>>> Testing:
>>>> - passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
>>>>     current Rawhide kernel (5.0.0-0.rc1.git0.1) [4]
>>>> - passed the reproducer from the last patch
>>>>
>>>> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
>>>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/log/?h=selinux-pr-20181224
>>>> [4] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/842855/
>>>>
>>>> Ondrej Mosnacek (3):
>>>>     LSM: Add new hook for generic node initialization
>>>>     selinux: Implement the object_init_security hook
>>>>     kernfs: Initialize security of newly created nodes
>>>>
>>>>    fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
>>>>    fs/kernfs/inode.c           |  9 +++----
>>>>    fs/kernfs/kernfs-internal.h |  4 +++
>>>>    include/linux/lsm_hooks.h   | 30 +++++++++++++++++++++++
>>>>    include/linux/security.h    | 14 +++++++++++
>>>>    security/security.c         | 10 ++++++++
>>>>    security/selinux/hooks.c    | 41 +++++++++++++++++++++++++++++++
>>>>    7 files changed, 149 insertions(+), 8 deletions(-)
>>>>
>>>
>>
>>
> 

