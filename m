Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478DDC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048802175B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 12:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oCoymvbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfEJMoN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 08:44:13 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:24657 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMoN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 08:44:13 -0400
X-EEMSG-check-017: 16142959|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 May 2019 12:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557492252; x=1589028252;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hCJD/O9QiSn0qA7wMMi40+nWoOuZqtYLtO+CVxccrts=;
  b=oCoymvbmqDAM0/+OTTr3Ke0tT67gaeH2Rw716luMh79+42vZi7XZFhpH
   lFtDzfxyP65pn1jqopkai5WwQ57rrCImtmx2ZKrMuqAUshvL3m6cPtTZV
   t8MVO7QTt0M+PmVwqr3+cOcGGsSH2XK/siyIAd3h+bV+eZssJ607Go0CJ
   /V3wZJEsTGUc40jeB8wxQSGmzQG3tP+5+2HqrGTvL/9P5IJamfshQA3aO
   bulhg83nXdWfJlNoQimykVCbEGETEqFCBzD/qB5VrjwV/+jhSuVD8ki03
   Cqcqe+0UQ9xYt2DQ6bKmZ02sJ6eqyCgwocAlTjyHZqcGReR35oAxoK8N3
   g==;
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="23418658"
IronPort-PHdr: =?us-ascii?q?9a23=3AkV+kAxSg2vAONc1j3f/db+HS29psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRKCt8tkgFKBZ4jH8fUM07OQ7/m5HzxQqsvc+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiroQnLtcQbgoRuJ6Yxxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtAWyCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzjjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXm9muCE/yrIcuJ?=
 =?us-ascii?q?67ejAHyJc5yB7FbfyIbYyI7gjkVOaLLjd1gm9udrGnhxuq7EStxeLxWtO03V?=
 =?us-ascii?q?pXtCZJjNbBum4X2xDO7MWMV+Fz8V272TmV0gDe8uREIUcpmqXFM5Mh2bswlo?=
 =?us-ascii?q?YLsUTEAy/2hF36jK+IeUUg/eil8/jnba/8pp+dKo90kRvyMrgum8OjAeQ4NR?=
 =?us-ascii?q?ICX26H9uSnyLLv50j5QLROjvEuk6nZto7VJdgDq6KkDAJY3Zwv5haiAzu8zt?=
 =?us-ascii?q?gVkmcLIEhYdB6fiojmIVDOIPT2DfelhFSslS9mx+vbMb36GZjNMnjCn6vhfb?=
 =?us-ascii?q?Z68UJczhEzwspF65JbDbEBPur/WlXtu9zAEh85Lwu0zv7lCNpj2IMeV3yPD7?=
 =?us-ascii?q?SWMKPVtl+I6eYvLPeWaIAJvzb9LuAv5+Tygn8hhV8dYa6p0IMMaH+mGvRmIk?=
 =?us-ascii?q?OZYWfjg9oaD2cKsRQxTPbwhF2BTzFTfXCyULw45j0hD4KmF4jDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1COHnfnbYGEVOkKaCKJJc9hlCcJVbemS48m2hGusBH1x6B7Ie?=
 =?us-ascii?q?rT/y0SrYjj28Rt5+3PiREy8iR5D9yZ026XUmF0gnkISCQs061ku0xy1EqM0a?=
 =?us-ascii?q?hijPxED9Bc+/RJUgIiP57G0+N6E8zyWh7GftqRTFamXM+mDisqQd0v39ADeF?=
 =?us-ascii?q?x9FMu/gRDDxSWqH6UZmKCMBJwx6qjcxWT+J95hy3ba06ksl0EmTdFSNW2ina?=
 =?us-ascii?q?N/7xLcB5PNk0mAkqaqcqMc3DTT+2uZ0WWOu0RYWhZqUarZRXAfelfWrdPh60?=
 =?us-ascii?q?PFSr+uDq8nMg1bxsGeNKRHccfpgktbS/fjItvef3i9lHu3BRaNlfuwa9/Idm?=
 =?us-ascii?q?sTxijMQHYNlQwe5z69KQ8zHm/1oW/QAiJGGlXobEfht+J5rSXoYFUzylSxc0?=
 =?us-ascii?q?B517ezsiUQjPiYRuJbiqkIow89uj50GxC7xNuQBN2e8VkyNJ5AaM8wtQ8UnV?=
 =?us-ascii?q?nSsBZwa9n5dfFv?=
