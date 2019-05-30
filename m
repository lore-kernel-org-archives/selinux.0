Return-Path: <SRS0=hg1M=T6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E908C28CC0
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 16:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFEA25DA0
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gSpUTqIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfE3QcH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 May 2019 12:32:07 -0400
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:5593 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3QcG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 May 2019 12:32:06 -0400
X-EEMSG-check-017: 402848423|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 May 2019 16:29:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559233800; x=1590769800;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=w1KKEGPGfa36J6oYjL10sZwpwqRdzg6jwv+nJ6ch0cY=;
  b=gSpUTqIsaNwGvjLGQaxgzsw1GF7fYTQGXBu45REmuwlsihbGwROYvId9
   IrsAIc2oQkRrOHvwHgm9l2v3kKqlJKqIZ49sKCO/9JSgC6O4EJ3W2ycZf
   qOVk/6QaxKToKN37SqrtYZJEOC0qddT79a4TFZZ1MF6HULKAwuikjFHje
   WjV/SecyZ/NNwvOvdm3pltuldq7Wmcmk3LaPYHytD7Ye1U4VI3OB3mMqr
   fNqbt1/Q8bPW/VfS8XrANzDOfXLCphYtWXNTxCs8pHt1YBrWzeFwlgIo1
   APMuBH2M/5lDkcU35ME6wDT7qo6tzqiCHpCSQp8hOO/Ug7RqAnieRv7lo
   g==;
X-IronPort-AV: E=Sophos;i="5.60,531,1549929600"; 
   d="scan'208";a="24233314"
IronPort-PHdr: =?us-ascii?q?9a23=3Acx6iqhEVq76cPyIF3FSUeJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8W9bnLW6fgltlLVR4KTs6sC17OP9fm6CCdZuc/JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQi6oR/MusUIhYZuJbs9xg?=
 =?us-ascii?q?fUrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHBegCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSg0yroDuZ?=
 =?us-ascii?q?GhfSgKzowqxx3BZPyddYiH/BbjWPyWITdii3JpYL2/hxG18Uivzu3zSNK00F?=
 =?us-ascii?q?FXripfjtbDqGoB2ADU6siCTPZ240Sv2S6X2gzO5exJLlo4mKrGJ5I73LI9mY?=
 =?us-ascii?q?QfvV7eEiLwhU74lrWZdl8+9eit8+nnZ7LmqYKCOIJskQH+N7gumtS4AeQlLg?=
 =?us-ascii?q?gCR2ib9vq41L3k5UD5XK9Fjuc3kqnEq5DWP9gbp66lDA9V1YYv8RC/ACu90N?=
 =?us-ascii?q?sEh3UHKVNFeBafg4joPVHBPuz4AO+ij1mjnzpn3fDLMqD7DpnTIXXPjq3tca?=
 =?us-ascii?q?tl505Z0gUzzNRf55xOCrEGJfL+QlTxu8HDDhIiLwy1w/roCNV61o8EX2KPGb?=
 =?us-ascii?q?WWPLndsV+P+OIjO/OMa5MNuDbhN/gl4ObjjWU4mVABfammx4EXZ22gEft6O0?=
 =?us-ascii?q?qZYWDjgtYHEWgUpQozV/fliEGDUT5Ve3a9Qbg85jclB4K6F4vMWoetgLmZ1i?=
 =?us-ascii?q?ehApJWfnxGCkyLEXrwbIWLRfMMaCOUIs98nT0JTqahS4A/2hG0rgP6yKRoLv?=
 =?us-ascii?q?DS+iIGsZLvzt915/fclRsq7zx7E9yd032RT2Fzhm4JSCI23KZjrkx90FiD16?=
 =?us-ascii?q?d4judXFdxU4PNJXQM6OoDGw+NmDNDyXxrLfs2VR1a+XtWmHTYxQ8o3w98IYE?=
 =?us-ascii?q?ZwANqijhfE3yqlB78aiaaHC4Az8qLZjDDNIJNHyn3G3bMtx3kvQ81CLiXynK?=
 =?us-ascii?q?909wHJC7nCpEWQlqCnbowWwC/L6GqZy2eS+kpfVVg0Gb7IWXEZe1v+s9v0/A?=
 =?us-ascii?q?XBQqWoBLBhNRFOmuCYLa4fUcHklVVLQr/YPd3aZ2+g0zOrCQ2g2qKHbI2sfX?=
 =?us-ascii?q?4UmiraFh5XwEgo4X+aOF1mVW+aqGXEAWkrTAi+bg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CjAgChBPBc/wHyM5BlGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?mmBBCiEFJMCTwEBAQaBNYlQkQcJAQEBAQEBAQEBLQcBAgEBg3pGAoJ9IzgTA?=
 =?us-ascii?q?QMBAQEEAQEBAQMBAWwcDII6KQGCZwEFIxVBEAsYAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?wGBdhQPqieBL4QyAQsBgQiDK4FABoEMKItWF3iBB4ERJ4I9Lj6HToJYBIslI?=
 =?us-ascii?q?CoHh3WBJpNbCYIPghaEJYRLiBcGG4IhlDeMd4EphV6RECE3gSErCAIYCCEPO?=
 =?us-ascii?q?4JtEoIHAReDTYUUhVsjAzEBgQQBAY19AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 May 2019 16:29:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4UGTwph031197;
        Thu, 30 May 2019 12:29:58 -0400
