Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B840C43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3596F20868
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3596F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeK3DUY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:20:24 -0500
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:8136 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeK3DUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 22:20:23 -0500
X-EEMSG-check-008: 183544673|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Nov 2018 16:14:23 +0000
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="21144898"
IronPort-PHdr: =?us-ascii?q?9a23=3Add38vxAVdkE8qosqF5JqUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP34r8+wAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS9ux/DHPb3hBpLNLmPYnbf6fL?=
 =?us-ascii?q?dy9VRcxxQuwtBe/Z5UCqwBKurpWkDtrNzYEgM5Mwuszub5B9V90YMfVniLAq?=
 =?us-ascii?q?KCKqPdr0KH5uI1LOmQfoMapDH9K/097f70kXA5gUMdfbWu3ZYPb3C4G/NmI1?=
 =?us-ascii?q?6fYXX2ntgOD3wHvhAgQ+P3iF2NSyJTa2yuUKI74zExEJimApvbRoCxnLyB2z?=
 =?us-ascii?q?+2EYZYZmBHFF+MFWrnd56fVvcCaSKdPMthnSEfVbe/UI8tzxautBX1y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTjgs99Th0DsWc02CNSXp5kXkORzArxqB/pk19xUqZ3a?=
 =?us-ascii?q?dkhPxYEMRZ5+lVXQciKZ7c0+t6BsjqWg3bY9eJTE2rQs28DjEsStI92toOY0?=
 =?us-ascii?q?F6G9W4kB/PxTalA7gQl7aTHpw77rrc32TtJ8Z603vG0Kghj187QspALGGmhb?=
 =?us-ascii?q?Bw9xLVB4HXl0WUjLiqdasC0y7X7muDznSBvFteUAFuVaXJR3cfZlHZrd7h/E?=
 =?us-ascii?q?PNU6euCag7MgtG0cOCLqpKatv0jVRJXfvjJdLeY2O2m2e2CxaI3aiBbJTle2?=
 =?us-ascii?q?oDxiXREksEnB4J/XaAKwc+Aj2to2XEDDxhDVjveV/j8fFiqHOnSU851wWKb0?=
 =?us-ascii?q?xn17qo9R8ZnPKcS+gO0b0apicutTF0EU2j39LZFdWAvRBtfKZCbtMn5ldIy2?=
 =?us-ascii?q?bZuxZ6Ppy6IKBonkQefBhvv0PyyxV3DZ1NkdM0o3MuzQpyL7+Y0VxaejOG0p?=
 =?us-ascii?q?D/JKfXJnPx/B+xca7W3E/R0NKM9qcI8vQ4pE3pvBu1GUo673Vnz95V3mOB6Z?=
 =?us-ascii?q?TEFgUSVYnxUkYs+hhgub7Vfyk96JnI1XF2Laa0tTrCiJoVA74AyxWkeMwXC7?=
 =?us-ascii?q?GJDgL+EoVOAsmtLOsxs0O7YwgJMOEU9LNibO28cP7T47KmJOZtmnqdiG1D5I?=
 =?us-ascii?q?1smhaX+zFUVv/D35FDxeqRmASASWGv3x+arsnrlNUcNnkpFW2lxH2hXdQJaw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BvAgDkDwBc/wHyM5BkHAEBAQQBAQcEAQGBZYFbKYE1M?=
 =?us-ascii?q?yeDeZQgTAEBAQEBAQaBCC2JHpAgOAGEQAKDMiI4EgEDAQEBAQEBAgFsKII2J?=
 =?us-ascii?q?AGCYQEBAQECASMVQRALGAICJgICVwYNBgIBAYJeP4F1BQimPoEvhUCEa4ELi?=
 =?us-ascii?q?wsXeIEHgTiCa4Q7HxEWgwSCVwKJFoIDhFE0UI81CZEsBhiBWog0hw6aKyGBV?=
 =?us-ascii?q?SsIAhgIIQ+DJ5B5IQMwgQUBAYptDxeCJwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Nov 2018 16:14:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wATGEHfw018238;
        Thu, 29 Nov 2018 11:14:17 -0500
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
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
Date:   Thu, 29 Nov 2018 11:16:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/29/18 6:04 AM, Miklos Szeredi wrote:
> On Wed, Nov 28, 2018 at 10:43 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 11/28/18 3:24 PM, Miklos Szeredi wrote:
>>> On Wed, Nov 28, 2018 at 8:32 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> [...]
> 
>>>> Does the breaking commit (007ea44892e6) fix a real bug affecting users?
>>>>     If not, I'd recommend just reverting it.
>>>
>>> That is certainly an option, but...  this is all about context=
>>> mounts, right?  Which allows mounter to override MAC checks under the
>>> new mount?  On any mount, not just overlay, right?  So why is overlay
>>> special?
>>
>> With other filesystems, the files are only accessible under the context
>> specified by the mounter (and you can't mount it twice with differing
>> context mount options). With overlay, the file is simultaneously
>> accessible under both the context specified by the mounter via the
>> overlay and under its lower/upper context via the lower/upper dir.
>>
>> Generally we only use context mounts on other filesystems when they have
>> no label information at all (no security.selinux xattrs) or when they
>> are completely untrusted to provide that information; the context
>> specified by the mounter is the only basis for access control.  With
>> overlay, we are frequently dealing with labeled lower and upper
>> directories in a filesystem we trust.
>>
>> It seems like overlay has a goal of preventing the mounter from
>> escalating its access through an overlay mount.
> 
> Overlayfs main purpose is to bypass limited access to a read-only
> filesystem by copying up on a write access.  So bypassing access is
> built into the system, but it's done in a way that in the end it
> doesn't permit mounter to do more than it could otherwise do.  Or at
> least that's the intent, as you say.
> 
> To generalize that, we could say:  trigger a copy-up if access to
> lower layer object is denied.  That would extend the scope of the
> trigger from write access on file/dir to read/write on special files
> and execute on regular files, all of which could theoretically be
> denied on the lower object, yet allowed on the upper object without
> violating the above rule.

