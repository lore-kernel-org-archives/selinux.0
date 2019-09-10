Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A9C49ED9
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 19:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AE021479
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 19:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OtS5FZuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfIJTr3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:47:29 -0400
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:9483 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfIJTr2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 15:47:28 -0400
X-EEMSG-check-017: 12714832|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-EEMSG-Attachment-filename: showperm.c, 0001-Move-watch-permissions-from-common_file-to-the-class.patch
X-EEMSG-Attachment-filesize: 1375, 3352
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="c'?scan'208,223";a="12714832"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 19:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568144714; x=1599680714;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=HLYQQlnwsS6JSqsknpgSKTM3DDs9zucpiVzxI+gZIWE=;
  b=OtS5FZuK6XaO1JOqZ0fQe/Hv4B1WHCV+c+/jnBzlEqCK7sP9gKYDoD6R
   YhC7qgLJf9Rgt3ON+y7lwHq5VPMDSanCLDEyRV2TdiuNYwNSssmb4Dg3P
   l76lTh0LTRZz/DLVQ9/IYEDxwJLQl88S9fzECGPD5MEPKzKCiIUqdnflL
   wMTdZUTuOJU95RmdII9NSYsR3SoLCbsqGifQhVrrybAzc1yc0xCjezjlU
   GTiB92inPFX4vwL12jMeDbMPMIlBXb3UyGtMc7Wg87pcMjVVogl0RqI3G
   Rui7K+SAQRjMyBVyj19RBeOU9dLtwOci7hp3wikKZd0iWPMmUM0jU11Uh
   Q==;
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="c'?scan'208,223";a="32657007"
IronPort-PHdr: =?us-ascii?q?9a23=3AATzbAhyabDG9TMLXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoTLPad9pjvdHbS+e9qxAeQG9mCsLQc06GP6v6oGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF+JqotxR?=
 =?us-ascii?q?fFv2ZEduVLzm9sOV6fggzw68it8JJ96Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFiXHs3a0+zu?=
 =?us-ascii?q?8vDwfI0gI9FN4KqXjYstH4OKIUXOuozqfH0C/DYutL1znj5ojGchMvr/+CUr?=
 =?us-ascii?q?1/c8Xe1VIiFwbZgliKs4HpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+WuiRJjJ4i2hkeLK5nxuy8lavyvf6Vsaq1F?=
 =?us-ascii?q?ZGtC1FksPDtnwVyhPc9MaHReV7/ke6xzmAyxrf6udAIUwsiKXUNYUuwr8qmZ?=
 =?us-ascii?q?oVq0jDGTX2mErwgaSLdUsk4vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Pw?=
 =?us-ascii?q?4TVGaB4+u8zqfs/UjhTbVPif05j7fWvYjBJcQeuq65GwhV0ps/6xqnDzepzt?=
 =?us-ascii?q?AYnX4fIVJZYh2HlYnpO0zVIPziEfe+g0ijkDdsx/zcOL3uHo7NIWTZnLfkfL?=
 =?us-ascii?q?Z971ZQyAs1zd9B+5JZEqwNLf38V0PrtNHUEwU1PxK7zur5Etlxy5sSWWeVDa?=
 =?us-ascii?q?+YNKPSv0WI5uUqI+SUf48apS39JuM55//ukXA5mVgdcbOv3ZsMcn+0BPtmI0?=
 =?us-ascii?q?KHYXb0mNcODX8KvhYiTOztkFCNTDlTZ3OzX6I65zE0FIGmAZ3MRoC3gbyB0j?=
 =?us-ascii?q?u7E4ZLaW9YBFCDD3Hod56aVPgQci6SJMthmCQeVbe9U48hyQ2utAjixrp/NO?=
 =?us-ascii?q?XU5ykYuIn71Ndv+u3TkQg+9TlzD8SayWGCUXt4kX8PRz8zxKp/u1Byyk+f0a?=
 =?us-ascii?q?hkhPxVDcdT6O1NUgc7M57c0uN7BsvsWgLOYNiJUkyqQta4DjErSNI+3dsOb1?=
 =?us-ascii?q?x6G9W4gRCQlxatVpMSkr2NBZc3uo3G3nbtb5JxzHPH0qgqjB8pWMpBKUWqi6?=
 =?us-ascii?q?By8RPeDMjPlxPKubytcPEnwCPV9GqFhVGLtUVcXR84Bb7JRlgDd0DWqpL//U?=
 =?us-ascii?q?qEQLiwX+d0ejBdwNKPf/MZIubiik9LEbK6YoXT?=
X-IPAS-Result: =?us-ascii?q?A2ARAADo+3dd/wHyM5BlGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?QMBAQEBCwGBbSptUgEyKoQhjxNPAQMGgTaJc48rFIFnCQEBAQEBAQEBAS0HA?=
 =?us-ascii?q?QIBAYQ/AoJJIzYHDgIMAQEBBAEBAQEBBgMBAWyFLgyCOikBgmYBAQEBAxoBC?=
 =?us-ascii?q?ARSEAkCEQMBAgEqAgJPCAYKAwYCAQGCUww/AYF2FA+MV5tvfzOENgGBFIMrg?=
 =?us-ascii?q?TkQgTQBi3cYeIEHgREngms+gkgZBBiBAS44gmuCWASMOA8LBokHDYEklTeCK?=
 =?us-ascii?q?4IsgRKCLYEWhQ2IYwYbgjRwgT6JM4ZVhCCPN4ZMkmsJKIFYKwgCGAghDzuCb?=
 =?us-ascii?q?AmCRReEU4NsJIVbJAMwAQl8AQGMTAQLF4IuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Sep 2019 19:45:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8AJjCIV007733;
        Tue, 10 Sep 2019 15:45:12 -0400
