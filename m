Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5064C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D1E2081C
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 19:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D1E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeK2GfF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:35:05 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:8970 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2GfE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 01:35:04 -0500
X-EEMSG-check-008: 619167708|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,291,1539648000"; 
   d="scan'208";a="619167708"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Nov 2018 19:32:18 +0000
X-IronPort-AV: E=Sophos;i="5.56,291,1539648000"; 
   d="scan'208";a="21107013"
IronPort-PHdr: =?us-ascii?q?9a23=3AqlC7VBQAY4CLimDYSS9B8NgHfNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBWBt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eIL3hDZLNL3jZn7flZr?=
 =?us-ascii?q?t98VBTxxczzd9F+5JYEK0OIPX2WkXprtzXEgc5MxCow+bgENh904IeWWGLAq?=
 =?us-ascii?q?+eK6PfqkSI5+MxLOmWeoAapTf9J+Il5/7zlXU5g0MSfbG13ZsLb3C1BvNmI0?=
 =?us-ascii?q?CeYXr3hNcOC3sFsRQlQezwllKNTD5TaGyuX64m+j47D4emB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa29dBFCMEGnnd4GZVPcXcy+SLM5hnSIAVbe8UI8uywquuBX9y7p9Ie?=
 =?us-ascii?q?re4jcYuo771Nhp++3Tkgk/9SduAMSZ02CMTmF1nmUTSjAs2qBwvFZ9ylCC0a?=
 =?us-ascii?q?dlmfBXCdtT5/ZRWAcgKZHc1/B6C8z1Wg/ZZteGUkumQtG9DDEpVN0x3tsOb1?=
 =?us-ascii?q?94G9WliRDDxTSlD6UJmLyMAZw+6rjc0GTpJ8Zh13bG07Esj10nQstJKG2nib?=
 =?us-ascii?q?dz9wvNCI7TlUWWiaKqeL8C3C7C6miD13CCvEJGXw5qV6XKQ3QfalHRrdTj6U?=
 =?us-ascii?q?PIV6WuBqg/Mgtd1c6CLbNHatnojVVAWffiN83SY3+3m2exAhaIwL2MbJHxdm?=
 =?us-ascii?q?UD0yXSFlIEnxoQ/XmYLwg+ADmuo2bEADxpD1LvbFvm8fNip3OjUk800waKYl?=
 =?us-ascii?q?Vl17q0/B4VmPOdR+od3rIfpSgutSt0E0i539/NFdqAqBRufL9GbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpC6KKBinFEeeRxtv0zyzxV3FplAkc8yoXMx0gVyLaOY0FVcdzKXxp?=
 =?us-ascii?q?3wJLLXJXfo/By1aK7ZxEve0NCI9acL8vg4rE/jvA6xHEo473pny8VV02eb5p?=
 =?us-ascii?q?jSEQUTX4j+UkIs9xh6vLzaeDcy6J7U1XJ2Lam4qCPN29UsBLht9hH1QdZBPa?=
 =?us-ascii?q?DMOwjjGslSU9ahL/0jn3CzYx4ENfwU/6kxaYfuUvqF3KmwdN1ykSirgWUPtI?=
 =?us-ascii?q?V80UaL7AJnWOPS0poEhfGFiFipTTD52Wy9v9j3lIYMXjQbGm6y2GCwH4JKTr?=
 =?us-ascii?q?FjdoYMT2G1Kou4wcso1M2lYGJR6FP2XwBO48SuYxfHKgWnhQA=3D?=
X-IPAS-Result: =?us-ascii?q?A2ALAABX7P5b/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?gQBAQEBCwGBWimBaCeDeZQgTAEBAQMGgQgtiR6OJBSBZjgBhEACgywiNQgNA?=
 =?us-ascii?q?QMBAQEBAQECAWwogjYkAYJiAQUjFTQKAxALDgoCAiYCAlcGAQwGAgEBgl4/g?=
 =?us-ascii?q?XUNpzKBL4VAhG+BC4sLF3iBB4E4gmuETgESAYMjglcCiQ4GggOEUDRQjltVC?=
 =?us-ascii?q?ZErBhiBWog0hweIdoEpj3EBNWRxKwgCGAghD4MngicXjjshAzCBBQEBiyWCP?=
 =?us-ascii?q?gEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Nov 2018 19:32:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wASJWFNP003988;
        Wed, 28 Nov 2018 14:32:16 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
