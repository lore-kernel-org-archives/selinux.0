Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B75C65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE520851
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 20:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YjhyM33a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDE520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeLMUHe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:07:34 -0500
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:37091 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeLMUHe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 15:07:34 -0500
X-EEMSG-check-008: 366291820|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2018 20:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1544731647; x=1576267647;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ezyFq6rPAhHz0ngCML6yS41EBOx9kefNc0C0oUkiEh0=;
  b=YjhyM33asE/1xGx6PKlK8/1EUm1BhtnaR5ibiSk7yvYhMBiTMhlqzKAG
   wSTw9vslwBXjGp4ZB0dJ7rfN56l5EFQl9sWgso6A6eOdw3sZuFOXhV3yY
   Gv/m6CIhqgJcsbwm9CD9GWgk8l8AUd+CkrHkpnK5iW53+fSILyR8zCvUU
   6ViSMtskFpLXw2DdpPxcNKM86235/92ke34BPk/ZXFRBNfhM9JCUVeDOb
   1kphF/v8oqJ+RQWCjwo847Z0Ruv2xY6QmhWFSAaqPJWn88RFnw9bgqKY4
   Wpm8/0bCk/zZgizZWdqmiPf3O9lBResNNk/2qAgGmd4qRBy7fOcGmEd/o
   A==;
X-IronPort-AV: E=Sophos;i="5.56,349,1539648000"; 
   d="scan'208";a="18698803"
IronPort-PHdr: =?us-ascii?q?9a23=3Ad7zfrhKJfJk1Iq4aHNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKfT7rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0jjdryPfGP737DZXJNXXDiqnucq?=
 =?us-ascii?q?t960FG1Ao/18xQ55VRCrsZOvL8RlfxtMDEDh8+KwG0xufnCNZ51oMZQmKCGb?=
 =?us-ascii?q?SZMaLMvl+S+O0gPuiMaJUVuDbgM/Il/eLhjWclmV8BeqmkxZwXaHW/HvR9JU?=
 =?us-ascii?q?WWe2bjjckaHGcQoAUxUezqh0eeUTJJe3myWKc87CkhCI26FYfDWpytgLuZ0S?=
 =?us-ascii?q?igEJ1WZ35JClSRHnfzbIiEVfYMZzyWIsB8iTwLS6OhR5Um1RG0uw/w06BnIf?=
 =?us-ascii?q?bM+i0EqZLj08B45/bJmhE29T11DsSc02eWQm5umGMHWiU23Kd+oUNg0FuMza?=
 =?us-ascii?q?94g/lAH9xJ+/xJShs6NYLbz+FiE9D9QB/BftOSRVa+WNqmHDUxQss0w98JZE?=
 =?us-ascii?q?Z9Acutggrf0CqtBr8fj6aLC4As8qLAw3jxIN5wy3LH1KknklknTdJDNW64ia?=
 =?us-ascii?q?5l8QjcGYrJnl6Hl6ala6scxjTB9GSdwmqUukFXTgpwXb/CXXAFaUvctc756V?=
 =?us-ascii?q?/aT7+yFbQnNRNMycqDKqtMd93ogkxKROrlONTfZGKxnWmwBQ2Ty7OSY4rlZX?=
 =?us-ascii?q?8d0D/eCEcaiQAT+2iJNQwkCiemuWLeAyRkFUjzbEP07el+tHS7Q1cwzwGLaU?=
 =?us-ascii?q?1hyrW09gcbhfyHVvwcwKwEtzklqzhvAla90MzZC8CaqwpiYqpce9U970lD1W?=
 =?us-ascii?q?7DsAx9JJOgJbh4hlECawR3o1/u1xJvB4Vbj8cqqHIqzAxvKaOXy15BaTyY0o?=
 =?us-ascii?q?7qOrHNKWn94gqva6jI1VHaytqW/b0P6PsgoVX5oA6pDlYi82lg09RNznSd6I?=
 =?us-ascii?q?/FDA4JUZLxSUs37QZ1qKzaYiYn+4PYz2FjMa6xsmyK59V8Ouo7xxXoUNBOOa?=
 =?us-ascii?q?fMQBH9FNwTA+C0JeAqkkTvZRUBarN87qkxavi6euOG1ajjB+NpmDarnCwT+4?=
 =?us-ascii?q?xm+l6d/Cp7DOjT1tAKxO/OjVjPbCv1kFr06pO/ootDfzxHWzPlkSU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BOAACPuxJc/wHyM5BjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYFohCOUK0wBAQEBAQEGgQgIJYkhkC04AYRAAoMDIjcGDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsKII2JAGCYgEFIxVBEAsOCgICJgICVwYNCAEBgl4/gXQNqF2BL4VAh?=
 =?us-ascii?q?HCBC4sxF3iBB4ERJwyCX4Q7g0qCVwKJO4F3hFw3kEoJkVMGGIFciEaHKJslI?=
 =?us-ascii?q?oFWKwgCGAghD4MokHghA4E1AQGKBII+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2018 20:07:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBDK7M9Q026064;
        Thu, 13 Dec 2018 15:07:24 -0500
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
References: <20181204154243.GA16818@redhat.com>
 <665ec6f3-f16d-681f-30d5-eface14c9808@tycho.nsa.gov>
 <20181204161747.GC16818@redhat.com>
 <e8841bf0-d6b8-0e7d-6a35-055a06441d30@tycho.nsa.gov>
 <20181205134317.GA11337@redhat.com>
 <8eb7f677-fd71-c31b-bfed-29fb7187d132@tycho.nsa.gov>
 <20181211214821.GD17242@redhat.com>
 <2e4d90ce-61e7-56b1-c161-4e5fb7236537@tycho.nsa.gov>
 <20181213145813.GB4384@redhat.com>
 <846eb23e-1188-9e45-ee0a-676d26cc715e@tycho.nsa.gov>
 <20181213185456.GC4384@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6de7d35e-9ee7-5324-86d0-e0e42c6a6d29@tycho.nsa.gov>
