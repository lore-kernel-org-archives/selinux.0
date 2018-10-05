Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1C2C00449
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412C42084D
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 12:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412C42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJETYY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:24:24 -0400
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:61370 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeJETYX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 15:24:23 -0400
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 15:24:22 EDT
X-EEMSG-check-008: 172705762|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 12:15:22 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="19085039"
IronPort-PHdr: =?us-ascii?q?9a23=3AiQ9Hhh2fCdstfwhJsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIRKvad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcpcDA+8HMO1FrYfyukEOoAOgCwesGe3hyTFGiXH50qIm3O?=
 =?us-ascii?q?osCh3G0Q46Et4SrHjZotf4OaEPWu611qnIyjDDYutL1zfh9ofIahAhru+KXb?=
 =?us-ascii?q?ltbMTRzFMgFwfBjlqOqY3uIjSY1v8QvGiA9OdgSeKuhHInqwF2uDSvwNwshZ?=
 =?us-ascii?q?PTioIazVDE6zx0zYAoLtO2T057ZMSrEJpWtyyCNIt5XNkiQ2d2tyY+0LEGvo?=
 =?us-ascii?q?S7fCcMxZ86xBDfc+SKf5WH7x/sTuqcISp0iGh7dL+wmRq+61Wsx+vhXceuyl?=
 =?us-ascii?q?lKtDBKktzUu3AI0Bzc99aIR+Nm/kekxTaPzwfT6vxYIUwslarUNZohwrkom5?=
 =?us-ascii?q?oPq0vDBC72mFjtjKOMakUl+vSn6+TgYrn8oJ+TK5R0hR3kPqQrm8y/Bfw0Mg?=
 =?us-ascii?q?kIX2eF5eSxzKDv8EL2TblQjvA6j7PVvI7VKMgFvKK1HhdZ0oM55Ba+Czem3s?=
 =?us-ascii?q?4YnX4CLF9dYxKIkpPpNkrSIPH4Efi/g1OsnC1tx/DdJLLtGJrNLn/dkLv5Z7?=
 =?us-ascii?q?Zy91ZcyBYvzdBY/59UEa8OIPbyWk/3qdzZAQQ0MxK7w+n5EtVxzIAeVnyVAq?=
 =?us-ascii?q?+fLqzStUWE5uU1I+mDfIUVoiryK+A55/7yin80gUcdcrO03ZsTc324Bu5pI1?=
 =?us-ascii?q?idYXb1h9cBFmAKvhAgQ+DwlFKCVjtTND6OWPcH6zU6Dp+2JZvSTYCqxrqa1W?=
 =?us-ascii?q?G0GYMFSHpBDwW3DXrwd4iCE8wJYSaWL94pxicITpC9WoQh0leorwa8xL15eL?=
 =?us-ascii?q?mHshYEvI7ugYAmr9bYkgs/oHktVpyQ?=
X-IPAS-Result: =?us-ascii?q?A2D9AgDRVLdb/wHyM5BkGwEBAQEDAQEBBwMBAQGBZQKBW?=
 =?us-ascii?q?ipmfxUTg3SUOIp8jXATgWYgDAwBhECELCE7BwwBAwEBAQEBAQIBbBwMgjYkA?=
 =?us-ascii?q?YMIFTYLNQIIHgJTGQYCAQGCXj8BKAGBSw2kEIEuhHeFHYELiiYXggCBOYc2A?=
 =?us-ascii?q?RECAWuCNIJXAo5dhTGJVAmGTIl0BheBTEuEGolDjB6LJAMbJz1xKwgCGAghD?=
 =?us-ascii?q?zuCbAmCHReIWoVaIzB7AQGNTwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Oct 2018 12:15:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95CFLen020438;
        Fri, 5 Oct 2018 08:15:21 -0400
To:     Selinux@tycho.nsa.gov
From:   Stephen Smalley <sds@tycho.nsa.gov>
Subject: selinux list is moving
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Message-ID: <8263f9fa-16f1-1d0a-e391-61d609e50d7d@tycho.nsa.gov>
Date:   Fri, 5 Oct 2018 08:17:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

The selinux mailing list is moving to vger.kernel.org.
If you wish to continue following the list, please subscribe by sending 
a plaintext message containing "subscribe selinux" in the body to 
majordomo@vger.kernel.org.

Going forward, mailing list archiving is being provided by lore, see 
https://lore.kernel.org/selinux/.  We provided the kernel.org admins 
with a snapshot of the selinux@tycho.nsa.gov mailing list archives 
yesterday that they imported so that (most) of our historical archives 
will be available from lore as well.  Unfortunately, we have not found a 
way to successfully forward subsequent postings to selinux@tycho.nsa.gov 
to the new list, so there are a few messages yesterday that did not make 
it into the new archive. You may wish to re-post those to the new list 
for posterity if you care.

Be advised that vger.kernel.org does not accept HTML email, so configure 
your mail clients accordingly.

Thanks.

