Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77915C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 21:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D192081C
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 21:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D192081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeK2IrM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:47:12 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:16976 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbeK2IrM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 03:47:12 -0500
X-EEMSG-check-008: 214692866|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Nov 2018 21:43:46 +0000
X-IronPort-AV: E=Sophos;i="5.56,292,1539648000"; 
   d="scan'208";a="21115754"
IronPort-PHdr: =?us-ascii?q?9a23=3ADCKFmR9VjzEe2v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0OIVIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnhlSskTRrx/TBPr36GZjNNXnCn6n7fb?=
 =?us-ascii?q?lj9kFcyRA/zdBC55hMELEOPOrzWlPttNzfFhI5LQO0w+HnCdpn0oMTQniPDb?=
 =?us-ascii?q?GEP6PSq1CI+vgjLPWLZI8QoDz9MeQq5+byjX8lnl8QZa6p3Z4QaHCjGPRpOV?=
 =?us-ascii?q?mWbmT3j9cbD2gFowo+Q/b2iFGYTTFTYHOyVbom5j4nEIKmEZvDRoe1jbOa0i?=
 =?us-ascii?q?e7H4NZZmRbBVCXCnroeYSEVOkIaC2POc9ujCcEWaKmS4872hGkrBX6xKZ/Lu?=
 =?us-ascii?q?rI5i0Ysoru1MNv6O3XlRAz9Dx1D8KG3m6XSWF7g3kIRzg33K9iu0By1lCD0a?=
 =?us-ascii?q?1gifxCCdNT/+9JUhs9NZPE1+x1Ec3yWgbac9eRUlmmX9GmDSg0TtI2xN8OeV?=
 =?us-ascii?q?hyF8++gRDE2iqgG6UVmKCTBJwo7qLc2GD8J8J8y3bAyakggEAqQshROm28gK?=
 =?us-ascii?q?5w6QzTCpXXk0WWiamqb74Q3C3T+2eZy2qBokVYXBR3UaXfUnAVflHWosjh5k?=
 =?us-ascii?q?PeU7+uDqwqMg9Ayc6EN6tLZcTljUhARPfiP9TeZWyxm3yrCBaWybODcpDqd3?=
 =?us-ascii?q?8e3CrDEkgElR4c/XKcOQg5HCehrHrUDCZyGlL3f0Ps7e5+pWu/Tk81yQGKck?=
 =?us-ascii?q?Jg26O7+h4OmPOTVe0T0awAuCo6tTV0E0iy38jMB9qDuQVhZqNcbs054Ftd0m?=
 =?us-ascii?q?LZrQN9NIS6L69+nl4ebxh3v0T22hVsFIpAlckqrHU3zAt9Mq+YzlxBeC2C3Z?=
 =?us-ascii?q?zqOb3YNHPy/BaxZK7SwF3e18yW+qgX4vQit1rjpB2pFlYl83h/ztZU3WGT5p?=
 =?us-ascii?q?HRDAoSSp/xSFg4+AV6p77Afikx/Z/b1XppMfr8jjiX/tMqAOw+gi2ycs1SPK?=
 =?us-ascii?q?LMQArzEMkdHOC1OuEwllSoKBIZarN87qkxavi6euOG1ajjB+NpmDarnCwT+4?=
 =?us-ascii?q?xm+l6d/Cp7DOjT1tAKxO/OjVjPbCv1kFr06pO/ootDfzxHWzPlkSU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BYAAAHC/9b/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYFoJ4N5lCBMAQEBAwaBCC2JHo44gWY4AYRAAoMsIjcGDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsKII2JAGCYQEBAQECASMVNAoDBQsLGAICJgICVwYNBgIBAYJeP4F1B?=
 =?us-ascii?q?QinK4EvhUCEbYELiwsXeIEHgTiCa4ROARIBH4MEglcCiQ4GggOEUDRQjltVC?=
 =?us-ascii?q?ZErBhiBWog0hweKH5AFImRxKwgCGAghD4MngicXjjshAzCBBQEBiyWCPgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Nov 2018 21:43:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wASLhiCu024844;
        Wed, 28 Nov 2018 16:43:44 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
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
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
Date:   Wed, 28 Nov 2018 16:46:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/28/18 3:24 PM, Miklos Szeredi wrote:
> On Wed, Nov 28, 2018 at 8:32 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 11/28/18 12:03 PM, Vivek Goyal wrote:
>>> On Wed, Nov 28, 2018 at 11:00:09AM +0100, Miklos Szeredi wrote:
>>>> On Tue, Nov 27, 2018 at 10:05 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>>
>>>>> On Tue, Nov 27, 2018 at 08:58:06PM +0100, Miklos Szeredi wrote:
>>>>>> [resending with fixed email address for Paul Moore]
>>>>>>
>>>>>> Moving discussion from github[1] to here.
>>>>>>
>>>>>> To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
>>>>>> underlying layers") was added in 4.20-rc1 to make overlayfs access
>>>>>> checks on underlying "real" filesystems more consistent.  The
>>>>>> discussion leading up to this commit can be found at [2].  The commit
>>>>>> broke some selinux-testsuite cases, possibly indicating a security
>>>>>> hole opened by this commit.
>>>>>>
>>>>>> The model this patch tries to follow is that if "cp --preserve=all"
>>>>>> was allowed to the mounter from underlying layer to the overlay layer,
>>>>>> then operation is allowed.  That means even if mounter's creds doesn't
>>>>>> provide permission to for example execute underying file X, if
>>>>>> mounter's creds provide sufficient permission to perform "cp
>>>>>> --preserve=all X Y"  and original creds allow execute on Y, then the
>>>>>> operation is allowed.  This provides consistency in the face of
>>>>>> copy-ups.  Consistency is only provided in sane setups, where mounter
>>>>>> has sufficient privileges to access both the lower and upper layers.
>>>>>
>>>>> [cc daniel walsh]
>>>>>
>>>>> I think current selinux testsuite tests are written keeping these
>>>>> rules in mind.
>>>>>
>>>>> 1. Check overlay inode creds in the context of task and underlying
>>>>>      inode creds (lower/upper), in the context of mounter.
>>>>>
>>>>> 2. For a lower inode, if said file is being copied up, then only
>>>>>      check MAY_READ on lower. This is equivalent to mounter creating
>>>>>      a copy of file and providing caller access to it (context mount).
>>>>>
>>>>> For the case of special devices, we do not copy up these. So should
>>>>> we continue to do check on lower inode in the context of mounter
>>>>> (instead of not doing any check on lower at all).
>>>>
>>>> Hmm, I'm trying to understand the logic... If we follow the "cp
>>>> --preserve=all" thing, than mounter needs to have CREATE permission
>>>> for the special file, not READ or WRITE.  Does that make sense?  Would
>>>> that help with the context= mount use case?
>>>
>>> Ok. If we follow "cp --preserve=all" methodology, then checking for
>>> mounter CREATE permission on upper for special files makes sense. Or
>>> change logic to copy up this special file during open. I am assuming
>>> we don't copy up special file during open as it is not necessary
>>> for things to work but copying up will work as well?
>>>
>>> So rules will become.
>>>
>>> - Two levels of checks.
>>> - For lower level inode, check MAY_READ for regular files. (including
>>>     exec).
>>> - For special files, only make sure mounter can CREATE object in upper.
>>>
>>> - What about checks on files on upper/. As of now we seem to check
>>>     access in mounter's context if it is regular file. Skip the checks
>>>     completely for special files and for executables.
>>>
>>> While non-context mount should still be ok, but this means lot of
>>> privilige granting to unprivileged process using context mounts. So
>>> unprivileged process which could not open a device/socket/fifo for
>>> read/write on host fs, can open it for those operations for context
>>> mounts.
>>>
>>> IOW, for context mount case, an unprivileged user will gain lot of
>>> privileges. But that seems to be the point of context mount anyway
>>> on regular disks. If a disk is mounted using context mount option,
>>> then all real labels are ignored and all access checking happens
>>> using context label. We are doing similar thing. With one step extra
>>> and that is making sure if mounter itself can not do certain operation
>>> on host, that will still be denied.
>>>
>>> This probably means that context= mounts should be used very carefully.
>>> It will grant lot of priviliges to the process (and allow operations
>>> which process could not do on host without overlayfs mount).
>>>
>>> Case of device file still baffels me though. We don't do any mounter's
>>> checks on device files. So if a device file is on upper which mounter
>>> can't open for read but mounter is still granting priviliges to client
>>> to open that device file. That's unintutive to me and seems counter
>>> to the principle of that mounter can't give more priviliges than what
>>> it itself can't do on host.
>>>
>>> Dan, stephen, paul moore, does this sound ok to you folks from selinux
>>> point of view.
>>
>> It seems wrong to check CREATE when no file is being created, and doing
>> so could lead to over-privileging of the mounter context, requiring one
>> to allow a mounter context to create device nodes just to allow a client
>> task context to read/write via already existing device nodes through an
>> overlay.
> 
> Point taken.
> 
>>
>> Checking READ but not EXECUTE upon an execute check could permit a
>> mounter to execute unauthorized code, if it can context mount from a
>> readable-but-not-executable context to an executable context.
>>
>> Note btw that cp --preserve=all doesn't quite operate as expected if
>> dealing with a context mount.  You can't preserve the original security
>> context if copying to a context mount unless the two contexts happen to
>> already match.  So I'm not sure how that model applies in the case of a
>> context mount.
>>
>> Does the breaking commit (007ea44892e6) fix a real bug affecting users?
>>    If not, I'd recommend just reverting it.
> 
> That is certainly an option, but...  this is all about context=
> mounts, right?  Which allows mounter to override MAC checks under the
> new mount?  On any mount, not just overlay, right?  So why is overlay
> special?

With other filesystems, the files are only accessible under the context 
specified by the mounter (and you can't mount it twice with differing 
context mount options). With overlay, the file is simultaneously 
accessible under both the context specified by the mounter via the 
overlay and under its lower/upper context via the lower/upper dir.

Generally we only use context mounts on other filesystems when they have 
no label information at all (no security.selinux xattrs) or when they 
are completely untrusted to provide that information; the context 
specified by the mounter is the only basis for access control.  With 
overlay, we are frequently dealing with labeled lower and upper 
directories in a filesystem we trust.

It seems like overlay has a goal of preventing the mounter from 
escalating its access through an overlay mount.

> I'd just like to see proper justification for why we should be doing
> those checks on underlying layer that simply don't belong there, IMO.
>   I'm sure you know better than I that it's not just about real bugs
> affecting users, it's about having a clear, well defined model to base
> the design on.   And by reverting the breaking commit, I don't see us
> getting closer to that.

It seems like the NFS folks raised a number of concerns with the overlay 
approach beyond just these two checks, and Android has their 
override_creds=off use case.  Maybe the overlay model needs a more 
significant rethinking than just these two cases.
