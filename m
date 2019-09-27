Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D117C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3488217D9
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aI60t8iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfI0NCM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:02:12 -0400
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:55186 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfI0NCM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 09:02:12 -0400
X-EEMSG-check-017: 28777869|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="28777869"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 13:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569589329; x=1601125329;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=PVTqIhpOnX8x4WqyGda8lEQTEA5GPlrHsiZOlHyT8+g=;
  b=aI60t8iQ0UhJA5vAla+Qco1KIBsYBxDHI52D3KxWSJQo1qKPZ4SZ/wbg
   2oTX61rQeGVTIpUl/9y8opzZjWowdKpQTn3ruSB1vDm7folOuBE+PyFOl
   taJWbDrLzH8itQyVPg44P6i12/0RFkZnSKOgWj5PSo0bjLa7uFMC8H9Kl
   dknZMEPnK6pYZmtopbBsk0vw0/0hQnAazvfHjgrABfG1EXBVk0OM2dc6V
   pxNL8p+UyEUsOOHJG3y4ObQq0o7CHOyVTPTt8KU0q2Etrh2xKEIjLovRp
   iJvyCGGnHJi7ThSx9d+infsVxKLRBWd/sMfCYt34EzlEFk79SBlRThbU9
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="33439415"
IronPort-PHdr: =?us-ascii?q?9a23=3Aulgu+B87w6whaf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B42+4cTK2v8tzYMVDF4r011RmVBN6dsKwP1reempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCCzbL5zIxm7rQXcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/4ahrUhvogzoZOTA//m/cl8h8gLtFrB+gohByxZPfboOIO/pkZq7TYM0URW?=
 =?us-ascii?q?RBUMhSWSJODIyzYIkTAOQOJutYs4vwqkESoReiCwShBuXiwSJIiH/s2q061v?=
 =?us-ascii?q?wsHxza3AM+B9IOsGrbrNPoP6kPVOC61q3IzTHdYPJWxDzw75PIfQ06ofyXQb?=
 =?us-ascii?q?JxcdbeyUkoFw/fiFWQspbqMyma1uQKrWiW9uxtXv+hhW4grgF+uDmvxsE0h4?=
 =?us-ascii?q?nSm4Ia11fE+T93wYYuI9CzVU11Yca8HZdNuCyXOJF6T8M/T21ypio3xaMKtY?=
 =?us-ascii?q?SmcCUM1Z8p3QTQa+adfIiN+h/jUeGRLipmi399Y7K/ggqy8VCnyu3hSsm4yF?=
 =?us-ascii?q?ZKoTRBktnLrn0Nywbc6tKGSvtg5UetwyqP1gDP5eFEJkA4j6zbJII6wrEsjJ?=
 =?us-ascii?q?YTtEXDHivulEX3iq+ZaFkk9/C15+nobbjqvJ+RO5Juhg3gPakihNazDfkgPg?=
 =?us-ascii?q?gLRWeb+OC81LP5/U3+RbVHluY2nbTCsJ3BOcQaprK2Aw9S0oo57Ra/FC2p3M?=
 =?us-ascii?q?4XnXkAMlJJYAiHgJTxO1HSPPD4Cu+yg0+ynzdvxvDGOKDhA5rWI3jdn7fuY6?=
 =?us-ascii?q?x951RfyAUt19Bf4YxbCrUbLPL0QE/xu4+QMhhsKAGwwuD6GP1j2Y4EH2GCGK?=
 =?us-ascii?q?mUNOXVq1DbyPgoJry3eIINuDv7Y8Mg7vrqgG5xzUQRZoG1zJAXbza+Bf0gLE?=
 =?us-ascii?q?KHNym/yuwdGHsH61JtBNfhj0ePBHsJOXs=3D?=
X-IPAS-Result: =?us-ascii?q?A2DXBgAvB45d/wHyM5BmHAEBAQQBAQwEAQGBZ4F0Km1SA?=
 =?us-ascii?q?TIqhCKObk0BAQEBAQEGgREliXWKCYU6gWcJAQEBAQEBAQEBKwkBAgEBhEACg?=
 =?us-ascii?q?zcjOBMCDAEBAQQBAQEBAQUDAQFshS0MgjopgmkBBSMVUQsYAgImAgJXEwgBA?=
 =?us-ascii?q?YJfPwGBdhQPrhCBMoVNgzOBQgaBDCiMDhh4gQeBOAyCXz6CSBkEGIEwZII+g?=
 =?us-ascii?q?lgElgqXDYIsgi6EV44ABhuZNC2WC5MYIYFYKwgCGAghD4MoTxAUjguCJCUDM?=
 =?us-ascii?q?IEGAQGOPgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Sep 2019 13:02:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8RD28Nf029114
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 09:02:08 -0400
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
To:     selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <20190927082401.GB20555@seamus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d3fbc1ce-15ac-adcf-8128-fdb152e5d399@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 09:02:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927082401.GB20555@seamus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 4:24 AM, Dominick Grift wrote:
> On Fri, Sep 27, 2019 at 09:55:07AM +0200, Dominick Grift wrote:
>> sudo does not reset the role of my tty properly [1], and i was wondering if anyone is able to determine what is causing this [2]
>>
>> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
>> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
> 
> Does fgetfilecon() get the context from the actual path or does it get it from file_contexts?
> If it does the latter then i guess that would explain it as pty/tty contexts are customizable and thus have no entry in file_contexts:
> 
> # matchpathcon /dev/pts/0
> /dev/pts/0      <<none>>
> 
> In that case i guess it skips the relabel?

I don't think that's relevant.  fgetfilecon() is a wrapper for 
fgetxattr(2); it gets the actual context set on the file, not something 
from file_contexts (you would use selabel_lookup(3) or matchpathcon(3) 
for the latter).

The behavior you describe suggests that sudo is never calling 
selinux_restore_tty() in this case (or there is some bug causing it to 
abort before reaching the fsetfilecon, or causing that to fail).

Don't know if you can turn up verbosity/logging and/or use strace or 
autrace or something to get more info.


