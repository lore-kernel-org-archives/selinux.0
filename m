Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA24C4CEC9
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18CE2054F
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QC1IXP6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfIRNxg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:53:36 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:3607 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfIRNxg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 09:53:36 -0400
X-EEMSG-check-017: 29242652|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="29242652"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 13:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568814815; x=1600350815;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=zBZsqCgYtFR3Xj7S1MTZlNGwurEhhaPuQRlfQyDLWeE=;
  b=QC1IXP6JnleoGtru2r1PQjF7jBeft1vDOkAme2qktwZV3hibvFZ1nb1k
   DMhpmLJbtbL01Nbhgu51gPUJhfv+muiAZZexZ7ZV7KjiRidoE+KXJoGpR
   oxdceb/o4c+syJURxJpa4/3c0/1e20Gm7sIMqpQHQFQuCO+HPpvnJ4+Dt
   57l31pFAAYK5wyDG0Kwd9Pn3ZKS/n17JHx+tmyk4/+WKOo4SRAiLJG/Em
   +5wozDe6axaDqVKuy1YjaqkreH9Nv2bI5bv0/60axu/1TwXSeRVE5Cm2B
   MLQhUO/pXBklfFbDuedYGyncRL1/4JtsleZwNUU2slSMDYczRkMYtHJyM
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28044688"
IronPort-PHdr: =?us-ascii?q?9a23=3AADRRdB0wTEMfryrqsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMWLPad9pjvdHbS+e9qxAeQG9mCsLQd26GI4+igATVGvc/b9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMuMQam5ZuJ6U+xh?=
 =?us-ascii?q?bIoXZDZuBayX91KV6JkBvw+9m88IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sOvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudzEAR45Lwu0w/rnCNhm2YMeXHiAAq?=
 =?us-ascii?q?6dMK/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gH8ih1Adeaip3Z0KaHG3BflmPU?=
 =?us-ascii?q?qZbmT2gtsbEmcFoBA+TOr0h12GSzJTYGyyX61vrg08Xb6rAc//QZytyOidzD?=
 =?us-ascii?q?u8Ap1+aWVPC1TKGnDtIcHMQPoIaSSPMud/nTEeE7usUYks0VeprgCp5aBgK7?=
 =?us-ascii?q?/v5iAAtZ/lnONw7unXmAB6oSd4FOyBwmqNSCdyhWpOSDgoivMs6Xdhw0uOhP?=
 =?us-ascii?q?Ary8dTEsZesrYQD1Y3?=
X-IPAS-Result: =?us-ascii?q?A2DMCQBuNoJd/wHyM5BmHQEBBQEHBQGBZ4FuKoFAMoRMj?=
 =?us-ascii?q?w9QAQEBBoE2iXSRKAkBAQEBAQEBAQE0AQIBAYQ1CgKDAyM4EwIMAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFOYI6KQGCZwEFIxVRCw4KAgImAgJXBgEMCAEBgl8/gXcUsEmBM?=
 =?us-ascii?q?oVMgy+BSYEMKIwJGHiBB4E4gms+h0+CWASVepZ+giyCLpJPBhuCJpZ6jg+bG?=
 =?us-ascii?q?iGBWCsIAhgIIQ+DKE8QFJAvJAOBNgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 13:53:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IDrTOm028983;
        Wed, 18 Sep 2019 09:53:31 -0400
Subject: Re: strange tclass in AVCs
To:     Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 09:53:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/18/19 9:35 AM, Ted Toth wrote:
> I'm seeing things like tclass=context#012 in some AVCs what is this telling me?

Just a guess here, but octal 012 is '\n' aka a newline character, and 
libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer 
before calling avc_log() to log the entire string.  avc_log() will call 
the logging callback, and dbusd does define one, which calls 
audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is 
escaping the newline character in its output as well as appending 
additional data.

I'm a little unclear though on why dbusd is checking a context contains 
permission?
