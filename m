Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C84DC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 15:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124842175B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 15:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="A0V8AThH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEJPBj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 11:01:39 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:47673 "EHLO
        UCOL19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfEJPBj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 11:01:39 -0400
X-EEMSG-check-017: 17513673|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="17513673"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 May 2019 15:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557500497; x=1589036497;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nDKi3B9fuL7NDm13kWt5OhWaCawCGaF0AI4SVSAf9vc=;
  b=A0V8AThHzlS3auzNKGEy9aRhGSu/B8p0LeKQT3foUa3hMOB79qg6HTay
   W5crkILH7cQrMlEhvcZoVLKfYnZtL7ANlwcYSmceUXEamhLxCxaETi4pR
   yYg8ERW32BcGPhpRXNg8b2SexJLklQ5gBz3EBFQcDb6UGcAksVLq2e92x
   Tczjg2EE60lQ3AkGgWG4MEL7IWmfknCapW60QDrquCoKJd9+IDBt7nA3H
   SroXHVdZwJu1cjZ71ZFRpTfhWLjmpfdS53OA4Qjsh4K0ZQdoepjI5Ee3b
   DtS4Wbk5fq16LYnLvZWiWxy83bBXE+9OOE4kLcBa/oaMjPuEsbazibLfr
   g==;
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="23427015"
IronPort-PHdr: =?us-ascii?q?9a23=3AEpdoUxB5COYh7GJn392VUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36ocmwAkXT6L1XgUPTWs2DsrQY0rOQ4/CrCTdIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+1oAjSucUbgoVvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4XkuVcDqR6yCA+xD+3t1zBInGf707A63e?=
 =?us-ascii?q?o/HwHI3wIuENwBv3vWsNr7O7wfUfy2waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMTM1UkgCRvFjlWOpozjIjiby+ENvHKf7+pkS+2ui3MspgZqojey3cchkZ?=
 =?us-ascii?q?XJh4IJxVDE8iV12oA1JcaiR0Jhbt6kF4VQujicOoBrTM0iRGRotzw7yr0AoZ?=
 =?us-ascii?q?O7fzYFyI4hxxHBb/yLaY+I4gjsVOuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80Kw60zPjpCNVzyIMTQm2PAq?=
 =?us-ascii?q?ieMKPdtV+H+PgjLPWLZI8QoDz9MeQq5+byjX8lnl8QZbKp0oUTaHC5GPRmPk?=
 =?us-ascii?q?qYbGHygtcOD2gKpBAyTO/0h12YVz5ceXKyU7g75jEhB4KsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZmJJCl+WFXfnaYOEW+wLaCKUOcJhnTsEVb+uS48lyx6irhP1y71iLu?=
 =?us-ascii?q?DM4C0XqYrj1MRp5+3UjRwy7Th0AN6A02GRVWF7hXkHSiQs3K9hvEN9yk2M0b?=
 =?us-ascii?q?Rij/NEEtxT4utDUh0mOp7E0+x6F9fyVxrFfteXUlapWM6pDi8tQd8q2d8BfV?=
 =?us-ascii?q?tyG9W4gRDfxSalH7gVl7mTDpwu7q3cx2TxJ9p6y3vezKkulUQmQs9UOG2+nK?=
 =?us-ascii?q?F/6gzTC5fMk0WekKaqb7oT0DTR+2eEyGqEpFtYXxJoUaXZQXAfYVPbrdP85k?=
 =?us-ascii?q?PFVL+uD64oPRdfxsOZMKtFdMDmjVVcS/f/ItjRf2Wxm2LjTSqPk5GBYoTwdn?=
 =?us-ascii?q?RV4izbBEUe2zsP+nuefVw8CymvvUrRCzthEV+paETpp7pQsnS+G3QowhmKYk?=
 =?us-ascii?q?sp7L+8/hoYlLTIUP8I9q4Vsycm7TNvFRCy2MyAWInInBZoYKgJOYB121xAz2?=
 =?us-ascii?q?+M8lUnb5E=3D?=
