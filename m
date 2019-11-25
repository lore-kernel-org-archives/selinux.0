Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4595C432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 13:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6FF2075C
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 13:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="STjRiZV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKYNX7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:23:59 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:60502 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYNX7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 08:23:59 -0500
X-EEMSG-check-017: 51733866|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,241,1571702400"; 
   d="scan'208";a="51733866"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Nov 2019 13:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574688237; x=1606224237;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=/BazuOf3bbzTC8AkJJi6VuEVCESIx5K9VXWU+KuXFNU=;
  b=STjRiZV47tlcKJkvon3fmiukjkCsgvAspNal+su/vzOmq/BAwQnFVUEM
   0CeIOXpJRqFsAEs2LMPYb0miA79ZL2aq4xe1O4RB3+SJmLjJ3aqVHkCgP
   /FOCS0zxX9a+tyOaEa08YbNvNDbtNYOGUt4OzZfeLW7x5p8xDhwUassY6
   PlLBE8u/hmSaQ+6iRjJ+RExgKS3z+QgbNjT85XAnlgwJotrDuqjrkbHop
   ejztPzXMtdef82aAh5s/YVQsYu9AdEwUYmqRgC9eK3XqveDGi7y6nksfC
   34pksp8NHhsnoqiedLmBznAsoLF1bML9fU4bs4H5A2WnQvd2zuXdgHUNY
   g==;
X-IronPort-AV: E=Sophos;i="5.69,241,1571702400"; 
   d="scan'208";a="30457224"