Subject: Re: [PATCH] selinux-testsuite: add tests for fsnotify
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org
References: <3e584347-f97f-eb00-3291-2ce666e50918@tycho.nsa.gov>
 <20190910141517.GA1058184@brutus.lan>
 <d6636549-d91c-d4d2-4478-9aa3c8e023df@tycho.nsa.gov>
 <76c7a2f2-ccc3-46bf-bf1c-ef11a039536e@tycho.nsa.gov>
 <b9cdbda9-af04-ddc5-6e17-040c74da7518@tycho.nsa.gov>
 <44cb5cbc-1811-3cf1-f910-ec04e65bdbce@tycho.nsa.gov>
 <20190910152231.GA963906@brutus.lan>
 <fff646bf-0911-fc5a-9a9c-79f4d5c30eae@tycho.nsa.gov>
 <20190910163236.GC1058184@brutus.lan>
 <cfd3df23-aa1d-9f02-1857-c62e68b39b35@tycho.nsa.gov>
 <20190910182018.GA1124500@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0288be5a-09c0-b1bc-1c90-3c8cf5644e90@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 15:45:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910182018.GA1124500@brutus.lan>
Content-Type: multipart/mixed;
 boundary="------------457A598CBC6883381AF01292"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------457A598CBC6883381AF01292
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/19 2:20 PM, Dominick Grift wrote:
> On Tue, Sep 10, 2019 at 02:13:07PM -0400, Stephen Smalley wrote:
>> On 9/10/19 12:32 PM, Dominick Grift wrote:
>>> On Tue, Sep 10, 2019 at 12:25:44PM -0400, Stephen Smalley wrote:
>>>> On 9/10/19 11:22 AM, Dominick Grift wrote:
>>>>> On Tue, Sep 10, 2019 at 11:02:16AM -0400, Stephen Smalley wrote:
>>>>>> On 9/10/19 10:59 AM, Stephen Smalley wrote:
>>>>>>> On 9/10/19 10:54 AM, Stephen Smalley wrote:
>>>>>>>> On 9/10/19 10:40 AM, Stephen Smalley wrote:
>>>>>>>>> On 9/10/19 10:15 AM, Dominick Grift wrote:
>>>>>>>>>> On Tue, Sep 10, 2019 at 08:26:57AM -0400, Stephen Smalley wrote:
>>>>>>>>>>> On 9/10/19 1:59 AM, Dominick Grift wrote:
>>>>>>>>>>>> On Wed, Jul 10, 2019 at 09:39:17AM -0400, Aaron Goidel wrote:
>>>>>>>>>>>>> Added a suite to test permissions for setting
>>>>>>>>>>>>> inotify and fanotify watches
>>>>>>>>>>>>> on filesystem objects. Tests watch,
>>>>>>>>>>>>> watch_with_perm, and watch_reads permissions.
>>>>>>>>>>>>
>>>>>>>>>>>> Ive also "tested" the fsnotify patch. And my tests
>>>>>>>>>>>> indicate that this might cause issues:
>>>>>>>>>>>>
>>>>>>>>>>>> I added the access vectors to my policy, but on
>>>>>>>>>>>> older systems (debian 10) cron fails to start
>>>>>>>>>>>> cron needs the "entrypoint" permission on
>>>>>>>>>>>> /etc/crontab but it looks like appending the "watch"
>>>>>>>>>>>> access vectors to common-file disrupted the ordering
>>>>>>>>>>>> The result is that now i have to allow cron to
>>>>>>>>>>>> "watch_read" /etc/crontab even though the neither
>>>>>>>>>>>> kernel nor selinux user space are aware of the
>>>>>>>>>>>> fsnotify access vectors
>>>>>>>>>>>> It seems the cron selinux code got confused and now
>>>>>>>>>>>> thinks watch_read is entrypoint (its using selinux
>>>>>>>>>>>> code to determine whether it can manually transition
>>>>>>>>>>>> to cronjob domains on crontabs)
>>>>>>>>>>>>
>>>>>>>>>>>> I am hoping this issue with resolve itself on
>>>>>>>>>>>> systems with kernels and user spaces that suppose
>>>>>>>>>>>> fsnotify.
>>>>>>>>>>>> However unless i am overlooking something this is
>>>>>>>>>>>> still likely to disrupt compatibility
>>>>>>>>>>>
>>>>>>>>>>> So, IIUC, the issue is that:
>>>>>>>>>>> a) older cron was directly using the fixed
>>>>>>>>>>> FILE__ENTRYPOINT definition from
>>>>>>>>>>> libselinux in a security_compute_av() call rather than
>>>>>>>>>>> dynamically looking
>>>>>>>>>>> up entrypoint permission,
>>>>>>>>>>> b) the value of the file entrypoint permission in policy
>>>>>>>>>>> has changed because
>>>>>>>>>>> you updated your policy and chose to place the watch*
>>>>>>>>>>> permissions in the
>>>>>>>>>>> common file definition to match the kernel.
>>>>>>>>>>>
>>>>>>>>>>> Note that you could have instead sprinkled copies of the
>>>>>>>>>>> watch* permissions
>>>>>>>>>>> across all of the individual file/dir/*_file classes and
>>>>>>>>>>> placed them at the
>>>>>>>>>>> end of the classes if you wanted to avoid this
>>>>>>>>>>> compatibility issue. The
>>>>>>>>>>> policy and kernel definitions no longer need to be
>>>>>>>>>>> identical; the kernel
>>>>>>>>>>> will dynamically map between them for its own permission checks.
>>>>>>>>>>>
>>>>>>>>>>> Also, this should have already been broken for you when
>>>>>>>>>>> map permission was
>>>>>>>>>>> added, which would have shown up as execute_no_trans
>>>>>>>>>>> being checked instead
>>>>>>>>>>> of entrypoint.  This was already filed as a bug on cron
>>>>>>>>>>> in debian here:
>>>>>>>>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=924716
>>>>>>>>>>>
>>>>>>>>>>> So, wrt compatibility, IIUC:
>>>>>>>>>>> - the kernel change does not break compatibility for old policy + old
>>>>>>>>>>> userspace,
>>>>>>>>>>> - new policy can choose to add the new permissions in a
>>>>>>>>>>> backward-compatible
>>>>>>>>>>> manner if desired, although refpolicy has already chosen
>>>>>>>>>>> not to do this for
>>>>>>>>>>> map permission,
>>>>>>>>>>> - the offending code in cron produces build warnings
>>>>>>>>>>> that were introduced in
>>>>>>>>>>> 2014 in libselinux to update their code to use the dynamic class/perm
>>>>>>>>>>> mapping support, which would resolve the issue.
>>>>>>>>>>
>>>>>>>>>> this does not work (cron[8934]: ((null)) ENTRYPOINT FAILED): https://defensec.nl/gitweb/dssp2.git/commitdiff/914b1d5366922f92435cba780519c5d2bb9f4f7d
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> [kcinimod@brutus dssp2 (master=)]$ seinfo policy.31 -x
>>>>>>>>>> --common common_file
>>>>>>>>>>
>>>>>>>>>> Commons: 1
>>>>>>>>>>        common common_file
>>>>>>>>>> {
>>>>>>>>>>             append
>>>>>>>>>>             lock
>>>>>>>>>>             mounton
>>>>>>>>>>             unlink
>>>>>>>>>>             read
>>>>>>>>>>             create
>>>>>>>>>>             quotaon
>>>>>>>>>>             execute
>>>>>>>>>>             setattr
>>>>>>>>>>             map
>>>>>>>>>>             relabelto
>>>>>>>>>>             rename
>>>>>>>>>>             link
>>>>>>>>>>             ioctl
>>>>>>>>>>             getattr
>>>>>>>>>>             relabelfrom
>>>>>>>>>> }
>>>>>>>>>> [kcinimod@brutus dssp2 (master=)]$ seinfo policy.31 -xcfile
>>>>>>>>>>
>>>>>>>>>> Classes: 1
>>>>>>>>>>        class file
>>>>>>>>>> inherits common_file
>>>>>>>>>> {
>>>>>>>>>>             execmod
>>>>>>>>>>             watch
>>>>>>>>>>             write
>>>>>>>>>>             watch_reads
>>>>>>>>>>             execute_no_trans
>>>>>>>>>>             watch_mount
>>>>>>>>>>             watch_with_perm
>>>>>>>>>>             open
>>>>>>>>>>             watch_sb
>>>>>>>>>>             audit_access
>>>>>>>>>>             entrypoint
>>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> If you want to preserve compatibility with userspace using fixed
>>>>>>>>> definitions of FILE__ENTRYPOINT, then you have to insert any new
>>>>>>>>> file permissions after the current entrypoint permission in the
>>>>>>>>> class file. So watch and friends have to go after it, not before
>>>>>>>>> it.
>>>>>>>>>
>>>>>>>>> Also, since the kernel always uses FILE__WATCH* in the check
>>>>>>>>> code rather than distinguishing by class, the watch* permissions
>>>>>>>>> need to be at the same offset in all of the file classes.  The
>>>>>>>>> same is true of the other file permissions.  It looks like you
>>>>>>>>> may have other permissions out of sync across the file classes
>>>>>>>>> e.g. execmod, open, audit_access, that need to be aligned or the
>>>>>>>>> kernel could check the wrong permission.
>>>>>>>>
>>>>>>>> Sorry, the last para isn't correct - it should get mapped correctly
>>>>>>>> per class.  But you do need to add the permissions after entrypoint
>>>>>>>> in the file class to avoid displacing its value.
>>>>>>>
>>>>>>> Also, it looks like your file class permission order differs in other
>>>>>>> incompatible ways. If you want it to be compatible with the deprecated
>>>>>>> libselinux headers, the requisite order would be:
>>>>>>> class file
>>>>>>> inherits common_file
>>>>>>> {
>>>>>>>         execute_no_trans
>>>>>>>         entrypoint
>>>>>>>         execmod
>>>>>>>         open
>>>>>>>         audit_access
>>>>>>>         map
>>>>>>
>>>>>> Sorry, insert watch* permissions here.
>>>>>
>>>>> I applied brute force:
>>>>>
>>>>> the map permission can be part of common_file just fine.
>>>>> the audit_access av (which was clearly introduced after entrypoint can precede entrypoint just fine.
>>>>>
>>>>> The problem is the prescence of the fsnotify access vector in general. Moving them out of common_file and after entrypoint does not make a difference.
>>>>> As soon as I remove the fsnotify av's things start to work.
>>>>>
>>>>> In other words. besides the precensce of the fsnotify access vectors everything (seemingly) is in order
>>>>> Now for me the question remains: will this issue automatically resolve itself as soon as userspace and kernel support the fsnotify av
>>>>
>>>> That doesn't make any sense to me.  Sounds like a bug somewhere. Anything
>>>> that changes the permission bit value in the policy for FILE__ENTRYPOINT is
>>>> going to break legacy crond that is using the hardcoded value from the
>>>> deprecated libselinux headers.  So adding permissions at the end of the file
>>>> class should be fine.  Adding or removing to/from common file should break.
>>>> I can't explain the behavior you are seeing.
>>>
>>> It does not make sense to me either, but i believe it when i see it.
>>> Ive tried several times and just removing the fsnotify access vectors make it work. Whether i append them to common_file or whether i append them to the individual classes does not make a difference.
>>>
>>> BTW: this fixes it for me: https://lore.kernel.org/selinux/d706a78c-d6d0-13bb-c9af-7ec4365b9b44@debian.org/T/#u
>>
>> I don't suppose you could make the broken policy available somewhere? Source
>> and a binary.
> 
> huh? git clone git://defensec.nl/dssp2.git && cd dssp2 && make all

If I build that policy, then the resulting policy yields the following 
values for the watch* and subsequent permissions:
0x00010000 watch
0x00020000 watch_mount
0x00040000 watch_reads
0x00080000 watch_sb
0x00100000 watch_with_perm
0x00200000 write
0x00400000 audit_access
0x00800000 entrypoint
0x01000000 execmod
0x02000000 execute_no_trans
0x04000000 open

You can see this yourself with the attached program.

Contrast that with the deprecated definitions in 
/usr/include/selinux/av_permissions.h that were generated from the old 
refpolicy access_vectors file long ago:
#define FILE__MOUNTON                             0x00010000UL
#define FILE__EXECUTE_NO_TRANS                    0x00020000UL
#define FILE__ENTRYPOINT                          0x00040000UL
#define FILE__EXECMOD                             0x00080000UL
#define FILE__OPEN                                0x00100000UL

So when cron tries to check FILE__ENTRYPOINT, it ends up checking the 
bit for watch_reads instead.

In order to avoid this, you would need to synchronize your common_file 
and file definitions to ensure that your policy still defines entrypoint 
with the same value.  This is what I was trying to achieve by 
recommending moving the watch* permissions and map permission to the end 
of the classes. However, what I didn't realize was that you have made 
multiple other changes to your common_file and file definitions that 
have perturbed the values in other ways, e.g. you removed swapon 
(thereby shifting back the values, effectively canceling out the 
addition of map, such that moving map now actually yields an incorrect 
entrypoint value).  And while you did move audit_access in front of 
entrypoint in the class file definition, it was already the case that 
entrypoint was second in the list originally (the first used to be 
execute_no_trans until you sorted them).

If I apply the attached change to merely move the watch permissions, 
then the correct value is assigned to entrypoint and everything should 
work even without the cron patch.

All that said, I think the cron patch is the right fix - I just wanted 
to understand what was happening here, which I think I now do.

> 
>>
>>>
>>>>
>>>>>>
>>>>>>> }
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>       policy/Makefile              |   4 ++
>>>>>>>>>>>>>       policy/test_notify.te        |  74 ++++++++++++++++++++++++
>>>>>>>>>>>>>       tests/Makefile               |   4 ++
>>>>>>>>>>>>>       tests/notify/Makefile        |   5 ++
>>>>>>>>>>>>>       tests/notify/test            | 101
>>>>>>>>>>>>> +++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>       tests/notify/test_fanotify.c | 105
>>>>>>>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>       tests/notify/test_inotify.c  |  43 ++++++++++++++
>>>>>>>>>>>>>       7 files changed, 336 insertions(+)
>>>>>>>>>>>>>       create mode 100644 policy/test_notify.te
>>>>>>>>>>>>>       create mode 100644 tests/notify/Makefile
>>>>>>>>>>>>>       create mode 100755 tests/notify/test
>>>>>>>>>>>>>       create mode 100644 tests/notify/test_fanotify.c
>>>>>>>>>>>>>       create mode 100644 tests/notify/test_inotify.c
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/policy/Makefile b/policy/Makefile
>>>>>>>>>>>>> index 305b572..65f88c5 100644
>>>>>>>>>>>>> --- a/policy/Makefile
>>>>>>>>>>>>> +++ b/policy/Makefile
>>>>>>>>>>>>> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q
>>>>>>>>>>>>> corenet_sctp_bind_all_nodes
>>>>>>>>>>>>> $(POLDEV)/include/kernel/coren
>>>>>>>>>>>>>       TARGETS += test_sctp.te
>>>>>>>>>>>>>       endif
>>>>>>>>>>>>> +ifeq ($(shell grep -q all_file_perms.*watch
>>>>>>>>>>>>> $(POLDEV)/include/support/all_perms.spt && echo
>>>>>>>>>>>>> true),true)
>>>>>>>>>>>>> +TARGETS+=test_notify.te
>>>>>>>>>>>>> +endif
>>>>>>>>>>>>> +
>>>>>>>>>>>>>       ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>>>>>>>>>>>>       TARGETS:=$(filter-out test_overlayfs.te
>>>>>>>>>>>>> test_mqueue.te, $(TARGETS))
>>>>>>>>>>>>>       endif
>>>>>>>>>>>>> diff --git a/policy/test_notify.te b/policy/test_notify.te
>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>> index 0000000..8ba6f1a
>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>> +++ b/policy/test_notify.te
>>>>>>>>>>>>> @@ -0,0 +1,74 @@
>>>>>>>>>>>>> +####################################################
>>>>>>>>>>>>> +# Policy for testing inoftify and fanotify watches #
>>>>>>>>>>>>> +####################################################
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +attribute test_notify_domain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Type for the file on which we want to set a watch
>>>>>>>>>>>>> +type test_notify_file_t;
>>>>>>>>>>>>> +files_type(test_notify_file_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Domain for the process which CAN set a non-permission watch
>>>>>>>>>>>>> +type test_watch_t;
>>>>>>>>>>>>> +domain_type(test_watch_t);
>>>>>>>>>>>>> +unconfined_runs_test(test_watch_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +typeattribute test_watch_t test_notify_domain;
>>>>>>>>>>>>> +typeattribute test_watch_t testdomain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_notify_domain self:capability sys_admin;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_watch_t test_notify_file_t:file {
>>>>>>>>>>>>> read write open watch };
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Domain for the process which CAN set a NON-access watch on a file
>>>>>>>>>>>>> +type test_perm_watch_t;
>>>>>>>>>>>>> +domain_type(test_perm_watch_t);
>>>>>>>>>>>>> +unconfined_runs_test(test_perm_watch_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +typeattribute test_perm_watch_t test_notify_domain;
>>>>>>>>>>>>> +typeattribute test_perm_watch_t testdomain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_perm_watch_t test_notify_file_t:file
>>>>>>>>>>>>> { read write open watch watch_with_perm };
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Domain which CAN set a NON-perm watch which MAY read accesses
>>>>>>>>>>>>> +type test_read_watch_t;
>>>>>>>>>>>>> +domain_type(test_read_watch_t);
>>>>>>>>>>>>> +unconfined_runs_test(test_read_watch_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +typeattribute test_read_watch_t test_notify_domain;
>>>>>>>>>>>>> +typeattribute test_read_watch_t testdomain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_read_watch_t test_notify_file_t:file
>>>>>>>>>>>>> { read write open watch watch_reads };
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Domain which CAN set any watch which CAN read accesses
>>>>>>>>>>>>> +type test_perm_read_watch_t;
>>>>>>>>>>>>> +domain_type(test_perm_read_watch_t);
>>>>>>>>>>>>> +unconfined_runs_test(test_perm_read_watch_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +typeattribute test_perm_read_watch_t test_notify_domain;
>>>>>>>>>>>>> +typeattribute test_perm_read_watch_t testdomain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_perm_read_watch_t
>>>>>>>>>>>>> test_notify_file_t:file { read write open watch
>>>>>>>>>>>>> watch_with_perm watch_reads };
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Domain which CANNOT set any watches
>>>>>>>>>>>>> +type test_no_watch_t;
>>>>>>>>>>>>> +domain_type(test_no_watch_t);
>>>>>>>>>>>>> +unconfined_runs_test(test_no_watch_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +typeattribute test_no_watch_t test_notify_domain;
>>>>>>>>>>>>> +typeattribute test_no_watch_t testdomain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_no_watch_t test_notify_file_t:file { read write open };
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Domain which has no write access but can watch
>>>>>>>>>>>>> +type test_rdonly_t;
>>>>>>>>>>>>> +domain_type(test_rdonly_t);
>>>>>>>>>>>>> +unconfined_runs_test(test_rdonly_t);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +typeattribute test_rdonly_t test_notify_domain;
>>>>>>>>>>>>> +typeattribute test_rdonly_t testdomain;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +allow test_rdonly_t test_notify_file_t:file { read open watch };
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +miscfiles_domain_entry_test_files(test_notify_domain);
>>>>>>>>>>>>> +userdom_sysadm_entry_spec_domtrans_to(test_notify_domain);
>>>>>>>>>>>>> diff --git a/tests/Makefile b/tests/Makefile
>>>>>>>>>>>>> index 63aa325..b99c96e 100644
>>>>>>>>>>>>> --- a/tests/Makefile
>>>>>>>>>>>>> +++ b/tests/Makefile
>>>>>>>>>>>>> @@ -50,6 +50,10 @@ ifeq ($(shell grep
>>>>>>>>>>>>> "^SELINUX_INFINIBAND_PKEY_TEST="
>>>>>>>>>>>>> infiniband_pkey/ibpkey_test.
>>>>>>>>>>>>>       SUBDIRS += infiniband_pkey
>>>>>>>>>>>>>       endif
>>>>>>>>>>>>> +ifeq ($(shell grep -q all_file_perms.*watch
>>>>>>>>>>>>> $(POLDEV)/include/support/all_perms.spt && echo
>>>>>>>>>>>>> true),true)
>>>>>>>>>>>>> +SUBDIRS+=notify
>>>>>>>>>>>>> +endif
>>>>>>>>>>>>> +
>>>>>>>>>>>>>       ifeq ($(DISTRO),RHEL4)
>>>>>>>>>>>>>           SUBDIRS:=$(filter-out bounds dyntrace
>>>>>>>>>>>>> dyntrans inet_socket mmap nnp_nosuid overlay
>>>>>>>>>>>>> unix_socket, $(SUBDIRS))
>>>>>>>>>>>>>       endif
>>>>>>>>>>>>> diff --git a/tests/notify/Makefile b/tests/notify/Makefile
>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>> index 0000000..78c4b3b
>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>> +++ b/tests/notify/Makefile
>>>>>>>>>>>>> @@ -0,0 +1,5 @@
>>>>>>>>>>>>> +TARGETS=test_inotify test_fanotify
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +all: $(TARGETS)
>>>>>>>>>>>>> +clean:
>>>>>>>>>>>>> +    rm -f $(TARGETS)
>>>>>>>>>>>>> diff --git a/tests/notify/test b/tests/notify/test
>>>>>>>>>>>>> new file mode 100755
>>>>>>>>>>>>> index 0000000..21f03de
>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>> +++ b/tests/notify/test
>>>>>>>>>>>>> @@ -0,0 +1,101 @@
>>>>>>>>>>>>> +#!/usr/bin/perl
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +use Test;
>>>>>>>>>>>>> +BEGIN { plan tests => 14 }    # number of tests to run
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# help the test script locate itself
>>>>>>>>>>>>> +$basedir = $0;
>>>>>>>>>>>>> +$basedir =~ s|(.*)/[^/]*|$1|;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Get rid of a testfile from last run if it's there (just in case)
>>>>>>>>>>>>> +system("rm -f $basedir/watch_me");
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Create a new test file
>>>>>>>>>>>>> +system("touch $basedir/watch_me");
>>>>>>>>>>>>> +system("chcon -t test_notify_file_t $basedir/watch_me");
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TESTS
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TEST BASIC WATCH PERMISSION
>>>>>>>>>>>>> +# Should be able to set inotify watch
>>>>>>>>>>>>> +$exit_val =
>>>>>>>>>>>>> +  system("runcon -t test_watch_t
>>>>>>>>>>>>> $basedir/test_inotify $basedir/watch_me 2>&1");
>>>>>>>>>>>>> +ok( $exit_val, 0 );
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should be able to set non-permissions based fanotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify $basedir/watch_me 2>&1");
>>>>>>>>>>>>> +ok( $exit_val, 0 );
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should NOT be able to set permission based fanotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -p $basedir/watch_me
>>>>>>>>>>>>> 2>&1");
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should NOT be able to set read based fanotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -r $basedir/watch_me
>>>>>>>>>>>>> 2>&1");
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should NOT be able to set read based inotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_watch_t
>>>>>>>>>>>>> $basedir/test_inotify -r $basedir/watch_me
>>>>>>>>>>>>> 2>&1");
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TEST PERM WATCH
>>>>>>>>>>>>> +# Should be able to set permission based fanotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +"runcon -t test_perm_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -p $basedir/watch_me
>>>>>>>>>>>>> 2>&1"
>>>>>>>>>>>>> +);
>>>>>>>>>>>>> +ok( $exit_val, 0 );
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should NOT be able to set watch of accesses
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +"runcon -t test_perm_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -r $basedir/watch_me
>>>>>>>>>>>>> 2>&1"
>>>>>>>>>>>>> +);
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TEST READ NO PERM WATCH PERMSISSIONS
>>>>>>>>>>>>> +# Should NOT be able to set read and perm watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +"runcon -t test_read_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -p -r $basedir/watch_me
>>>>>>>>>>>>> 2>&1"
>>>>>>>>>>>>> +);
>>>>>>>>>>>>> +ok($exit_val);    # should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should be able to set read inotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +"runcon -t test_read_watch_t
>>>>>>>>>>>>> $basedir/test_inotify -r $basedir/watch_me 2>&1"
>>>>>>>>>>>>> +);
>>>>>>>>>>>>> +ok( $exit_val, 0 );
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TEST READ WITH PERM WATCH PERMSISSIONS
>>>>>>>>>>>>> +# Should be able to set read and perm watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +"runcon -t test_perm_read_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -p -r $basedir/watch_me
>>>>>>>>>>>>> 2>&1"
>>>>>>>>>>>>> +);
>>>>>>>>>>>>> +ok( $exit_val, 0 );
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TEST NO WATCH PERMSISSIONS
>>>>>>>>>>>>> +# Should NOT be able to set inotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_no_watch_t
>>>>>>>>>>>>> $basedir/test_inotify $basedir/watch_me 2>&1");
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should NOT be able to set any fanotify watch
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_no_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify $basedir/watch_me 2>&1");
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +## TEST READ ONLY
>>>>>>>>>>>>> +# Should NOT be able to get read-write descriptor
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_rdonly_t
>>>>>>>>>>>>> $basedir/test_fanotify -l $basedir/watch_me
>>>>>>>>>>>>> 2>&1");
>>>>>>>>>>>>> +ok($exit_val);    # this should fail
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Should be able to get read-write descriptor
>>>>>>>>>>>>> +$exit_val = system(
>>>>>>>>>>>>> +    "runcon -t test_watch_t
>>>>>>>>>>>>> $basedir/test_fanotify -l $basedir/watch_me
>>>>>>>>>>>>> 2>&1");
>>>>>>>>>>>>> +ok( $exit_val, 0 );
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +# Clean up test file
>>>>>>>>>>>>> +system("rm -f $basedir/watch_me");
>>>>>>>>>>>>> diff --git a/tests/notify/test_fanotify.c
>>>>>>>>>>>>> b/tests/notify/test_fanotify.c
>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>> index 0000000..fff773f
>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>> +++ b/tests/notify/test_fanotify.c
>>>>>>>>>>>>> @@ -0,0 +1,105 @@
>>>>>>>>>>>>> +#define _GNU_SOURCE 1
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +#include <stdio.h>
>>>>>>>>>>>>> +#include <stdlib.h>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +#include <getopt.h>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +#include <fcntl.h>
>>>>>>>>>>>>> +#include <poll.h>
>>>>>>>>>>>>> +#include <sys/fanotify.h>
>>>>>>>>>>>>> +#include <unistd.h>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +void printUsage()
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    fprintf(stderr, "Usage: test_fanotify [-p]
>>>>>>>>>>>>> [-r] [-l] file_name\n");
>>>>>>>>>>>>> +    exit(1);
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +int main(int argc, char *argv[])
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    if (argc < 2) {
>>>>>>>>>>>>> +        printUsage();
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    int fd, ret, arg;
>>>>>>>>>>>>> +    int mask = FAN_OPEN;  // default mask
>>>>>>>>>>>>> +    int listening = 0;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    // the -p flag will test for watch_with_perm
>>>>>>>>>>>>> +    // the mask used at mark will contain FAN_OPEN_PERM
>>>>>>>>>>>>> +    //
>>>>>>>>>>>>> +    // the -r flag will test for watching
>>>>>>>>>>>>> accesses to files for reads
>>>>>>>>>>>>> +    // the mask will contain FAN_ACCESS
>>>>>>>>>>>>> +    while ((arg = getopt(argc, argv, "prl")) != -1) {
>>>>>>>>>>>>> +        switch (arg) {
>>>>>>>>>>>>> +        case 'p':
>>>>>>>>>>>>> +            mask |= FAN_OPEN_PERM;
>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>> +        case 'r':
>>>>>>>>>>>>> +            mask |= FAN_ACCESS;
>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>> +        case 'l':
>>>>>>>>>>>>> +            listening = 1;
>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>> +        default:
>>>>>>>>>>>>> +            printUsage();
>>>>>>>>>>>>> +        }
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    // get file descriptor for new fanotify event queue
>>>>>>>>>>>>> +    fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
>>>>>>>>>>>>> +    if (fd < 0) {
>>>>>>>>>>>>> +        perror("fanotify_init:bad file descriptor");
>>>>>>>>>>>>> +        exit(1);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    // mark a filesystem object and add mark to event queue
>>>>>>>>>>>>> +    // get notifications on file opens, accesses, and closes
>>>>>>>>>>>>> +    // use current working directory as base dir
>>>>>>>>>>>>> +    ret = fanotify_mark(fd, FAN_MARK_ADD, mask,
>>>>>>>>>>>>> AT_FDCWD, argv[optind]);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    if (ret < 0) {
>>>>>>>>>>>>> +        perror("test_fanotify:watch denied");
>>>>>>>>>>>>> +        exit(1);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    // logic to actually listen for an event if
>>>>>>>>>>>>> the -l flag is passed
>>>>>>>>>>>>> +    // this is used to test if an app with
>>>>>>>>>>>>> read-only access can get a read/write
>>>>>>>>>>>>> +    // handle to the watched file
>>>>>>>>>>>>> +    if (listening) {
>>>>>>>>>>>>> +        if (fork() == 0) {  // fork a child
>>>>>>>>>>>>> process to cause an event on the file
>>>>>>>>>>>>> +            FILE *f;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +            f = fopen(argv[optind], "r");  // open file for reading
>>>>>>>>>>>>> +            fgetc(f);                      // read char from file
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +            fclose(f);
>>>>>>>>>>>>> +        } else {  // logic to watch for events
>>>>>>>>>>>>> and try to access file read/write
>>>>>>>>>>>>> +            struct pollfd fds;
>>>>>>>>>>>>> +            fds.fd = fd;
>>>>>>>>>>>>> +            fds.events = POLLIN;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +            while (listening) {
>>>>>>>>>>>>> +                int polled = poll(&fds, 1, 1);
>>>>>>>>>>>>> +                if (polled > 0) {
>>>>>>>>>>>>> +                    if (fds.revents & POLLIN) {
>>>>>>>>>>>>> +                        struct fanotify_event_metadata buff[200];
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +                        size_t len = read(fd,
>>>>>>>>>>>>> (void *)&buff, sizeof(buff));
>>>>>>>>>>>>> +                        if (len == -1) {
>>>>>>>>>>>>> +
>>>>>>>>>>>>> perror("test_fanotify:can't open file");
>>>>>>>>>>>>> +                            exit(1);
>>>>>>>>>>>>> +                        } else {
>>>>>>>>>>>>> +                            listening = 0;
>>>>>>>>>>>>> +                            break;
>>>>>>>>>>>>> +                        }
>>>>>>>>>>>>> +                    }
>>>>>>>>>>>>> +                } else if (polled == -1) {
>>>>>>>>>>>>> +                    listening = 0;
>>>>>>>>>>>>> +                }
>>>>>>>>>>>>> +            }
>>>>>>>>>>>>> +        }
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +    exit(0);
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> diff --git a/tests/notify/test_inotify.c
>>>>>>>>>>>>> b/tests/notify/test_inotify.c
>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>> index 0000000..17c3565
>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>> +++ b/tests/notify/test_inotify.c
>>>>>>>>>>>>> @@ -0,0 +1,43 @@
>>>>>>>>>>>>> +#include <stdio.h>
>>>>>>>>>>>>> +#include <stdlib.h>
>>>>>>>>>>>>> +#include <sys/inotify.h>
>>>>>>>>>>>>> +#include <getopt.h>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +int main(int argc, char *argv[])
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    if (argc < 2) {
>>>>>>>>>>>>> +        fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
>>>>>>>>>>>>> +        exit(1);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    int fd, wd, arg;
>>>>>>>>>>>>> +    int mask = IN_MODIFY;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    while ((arg = getopt(argc, argv, "pr")) != -1) {
>>>>>>>>>>>>> +        switch (arg) {
>>>>>>>>>>>>> +        case 'r':
>>>>>>>>>>>>> +            mask |= IN_ACCESS;
>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>> +        default:
>>>>>>>>>>>>> +            fprintf(stderr, "Usage:
>>>>>>>>>>>>> test_inotify [-r] file_name\n");
>>>>>>>>>>>>> +            exit(1);
>>>>>>>>>>>>> +        }
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    // get new file descriptor for inotify access
>>>>>>>>>>>>> +    fd = inotify_init();
>>>>>>>>>>>>> +    if (fd < 0) {
>>>>>>>>>>>>> +        perror("inotify_init:bad file descriptor");
>>>>>>>>>>>>> +        exit(1);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    // set watch on file and get watch
>>>>>>>>>>>>> descriptor for accessing events on it
>>>>>>>>>>>>> +    wd = inotify_add_watch(fd, argv[optind], mask);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    if (wd < 0) {
>>>>>>>>>>>>> +        perror("test_inotify:watch denied");
>>>>>>>>>>>>> +        exit(1);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    exit(0);
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> -- 
>>>>>>>>>>>>> 2.21.0
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 


--------------457A598CBC6883381AF01292
Content-Type: text/x-csrc;
 name="showperm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="showperm.c"

/*
 * showperm.c
 * $  make LDLIBS+="/usr/lib64/libsepol.a" showperm
 * $ ./showperm /path/to/policy classname
 */