Date:   Thu, 13 Dec 2018 15:09:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181213185456.GC4384@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/18 1:54 PM, Vivek Goyal wrote:
> On Thu, Dec 13, 2018 at 11:12:31AM -0500, Stephen Smalley wrote:
> 
> [..]
>>>>> Can you elaborate a bit more on how this is leaking data through overlay
>>>>> mount. If it is, then why accessing file on lower is not equivalent of
>>>>> leaking of data.
>>>>
>>>> In the container use case, retaining the lower label on copy-up for a
>>>> context-mounted overlay permits a process in the container to leak the
>>>> container data out to host files not labeled with the container label and
>>>> thus potentially accessible to other containers or host processes.
>>>
>>>> The
>>>> container process appears to just be writing to files labeled with the
>>>> container label via the overlay, but the written data and/or metadata is
>>>> directly accessible through the lower label, which is likely readable to
>>>> all/many containers and host processes.
>>>>
>>>> In the multi-level security (MLS) use case, an analogy would a situation
>>>> where you have an unclassified lower dir with some content to be shared
>>>> read-only across all levels, and an overlay is context-mounted at each level
>>>> with a corresponding upper dir and work dir private to that level.  If a
>>>> client process at secret performs a write to a file via the secret overlay,
>>>> and if the written data is stored in a file in the upper dir that inherits
>>>> the label from the lower file (unclassified), then the secret process can
>>>> leak data to unclassified processes at will, violating the MLS policy.
>>>
>>> For the case of devices, its already happening. One might change metadata
>>> of a device (hence trigger copy up). Now all writes to upper device file
>>> from secret process still go to same underlying device and are still
>>> readable from lower device file.
>>
>> This is an argument for not copying up device files IMHO, not for preserving
>> the lower label on them.
> 
> How do we handle metadata change to device node (like timestamp, ownership
> change) without copy up.

Do we need to support such metadata changes to device nodes through an 
overlay mount?  Is that required for some legitimate purpose (and if so, 
what is the use case?)?  If not, just deny it up front.  Much simpler 
and no potential for a leak.
