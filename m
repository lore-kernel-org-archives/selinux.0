Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7392DC43610
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3887B20868
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 16:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3887B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeK3DZt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:25:49 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:21937 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeK3DZs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 22:25:48 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2018 22:25:45 EST
X-EEMSG-check-008: 183411373|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Nov 2018 16:19:49 +0000
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="21145288"
IronPort-PHdr: =?us-ascii?q?9a23=3Aq2VAaxFdtDD1lrUwLTBgT51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pMS5bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxD9WiH/43qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodbvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFYIUE7iarbK5k7zr42ip?=
 =?us-ascii?q?UTqljMEjXzmEX3iK+abkQk+u625OT7erjqu5CROoBuhgz+L6gigNKzDOsmPg?=
 =?us-ascii?q?QUQmSX4eG826fi/U39TrVKlPo2kqzBvZDBOMsbvbW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpzwvDGP77hApHKLnjYi7rhZr?=
 =?us-ascii?q?d85FBGyAUt0N9f5ohYCrEcIPjrQE/+qMTYDgMlMwyz2+vnFtp91oQeWG2VBq?=
 =?us-ascii?q?+UK7nSvkGV6eIvOeaMeJUZtyr6K/gg//Tul2M2mUcBfam12psacHe4HvFhI0?=
 =?us-ascii?q?WCZ3rjmMsOHnkRswokUuPllV2CXiRPZ3qoQ6084TQ7Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE5JNaGBGC06DEXP1eIWfQPoMZiOSLdFlkjMZTriuVZQh2QuptA/gxLptNv?=
 =?us-ascii?q?DU9TEAtZL/yNh14PXelQoo+jxwD8Wc0mGMT2dvk2wSQT85wbp/oUt8yliey6?=
 =?us-ascii?q?R3n/tYFdlL7fNTTgg6LYLcz/B9C93qQgLOZMqJSFK9T9W+Gz4xU9Yxz8YLY0?=
 =?us-ascii?q?Z6HNWilA7M0zC2DL8SkryBHIY0/b7E33jtO8Z9zG7L1K0gj1kgX8tOOnSqhq?=
 =?us-ascii?q?1h+AjJAY7GjUGZmr20daQTwiHN7n2PzWmQs0FCVg5/T6HFUWoYZkvMotTz/l?=
 =?us-ascii?q?nCQKO2CbQ7LgtBztaPKq9Lat3vkFVHS+7vOMnYY2KwnGewAxiIxqiXYYr0dG?=
 =?us-ascii?q?USwj/dBFIHkw8N53aGMxYxBiO7r2LZFjxuGkrlY1nw/ulmtHO7Ukg0whmOb0?=
 =?us-ascii?q?1g0bq15xEUieWSS/MIw70LpjkhpCtwHFumwdLWBMSPpxB7cKVff9w9+lFH2n?=
 =?us-ascii?q?zdtwBnOZygNa9ijEYEcwtrp0Puywl3CoJYnMgxsnwqyAtyKaSF0FJObD6Yw5?=
 =?us-ascii?q?/wNaPNKmXo/xCgdbTW2lfA39aS4KsP7+44q1r7tgGzCkUi62ln08VS03aE+5?=
 =?us-ascii?q?rLAhAdUZbqUkY37BV6va/VbTQ954zOyX1gK7W7sjjH24FhOOxw7xeje9BEeJ?=
 =?us-ascii?q?iWGRX/H8xSU82vK+gtgHCyfB8eMexTsq4paZCIbfyDjZW3Mf5gkTTutmFO5I?=
 =?us-ascii?q?RwwwrY7CZnYvLZ1JYChfeD102IUCmq3wTpidz+hY0RPWJaJWG40yWxQdcLPq?=
 =?us-ascii?q?A=3D?=
X-IPAS-Result: =?us-ascii?q?A2DNAAAREQBc/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YE1MyeDeZQgTAEBAQEBAQaBCAgliR6QIDgBhEACgzIiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCNiQBgmIBBSMPAQVBEAsYAgImAgJXBg0GAgEBgl4/gXUNpjaBL4orgQuLC?=
 =?us-ascii?q?xd4gQeBOAyCX4Q7HxEWgwSCVwKJFoIDhQVQjzUJkSwGGIFaiDSHDporIYFVK?=
 =?us-ascii?q?wgCGAghD4MnkHkhAzCBBQEBim0PF4InAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Nov 2018 16:19:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wATGJlIk020702;
        Thu, 29 Nov 2018 11:19:47 -0500
