Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C67AC04AB6
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30ED20645
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VU26CRHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfE1OYI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 10:24:08 -0400
Received: from usfb19pa15.eemsg.mail.mil ([214.24.26.86]:48527 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfE1OYI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 10:24:08 -0400
X-EEMSG-check-017: 215483403|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 May 2019 14:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559053446; x=1590589446;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E6cVLMkSY9AuJRyw0mI2h3e72ywUdMSFwUBc1EK6E2c=;
  b=VU26CRHrcFpn7rV25fDF5MvVUuN6r81VExXx37SEdJURlvzFsrtAsqrB
   L8ljtp69B2skORDFMCCmKtzI1C4zwg/PVtJhqX5ZYtlGiFhyHExxxXHA/
   dvBWL+N6bBox9e8Jj9n/voI2nF+qK9bDT1oT4UUAyxidIF/VShVZlx5nU
   2M0AESDogHijml3Ti571tmpnAIyre2rtGLV8EB8RFBTvK259QvZ42CXXH
   gU/Icgkhb2q/46vmo9Jw4gcDK2Pii/7Nm4IG6VCDnMPSxYk+CgrUBTrP0
   Mq66Vc+oL0hPNKoe9CtwfQUOfyQ+Z6GlR8233T40EAFKLnDjJjvNQG+Dl
   w==;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="28216340"
IronPort-PHdr: =?us-ascii?q?9a23=3AUdGyvBDBkJmhpft9nnIbUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37rsiwAkXT6L1XgUPTWs2DsrQY0rOQ6vq9EjNbqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5vIBmssAndqMkbjYRgJ6s/1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoQW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAJyJs53R7fbeKIc4yS7hLkTuaRLi90hH1ieLK4iBay9Vavyvb7Vsmpyl?=
 =?us-ascii?q?ZFsjRKnsPQuXAK0hze7NWMRPhl/kq5xDqC2A/e5vtELEwpj6bXNZEszqAqmp?=
 =?us-ascii?q?YOt0nIAzX4l1/sjKCMc0Up4u2o6+P6bbr4vpKcLIp0ih3mMqQph8y/Hfw0Mg?=
 =?us-ascii?q?gQUGif/uSxzKHj8lfjQLVLk/02ibPVsIzaJMsHpq65BBVZ0oA/5BakEziqyt?=
 =?us-ascii?q?EYnXgDLF5deRKHiZbmO03WLfzlAvqyjE6gnTd2y/zcILHsDYvBImLenLv5eL?=
 =?us-ascii?q?Zy8U9cyA49zdBF4JJUD6kMIOnuVU/qr9HYEh84PBC0w+bgEtl90JgeVniVDq?=
 =?us-ascii?q?+WN6PSr0eE5vgzLOmUeI8VpDH9JuA/5/7vkXA5mUUSfbO00pQPdH+3BvRmLF?=
 =?us-ascii?q?+YYXrqnNgBCnwHsREiTOzrjl2CTSBcZ2y0X60i+jE3Ep6pDYDGRoq1mryOwD?=
 =?us-ascii?q?+7HoFKZmBBEl2MCmnnd4GFW/cKdSKTLdRskiILVbe/UY8tzxKuuxHgy7phMO?=
 =?us-ascii?q?XU/jcUtZX51Nh6/+fTjw099SRoD8SB1GGAV251nn4ORzAq3KBwu0p9yliY3K?=
 =?us-ascii?q?h3hPxYEtNT5/dXXQsgKZHcyOl6AcjoWg3dZteJVEqmQtK+DDE3SNIxwMQDY0?=
 =?us-ascii?q?l6G9WlgRDD2zSlD6UJmLyMAZxnup7bikLwLMZ00XqO9KAgiVQ9Cp9VNGamj7?=
 =?us-ascii?q?RzwAPkB4fIlUiCv6y2dKIA0TTL+XvFxm2L6gUQSwN0UKPYTVgBaUbM69f0/E?=
 =?us-ascii?q?XPS/mpE7t0HBFGzJu5NqZSatDvxW5DTfPnNcWWN3m9gE+sFB2IwfWKd4OsdG?=
 =?us-ascii?q?IDinaOQHMYmhweqC7VfTM1AT2s9ieHVm1j?=
X-IPAS-Result: =?us-ascii?q?A2ByAACZQ+1c/wHyM5BlGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?QGBZYFnKmlSMiiEE5NdAQEBAQEBBoE1iU+RBQkBAQEBAQEBAQEtBwECAQGDe?=
 =?us-ascii?q?kYCgmMjOBMBAwEBAQQBAQEBAwEBbBwMgjopAYJnAQUjFUEQCxgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYF2FA+ofoEvhDIBCwGBCIMdgUAGgQwoi1MXeIEHgREngj0uP?=
 =?us-ascii?q?odOglgEiyAgKgeHbIElk1EJgg+CEoQihEiIEwYbgh+UKoxugSiFWpEEITaBI?=
 =?us-ascii?q?SsIAhgIIQ87gm0SggcBF4NNhRSFWyMDMQGBBAEBjg4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 May 2019 14:24:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4SEO32g010700;
        Tue, 28 May 2019 10:24:03 -0400
Subject: Re: [PATCH 0/3] Update restorecon to support new digest scheme
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     xunchang@google.com, nnk@google.com
References: <20190522164240.3062-1-richard_c_haines@btinternet.com>
 <d508ca78-1166-be9b-7659-9def4728d991@tycho.nsa.gov>
 <cc26a91a5fb500e6c61131965920131782751880.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2a7c75b3-c0c4-0eee-fe6c-d47702ac91af@tycho.nsa.gov>
Date:   Tue, 28 May 2019 10:24:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cc26a91a5fb500e6c61131965920131782751880.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/24/19 2:06 PM, Richard Haines wrote:
> On Fri, 2019-05-24 at 13:11 -0400, Stephen Smalley wrote:
>> On 5/22/19 12:42 PM, Richard Haines wrote:
>>> These patches require [1] and [2] be installed first. They have
>>> been implemented on Android and sent to the selinux list, however
>>> their
>>> merge has been deferred. They will install the core hashing of
>>> file_context entries and fix root stem processing.
>>>
>>> Patch 1/3 updates selinux_restorecon() replacing the per-mountpoint
>>> security.restorecon_last attribute with a per-directory
>>> security.sehash
>>> attribute computed from only those file contexts entries that
>>> partially
>>> match the directory. This is to avoid the need to walk the entire
>>> tree
>>> when any part of file_contexts changes, limiting relabels to only
>>> those
>>> parts of the tree that could have changed.
>>>
>>> One change is to add a new
>>> selabel_get_digests_all_partial_matches(3)
>>> function that is explained in the man page. This could replace the
>>> Android
>>> version of selabel_hash_all_partial_matches(3), that could then be
>>> converted into a local function (The Android team would need to
>>> approve).
>>
>> Has Android sorted out all of the ramifications of this change?
> As I'm not involved with Android I don't know. Note that as I do not
> change their core selabel code my new function could be added to
> libselinux and they pick it up if they want it (or it gets rejected by
> the SELinux team). I've added Nick to the cc list in case any comments.
> 
> The main reason I added the function was the call retrieved the info in
> one go plus you did't need to know the digest length.
> 
>>    What
>> about the triggering of CAP_SYS_ADMIN denials for setting the
>> security.sehash attribute?
> They solved this by adding the *_RESTORECON_SKIP_SEHASH flag that I've
> copied (the selinux-testsuite restorecon has tests for this).

Per 
https://android-review.googlesource.com/c/platform/external/selinux/+/940326, 
they say:
"TODO: It would be better if the default for restorecon was to suppress
the hash computation, since otherwise it encourages programs to be
overprivileged with CAP_SYS_ADMIN. I'll plan on doing that in a followup
commit."

So I think we would want to disable the setting of sehash by default 
upstream to match their planned future behavior. In fact, I think that 
is how your version of setting security.restoreconlast worked upstream 
originally - the caller had to selabel_open() with options containing a 
SELABEL_OPT_DIGEST option with a non-zero value in order to enable 
setting of a digest in the first place?  By the way, this patch set 
seems to dispense with SELABEL_OPT_DIGEST and selabel_digest() usage 
internally even though it leaves them defined, thereby changing behavior 
for existing API callers?

> 
>>
>>> Patches 2/3 and 3/3 update restorecon, setfiles and restorecond.
>>>
>>> I will send a patch for the selinux-testsuite that will perform
>>> tests on
>>> the new code.
>>>    
>>> [1]
>>> https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/
>>> [2]
>>> https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/
>>>
>>> Richard Haines (3):
>>>     libselinux: Save digest of all partial matches for directory
>>>     setfiles: Update utilities for the new digest scheme
>>>     restorecond: Update to handle new digest scheme
>>>
>>>    libselinux/include/selinux/label.h            |   5 +
>>>    libselinux/include/selinux/restorecon.h       |  17 +-
>>>    .../selabel_get_digests_all_partial_matches.3 |  70 +++++
>>>    libselinux/man/man3/selinux_restorecon.3      |  91 +++---
>>>    .../man3/selinux_restorecon_default_handle.3  |   9 +-
>>>    .../man/man3/selinux_restorecon_xattr.3       |  11 +-
>>>    libselinux/src/label.c                        |  15 +
>>>    libselinux/src/label_file.c                   |  51 ++++
>>>    libselinux/src/label_file.h                   |   4 +
>>>    libselinux/src/label_internal.h               |   5 +
>>>    libselinux/src/selinux_restorecon.c           | 267 +++++++++++
>>> -------
>>>    libselinux/utils/.gitignore                   |   1 +
>>>    .../selabel_get_digests_all_partial_matches.c | 170 +++++++++++
>>>    policycoreutils/setfiles/restore.c            |   7 +-
>>>    policycoreutils/setfiles/restore.h            |   2 +-
>>>    policycoreutils/setfiles/restorecon.8         |  10 +-
>>>    policycoreutils/setfiles/restorecon_xattr.8   |  19 +-
>>>    policycoreutils/setfiles/restorecon_xattr.c   |  66 +----
>>>    policycoreutils/setfiles/setfiles.8           |  10 +-
>>>    policycoreutils/setfiles/setfiles.c           |  19 +-
>>>    restorecond/restore.c                         |   8 +-
>>>    restorecond/restore.h                         |   2 +-
>>>    restorecond/restorecond.c                     |   5 +-
>>>    23 files changed, 593 insertions(+), 271 deletions(-)
>>>    create mode 100644
>>> libselinux/man/man3/selabel_get_digests_all_partial_matches.3
>>>    create mode 100644
>>> libselinux/utils/selabel_get_digests_all_partial_matches.c
>>>
> 

