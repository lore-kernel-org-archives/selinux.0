Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA2C2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7562187F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="guLhKbZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgBNNWh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:22:37 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:31607 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgBNNWh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 08:22:37 -0500
X-EEMSG-check-017: 56170812|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="56170812"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 13:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581686555; x=1613222555;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=J+9iqjBEl+YaZTEQ49wRsbIFyQdgGGYSq8Nn561tlSU=;
  b=guLhKbZ1QELPBzNVkC0JFRcWIPr6ZPj13mKfzPDseYKKmvMd1T30X1pM
   CVxanQACEAWwGybe6RiKAnQ/cvUHZEYAD1sZ7u1YVecphcUwehGgLDm6+
   zzjwXq/llcqJZ6wJBvJMdRzUKYwLPYYts4NBtWYFnGKazmJSe5aP+hX3S
   elTkMPExLXelzC4hxiyzz+ZD1Q6BnlTKGySHC8w0jLlpaW5Tqf4pp24IV
   D0V50ZxCCm5Xpv8QLUC8nN+Pvsh+tmVeWCqRwHMTSeUdAX/lAZV+T+R1v
   SuCsThBleX9GqYNq0nRJ+mKFQn2pcp9JBa5zqPrsXxEOerzrkQKvezKSm
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="33069703"
IronPort-PHdr: =?us-ascii?q?9a23=3AkOrUNBaGxXPq9+UDCm7pkxb/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsi6bnLW6fgltlLVR4KTs6sC17OK9f+4EjBRqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtMQanYRuJ6k1xx?=
 =?us-ascii?q?DUvnZGZuNayH9nKl6Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU7FWDykoPn?=
 =?us-ascii?q?4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Xi?=
 =?us-ascii?q?mi77tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQW?=
 =?us-ascii?q?ZNR9tdWzBdDo+5aYYAAfABPeJFpIfjoVUAowa1CQ21CO7vzjJEg3n71rA43e?=
 =?us-ascii?q?s8CwHLxBEuEcwAsHrUr9v7OqkdXu+3w6bUwjvOdO9W1DXn5YTUbhwsr/OBUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02Np4z5ITyVzuQNvHad7+F9SOyvjnQoqwV1ojexxsYnl4?=
 =?us-ascii?q?7EhpkIxVDf7ih53IY0KsG4SE58e9KkFoBQuDuAO4t5RcMiXXhltSAnwbMFoZ?=
 =?us-ascii?q?62ZDUGxZsoyhLFa/GLbpKE7gzsWeqPOzt0mXRoc6+liRmo60iv0Oj8W9Gx0F?=
 =?us-ascii?q?ZNsyVKjMHBtmsI1xzP8siHTeZ9/lu51TaPyQ/T7uZELFgolaXBMZ4hw6Mwlo?=
 =?us-ascii?q?EJvUTCGC/2lkL2jLSIeUo44OSo9+Tmbanmpp+bLYN0jB3xMr8ylcClBOQ4Mw?=
 =?us-ascii?q?wOU3Ca+eS6yrLj4VX0TKhFg/A5iKXUsI3WKd4FqqO2HQNZyJsv5w66Dzi80d?=
 =?us-ascii?q?QYmXcHLEhCeBKCl4XpIEzBIOvjAPejg1WjjDdrx/fcMr3nGZXCNGLPkLjmfb?=
 =?us-ascii?q?Zj80Jc0hY8zchD55JIDbEMOPXzWkr2tNzDCB82KRC7zPj8BdVnyIwRRGKPDb?=
 =?us-ascii?q?WFMK/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gH8hg1AdYK2p0IAPaH+iA/RmJ1?=
 =?us-ascii?q?yVYX/rgtcGC2cFoBAyQ/DtiF2HSTRTfWq9X7og5jEnD4KrFZzDSZ6pgLyA2i?=
 =?us-ascii?q?e7A5JXa3tYClCDD3jobZ+IW/QSZyKIJM9ujDgEWaKmS4872hH9/DP9np1hIv?=
 =?us-ascii?q?DZ+GU9sonl3dN45KWHkhQ17jp9BMm1yWyBT2ho2GgPQmll8rp4pBlG1lqb0a?=
 =?us-ascii?q?V+y8ddHNhX6uIBBhw2LrbA3ud6DJb0QQuHcdCXHgX1Cu66CC08G4pii+QFZF?=
 =?us-ascii?q?xwTpD700HO?=
X-IPAS-Result: =?us-ascii?q?A2B1BwBtnkZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBbSASKoQUiQOGWgEBBAaBN4EBiG+PUBOBZwkBAQEBAQEBAQE3BAEBhEACg?=
 =?us-ascii?q?iU6BA0CEAEBAQUBAQEBAQUDAQFshUOCOykBgwIBBSMEEUEQCw4KAgImAgJXB?=
 =?us-ascii?q?g0GAgEBgmM/glclrXx/M4VKg1aBPoEOKgGMPXmBB4ERJw+CKDU+hDGDKoJeB?=
 =?us-ascii?q?JZjZEaXbYJEgk+TfAYcmxisKgIdgVgrCAIYCCEPgydQGA2OKReOQSMDMJBYA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2020 13:22:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EDLa5s087859;
        Fri, 14 Feb 2020 08:21:36 -0500
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve
 handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200129164256.3190-1-sds@tycho.nsa.gov>
 <CAFqZXNsk_fyPuLDz-jtjtjzJR5rZmBAKgFzPk3Z0y35ahyaeRw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f9f12adf-51b1-3ba5-fef2-f290b69d974e@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 08:23:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsk_fyPuLDz-jtjtjzJR5rZmBAKgFzPk3Z0y35ahyaeRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 7:46 AM, Ondrej Mosnacek wrote:
> On Wed, Jan 29, 2020 at 5:42 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Fully decoupling the policy and kernel initial SID values will
>> require introducing a mapping between them and dyhamically
> 
> Nit: s/dyhamically/dynamically/

Ah, thanks; will fix if I need to re-spin.

>> -               if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
>> -                       pr_err("SELinux:  Initial SID %s out of range.\n",
>> -                               c->u.name);
>> +               u32 sid = c->sid[0];
>> +               const char *name = security_get_initial_sid_context(sid);
>> +
>> +               if (sid == SECSID_NULL) {
>> +                       pr_err("SELinux:  SID null was assigned a context.\n");
>>                          sidtab_destroy(s);
>>                          goto out;
>>                  }
> 
> Your sentence "Stop treating it as an error if a policy defines
> additional initial SIDs unknown to the kernel." and the removed check
> for > SECINITSID_NUM suggest that you intend to not treat this
> condition as an error, but sidtab_set_initial() called bellow will
> reject such SID with -ENIVAL. Or am I misreading it and you just
> wanted to remove the duplicate check?

The comment and if statement below will cause it to ignore any initial 
SIDs unused by the kernel, whether they are ones <= SECINITSID_NUM whose 
names have been dropped and replaced by NULL or ones > SECINITSID_NUM. 
security_get_initial_sid_context() returns NULL for anything > 
SECINITSID_NUM.

> 
>> +
>> +               /* Ignore initial SIDs unused by this kernel. */
>> +               if (!name)
>> +                       continue;
>> +
