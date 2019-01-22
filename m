Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E7C282C5
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14E0217D4
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XIsLXUfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfAVOPB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:15:01 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:62331 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfAVOPB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 09:15:01 -0500
X-EEMSG-check-017: 636213039|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,506,1539648000"; 
   d="scan'208";a="636213039"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2019 14:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548166498; x=1579702498;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8h5a8jYU9AM9VBWsQ1/LWOCeSIib4aGk6gQjC22s79E=;
  b=XIsLXUfwB4U9o+0e+LphPnYBbF39pBw/N1RYE8j9VgzZHDgxG1KMULZu
   bOG093nzR4TIkJ8wNa4ZWJ8+ci4MXVPLUvF4FKRalEIjMMp18Y3o2Iixi
   LmjLxoYZP0o6Rg47agzvBtsQ2KCisjAnIaryNFme+qMFRS9xGG2zdywcp
   oyoVX7vT1FFW7qhYeu+BSyW22WgyaJMQSUbRKWDVYyCnX7k24j9m73ItU
   /vDxrY/xuonn4sZemT96D6kS2cRh2/w+Vo65vginaZueYsKnf80KzfQqe
   7nJhRuIFlRfBLtfsjkrFlaGHm8ZQjFWeG7FmJM0oauxgdB2SNNQs60OSK
   w==;
X-IronPort-AV: E=Sophos;i="5.56,506,1539648000"; 
   d="scan'208";a="19722476"
IronPort-PHdr: =?us-ascii?q?9a23=3A2FIt8haipB1rNr5UA4U0bJn/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps65bB7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYMPONUoo/grFUMsBS+HxGhCv7xxD9GhnH43qM03O?=
 =?us-ascii?q?ouHg7EwAMuEMkDsGjWodjvKKseTe64wavOwD7eb/1WwzD96I3Qfx48vfGDQ6?=
 =?us-ascii?q?pwccrPxkkpCgjLk1CQppbhPzORyOsMs3WQ4u17Ve2ykG4qsB1xozizyccsjY?=
 =?us-ascii?q?nFnIQVykve+iljz4Y1IsO4RVd9bNW5HpVQsCSaOJF3QsMkW2xouzg1yqcAuZ?=
 =?us-ascii?q?GleCgG0pMnxwTQa/CffIiI4w7jVOKLLjhjnn5qZLW/hxO0/EO9yeP8TtG53E?=
 =?us-ascii?q?tFoydKiNXBtm0B2wbN5sWIVPdx5Fqt1DCS3A7J8O5EO1o7la/DJp4kxb4/i4?=
 =?us-ascii?q?QcvFzYHi/zhEX2lKiWdlg4+uSw6+TofLHmppiEOo9okA7+KKUumtGkAegiLg?=
 =?us-ascii?q?gPX3SU+eS71LH5+032XK5KgeEsnqncsZDaIdwXpq+/AwBLzoYu8wuzAjip3d?=
 =?us-ascii?q?gCnXQLMUhJdAyIgoT3IV3CPej0DfKljFStlDdryerGPrrkApjVNXjMjazhcK?=
 =?us-ascii?q?1h609c1AUzzddf64hSCrEaOv3/QEDxtNvGDhMhKQy73/7nCMlh1oMZQW+PBa?=
 =?us-ascii?q?qZMKTJsV+O/O0gP/eDaZQPuDnjNvcl5+ThjWMjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GAEiWEXj0b4WER+sMaCWKL8B9iDMETqauSo862BG1qAD6y6BoLv?=
 =?us-ascii?q?fa+i0cq53jzsF56PHJmh0o6TN0CMGd2XmXT25ohmMIWyM23KdnrEx5y1eD17?=
 =?us-ascii?q?V4gvNBGdxI+fxGTho6NYTdz+xmC9H+QwfBftCUR1a7RtWpHyo8Tsw+w9AQeU?=
 =?us-ascii?q?ZxAdaigQ7Z3yqsHbAVk6aHBJsu8qLTx3LxPdpyy27a1Kk9iFkrWtdPNW+9i6?=
 =?us-ascii?q?586QfTHYjJnFudl6qwcqQcxiHN/n+ZzWWSpEFYTBJwUaLdUHAbZ0vWq8n550?=
 =?us-ascii?q?zbQ7+gErQoLxVOydCcJatOcdDpk1pGS+n5ONjEYGK+hX2wBRCWybOIdobqfH?=
 =?us-ascii?q?8d3CrFAkgejw8T5WqGNRQ5Biq5v23eAyZuFVXyY0P06ulzs227TkAqwAGQdU?=
 =?us-ascii?q?Fh1KS6+gQThfOCT/MfxLUEuD0uq2Y8IFHo+NTaEdeC7y9mZ6NVat4+qANA0G?=
 =?us-ascii?q?XCsQV2M7S6Iqxij0JYeANy6RDAzRJyX75cnNAqoXVi9w97LaaVwRsVbD+D9Y?=
 =?us-ascii?q?zhMb3QbG/p9VagbLCAiQKW68qf5qpasKdwkF7kpgz8UxN6rXg=3D?=
