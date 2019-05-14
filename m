Return-Path: <SRS0=j2AE=TO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B5C04AB4
	for <selinux@archiver.kernel.org>; Tue, 14 May 2019 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF2920644
	for <selinux@archiver.kernel.org>; Tue, 14 May 2019 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UH+9hwux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENUWW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 May 2019 16:22:22 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:52745 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUWW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 May 2019 16:22:22 -0400
X-EEMSG-check-017: 412126278|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 May 2019 20:22:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557865337; x=1589401337;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=i2YRbvBVVx0eFICrxHCRbmzSvzY5yKuNMzNgSwwgBS4=;
  b=UH+9hwuxdRi4IB4dwNOAWXEhktodD70b1CPaDiZOs4NecgsjkFS2OfNc
   mfDxpA24c8SO5g02CEMKHF17ns/4f8kBr23s8g2ERCEk7LeCZR0+6UwCl
   5WnHFlXY5qoYADln2y6uWI4Xxl16IZnO+tKVXb+uzeS+gy16ybHWDLuIy
   5p6rAbo0h21oYQL7zy9qyMG1ac69Ltivyh5RrsY6zGVzrW7s+SKKtI9pe
   JeUImjc83uw5l5izC+BiPoAqfyT/0MUvKzm+Ra+ibeAY/SAQ0oBjvT/ZZ
   I2C3pLXE4UzgE4MY+YQ5z1Snh0ZK7cfJmAIFLK4jNF0Qy8TmjRri3OUAQ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,470,1549929600"; 
   d="scan'208";a="27711176"
IronPort-PHdr: =?us-ascii?q?9a23=3As25ifhcU6YrbcQ60e/3dJQtQlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc27YhyN2/xhgRfzUJnB7Loc0qyK6vmmCDJLuMrf+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiroQnLssQbgIRuJrs+xx?=
 =?us-ascii?q?bIv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCReoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/I3BIuH9wNvnraotr6O6UdXvy6wqTT0TXObOlb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtig9yr0Do5?=
 =?us-ascii?q?G7fS4KxYwkxxHBcfyHdZaH4hb5WOaWOzd4i3Roc6+8iRaq6UWs1+LxW8au3F?=
 =?us-ascii?q?tKsyZJiMfAu38T2xDJ98SKTOZ28F271jaVzQ/T7/lJIUUzlaXGNZEs2qUwlp?=
 =?us-ascii?q?8PsUTbGS/2hVn2gLeWdko6/uio7PzqYqn8qZ+GNo90lxr+Pr4yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eugz73s4Vf1QLBLjv0yiqXZsZbaKtoHpqOhHgNY3Yku5wy/Aju7yt?=
 =?us-ascii?q?gUg3YKIExfdB6al4TpPkvBIPH8DfexmVSslzJryujdPrL8GZXANWTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzzctF6J5OBbEBJ+zzVlfrtNPEFh85LxC0w+H/BdV/yIweV2yPAr?=
 =?us-ascii?q?GCPaPdtl+I4e0vI+2Sa4MPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZXCjAPtmJ0?=
 =?us-ascii?q?SZYXzxgtYOCmoKoAU+Q/LwiFGYUj5ceWyyX6Qi6TE/Eo6mCp3DRo+1irybwC?=
 =?us-ascii?q?i7BoFWZnxBCl2UE3foeJ+LW/MSZyKUOc9hlToEWKOuS48m0hGuuwv6xKR9Iu?=
 =?us-ascii?q?XI/S0YsIrp1MJp6O3LiREy6Tt0AtyF02GJVW50g38IRyUt069lukF90EmM3r?=
 =?us-ascii?q?V4g/NCCdxf/e9GUgA/NZTE1ex1F8jyWh7dfteOUFumRsumASsrQd0q3dABf1?=
 =?us-ascii?q?1wG8+8gR/e3yqlGaMVm6aXC5wz96LWx2LxKNply3bayKkhiEErQtNVOm27gq?=
 =?us-ascii?q?5y7BDTCJTUk0WdjqqqcKMc3CnX9Gid12aBoEZYUAtoW6XfQX8fflfWrcj+5k?=
 =?us-ascii?q?7aSL+uDLMnMhBHycGYNqRFdMbkjU9YS/j+ONTReX6xl32sChaPw7PfJLbtLk?=
 =?us-ascii?q?cQ0ivHBVlMrQkV8XucfTMiASq56zbcATJgC3rgZETj9eQ4o3S+GBwa1QaPOn?=
 =?us-ascii?q?Z92qK19xhdvvmVT/cez/pQoys6gyllF1a6mdTNApyPoBQ3L/YUWs80/FoSjT?=
 =?us-ascii?q?GRjAd6JJH1avk411M=3D?=