Date:   Wed, 28 Nov 2018 14:34:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128170302.GA12405@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/28/18 12:03 PM, Vivek Goyal wrote:
> On Wed, Nov 28, 2018 at 11:00:09AM +0100, Miklos Szeredi wrote:
>> On Tue, Nov 27, 2018 at 10:05 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>
>>> On Tue, Nov 27, 2018 at 08:58:06PM +0100, Miklos Szeredi wrote:
>>>> [resending with fixed email address for Paul Moore]
>>>>
>>>> Moving discussion from github[1] to here.
>>>>
>>>> To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
>>>> underlying layers") was added in 4.20-rc1 to make overlayfs access
>>>> checks on underlying "real" filesystems more consistent.  The
>>>> discussion leading up to this commit can be found at [2].  The commit
>>>> broke some selinux-testsuite cases, possibly indicating a security
>>>> hole opened by this commit.
>>>>
>>>> The model this patch tries to follow is that if "cp --preserve=all"
>>>> was allowed to the mounter from underlying layer to the overlay layer,
>>>> then operation is allowed.  That means even if mounter's creds doesn't
>>>> provide permission to for example execute underying file X, if
>>>> mounter's creds provide sufficient permission to perform "cp
>>>> --preserve=all X Y"  and original creds allow execute on Y, then the
>>>> operation is allowed.  This provides consistency in the face of
>>>> copy-ups.  Consistency is only provided in sane setups, where mounter
>>>> has sufficient privileges to access both the lower and upper layers.
>>>
>>> [cc daniel walsh]
>>>
>>> I think current selinux testsuite tests are written keeping these
>>> rules in mind.
>>>
>>> 1. Check overlay inode creds in the context of task and underlying
>>>     inode creds (lower/upper), in the context of mounter.
>>>
>>> 2. For a lower inode, if said file is being copied up, then only
>>>     check MAY_READ on lower. This is equivalent to mounter creating
>>>     a copy of file and providing caller access to it (context mount).
>>>
>>> For the case of special devices, we do not copy up these. So should
>>> we continue to do check on lower inode in the context of mounter
>>> (instead of not doing any check on lower at all).
>>
>> Hmm, I'm trying to understand the logic... If we follow the "cp
>> --preserve=all" thing, than mounter needs to have CREATE permission
>> for the special file, not READ or WRITE.  Does that make sense?  Would
>> that help with the context= mount use case?
> 
> Ok. If we follow "cp --preserve=all" methodology, then checking for
> mounter CREATE permission on upper for special files makes sense. Or
> change logic to copy up this special file during open. I am assuming
> we don't copy up special file during open as it is not necessary
> for things to work but copying up will work as well?
> 
> So rules will become.
> 
> - Two levels of checks.
> - For lower level inode, check MAY_READ for regular files. (including
>    exec).
> - For special files, only make sure mounter can CREATE object in upper.
> 
> - What about checks on files on upper/. As of now we seem to check
>    access in mounter's context if it is regular file. Skip the checks
>    completely for special files and for executables.
> 
> While non-context mount should still be ok, but this means lot of
> privilige granting to unprivileged process using context mounts. So
> unprivileged process which could not open a device/socket/fifo for
> read/write on host fs, can open it for those operations for context
> mounts.
> 
> IOW, for context mount case, an unprivileged user will gain lot of
> privileges. But that seems to be the point of context mount anyway
> on regular disks. If a disk is mounted using context mount option,
> then all real labels are ignored and all access checking happens
> using context label. We are doing similar thing. With one step extra
> and that is making sure if mounter itself can not do certain operation
> on host, that will still be denied.
> 
> This probably means that context= mounts should be used very carefully.
> It will grant lot of priviliges to the process (and allow operations
> which process could not do on host without overlayfs mount).
> 
> Case of device file still baffels me though. We don't do any mounter's
> checks on device files. So if a device file is on upper which mounter
> can't open for read but mounter is still granting priviliges to client
> to open that device file. That's unintutive to me and seems counter
> to the principle of that mounter can't give more priviliges than what
> it itself can't do on host.
> 
> Dan, stephen, paul moore, does this sound ok to you folks from selinux
> point of view.

It seems wrong to check CREATE when no file is being created, and doing 
so could lead to over-privileging of the mounter context, requiring one 
to allow a mounter context to create device nodes just to allow a client 
task context to read/write via already existing device nodes through an 
overlay.

Checking READ but not EXECUTE upon an execute check could permit a 
mounter to execute unauthorized code, if it can context mount from a 
readable-but-not-executable context to an executable context.

Note btw that cp --preserve=all doesn't quite operate as expected if 
dealing with a context mount.  You can't preserve the original security 
context if copying to a context mount unless the two contexts happen to 
already match.  So I'm not sure how that model applies in the case of a 
context mount.

Does the breaking commit (007ea44892e6) fix a real bug affecting users? 
  If not, I'd recommend just reverting it.
