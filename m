Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95122C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690D5217BA
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O54oxZ/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBEPnQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:43:16 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:18711 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBEPnP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 10:43:15 -0500
X-EEMSG-check-017: 53416414|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="53416414"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2020 15:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580917391; x=1612453391;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=KieQE3OjkV1zbE9yEVeUEY2Hc8UeHiYPx0audhtldTY=;
  b=O54oxZ/9xAhsFTHkSAjdsbmUfwh/MB+Xc5Io521a07uNUklHKv2tstkY
   V1vtJHdaa7QOo9ydUuwWXR2SL077plAcqAELG4MRBn5+ZoNyUPtHFsgFw
   e4rPfXI/q2vN+Xp2HUzawYHb0lIzChGMX/HpzTLV/lzSjylUTnOZA8Ejs
   Zh01zC21rTS5q3L0XAlB03SrKo2uWzl0WiH4Ik1xS2ke6eMMhk5gH6zLZ
   q/4wHSc92376r4wUahAo8iDg8kqrlNxUy07o+J3/e8nHqIkZiyT5yVF/J
   MAcJi7WhNL26k/2+SBuiIo9KOT8H1LC5IPPlW2//4D4wneaIaLs9wiKPr
   w==;
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="38703160"
IronPort-PHdr: =?us-ascii?q?9a23=3A3PQo0xUnK1DdnjrVZbRQujD5IxzV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbByEt8tkgFKBZ4jH8fUM07OQ7/m8HzFZqsnf+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTonZEZutayGFpKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kAD+MqIgmsy4GuQ3LB?=
 =?us-ascii?q?QBU3KH+eW8yLLj/Ur5TK9MjvIqianWrIrWJcEapq69GwNV04Aj5AijDzq+zd?=
 =?us-ascii?q?gVknYKIEhFdR6alYTlJV7DLO7iAfuim1islS1kx/HCPr3vGJXNKX3Dna/6fb?=
 =?us-ascii?q?lg8E5R0xYzzNBD6JJUDbENOvTzWlTru9DCAR85NBK0z/79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPJr1CI4uMvI++RZI4aozv9Nfcl6OD0jXMjml8SY7Op3Z0JZ3C8BPhmJF?=
 =?us-ascii?q?+ZYXW/yusGREUDuwclBMfjkkGPS3YHZWm5VrggvBknGYmmCsHFXYnrj7ufim?=
 =?us-ascii?q?PzBZBSZ2ZbGniSHnryMYaJQfEBbGSVOMAyvCYDUO2aV4I51Ryo/DT/wr5jI/?=
 =?us-ascii?q?ucrjYUrrr/xdN14KvVjhh0+jtqWZfOm1qRRn15yztbDwQ927py9AkkkQaO?=
X-IPAS-Result: =?us-ascii?q?A2BWAwA34Tpe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIWFIQViQOHeyWJcIonhyQJAQEBAQEBAQEBNwEBhEACgl44EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGDAgEFIxVRCw4KAgImAgJXBgEMBgIBAYJjPysBg?=
 =?us-ascii?q?islrEiBMoVKg0mBPoEOKow8ggCBEScMA4IvLj6HW4JeBI1eiVxGl2aCRIJOk?=
 =?us-ascii?q?28GG5sJizSDLp0wIoFYKwgCGAghD4MnUBgNjikXFY4sIwMwjk8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2020 15:43:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 015FgIN0153243;
        Wed, 5 Feb 2020 10:42:18 -0500
Subject: Re: [PATCH] libsepol/cil: Rewrite verification of map classes and
 classpermissionsets
To:     James Carter <jwcart2@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200131202450.25665-1-jwcart2@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ac11d80b-c9fe-725b-8690-40abab87595f@tycho.nsa.gov>
Date:   Wed, 5 Feb 2020 10:44:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131202450.25665-1-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/20 3:24 PM, James Carter wrote:
> The classperms associated with each map class permission and with each
> classpermissionset are verified in __cil_verify_classperms() which had
> multiple problems with how it did the verification.
> 
> 1) Verification was short-circuited when the first normal class is found.
>    The second classpermissionset statement below would not have been
>    verified.
>      (classpermission cp1)
>      (classpermissionset cp1 (CLASS (PERM)))
>      (classpermissionset cp1 cp2)
> 
> 2) The classperms of a map class permission and classpermissionset were
> not checked for being NULL before the function recursively called itself.
> This would result in a segfault if the missing map or set was referred to
> before the classmap or classpermission occured. This error was reported by
> Dominick Grift (dominick.grift@defensec.nl).
>    These rules would cause a segfault.
>      (classmap cm1 (mp1))
>      (classmapping cm1 mp1 (cm2 (mp2)))
>      (classmap cm2 (mp2))
>    But an error would be produced for these rules.
>      (classmap cm1 (mp1))
>      (classmap cm2 (mp2))
>      (classmapping cm2 mp2 (cm1 (mp1)))
> 
> 3) The loop detection logic was incomplete and could only detect a loop
> with a certain statement ordering.
>    These rules would cause a stack overflow.
>      (classmap cm1 (mp1))
>      (classmapping cm1 mp1 (cm2 (mp2)))
>      (classmap cm2 (mp2))
>      (classmapping cm2 mp2 (cm3 (mp3)))
>      (classmap cm3 (mp3))
>      (classmapping cm3 mp3 (cm2 (mp2)))
> 
> Rewrote __cil_verify_classperms() to fix these errors.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libsepol/cil/src/cil_verify.c | 83 ++++++++++++++++-------------------
>   1 file changed, 37 insertions(+), 46 deletions(-)

[...]

