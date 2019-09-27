Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C90C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC34021850
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 12:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="m1F4dhf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfI0M7h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:59:37 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:25163 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0M7h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 08:59:37 -0400
X-EEMSG-check-017: 17719267|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="17719267"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 12:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569589174; x=1601125174;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3aJxXagwTVxZ7EgkUR4FYPQ/QHFO/ihijFrPXZ8yOgc=;
  b=m1F4dhf/5Ht1ja/cA7PYggA8nL2aG0OYrkcZgMceedLn3IqLrNnXWynZ
   fZ1mwHCkBuHA96ouJhsLRL19ccjbVvAIPcG8KZ/q8FBNN61+9T6QnvyXJ
   zuvGiur2/yAOw9HqipN/1Qf3x4Wpw5UzgWXG9f75VwIFwICVssXZpPBat
   NyMvfhtMOunODVsr3xzNo9etXFW2SIZM6BS9Afp9qPbgWb61cqJs7GiyF
   qLx9pE8kdo8PuD+yUM92JomZFJgSv0u5OLRnPbb8mOiP6KYsIjksYeR3G
   l/doiPrPoJ40ABNqtaMqM54sA9d4OvdFYkSyiGfQ2aODQSwfyn4zcDpUk
   g==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="33439210"
IronPort-PHdr: =?us-ascii?q?9a23=3AnDMeAR+93xB+gP9uRHKM819IXTAuvvDOBiVQ1K?=
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
X-IPAS-Result: =?us-ascii?q?A2CTDAAvB45d/wHyM5BmHQEBBQEMBQGBZ4F0Km1SATIqh?=
 =?us-ascii?q?CKIPoYwTQEBAQEBAQaBNol1g3uGDoU6gWcJAQEBAQEBAQEBKwkBAgEBhEACg?=
 =?us-ascii?q?zcjOBMCDAEBAQQBAQEBAQUDAQFshS0MgjopgmkBBSMVUQsYAgImAgJXEwgBA?=
 =?us-ascii?q?YJfPwGBdhQPrhCBMoVNgzOBQgaBDCiMDhh4gQeBOIJrPoJIGQQYgTBkgj6CW?=
 =?us-ascii?q?ASWCpcNgiyCLoRXjgAGG4InAZcMLZYLkxghgVgrCAIYCCEPgyhPEBSOC4IkJ?=
 =?us-ascii?q?QMwgQYBAY4+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Sep 2019 12:59:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8RCxQBn029037
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 08:59:26 -0400
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
To:     selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 08:59:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927075507.GA20555@seamus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 3:55 AM, Dominick Grift wrote:
> sudo does not reset the role of my tty properly [1], and i was wondering if anyone is able to determine what is causing this [2]
> 
> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c

Are you sure sudo is calling selinux_restore_tty()?


