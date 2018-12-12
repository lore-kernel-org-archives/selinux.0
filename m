Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555DFC65BAF
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A5D20870
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 14:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A5D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLOtl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:49:41 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:47572 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLLOtl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Dec 2018 09:49:41 -0500
X-EEMSG-check-008: 623516362|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,344,1539648000"; 
   d="scan'208";a="623516362"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2018 14:49:39 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539648000"; 
   d="scan'208";a="18642979"
IronPort-PHdr: =?us-ascii?q?9a23=3AeWF57h8iVtbR1/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0OIWIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
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
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnnVSsnzBrxvDcMb3lGZjNNGbMn6rhfb?=
 =?us-ascii?q?ln905Q0hY8zdda55hMELEOPOrzWlPttNzfFhI5Ng20w+XjCNV6zYMTQnmPA6?=
 =?us-ascii?q?6HP6PIr1CH++MvL/OMZI8IoDz9MeQq5+byjX8lnl8QZa6p3Z4QaHCjGPRpOV?=
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
 =?us-ascii?q?HRDAoSSp/xSFg4+AV6p77Afikx/Z/b1XppMfr8jjiX5dM3Ceht5RGxdtMXZL?=
 =?us-ascii?q?2LEx77F+UACsSuIfBskF+sOEEqJudXoZUoMtumev3O46uiOOJtjXrylmhcyJ?=
 =?us-ascii?q?xs2UKLsSxnQ6jH2IhTkKLQ5ReOSzqp1ATpicvwg40RIGhIRmc=3D?=
X-IPAS-Result: =?us-ascii?q?A2AQAQCsHxFc/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAQGBVAUpgWgng3uUK0wBAQEBAQEGgQgtiSGQLDgBhEACgnwiNwYNAQMBA?=
 =?us-ascii?q?QEBAQECAWwoQgEQAYFiJAGCYgEFIxU0CgMQCw4KAgImAgJXBg0GAgEBF4JHP?=
 =?us-ascii?q?4F1DaV0gS+FQIRvgQuLMRd4gQeBOIJrhDuDSoJXAokoggiEXDdRj3gJkVEGG?=
 =?us-ascii?q?IFciEOHJ5sbIoFWKwgCGAghD4MngicXjjshAzCBBQEBhT2FAYI+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Dec 2018 14:49:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBCEnP0R025358;
        Wed, 12 Dec 2018 09:49:26 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
 <20181204151549.GA21509@redhat.com> <20181204152248.GB21509@redhat.com>
 <CAJfpegtFVvq286HAorGLg6ywMsfs51KqaQwFkcuV7Dtu8TLaLg@mail.gmail.com>
 <20181204154243.GA16818@redhat.com>
 <665ec6f3-f16d-681f-30d5-eface14c9808@tycho.nsa.gov>
 <20181204161747.GC16818@redhat.com>
 <e8841bf0-d6b8-0e7d-6a35-055a06441d30@tycho.nsa.gov>
 <20181205134317.GA11337@redhat.com>
 <8eb7f677-fd71-c31b-bfed-29fb7187d132@tycho.nsa.gov>
 <20181211214821.GD17242@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2e4d90ce-61e7-56b1-c161-4e5fb7236537@tycho.nsa.gov>
