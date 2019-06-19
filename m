Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333AC31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7962187F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BgBCfsP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfFSQE7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:04:59 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:53418 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSQE7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:04:59 -0400
X-EEMSG-check-017: 421046750|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Jun 2019 16:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560960298; x=1592496298;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SE43FCKz0S+ctGc329ACQCcBh8YKi/wrnHA1Sq7riSY=;
  b=BgBCfsP+lUNWnlAqV9QKGPXTGIf7Pv/byK4L5afTdPmSzHFqEJAN+npA
   p0O3jG+OASuCy02GaT/oIiq1uTUT2xchjv1XekKKZcSLtFPmZQod1ZfQI
   leP9mUKbB0Ed4JrA0881OdMROFQDWhP5R21REbXHMx1GItuHd710TR2nt
   vG/4eYFYsBmWLwIwOQFAERsvwHPIeQyJTk/EWyARIAvl1Vl9z5XZuyYnH
   Lg5/8GsGyFEjwS+WFaL0oC5WaN9YJBryVRjnvpXG33slXnlHTZc1Z/vkH
   2XWKZAn12VlWhKKEcMDYmpiMk9NJMCYBXkQzWJyt7M1ZHuxmupKWCeRj1
   w==;
X-IronPort-AV: E=Sophos;i="5.63,392,1557187200"; 
   d="scan'208";a="29174048"
IronPort-PHdr: =?us-ascii?q?9a23=3AvPYD7xxXOeSDRI3XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uIeIJqq85mqBkHD//Il1AaPAdyBraoewLSJ++C4ACpcuM/H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjPusUMnYduNKk9xx?=
 =?us-ascii?q?rLr3BVf+ha2X5kKUickhrh+8u85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBswCvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xztVOGUIThihXJlfqqyhxis/ke9ze38TNO70E?=
 =?us-ascii?q?5QripCkNnDqGwC1wDJ5siAUPt98V+t2TmO1wDP6uFEPFs7mbDHJJ4mx748jo?=
 =?us-ascii?q?ITsETfHi/2n0X2irWadkI++uin7ensf7bopoeEOoNphQzzPb4il8yiDegiLA?=
 =?us-ascii?q?QDUHaX9f6h2LDl4Eb3Wq9FjucsnancqJ3aIMMbqbOnDAJNyYYj7gq/Dy+h0N?=
 =?us-ascii?q?QFgXkLNFJFdwyDj4juI1zOPOr3De2+g1Sxizdn3ezGP739DZXNKXjPirHhcq?=
 =?us-ascii?q?pm60FA0gYzyNFf55ZMBrEAJvL8RFPxucTFAhI2PAG42ebqBMhn2o8AVm+DHL?=
 =?us-ascii?q?WVPL7KvV+N/O0vIu2MZIEPuDb6Lvgo/+XugmIimVIGYamo3YcYaHC/Hvh8JU?=
 =?us-ascii?q?WZemDjjs0OEWcNoAoyVPbqh0GaUT5Pe3ayWLox5ikhB4K7CYfOXZitj6ac3C?=
 =?us-ascii?q?e/B5FWY2dGCleWEXj2bYmLR/AMaCeKKM97jjMETaShS5Mm1Ry2rw/11b5nLu?=
 =?us-ascii?q?vS+i0FupPuz8Z15+LNmhEo7zB0DNqS03uLT25qmmMEXTg23LpwoR819lDW6a?=
 =?us-ascii?q?Flh7R9EttJ6rsdSg4nMbbExvF+TtX1XRjMONyOTQD1bM+hBGQKUt8pw9IIK3?=
 =?us-ascii?q?14EtGmgwGLizGmGJcJhreLA9oy6aua0H/vcZUug03a3bUs2gF1CvBEMner0+?=
 =?us-ascii?q?smrVne?=
X-IPAS-Result: =?us-ascii?q?A2B+BABuXApd/wHyM5BmHgEGBwaBZ4FtKmpRATIohBaTP?=
 =?us-ascii?q?wEBAQEBAQaBNYlTkQwJAQEBAQEBAQEBKwkBAgEBhEACglgjOBMBAwEBAQQBA?=
 =?us-ascii?q?QEBBAEBbIo3DII6KQGCZgEBAQECASMVQRALGAICJgICVwYNBgIBAYJfPwGBd?=
 =?us-ascii?q?gUPD6tEgTGENgULQUCDKIFABoEMKIteF3iBB4E4gW1+PoJhAoEqg0GCWASUL?=
 =?us-ascii?q?ZU4CYITghuELY0FBhuXNJRBkVIhgVgrCAIYCCEPgnMBM4YxhRSFWyMDMIEGA?=
 =?us-ascii?q?QGMGIJSAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Jun 2019 16:04:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5JG4tfs019953;
        Wed, 19 Jun 2019 12:04:55 -0400
Subject: Re: [PATCH] selinux-testsuite: fix old python shebang in
 tests/overlay/access
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20190619142630.26648-1-sds@tycho.nsa.gov>
 <CAHC9VhQ1Bo-xpROgZa18MqxJSnTLoYoj6GbQR-pmDy2jSDs1bQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a11f8817-ac26-ce5c-1b1d-20c310777a03@tycho.nsa.gov>
Date:   Wed, 19 Jun 2019 12:04:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ1Bo-xpROgZa18MqxJSnTLoYoj6GbQR-pmDy2jSDs1bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/19/19 10:40 AM, Paul Moore wrote:
> On Wed, Jun 19, 2019 at 10:26 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> /usr/bin/python is no longer installed by default, so this test
>> script fails on default installs.
>> Best practice guidance appears to be to switch to using
>> /usr/bin/python3 instead, per
>> https://docs.fedoraproject.org/en-US/packaging-guidelines/Python/
>>
>> Fixes: #46
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   tests/overlay/access | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think it would be better to reference the Python upstream guidance
> regarding "python3" instead of the Fedora packaging guidelines.
> Keeping things distro agnostic is a good goal whenever possible.
> 
> * https://www.python.org/dev/peps/pep-0394

When I looked for guidance in response to the github issue for 
selinux-testsuite [1], there seemed to be some ambiguity left by pep-0394:

1) It says "One exception to this is scripts that are deliberately 
written to be source compatible with both Python 2.x and 3.x. Such 
scripts may continue to use python on their shebang line.".  This leaves 
open the possibility of staying with "/usr/bin/python" as far as the pep 
is concerned since the script itself is not version-specific in any way, 
but doing so is not permitted by the Fedora guidelines and breaks on 
default installs of Fedora.

2) It doesn't specify whether or not one should use "/usr/bin/env 
python3" or just "/usr/bin/python3".  The github issue reported had 
originally suggested the former, but this is also prohibited by the 
Fedora guidelines.

That's why I went with the Fedora guidelines.  Happy to use whatever but 
at least that particular PEP doesn't clearly motivate the use of 
"/usr/bin/python3" here.

[1] https://github.com/SELinuxProject/selinux-testsuite/issues/46

> 
>> diff --git a/tests/overlay/access b/tests/overlay/access
>> index 5a47eb145904..e50d5b402ebd 100755
>> --- a/tests/overlay/access
>> +++ b/tests/overlay/access
>> @@ -1,4 +1,4 @@
>> -#!/bin/python
>> +#!/usr/bin/python3
>>   import os, sys
>>   try:
>>           acc=eval("os.%s" % sys.argv[2])
>> --
>> 2.20.1
> 