Subject: Re: overlayfs access checks on underlying layers
From:   Stephen Smalley <sds@tycho.nsa.gov>
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
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
Message-ID: <d82ba663-0154-337e-9cd5-360794df8c82@tycho.nsa.gov>
Date:   Thu, 29 Nov 2018 11:22:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/29/18 11:16 AM, Stephen Smalley wrote:
> On 11/29/18 6:04 AM, Miklos Szeredi wrote:
>> On Wed, Nov 28, 2018 at 10:43 PM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>>
>>> On 11/28/18 3:24 PM, Miklos Szeredi wrote:
>>>> On Wed, Nov 28, 2018 at 8:32 PM Stephen Smalley <sds@tycho.nsa.gov> 
>>>> wrote:
>>
>> [...]
>>
>>>>> Does the breaking commit (007ea44892e6) fix a real bug affecting 
>>>>> users?
>>>>>     If not, I'd recommend just reverting it.
>>>>
>>>> That is certainly an option, but...  this is all about context=
>>>> mounts, right?  Which allows mounter to override MAC checks under the
>>>> new mount?  On any mount, not just overlay, right?  So why is overlay
>>>> special?
>>>
>>> With other filesystems, the files are only accessible under the context
>>> specified by the mounter (and you can't mount it twice with differing
>>> context mount options). With overlay, the file is simultaneously
>>> accessible under both the context specified by the mounter via the
>>> overlay and under its lower/upper context via the lower/upper dir.
>>>
>>> Generally we only use context mounts on other filesystems when they have
>>> no label information at all (no security.selinux xattrs) or when they
>>> are completely untrusted to provide that information; the context
>>> specified by the mounter is the only basis for access control.  With
>>> overlay, we are frequently dealing with labeled lower and upper
>>> directories in a filesystem we trust.
>>>
>>> It seems like overlay has a goal of preventing the mounter from
>>> escalating its access through an overlay mount.
>>
>> Overlayfs main purpose is to bypass limited access to a read-only
>> filesystem by copying up on a write access.  So bypassing access is
>> built into the system, but it's done in a way that in the end it
>> doesn't permit mounter to do more than it could otherwise do.  Or at
>> least that's the intent, as you say.
>>
>> To generalize that, we could say:  trigger a copy-up if access to
>> lower layer object is denied.  That would extend the scope of the
>> trigger from write access on file/dir to read/write on special files
>> and execute on regular files, all of which could theoretically be
>> denied on the lower object, yet allowed on the upper object without
>> violating the above rule.
> 
> Possibly I misunderstood you, but I don't think we want to copy-up on 
> permission denial, as that would still allow the mounter to read/write 
> special files or execute regular files to which it would normally be 
> denied access, because the copy would inherit the context specified by 
> the mounter in the context mount case.  It still represents an 
> escalation of privilege for the mounter.  In contrast, the copy-up on 
> write behavior does not allow the mounter to do anything it could not do 
> already (i.e. read from the lower, write to the upper).

Also, copy-up in those cases might allow for device files that would 
normally be unusable due to nodev on the lower filesystem mount to 
become usable in the upper?  And likewise for executable files in a 
noexec lower mount?  Is that already an issue for nosuid?

> 
>>
>>>> I'd just like to see proper justification for why we should be doing
>>>> those checks on underlying layer that simply don't belong there, IMO.
>>>>    I'm sure you know better than I that it's not just about real bugs
>>>> affecting users, it's about having a clear, well defined model to base
>>>> the design on.   And by reverting the breaking commit, I don't see us
>>>> getting closer to that.
>>>
>>> It seems like the NFS folks raised a number of concerns with the overlay
>>> approach beyond just these two checks,
>>
>> The concerns that NFS folks had was that overlayfs does not enforce
>> permission checks (with creds of task) on underlying objects,
>> resulting in possibly elevated access compared to directly accessing
>> the NFS mount.    But I think there's no way to reconcile server
>> permission checks with overlayfs, so we are left with the current
>> model of only verifying the permission on the server against the
>> mounter's creds.
> 
> Typically this will only work if the NFS files are 
> world-readable/searchable, right, since usually the mounter will be root 
> and the server will enable root squash on the export?  Is that 
> sufficient for most use cases?
> 
>>
>>> and Android has their
>>> override_creds=off use case.  Maybe the overlay model needs a more
>>> significant rethinking than just these two cases.
>>
>> Yes, it would be good if that override_creds=off use case was
>> discussed.  AFAICS it trades less privilege in the mounter for more
>> privilege in the task accessing the overlay.  If, or how, that is a
>> good model for anything other than Android is not clear to me.
>>
>> Thanks,
>> Miklos
>>
> 