#include <sepol/policydb/policydb.h>
#include <stdio.h>

static int show_perm(hashtab_key_t key, hashtab_datum_t datum, void *data)
{
	perm_datum_t *perdatum = datum;

	printf("0x%08x %s\n", 1 << (perdatum->s.value - 1), key);
	return 0;
}

int main(int argc, char **argv)
{
	const char *path;
	const char *cls;
	FILE *fp;
	struct sepol_policy_file *pf = NULL;
	struct sepol_policydb *policydb = NULL;
	class_datum_t *cladatum;
	perm_datum_t *perdatum;

	if (argc != 3) {
		fprintf(stderr, "usage: %s policy class\n", argv[0]);
		exit(1);
	}

	path = argv[1];
	cls = argv[2];

	fp = fopen(path, "r");
	if (!fp) {
		perror(path);
		exit(1);
	}

	if (sepol_policy_file_create(&pf)) {
		perror("sepolicy_policy_file_create");
		exit(1);
	}

	if (sepol_policydb_create(&policydb)) {
		perror("sepolicy_policydb_create");
		exit(1);
	}

	sepol_policy_file_set_fp(pf, fp);
	if (sepol_policydb_read(policydb, pf)) {
		perror("sepolicy_policydb_read");
		exit(1);
	}

	cladatum = hashtab_search(policydb->p.p_classes.table, cls);
	if (!cladatum) {
		fprintf(stderr, "no file class?\n");
		exit(1);
	}

	if (cladatum->comdatum)
		hashtab_map(cladatum->comdatum->permissions.table, show_perm, NULL);

	hashtab_map(cladatum->permissions.table,
		    show_perm, NULL);
}