X-IPAS-Result: =?us-ascii?q?A2AhBQC9Ittc/wHyM5BkHAEBAQQBAQcEAQGBZYFnKmlNB?=
 =?us-ascii?q?DMohBGTE0wBAQEBAQEGgQgIJYlNkCoDVAkBAQEBAQEBAQEvBQECAQGEQAKCH?=
 =?us-ascii?q?SM4EwEDAQEBBAEBAQEDAQFsHAyCOikBgmYBAQEBAyMPAQVBEAkCFAEDAgIjA?=
 =?us-ascii?q?wICRhEGDQYCAQGCXz8BgXYUD5AAm2WBL4hsgUAGgQsoi08XeIEHgTgMgWFJN?=
 =?us-ascii?q?T6CSBkEGIRRgjYiBI0wmURlCYILggmEGIw3BhuCFIpAiRqTDJBAITaBISsIA?=
 =?us-ascii?q?hgIIQ+DJ4IbF4hghVsjAzABCXwBAY9nAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 May 2019 20:22:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4EKMFTK028197;
        Tue, 14 May 2019 16:22:15 -0400
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     selinux@vger.kernel.org, Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Lukas Vrabec <lvrabec@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
 <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
 <CABXk95Au_UVdghpHGuu39mHJkSYA2=7YS__vtx8sxGEH4CuSgg@mail.gmail.com>
 <CAB9W1A2LPEk_XixkFU5mVgr9c2yNoiGzBjXYjpc3vDM1b2VpyA@mail.gmail.com>
 <cc889840-5c5a-99c5-d3fe-1604c32763f2@tycho.nsa.gov>
 <525387dc-ed0c-7555-0dd5-49ca442a6b88@tycho.nsa.gov>