IronPort-PHdr: =?us-ascii?q?9a23=3APvvezRUFZfeUCFt1lYjFhhNjsSnV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBOFt8tkgFKBZ4jH8fUM07OQ7/m7HzVeuN3c6DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIp/Jqo+yh?=
 =?us-ascii?q?bFvmZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfp6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZH42ycYUPAeoCM+hWoYbyqFkBogexCwS3GOPiyCVFimPq0aA00e?=
 =?us-ascii?q?ksFxzN0gw6H9IJtXTZtMj7NLsMXuCtzKnH0zPDZO5L1zf48ofIdhQhru+MXL?=
 =?us-ascii?q?ltdsfR0lQgFxjeg1WMqY3qIzOV1uMXv2id9OpvT/iji2EgqwFvuzWiwNonhI?=
 =?us-ascii?q?rRho8N11zJ+ip0zJw1KNGlUkJ3f9GpHIVKuy2HMYZ9X9ksTHtyuCkgz70LoZ?=
 =?us-ascii?q?u7fC8Xx5s53xPfcPmHc5SQ4hLkSeaRPS90hHJ7d7K7gBa/6VSgxffmVsm1zV?=
 =?us-ascii?q?ZKtTBJktjKtnAD0BzT8daIRedn8ke92TeAywDT6uZeLUAyiaXbMIIuzqQ1lp?=
 =?us-ascii?q?oStUTPBi72mEPog6+Kbkgo5+el5uv9brjmu5OQLZF4hw7gPqg0h8CzGeE4PR?=
 =?us-ascii?q?IPX2if9+S8zrrj/UjhTbVRk/I2ibLUsIzaJMsHpq65BBVZ0oA46xmlFTum39?=
 =?us-ascii?q?MYnWcfIFJfZB2Hl5TpO03JIP3gEPiwmUijnC1sx/DYILLhGI/NLnnen7j/Zr?=
 =?us-ascii?q?t95EtcxxAyzdBb/Z5bFrYBIPfrUE/rqNPYFgM5MxCzw+v/E9VyyIceWWOJAq?=
 =?us-ascii?q?+EP6LfqkGI5u0xLOmWfoMVuyjyK+Ij5/HwiX81g1gdfbOm3chfVHftMvNjIk?=
 =?us-ascii?q?OYanmkrc0AH3tC6gY3R6rtllCYSz9fal69Wqs94ncwD4fwSc/YS4SshqGR9D?=
 =?us-ascii?q?m0E4cQZW1cDF2IV3DyeNaqQfAJPRmOL9dhnzpMbr2oT4ssxFn6rwPh46Z2Je?=
 =?us-ascii?q?rTvCsDvNTs08YjtL6brg076TEhV5fV6GqKVWwh2z5ZSg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AfAQBX1Ntd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gWwBIBKEVYkDhlABAQEBAQEGgTeJaY9dgWcJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACglI4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJuAQEBAQIBIxVRCw4KAgImA?=
 =?us-ascii?q?gJXBgEMCAEBgl8/glMFIK9ddYEyhU+DMoFIgQ4ogRKLHniBB4ERJw+CXT6EM?=
 =?us-ascii?q?YMogl4EjViJCUaHW45CboI1gjiTFgYbkQaJFo5Ilw2FFCKBWCsIAhgIIQ+DK?=
 =?us-ascii?q?E8RFJUsIwOOfQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Nov 2019 13:23:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAPDPfKm146520;
        Mon, 25 Nov 2019 08:25:41 -0500
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
To:     Dominick Grift <dac.override@gmail.com>, selinux@vger.kernel.org
References: <20191123144245.3079306-1-dac.override@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
Date:   Mon, 25 Nov 2019 08:24:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191123144245.3079306-1-dac.override@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/23/19 9:42 AM, Dominick Grift wrote:
> In 2008 support for UserPrefix was removed from Reference policy.
> The code to support this functionality in libsepol and libsemanage however remained albeit slightly modified.
> I am not sure why it was not fully removed.
> 
> DefaultRole replaces UserPrefix functionality but the code in libsepol and libsemanage was only slighty adjusted to accomodate my use-case.
> This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016).
> I do not use semanage and I do not mind using the old UserPrefix statement, but there is some confusion.
> For example there was a report recently about how semanage does not document UserPrefix.
> The documentation was likely removed from view because UserPrefix is no longer supported as such.
> 
> I want to make the situation better and this proposal is the next phase.
> This proposal causes some disruption as Reference policy based policy often calls the gen_user() macro with the "user" prefix.
> 
> Example: gen_user(user_u, user, user_r, s0, s0)
> 
> This will no longer be valid, and the userprefix parameter in gen_user() can be left empty (or needs a valid role if RBACSEP DefaultRole is leveraged).
> 
> Example: gen_user(user_u,, user_r, s0, s0)
> 
> UserPrefix will now default to object_r. This should not affect common policy implementations.
> 
> The next phases will be:
> 
> Renaming the UserPrefix statement to UserRBACSEPRole, and renaming references to (user)?prefix to (user)?rbacseprole.
> Adjusting semanage to expose UserRBACSEPRole.
> Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from libsemanage.
> 
> After this the UserPrefix to UserRBACSEPRole transition should be completed.
> 
> This should get us by until someone decides to rewrite libsemanage to take advantage of CIL, simplify the code, and to make the code more robust.

I guess my only question with regard to this phase and the next ones is 
with regard to backward compatibility.  Even if no one is using this 
facility, we have to make sure we do not break existing installs upon 
upgrade.

> 
> Dominick Grift (3):
>    libsemanage: fall back to valid "object_r" role instead of "user"
>      prefix string
>    semanage: do not default prefix to "user"
>    cil: qualify roles from symtable when resolving userprefix
> 
>   libsemanage/src/genhomedircon.c    |  2 +-
>   libsemanage/src/user_record.c      |  4 ++--
>   libsepol/cil/src/cil.c             |  7 +++++--
>   libsepol/cil/src/cil_internal.h    |  1 +
>   libsepol/cil/src/cil_resolve_ast.c | 10 ++++------
>   python/semanage/semanage           |  2 +-
>   6 files changed, 14 insertions(+), 12 deletions(-)
> 

