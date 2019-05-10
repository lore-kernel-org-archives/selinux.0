Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC22C04AB2
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4625D216C4
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QN+FQdbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfEJOem (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 10:34:42 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:28880 "EHLO
        UCOL19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfEJOel (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 10:34:41 -0400
X-EEMSG-check-017: 17501284|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="17501284"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 May 2019 14:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557498871; x=1589034871;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5wFtP6R2wfDTgJgkhYmtC6NPBu91MCcd9QJQdSIPRK8=;
  b=QN+FQdbKtHhhBoZvvW57mG2JCQi8QiFk56hOF3RgvPGzTtyd3e8aJJcO
   gCLpGyFl5nx+KM+E6bmzU1cnWYYsjdAiGMZ9qNeZYf3ykR3bPauWGS1J8
   Tw4xDuS85L/c54C/ds4uZ0OG60Uyc0GAP2Gh8X5Ci7wgyp2gdKlkRYX5+
   A63LNv/VtMyRG/Ia/dzfXJjE/M5RDXI9I6liJzRfzOTUhQyUj4LBg9tRR
   sTOkHe83ivqfErT4wCDZMB0QQeH0ZqJtXEBCQU2EJXzloxWwgl/0Eutwz
   spZwIc32ydu8WRnOkyMPPrVqAG4BS/IWhGC0wFXUS/s4Qb5j1D4BVeVqf
   A==;
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="27385988"
IronPort-PHdr: =?us-ascii?q?9a23=3AdHNO7x9neFgDJv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0e4fIJqq85mqBkHD//Il1AaPAdyCraIUwLWJ+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhViDanYr5/Lxq6oAfTu8ILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUUSm?=
 =?us-ascii?q?pbWsZaSjJPDIWyYYASC+YNJOhVoo34q1YIsBCwBxSjBPn3xzFVmHH206003e?=
 =?us-ascii?q?cvHw7I0wMvHc4BvnvPodXpNqofS/y5wLXGwDjBaf5dxDfz6JLPchAkufyCQK?=
 =?us-ascii?q?5wftTJyUkvCQzFiEibp5HgPzyP0uQNt3aU7up9Xu+okG4othpxryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqiKUN5NuT88/TGxltzw2x70btZ?=
 =?us-ascii?q?KhYiQHx4orywTCZ/GBboOG+AjsVPyLLjd9nH9lfbW/iAus/kW40e38U9W00E?=
 =?us-ascii?q?5NripYjtnArnAN2ALX6siAUvZ94l2u2SyO1wDO8eFIO1w0lKrHJJ4hxb48jJ?=
 =?us-ascii?q?wTvljYHiDqgkn2ia6WdkE89uip7eTofKnmq4eBO4J7hQzyKKQjltGlDegmPQ?=
 =?us-ascii?q?UCQXKX9fmk2L3m50L5QbFKjvMskqnetZDXPd8bqbOiAwJOzoYi6wqwDzeh0N?=
 =?us-ascii?q?gCm3kHN0hKdAiIj4juJVHCOOr4Auung1SwjDdrwOjLPr//DZXDIHjDjqzsfb?=
 =?us-ascii?q?l6605bxwozyc5Q64hIBbEGJfL5QlXxu8DADh8lLwy0xP7qCM5j2YMaWGKPBL?=
 =?us-ascii?q?KZMazJvF+W6eIgPfOMaJUWuDnjMfgl4eDhjXsjlV8aZ6mp0oMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88DEWcFpAU+SPLliFuZUT5UYXa/RK085jY8CIKpCYfMWJqhj6CG3C?=
 =?us-ascii?q?e+BpdWfHxJCkiQEXf0cIWJQ+8MaCaILc98jjwET6OuRJU62BG0qgD11rpnIf?=
 =?us-ascii?q?DI+iECqZ3j09117fXJlR4u7Tx0E9id02aVQmFshGwIWjs20btnoUNn11eD1b?=
 =?us-ascii?q?F0g/lfFdxU/fNGTB02OoLbz+x/E9ryQB7Ofs+VSFa6RdWrGTYxTtc2w98VZU?=
 =?us-ascii?q?ZyAcmtgQ7Y0iqwHbAairyLC4Yo8q7Gw3fxIMN9mD760/wDglcoWMZefVOvgK?=
 =?us-ascii?q?Jy7UDoG4nEiw3Nlauke7o00ynK+2OOi2GJuRccGBV9VaTDQGA3eETbt5L661?=
 =?us-ascii?q?nEQrvoDq4odkNjzsOGYoRDbtDvllJADKPhN93abmSqnGGYChGPybeBKoHtfj?=
 =?us-ascii?q?NZlB3QFFJMtwkO4WyMPAM+TnO5p2vDECZkHHr1bk/s+PU4o3S+GAt89wiXaw?=
 =?us-ascii?q?VE0L2v91ZBnfWBT9sL168A/SImrC95Wl262oSSQ/2GqxBsfu15Zsg76VxK1i?=
 =?us-ascii?q?qNsAl6JZqpJK1KnFMScw1r+Ujp0kMkJJ9HlJ0RsH4yzAd0YZmd2VdFeiLQiY?=
 =?us-ascii?q?v8IZXLO2Ly+1apcKeQ1VbAhoXFspwT4eg1/g2w9DqiEVAvpjA+iIhY?=
X-IPAS-Result: =?us-ascii?q?A2AXBgC6itVc/wHyM5BkHAEBAQQBAQcEAQGBZYFnKoE2B?=
 =?us-ascii?q?TIohBGTEUwBAQEBAQEGgQgtiU2PGoFnCQEBAQEBAQEBATQBAgEBhEACggsjO?=
 =?us-ascii?q?BMBAwEBAQQBAQEBAwEBbCiCOikBgmYBAQEBAyMVUQsUAQMCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/gXcUrTGBL4QGAYFAgyKBRoELJ4tPF3iBB4E4gjY1PoQsgyKCNiIEk?=
 =?us-ascii?q?xuUNQmCC4IHkEwGG5VpjDGXESGBVysIAhgIIQ87gmyCGxeNaAFSIwMwgQYBA?=
 =?us-ascii?q?Y9YAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 May 2019 14:34:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4AEYRpO007727;
        Fri, 10 May 2019 10:34:27 -0400
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
To:     Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org,
        Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
 <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
 <CABXk95Au_UVdghpHGuu39mHJkSYA2=7YS__vtx8sxGEH4CuSgg@mail.gmail.com>
 <20190510071208.GA14283@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <31b10fd2-bb1b-1a01-9bc3-f876404449a5@tycho.nsa.gov>
Date:   Fri, 10 May 2019 10:28:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510071208.GA14283@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/10/19 3:12 AM, Dominick Grift wrote:
> On Thu, May 09, 2019 at 02:47:30PM -0700, Jeffrey Vander Stoep wrote:
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> Date: Thu, May 9, 2019 at 2:17 PM
>> To: Jeffrey Vander Stoep, <selinux@vger.kernel.org>, Joel Galenson,
>> Petr Lautrbach
>>
>>> On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
>>>> I expected files here would have the process's context, but they
>>>> don't. The files are actually all symlinks so it's entirely possible
>>>> that the they shouldn't have the process's context. If that's the
>>>> case, how can I provide different labels for them? Neither "proc" nor
>>>> "unlabeled" are appropriate.
>>>>
>>>> On a device with a 3.18 kernel they have the "proc" context:
>>>> sailfish:/ # ls -LZ1 /proc/1/ns
>>>> u:object_r:proc:s0 mnt
>>>> u:object_r:proc:s0 net
>>>>
>>>> On a device with the 4.9 kernel the have the "unlabeled" context:
>>>> blueline:/ # ls -LZ1 /proc/1/ns
>>>> u:object_r:unlabeled:s0 cgroup
>>>> u:object_r:unlabeled:s0 mnt
>>>> u:object_r:unlabeled:s0 net
>>>
>>> First, ls -L dereferences symlinks so you are going to get the context
>>> of the object referenced by the symlink, not the context of the symlink
>>> itself.
>>
>> I'm seeing a denial on the object not the symlink, so -L is what I want.
>>
>>>
>>> Second, the task context is only assigned to proc inodes created via
>>> proc_pid_make_inode(), which has never been the case of /proc/pid/ns
>>> inodes - those have their own implementations and operations.
>>>
>>> Third, /proc/pid/ns migrated from proc to its own pseudo filesystem,
>>> nsfs, which requires a corresponding fs_use or genfscon rule in policy
>>> or they will be unlabeled.  refpolicy has a genfscon rule. Confusingly
>>> there appears to be both in Fedora policy, a fs_use_task and a genfscon
>>> rule, and it appears that fs_use_task is being applied here.  I don't
>>> know why or what exactly that means.  It won't be the task context for
>>> the task associated with that /proc/pid directory but instead would be
>>> whichever task context instantiates the inode.
>>>
>>
>> So, how do I label these files in genfs_contexts?
>>
>> "mount | grep nsfs" returns nothing.
> 
> # seinfo --genfs | grep nsfs
>     genfscon nsfs /  sys.id:sys.role:fs.nsfs.fs:s0
> 
> Yes, i think this is a step backwards. In the past we got a nice list of objects that have no context associated when policy is loaded.
> That list was removed. So sometimes its hard to determine whether something needs a genfscon if its not listen with `mount.

So, to be specific, commit 2088d60e3b2f53d0c9590a0202eeff85b288b1eb 
("selinux: quiet the filesystem labeling behavior message") removed the 
logging of which filesystem labeling behavior was selected for each 
filesystem, and then the last remnant was dropped by commit 
270e8573145a26de924e2dc644596332d400445b ("selinux: Remove redundant 
check for unknown labeling behavior").  The second commit makes sense 
given the prior one, but perhaps we do need/want to retain some kind of 
log message when mounting a filesystem that is not configured for 
labeling (i.e. SECURITY_FS_USE_NONE)?  We could add back a log message 
just for that case without reverting the other changes.