X-IPAS-Result: =?us-ascii?q?A2AJAgDpkdVc/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?mlNBTIohBGTEUwBAQEBAQEGgQgIJYlNkCoDVAkBAQEBAQEBAQEvBQECAQGEQ?=
 =?us-ascii?q?AKCCyM4EwEDAQEBBAEBAQEDAQFsHAyCOikBgmYBAQEBAyMPAQVBEAkCFAEDA?=
 =?us-ascii?q?gIjAwICRhEGDQYCAQGCXz8BgXYUD5E8m2WBL4hpgUAGgQsni08XeIEHgTgMg?=
 =?us-ascii?q?WFJNT6CSBkEGIRRgjYiBI0tmT5lCYILggeEGIw0BhuVaZMFkD0hNoEhKwgCG?=
 =?us-ascii?q?AghD4MnghsXiGCFWyMDMAEJfAEBj1gBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 May 2019 15:01:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4AF1ZBv014222;
        Fri, 10 May 2019 11:01:36 -0400
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
Message-ID: <525387dc-ed0c-7555-0dd5-49ca442a6b88@tycho.nsa.gov>
Date:   Fri, 10 May 2019 10:55:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cc889840-5c5a-99c5-d3fe-1604c32763f2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/10/19 8:38 AM, Stephen Smalley wrote:
> On 5/9/19 8:32 PM, Stephen Smalley wrote:
>> On Thu, May 9, 2019, 5:49 PM Jeffrey Vander Stoep <jeffv@google.com 
>> <mailto:jeffv@google.com>> wrote:
>>
>>     From: Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
>>     Date: Thu, May 9, 2019 at 2:17 PM
>>     To: Jeffrey Vander Stoep, <selinux@vger.kernel.org
>>     <mailto:selinux@vger.kernel.org>>, Joel Galenson,
>>     Petr Lautrbach
>>
>>      > On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
>>      > > I expected files here would have the process's context, but they
>>      > > don't. The files are actually all symlinks so it's entirely
>>     possible
>>      > > that the they shouldn't have the process's context. If that's 
>> the
>>      > > case, how can I provide different labels for them? Neither
>>     "proc" nor
>>      > > "unlabeled" are appropriate.
>>      > >
>>      > > On a device with a 3.18 kernel they have the "proc" context:
>>      > > sailfish:/ # ls -LZ1 /proc/1/ns
>>      > > u:object_r:proc:s0 mnt
>>      > > u:object_r:proc:s0 net
>>      > >
>>      > > On a device with the 4.9 kernel the have the "unlabeled" 
>> context:
>>      > > blueline:/ # ls -LZ1 /proc/1/ns
>>      > > u:object_r:unlabeled:s0 cgroup
>>      > > u:object_r:unlabeled:s0 mnt
>>      > > u:object_r:unlabeled:s0 net
>>      >
>>      > First, ls -L dereferences symlinks so you are going to get the
>>     context
>>      > of the object referenced by the symlink, not the context of the
>>     symlink
>>      > itself.
>>
>>     I'm seeing a denial on the object not the symlink, so -L is what I 
>> want.
>>
>>      >
>>      > Second, the task context is only assigned to proc inodes 
>> created via
>>      > proc_pid_make_inode(), which has never been the case of 
>> /proc/pid/ns
>>      > inodes - those have their own implementations and operations.
>>      >
>>      > Third, /proc/pid/ns migrated from proc to its own pseudo 
>> filesystem,
>>      > nsfs, which requires a corresponding fs_use or genfscon rule in
>>     policy
>>      > or they will be unlabeled.  refpolicy has a genfscon rule.
>>     Confusingly
>>      > there appears to be both in Fedora policy, a fs_use_task and a
>>     genfscon
>>      > rule, and it appears that fs_use_task is being applied here.  I 
>> don't
>>      > know why or what exactly that means.  It won't be the task
>>     context for
>>      > the task associated with that /proc/pid directory but instead
>>     would be
>>      > whichever task context instantiates the inode.
>>      >
>>
>>     So, how do I label these files in genfs_contexts?
>>
>>     "mount | grep nsfs" returns nothing.
>>
>>
>> Just a single entry for the nsfs / should suffice if using genfscon. 
>> That will apply a single label to all nsfs inodes. If you need to 
>> distinguish than fs_use_task might work better but you'd have to check 
>> when these inodes get instantiated; they are not per task but rather 
>> per namespace iiuc. See 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e149ed2b805fefdccf7ccdfc19eca22fdd4514ac 
>>
> 
> Actually, looking at the nsfs code, it looks like the inode gets 
> allocated when the link is first followed, so fs_use_task nsfs would be 
> misleading - it would get the context of whatever task first followed 
> the link, not the associated task for the /proc/pid directory.  And 
> really, these objects are not per-process state; they are per-namespace 
> (note that ls -Li shows the same inode number for anything sharing that 
> namespace). genfscon is the only thing that makes sense for labeling in 
> that case.  Arguably, namespaces should be labeled from their creating 
> process and these pseudo files should inherit that label but that would 
> require kernel changes to label namespaces and propagate those labels.
> 
> Red Hat folks, why do you have both fs_use_task nsfs and genfscon nsfs 
> in your policy?  I think the fs_use_task is wrong here; probably was an 
> attempt to label the targets of the /proc/pid/ns links with the same 
> label as the other /proc/pid nodes but that isn't right and won't work; 
> try ls -LZ /proc/1/ns for example and contrast with ls -lZ /proc/1/ns.

 From a compatibility POV, it would probably be best to assign nsfs the 
same context as proc via genfscon so that policy that worked on v3.18 
and earlier will continue working under later kernels, unless there is 
some real reason to distinguish these accesses.