Subject: Re: [PATCH 0/3] Update restorecon to support new digest scheme
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     xunchang@google.com, nnk@google.com
References: <20190522164240.3062-1-richard_c_haines@btinternet.com>
 <d508ca78-1166-be9b-7659-9def4728d991@tycho.nsa.gov>
 <cc26a91a5fb500e6c61131965920131782751880.camel@btinternet.com>
 <2a7c75b3-c0c4-0eee-fe6c-d47702ac91af@tycho.nsa.gov>
 <c56a4e4524b98db76c642714c9e4fd927458e3f8.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1d4e5554-27a9-1f56-a36c-862ec54ed400@tycho.nsa.gov>
Date:   Thu, 30 May 2019 12:29:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c56a4e4524b98db76c642714c9e4fd927458e3f8.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/30/19 12:22 PM, Richard Haines wrote:
> On Tue, 2019-05-28 at 10:24 -0400, Stephen Smalley wrote:
>> On 5/24/19 2:06 PM, Richard Haines wrote:
>>> On Fri, 2019-05-24 at 13:11 -0400, Stephen Smalley wrote:
>>>> On 5/22/19 12:42 PM, Richard Haines wrote:
>>>>> These patches require [1] and [2] be installed first. They have
>>>>> been implemented on Android and sent to the selinux list,
>>>>> however
>>>>> their
>>>>> merge has been deferred. They will install the core hashing of
>>>>> file_context entries and fix root stem processing.
>>>>>
>>>>> Patch 1/3 updates selinux_restorecon() replacing the per-
>>>>> mountpoint
>>>>> security.restorecon_last attribute with a per-directory
>>>>> security.sehash
>>>>> attribute computed from only those file contexts entries that
>>>>> partially
>>>>> match the directory. This is to avoid the need to walk the
>>>>> entire
>>>>> tree
>>>>> when any part of file_contexts changes, limiting relabels to
>>>>> only
>>>>> those
>>>>> parts of the tree that could have changed.
>>>>>
>>>>> One change is to add a new
>>>>> selabel_get_digests_all_partial_matches(3)
>>>>> function that is explained in the man page. This could replace
>>>>> the
>>>>> Android
>>>>> version of selabel_hash_all_partial_matches(3), that could then
>>>>> be
>>>>> converted into a local function (The Android team would need to
>>>>> approve).
>>>>
>>>> Has Android sorted out all of the ramifications of this change?
>>> As I'm not involved with Android I don't know. Note that as I do
>>> not
>>> change their core selabel code my new function could be added to
>>> libselinux and they pick it up if they want it (or it gets rejected
>>> by
>>> the SELinux team). I've added Nick to the cc list in case any
>>> comments.
>>>
>>> The main reason I added the function was the call retrieved the
>>> info in
>>> one go plus you did't need to know the digest length.
>>>
>>>>     What
>>>> about the triggering of CAP_SYS_ADMIN denials for setting the
>>>> security.sehash attribute?
>>> They solved this by adding the *_RESTORECON_SKIP_SEHASH flag that
>>> I've
>>> copied (the selinux-testsuite restorecon has tests for this).
>>
>> Per
>> https://android-review.googlesource.com/c/platform/external/selinux/+/940326,
>> they say:
>> "TODO: It would be better if the default for restorecon was to
>> suppress
>> the hash computation, since otherwise it encourages programs to be
>> overprivileged with CAP_SYS_ADMIN. I'll plan on doing that in a
>> followup
>> commit."
>>
>> So I think we would want to disable the setting of sehash by default
>> upstream to match their planned future behavior. In fact, I think
>> that
>> is how your version of setting security.restoreconlast worked
>> upstream
>> originally - the caller had to selabel_open() with options containing
>> a
>> SELABEL_OPT_DIGEST option with a non-zero value in order to enable
>> setting of a digest in the first place?  By the way, this patch set
>> seems to dispense with SELABEL_OPT_DIGEST and selabel_digest() usage
>> internally even though it leaves them defined, thereby changing
>> behavior
>> for existing API callers?
> I'll fix this in the next set of patches to follow the original idea of
> calling selabel_open to determine the behavior. However I see Android
> have abandoned these changes (I could not see the reason why).
> 
> I'm happy to continue if you think worthwhile.