Date:   Wed, 12 Dec 2018 09:51:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181211214821.GD17242@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/18 4:48 PM, Vivek Goyal wrote:
> On Thu, Dec 06, 2018 at 03:26:26PM -0500, Stephen Smalley wrote:
>> On 12/5/18 8:43 AM, Vivek Goyal wrote:
>>> On Tue, Dec 04, 2018 at 11:49:16AM -0500, Stephen Smalley wrote:
>>>> On 12/4/18 11:17 AM, Vivek Goyal wrote:
>>>>> On Tue, Dec 04, 2018 at 11:05:46AM -0500, Stephen Smalley wrote:
>>>>>> On 12/4/18 10:42 AM, Vivek Goyal wrote:
>>>>>>> On Tue, Dec 04, 2018 at 04:31:09PM +0100, Miklos Szeredi wrote:
>>>>>>>> On Tue, Dec 4, 2018 at 4:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>>>>>
>>>>>>>>> Having said that, this still create little anomaly when mknod to client
>>>>>>>>> is not allowed on context label. So a device file, which is on lower
>>>>>>>>> and client can not open it for read/write on host, it can now be opened
>>>>>>>>> for read/write because mounter will allow access. So why it is different
>>>>>>>>> that regular copy up. Well, in regular copy up, we created a copy of
>>>>>>>>> the original object and allowed writing to that object (cp --preserve=all)
>>>>>>>>> model. But in case of device file, writes will go to same original
>>>>>>>>> object. (And not a separate copy).
>>>>>>>>
>>>>>>>> That's true.
>>>>>>>>
>>>>>>>> In that sense copy up of special file should result in upper having
>>>>>>>> the same label as of lower, right?
>>>>>>>
>>>>>>> I guess that might be reasonable (if this behavior is a concern). So even
>>>>>>> after copy up, client will not be able to read/write a device if it was
>>>>>>> not allowed on lower.
>>>>>>>
>>>>>>> Stephen, what do you think about retaining label of lower for device
>>>>>>> files during copy up. What about socket/fifo.
>>>>>>
>>>>>> We don't check client task access to the upper inode label, only to the
>>>>>> overlay, right?  So the client is still free to access the device through
>>>>>> the overlay even if we preserve the lower inode label on the upper inode?
>>>>>> What do we gain?
>>>>>
>>>>> That's only with latest code and Miklos said he will revert it for 4.20.
>>>>>
>>>>> IOW, I am assuming that we will continue to check access to a file
>>>>> on upper in the context of mounter. Otherwise, client will be able to access
>>>>> files on upper/ which even mounter can't access.
>>>>
>>>> I was assuming we're talking about the proposed solution, where we check
>>>> client access to the overlay (unchanged), mounter access to lower
>>>> (unchanged), copy-up if denied (new), mounter access to upper (new in the
>>>> sense that previously we didn't copy-up on denials).
>>>>
>>>> In that situation, propagating the lower inode label to the upper inode only
>>>> impacts the mounter checks, and in that case makes copy-up pointless - if it
>>>> wasn't allowed to lower it won't be allowed to upper.  If it is allowed,
>>>> then client task is free to access the device regardless as long as it has
>>>> permissions to the overlay inode.  So I don't see what we gain by
>>>> propagating the lower inode label to the upper inode in the context mount
>>>> case, and it creates an inconsistency between special files and regular
>>>> ones.
>>>
>>> If we agree on retaining lower label of lower device file on copy up, then
>>> I am assuming we will change rule c) to copy up only non device files.
>>> (because if you don't have access on lower, you will not have access
>>> even after copy up).
>>>
>>> There are other paths where copy up happnes. Like link or when file
>>> metadata (ownership, permissions, timestmap) changes. In those cases,
>>> if we retain the lower label over copy up, it probably will help.
>>>
>>> IOW, just by creating a link to a device, one will not get access to
>>> a device on upper which could not be accessed on lower.
>>>
>>> Device files are special anyway. In regular files we are creating a
>>> copy and user writes to copy. But that's not the case with device
>>> files. So I guess these will have to be treated differently.
>>
>> I don't understand what you are suggesting.  In the case of a context mount,
>> the context specified by the mounter must be assigned to the upper inode for
>> any files that are copied up.  Otherwise, changes to file data or metadata
>> made through the overlay will be visible under two different security
>> contexts simultaneously: the context of the overlay inode (i.e. the one
>> specified by the mounter) and the context of the upper inode (in your
>> suggestion, the context from the lower inode). This allows a violation of
>> MAC policy where one can leak data through an overlay to an unauthorized
>> context.
> 
> Hi Stephen,
> 
> Sorry, I don't understand this point of leaking data through overlay. Even
> if we retain lower label on copy up (for device file), to open that file
> process should have access on overlay context label and then mounter needs
> to have access on upper inode (lower label). This is not different from
> opening a file on lower. Just that metadata of this file on upper might
> be different.
> 
> Can you elaborate a bit more on how this is leaking data through overlay
> mount. If it is, then why accessing file on lower is not equivalent of
> leaking of data.

In the container use case, retaining the lower label on copy-up for a 
context-mounted overlay permits a process in the container to leak the 
container data out to host files not labeled with the container label 
and thus potentially accessible to other containers or host processes. 
The container process appears to just be writing to files labeled with 
the container label via the overlay, but the written data and/or 
metadata is directly accessible through the lower label, which is likely 
readable to all/many containers and host processes.

In the multi-level security (MLS) use case, an analogy would a situation 
where you have an unclassified lower dir with some content to be shared 
read-only across all levels, and an overlay is context-mounted at each 
level with a corresponding upper dir and work dir private to that level. 
  If a client process at secret performs a write to a file via the 
secret overlay, and if the written data is stored in a file in the upper 
dir that inherits the label from the lower file (unclassified), then the 
secret process can leak data to unclassified processes at will, 
violating the MLS policy.

The difference with the lower is that it is read-only and the mounter is 
explicitly choosing to export it under the new context for reading (but 
not for writing).

As a side note, the actual checking during a context mount isn't as 
granular as we might like here, since there is no overlay-specific logic 
and thus no individual checking of the lower, upper, and work directory 
labels.