X-IPAS-Result: =?us-ascii?q?A2CvAwADJUdc/wHyM5BkHAEBAQQBAQcEAQGBZYFbKWZPM?=
 =?us-ascii?q?yeEAZQETAEBAQEBAQaBCAgliTOOYoFnMgYBhEACgmoiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjopAYJnAQUjFUEQCw4KAgIRFQICVwYNBgIBAYJfPwGBdA0PrEuBL4QuA?=
 =?us-ascii?q?YEUhFwFgQuLNhd4gQeBEScMgl+DHgSBGhIBEgEHBFOCSoJXApBTOZA6WgmHJ?=
 =?us-ascii?q?IpxBhiSFI8gjVohZXErCAIYCCEPO4I4ATMTghQXE4M4hRSFXSEDMAEBgQMBA?=
 =?us-ascii?q?YdFDheCJwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Jan 2019 14:14:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0MEEgBT023062;
        Tue, 22 Jan 2019 09:14:42 -0500
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
 <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
 <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
 <CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com>
 <CAFqZXNsm2+79gMTqhxoZuPgibxfhSjJXu8742o7Ho7Yrf=2QCw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3f663024-98f0-98c9-6235-fa4ffafa6a03@tycho.nsa.gov>
Date:   Tue, 22 Jan 2019 09:17:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsm2+79gMTqhxoZuPgibxfhSjJXu8742o7Ho7Yrf=2QCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/22/19 3:49 AM, Ondrej Mosnacek wrote:
> On Mon, Jan 14, 2019 at 10:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> On Thu, Jan 10, 2019 at 6:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Resending after email configuration repair.
>>>
>>> On 1/10/2019 6:15 AM, Stephen Smalley wrote:
>>>> On 1/9/19 5:03 PM, Casey Schaufler wrote:
>>>>> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
>>>>>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>>>>>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>>>>>>> Changes in v2:
>>>>>>>> - add docstring for the new hook in union security_list_options
>>>>>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>>>>>>      implemented
>>>>>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>>>>>>>
>>>>>>>> This series adds a new security hook that allows to initialize the security
>>>>>>>> context of kernfs properly, taking into account the parent context. Kernfs
>>>>>>>> nodes require special handling here, since they are not bound to specific
>>>>>>>> inodes/superblocks, but instead represent the backing tree structure that
>>>>>>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>>>>>>
>>>>>>>> The kernfs nodes initially do not store any security context and rely on
>>>>>>>> the LSM to assign some default context to inodes created over them.
>>>>>>>
>>>>>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
>>>>>>> and expected filesystem behavior?
>>>>>>
>>>>>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
>>>>>>
>>>>>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
>>>>>
>>>>> OK, so as I said, this seems like a bug in kernfs.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> Kernfs
>>>>>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
>>>>>>>> syscalls, in which case the context is stored inside the kernfs node's
>>>>>>>> metadata.
>>>>>>>>
>>>>>>>> SELinux (and possibly other LSMs) initialize the context of newly created
>>>>>>>> FS objects based on the parent object's context (usually the child inherits
>>>>>>>> the parent's context, unless the policy dictates otherwise).
>>>>>>>
>>>>>>> An LSM might use information about the parent other than the "context".
>>>>>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
>>>>>>> to determine whether the Smack label of the new object should be taken
>>>>>>> from the parent or the process. Passing the "context" of the parent is
>>>>>>> insufficient for Smack.
>>>>>>
>>>>>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.
>>
>> I actually had a patch to do just that at one point because I thought
>> for a while that it would be required to call
>> security_inode_init_security() (which I had tried to somehow force
>> into the kernfs node creation at some point), but then I realized it
>> is not actually needed (although would make thing a bit nicer) and put
>> it away... I will try to dig it out and reuse here.
> 
> Okay, now that I tried to do this with full xattr support I ran into a
> problem. Along with converting kernfs to use simple_xattrs for
> security attributes, I removed the call to
> security_inode_notifysecctx() from kernfs_refresh_inode(), as it no
> longer makes sense (kernfs doesn't know which attribute contains the
> context; the LSM should now be able to pull it out via
> vfs_getxattr()). However, SELinux now doesn't set the right security
> context in the selinux_d_instantiate() hook, because the policy tells
> it to use genfs, not xattr.
> 
> So... I'm not sure how to fix this. Setting fs_use_xattr for cgroupfs
> in the policy won't work, because then all nodes will be unlabeled_t
> by default. Maybe we could patch the genfs case in
> inode_doinit_with_dentry() to try fetching the xattr first? I'm not
> very confident about touching that part of the code, so I would
> welcome some advice here.
> 
> This is the code I have so far, in case it helps:
> https://gitlab.com/omos/linux-public/compare/selinux-next...selinux-fix-cgroupfs-v8

I would have left security_inode_notifysecctx() or an equivalent that 
passes all of the xattrs to push the security attributes to the security 
module.

Blindly calling __vfs_getxattr() on genfs could be a problem; IIRC, 
doing so on fuse filesytems can create a deadlock during mount.  Or at 
least that was the issue with switching fuse to fs_use_xattr in the past.