I think they abandoned changes to revert these changes, i.e. they are 
actually keeping them.  I assume this means that they were going to 
revert them due to some bug (not accessible to us) but that they 
resolved that bug in some other way.

> 
> 
> [1]
> https://android-review.googlesource.com/c/platform/external/selinux/+/932005
> 
>>
>>>>> Patches 2/3 and 3/3 update restorecon, setfiles and
>>>>> restorecond.
>>>>>
>>>>> I will send a patch for the selinux-testsuite that will perform
>>>>> tests on
>>>>> the new code.
>>>>>     
>>>>> [1]
>>>>> https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/
>>>>> [2]
>>>>> https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/
>>>>>
>>>>> Richard Haines (3):
>>>>>      libselinux: Save digest of all partial matches for
>>>>> directory
>>>>>      setfiles: Update utilities for the new digest scheme
>>>>>      restorecond: Update to handle new digest scheme
>>>>>
>>>>>     libselinux/include/selinux/label.h            |   5 +
>>>>>     libselinux/include/selinux/restorecon.h       |  17 +-
>>>>>     .../selabel_get_digests_all_partial_matches.3 |  70 +++++
>>>>>     libselinux/man/man3/selinux_restorecon.3      |  91 +++---
>>>>>     .../man3/selinux_restorecon_default_handle.3  |   9 +-
>>>>>     .../man/man3/selinux_restorecon_xattr.3       |  11 +-
>>>>>     libselinux/src/label.c                        |  15 +
>>>>>     libselinux/src/label_file.c                   |  51 ++++
>>>>>     libselinux/src/label_file.h                   |   4 +
>>>>>     libselinux/src/label_internal.h               |   5 +
>>>>>     libselinux/src/selinux_restorecon.c           | 267
>>>>> +++++++++++
>>>>> -------
>>>>>     libselinux/utils/.gitignore                   |   1 +
>>>>>     .../selabel_get_digests_all_partial_matches.c | 170
>>>>> +++++++++++
>>>>>     policycoreutils/setfiles/restore.c            |   7 +-
>>>>>     policycoreutils/setfiles/restore.h            |   2 +-
>>>>>     policycoreutils/setfiles/restorecon.8         |  10 +-
>>>>>     policycoreutils/setfiles/restorecon_xattr.8   |  19 +-
>>>>>     policycoreutils/setfiles/restorecon_xattr.c   |  66 +----
>>>>>     policycoreutils/setfiles/setfiles.8           |  10 +-
>>>>>     policycoreutils/setfiles/setfiles.c           |  19 +-
>>>>>     restorecond/restore.c                         |   8 +-
>>>>>     restorecond/restore.h                         |   2 +-
>>>>>     restorecond/restorecond.c                     |   5 +-
>>>>>     23 files changed, 593 insertions(+), 271 deletions(-)
>>>>>     create mode 100644
>>>>> libselinux/man/man3/selabel_get_digests_all_partial_matches.3
>>>>>     create mode 100644
>>>>> libselinux/utils/selabel_get_digests_all_partial_matches.c
>>>>>
> 