--------------457A598CBC6883381AF01292
Content-Type: text/x-patch;
 name="0001-Move-watch-permissions-from-common_file-to-the-class.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Move-watch-permissions-from-common_file-to-the-class.pa";
 filename*1="tch"

From e18f773445353cccb56dc04ded4240765ee027f2 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 10 Sep 2019 15:43:58 -0400
Subject: [PATCH] Move watch* permissions from common_file to the classes.

To avoid perturbing the value of file entrypoint permission,
which breaks legacy cron.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/base/access_vectors.cil | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/policy/base/access_vectors.cil b/policy/base/access_vectors.cil
index a1e4d5e5b9c6..cdd240041e38 100644
--- a/policy/base/access_vectors.cil
+++ b/policy/base/access_vectors.cil
@@ -12,7 +12,8 @@
 (class bpf (map_create map_read map_write prog_load prog_run))
 (class binder (call impersonate set_context_mgr transfer))
 
-(class blk_file (audit_access execmod open))
+(class blk_file (audit_access execmod open watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon blk_file common_file)
 
 (class cap_userns ())
@@ -27,22 +28,26 @@
 (class capability2 ())
 (classcommon capability2 common_capability2)
 
-(class chr_file (audit_access execmod open))
+(class chr_file (audit_access execmod open watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon chr_file common_file)
 
 (class dccp_socket (name_connect node_bind))
 (classcommon dccp_socket common_socket)
 
 (class dir
-       (add_name audit_access execmod open remove_name reparent rmdir search))
+       (add_name audit_access execmod open remove_name reparent rmdir search watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon dir common_file)
 
 (class fd (use))
 
-(class fifo_file (audit_access execmod open))
+(class fifo_file (audit_access execmod open watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon fifo_file common_file)
 
-(class file (audit_access entrypoint execmod execute_no_trans open))
+(class file (audit_access entrypoint execmod execute_no_trans open watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon file common_file)
 
 (class filesystem
@@ -60,7 +65,8 @@
 (class key_socket ())
 (classcommon key_socket common_socket)
 
-(class lnk_file (audit_access execmod open))
+(class lnk_file (audit_access execmod open watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon lnk_file common_file)
 
 (class memprotect (mmap_zero))
@@ -153,7 +159,8 @@
 (class shm (lock))
 (classcommon shm common_ipc)
 
-(class sock_file (audit_access execmod open))
+(class sock_file (audit_access execmod open watch watch_mount
+                watch_reads watch_sb watch_with_perm))
 (classcommon sock_file common_file)
 
 (class socket ())
@@ -320,8 +327,7 @@
         (audit_read block_suspend mac_admin mac_override syslog wake_alarm))
 (common common_file
         (append create execute getattr ioctl lock link map mounton quotaon read
-                relabelfrom relabelto rename setattr unlink watch watch_mount
-                watch_reads watch_sb watch_with_perm write))
+                relabelfrom relabelto rename setattr unlink write))
 (common common_ipc
         (associate create destroy getattr read setattr unix_read
                    unix_write write))
-- 
2.21.0


--------------457A598CBC6883381AF01292--