Message-ID: <17bfd94b-8409-3bce-8963-c462a1952ec2@tycho.nsa.gov>
Date:   Tue, 14 May 2019 16:13:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <525387dc-ed0c-7555-0dd5-49ca442a6b88@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/10/19 10:55 AM, Stephen Smalley wrote:
> On 5/10/19 8:38 AM, Stephen Smalley wrote:
>> On 5/9/19 8:32 PM, Stephen Smalley wrote:
>>> On Thu, May 9, 2019, 5:49 PM Jeffrey Vander Stoep <jeffv@google.com 
>>> <mailto:jeffv@google.com>> wrote:
>>>
>>>     From: Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
>>>     Date: Thu, May 9, 2019 at 2:17 PM
>>>     To: Jeffrey Vander Stoep, <selinux@vger.kernel.org
>>>     <mailto:selinux@vger.kernel.org>>, Joel Galenson,
>>>     Petr Lautrbach
>>>
>>>      > On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
>>>      > > I expected files here would have the process's context, but 
>>> they
>>>      > > don't. The files are actually all symlinks so it's entirely
>>>     possible
>>>      > > that the they shouldn't have the process's context. If 
>>> that's the
>>>      > > case, how can I provide different labels for them? Neither
>>>     "proc" nor
>>>      > > "unlabeled" are appropriate.
>>>      > >
>>>      > > On a device with a 3.18 kernel they have the "proc" context:
>>>      > > sailfish:/ # ls -LZ1 /proc/1/ns
>>>      > > u:object_r:proc:s0 mnt
>>>      > > u:object_r:proc:s0 net
>>>      > >
>>>      > > On a device with the 4.9 kernel the have the "unlabeled" 
>>> context:
>>>      > > blueline:/ # ls -LZ1 /proc/1/ns
>>>      > > u:object_r:unlabeled:s0 cgroup
>>>      > > u:object_r:unlabeled:s0 mnt
>>>      > > u:object_r:unlabeled:s0 net
>>>      >
>>>      > First, ls -L dereferences symlinks so you are going to get the
>>>     context
>>>      > of the object referenced by the symlink, not the context of the
>>>     symlink
>>>      > itself.
>>>
>>>     I'm seeing a denial on the object not the symlink, so -L is what 
>>> I want.
>>>
>>>      >
>>>      > Second, the task context is only assigned to proc inodes 
>>> created via
>>>      > proc_pid_make_inode(), which has never been the case of 
>>> /proc/pid/ns
>>>      > inodes - those have their own implementations and operations.
>>>      >
>>>      > Third, /proc/pid/ns migrated from proc to its own pseudo 
>>> filesystem,
>>>      > nsfs, which requires a corresponding fs_use or genfscon rule in
>>>     policy
>>>      > or they will be unlabeled.  refpolicy has a genfscon rule.
>>>     Confusingly
>>>      > there appears to be both in Fedora policy, a fs_use_task and a
>>>     genfscon
>>>      > rule, and it appears that fs_use_task is being applied here.  
>>> I don't
>>>      > know why or what exactly that means.  It won't be the task
>>>     context for
>>>      > the task associated with that /proc/pid directory but instead
>>>     would be
>>>      > whichever task context instantiates the inode.
>>>      >
>>>
>>>     So, how do I label these files in genfs_contexts?
>>>
>>>     "mount | grep nsfs" returns nothing.
>>>
>>>
>>> Just a single entry for the nsfs / should suffice if using genfscon. 
>>> That will apply a single label to all nsfs inodes. If you need to 
>>> distinguish than fs_use_task might work better but you'd have to 
>>> check when these inodes get instantiated; they are not per task but 
>>> rather per namespace iiuc. See 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e149ed2b805fefdccf7ccdfc19eca22fdd4514ac 
>>>
>>
>> Actually, looking at the nsfs code, it looks like the inode gets 
>> allocated when the link is first followed, so fs_use_task nsfs would 
>> be misleading - it would get the context of whatever task first 
>> followed the link, not the associated task for the /proc/pid 
>> directory.  And really, these objects are not per-process state; they 
>> are per-namespace (note that ls -Li shows the same inode number for 
>> anything sharing that namespace). genfscon is the only thing that 
>> makes sense for labeling in that case.  Arguably, namespaces should be 
>> labeled from their creating process and these pseudo files should 
>> inherit that label but that would require kernel changes to label 
>> namespaces and propagate those labels.
>>
>> Red Hat folks, why do you have both fs_use_task nsfs and genfscon nsfs 
>> in your policy?  I think the fs_use_task is wrong here; probably was 
>> an attempt to label the targets of the /proc/pid/ns links with the 
>> same label as the other /proc/pid nodes but that isn't right and won't 
>> work; try ls -LZ /proc/1/ns for example and contrast with ls -lZ 
>> /proc/1/ns.
> 
>  From a compatibility POV, it would probably be best to assign nsfs the 
> same context as proc via genfscon so that policy that worked on v3.18 
> and earlier will continue working under later kernels, unless there is 
> some real reason to distinguish these accesses.

Looks like someone added a type, genfscon, and allow rules for nsfs to 
the goldfish sepolicy,
$ grep -r nsfs device/generic/goldfish/sepolicy
device/generic/goldfish/sepolicy/common/genfs_contexts:genfscon nsfs / 
u:object_r:nsfs:s0
device/generic/goldfish/sepolicy/common/execns.te:allow execns nsfs:file 
{ open read };
device/generic/goldfish/sepolicy/common/vold.te:allow vold nsfs:file 
r_file_perms;
device/generic/goldfish/sepolicy/common/goldfish_setup.te:allow 
goldfish_setup nsfs:file r_file_perms;
device/generic/goldfish/sepolicy/common/file.te:type nsfs, fs_type;

Don't know if most of that ought to be moved over to system/sepolicy. 
Looks like execns is goldfish-specific 
(device/generic/goldfish/wifi/execns), as is goldfish_setup of course. 
At least the type declaration and genfscon statement probably should 
live in system/sepolicy.  And whether or not you keep it as a separate 
nsfs type or switch to proc for consistency/compatibility with older 
kernels/policies is up to you.  I guess the question is whether you 
want/need to allow nsfs access without allowing access to the generic 
proc type.