X-IPAS-Result: =?us-ascii?q?A2AGAgDacNVc/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?mlNBTIohBGTXgEBAQEBAQaBCC2JTZAqA1QJAQEBAQEBAQEBLwUBAgEBhEACg?=
 =?us-ascii?q?gsjOBMBAwEBAQQBAQEBAwEBbBwMgjopAYJmAQEBAQMjDwEFQRALFAEDAgIjA?=
 =?us-ascii?q?wICRhEGDQYCAQGCXz8BgXYUD60ggS+FR4MigUAGgQsni08XeIEHgTiCNjU+g?=
 =?us-ascii?q?kgZBBiEUYI2IgSNLZk+ZQmCC4IHhBiMNAYblWmTBZA9ITaBISsIAhgIIQ+DJ?=
 =?us-ascii?q?4IbF4hghVsjAzABCXwBAY9YAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 May 2019 12:44:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4ACiAi9002561;
        Fri, 10 May 2019 08:44:10 -0400
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cc889840-5c5a-99c5-d3fe-1604c32763f2@tycho.nsa.gov>
Date:   Fri, 10 May 2019 08:38:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAB9W1A2LPEk_XixkFU5mVgr9c2yNoiGzBjXYjpc3vDM1b2VpyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/9/19 8:32 PM, Stephen Smalley wrote:
> On Thu, May 9, 2019, 5:49 PM Jeffrey Vander Stoep <jeffv@google.com 
> <mailto:jeffv@google.com>> wrote:
> 
>     From: Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
>     Date: Thu, May 9, 2019 at 2:17 PM
>     To: Jeffrey Vander Stoep, <selinux@vger.kernel.org
>     <mailto:selinux@vger.kernel.org>>, Joel Galenson,
>     Petr Lautrbach
> 
>      > On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
>      > > I expected files here would have the process's context, but they
>      > > don't. The files are actually all symlinks so it's entirely
>     possible
>      > > that the they shouldn't have the process's context. If that's the
>      > > case, how can I provide different labels for them? Neither
>     "proc" nor
>      > > "unlabeled" are appropriate.
>      > >
>      > > On a device with a 3.18 kernel they have the "proc" context:
>      > > sailfish:/ # ls -LZ1 /proc/1/ns
>      > > u:object_r:proc:s0 mnt
>      > > u:object_r:proc:s0 net
>      > >
>      > > On a device with the 4.9 kernel the have the "unlabeled" context:
>      > > blueline:/ # ls -LZ1 /proc/1/ns
>      > > u:object_r:unlabeled:s0 cgroup
>      > > u:object_r:unlabeled:s0 mnt
>      > > u:object_r:unlabeled:s0 net
>      >
>      > First, ls -L dereferences symlinks so you are going to get the
>     context
>      > of the object referenced by the symlink, not the context of the
>     symlink
>      > itself.
> 
>     I'm seeing a denial on the object not the symlink, so -L is what I want.
> 
>      >
>      > Second, the task context is only assigned to proc inodes created via
>      > proc_pid_make_inode(), which has never been the case of /proc/pid/ns
>      > inodes - those have their own implementations and operations.
>      >
>      > Third, /proc/pid/ns migrated from proc to its own pseudo filesystem,
>      > nsfs, which requires a corresponding fs_use or genfscon rule in
>     policy
>      > or they will be unlabeled.  refpolicy has a genfscon rule.
>     Confusingly
>      > there appears to be both in Fedora policy, a fs_use_task and a
>     genfscon
>      > rule, and it appears that fs_use_task is being applied here.  I don't
>      > know why or what exactly that means.  It won't be the task
>     context for
>      > the task associated with that /proc/pid directory but instead
>     would be
>      > whichever task context instantiates the inode.
>      >
> 
>     So, how do I label these files in genfs_contexts?
> 
>     "mount | grep nsfs" returns nothing.
> 
> 
> Just a single entry for the nsfs / should suffice if using genfscon. 
> That will apply a single label to all nsfs inodes. If you need to 
> distinguish than fs_use_task might work better but you'd have to check 
> when these inodes get instantiated; they are not per task but rather per 
> namespace iiuc. See 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e149ed2b805fefdccf7ccdfc19eca22fdd4514ac

Actually, looking at the nsfs code, it looks like the inode gets 
allocated when the link is first followed, so fs_use_task nsfs would be 
misleading - it would get the context of whatever task first followed 
the link, not the associated task for the /proc/pid directory.  And 
really, these objects are not per-process state; they are per-namespace 
(note that ls -Li shows the same inode number for anything sharing that 
namespace). genfscon is the only thing that makes sense for labeling in 
that case.  Arguably, namespaces should be labeled from their creating 
process and these pseudo files should inherit that label but that would 
require kernel changes to label namespaces and propagate those labels.

Red Hat folks, why do you have both fs_use_task nsfs and genfscon nsfs 
in your policy?  I think the fs_use_task is wrong here; probably was an 
attempt to label the targets of the /proc/pid/ns links with the same 
label as the other /proc/pid nodes but that isn't right and won't work; 
try ls -LZ /proc/1/ns for example and contrast with ls -lZ /proc/1/ns.