Possibly I misunderstood you, but I don't think we want to copy-up on 
permission denial, as that would still allow the mounter to read/write 
special files or execute regular files to which it would normally be 
denied access, because the copy would inherit the context specified by 
the mounter in the context mount case.  It still represents an 
escalation of privilege for the mounter.  In contrast, the copy-up on 
write behavior does not allow the mounter to do anything it could not do 
already (i.e. read from the lower, write to the upper).

> 
>>> I'd just like to see proper justification for why we should be doing
>>> those checks on underlying layer that simply don't belong there, IMO.
>>>    I'm sure you know better than I that it's not just about real bugs
>>> affecting users, it's about having a clear, well defined model to base
>>> the design on.   And by reverting the breaking commit, I don't see us
>>> getting closer to that.
>>
>> It seems like the NFS folks raised a number of concerns with the overlay
>> approach beyond just these two checks,
> 
> The concerns that NFS folks had was that overlayfs does not enforce
> permission checks (with creds of task) on underlying objects,
> resulting in possibly elevated access compared to directly accessing
> the NFS mount.    But I think there's no way to reconcile server
> permission checks with overlayfs, so we are left with the current
> model of only verifying the permission on the server against the
> mounter's creds.

Typically this will only work if the NFS files are 
world-readable/searchable, right, since usually the mounter will be root 
and the server will enable root squash on the export?  Is that 
sufficient for most use cases?

> 
>> and Android has their
>> override_creds=off use case.  Maybe the overlay model needs a more
>> significant rethinking than just these two cases.
> 
> Yes, it would be good if that override_creds=off use case was
> discussed.  AFAICS it trades less privilege in the mounter for more
> privilege in the task accessing the overlay.  If, or how, that is a
> good model for anything other than Android is not clear to me.
> 
> Thanks,
> Miklos
> 

