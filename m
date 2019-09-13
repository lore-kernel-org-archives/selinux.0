Return-Path: <SRS0=5Yad=XI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3103C49ED7
	for <selinux@archiver.kernel.org>; Fri, 13 Sep 2019 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF7820693
	for <selinux@archiver.kernel.org>; Fri, 13 Sep 2019 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Hltjij3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfIMPda (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:33:30 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:43494 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfIMPd3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Sep 2019 11:33:29 -0400
X-EEMSG-check-017: 13650085|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="13650085"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Sep 2019 15:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568388806; x=1599924806;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DsWv8ygbcHuJoz2t9H8hJO+I5FJLKI2h4SpsBWKZAw8=;
  b=Hltjij3jGGugmmDeoA+M/DKWGjFr4mDNSwKgGgZLSReDtpQZeIwc/l+j
   77R0xA4TpyQ+rHSBQj6r4AwSlTt5ceyblDIbCJpG9jUgPjkHjIQmh3yYm
   Y7Sce+1RRmnxujwtwbjNLekg8xCLKM9G22AR5dNkpN/C907viyN0T9Lub
   cEOKOb9Ns+3Bk7BiAf7iCNPERtChFhxc5QLbn3EV8BPEZhOhyZJc9JuuS
   DijlFwjruulJ6vviV75+pCOqooIX8Wsk+bpcTRLaUfPhq36GmI58b9GqC
   aCKt48tddV6AJmz6f4pEfBR3wQNALUIdEc5nyTL1JNqTEc8vTw+FfJhW1
   A==;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="27892449"
IronPort-PHdr: =?us-ascii?q?9a23=3AHCNg9RyMJ6wMpt7XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoSL/ad9pjvdHbS+e9qxAeQG9mCsLQc1KGG7OigATVGvc/b9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMuMQam5duJ6Q+xh?=
 =?us-ascii?q?bKoHZDZuBayX91KV6JkBvw+9m88IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sQvHnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudPFFBA5MxC7w+b9B9V7zYMeXmSPD7?=
 =?us-ascii?q?SWMKPXq1CI5+YvL/OQa48SvTb3M+Il6OL2jX8lhV8derGk3Z0WaH+kGfRmJ1?=
 =?us-ascii?q?+WYWH2jtcAFmcKuRE+TPfxhV2HXjNSaGy+X6Um5jE0EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2BoNWZmVBClCOEHbodp6EVuwWaC2MP8BhkiYLVaS7R4A90hGusRfwy6B7Ie?=
 =?us-ascii?q?rM5i0YqZXj2cBu5+LNkREy9Dp0D9mS0myWUWF0kX0HRyUs0KB8v0N90FGD3r?=
 =?us-ascii?q?Z8g/BCEtxT/fxJAU8GMsv3z+V2Q/D7XBnGeJ/dRF+mSdWvByo2SPo+xtYPZw?=
 =?us-ascii?q?B2HND0yljl3iGtB7YO352MA4cvuvba3nP2I89mjXfB07I6p1x6Uo1IL2Lw1Y?=
 =?us-ascii?q?Bl8A2GPJLEi0WUke6RcK0Y2CPcvDOYwXGmoFBTUAk2V77MG38YeB2F/pzC+k?=
 =?us-ascii?q?reQur2WvwcOQxbxJvHc/EbZw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BqAAB+tntd/wHyM5BmHAEBAQQBAQcEAQGBVAYBAQsBg?=
 =?us-ascii?q?W0qgT8BMiqEIY9UAQEBAQEBBoE2iXOPK4F7CQEBAQEBAQEBATQBAgEBhD8Cg?=
 =?us-ascii?q?mAjNQgOAgwBAQEEAQEBAQEGAwEBbIU6gjopAYJnAQUjFUEQCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfP4F3FKptgTKFS4MzgUmBDCgBhH+GeBh4gQeBOIJrPodPglgEl?=
 =?us-ascii?q?V+WaIIrgiySRQYbgjSHQI8WjX+aagI0gVgrCAIYCCEPgyeRIyQDMIEGAQGPI?=
 =?us-ascii?q?AEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Sep 2019 15:33:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8DFXNfX013803;
        Fri, 13 Sep 2019 11:33:23 -0400
Subject: Re: [PATCH 2/2] Fix mcstrans secolor examples
To:     Chad Hanson <dahchanson@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20190702120905.9808-1-vmojzis@redhat.com>
 <20190702120905.9808-2-vmojzis@redhat.com>
 <CAJfZ7=nZ3mVRFD6d5OGq+r1srH+8bRr-hKeLi3kpc_bx3W5yTw@mail.gmail.com>
 <CAOFCXecb5Z_d+iSqda-yHaQRgEsonHJEZx4MQut89t8E4CQ9BA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7762a815-65b6-b57c-7c03-38303ccf1d25@tycho.nsa.gov>
Date:   Fri, 13 Sep 2019 11:33:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOFCXecb5Z_d+iSqda-yHaQRgEsonHJEZx4MQut89t8E4CQ9BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/31/19 1:15 AM, Chad Hanson wrote:
> I agree the secolor configuration file is lacking consistency. From a
> historical MLS perspective, there were two special labels in many MLS
> systems: SystemLow and SystemHigh.  This would be "s0" (lowest
> level/no categories)  and "s15:c0.c1023" (highest level/all
> categories) respectively.  At these special  levels, there was
> traditionally no other category usage.
> 
> I concur we either do the proposed change in this patch or just change
> the "s0:c0.c1023" lines to just "s0" (SystemLow) to be consistent with
> the "s15:c0.c1023" (SystemHigh) range that exists currently. They will
> both provide the desired results.

I see that these two patches were never merged and still apply.  Does 
anyone have any objection to merging them both?

> 
> -Chad
> 
> 
> On Mon, Jul 29, 2019 at 5:41 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> On Tue, Jul 2, 2019 at 2:09 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>>
>>> According to "check_dominance" function:
>>> Range defined as "s15:c0.c1023" does not dominate any other range than
>>>   "s15:c0.c1023" (does not dominate "s15", "s15:c0.c200", etc.).
>>> While range defined as "s15-s15:c0.c1023" dominates all of the above.
>>>
>>> This is either a bug, or "s15:c0.c1023" should not be used in the
>>> examples.
>>
>> Hello,
>> I am not familiar with the concepts about range dominance, so I do not
>> know whether this is a bug that should be fixed or if updating the
>> examples is better. Can someone please review this?
>>
>> Cheers,
>> Nicolas
>>
>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>> ---
>>>   libselinux/man/man5/secolor.conf.5                      | 4 ++--
>>>   libselinux/man/ru/man5/secolor.conf.5                   | 4 ++--
>>>   mcstrans/share/examples/urcsts-via-include/secolor.conf | 2 +-
>>>   mcstrans/share/examples/urcsts/secolor.conf             | 2 +-
>>>   4 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/libselinux/man/man5/secolor.conf.5 b/libselinux/man/man5/secolor.conf.5
>>> index b834577a..a3bf2da1 100644
>>> --- a/libselinux/man/man5/secolor.conf.5
>>> +++ b/libselinux/man/man5/secolor.conf.5
>>> @@ -123,7 +123,7 @@ range s7\-s7:c0.c1023 = black red
>>>   .br
>>>   range s9\-s9:c0.c1023 = black orange
>>>   .br
>>> -range s15:c0.c1023   = black yellow
>>> +range s15\-s15:c0.c1023   = black yellow
>>>   .RE
>>>
>>>   .sp
>>> @@ -165,7 +165,7 @@ type xguest_t     = black green
>>>   .br
>>>   user sysadm_u     = white black
>>>   .br
>>> -range s0:c0.c1023 = black white
>>> +range s0-s0:c0.c1023 = black white
>>>   .br
>>>   user *            = black white
>>>   .br
>>> diff --git a/libselinux/man/ru/man5/secolor.conf.5 b/libselinux/man/ru/man5/secolor.conf.5
>>> index 4c1236ae..bcae80c1 100644
>>> --- a/libselinux/man/ru/man5/secolor.conf.5
>>> +++ b/libselinux/man/ru/man5/secolor.conf.5
>>> @@ -121,7 +121,7 @@ range s7\-s7:c0.c1023 = black red
>>>   .br
>>>   range s9\-s9:c0.c1023 = black orange
>>>   .br
>>> -range s15:c0.c1023   = black yellow
>>> +range s15\-s15:c0.c1023   = black yellow
>>>   .RE
>>>
>>>   .sp
>>> @@ -163,7 +163,7 @@ type xguest_t     = black green
>>>   .br
>>>   user sysadm_u     = white black
>>>   .br
>>> -range s0:c0.c1023 = black white
>>> +range s0\-s0:c0.c1023 = black white
>>>   .br
>>>   user *            = black white
>>>   .br
>>> diff --git a/mcstrans/share/examples/urcsts-via-include/secolor.conf b/mcstrans/share/examples/urcsts-via-include/secolor.conf
>>> index d35b3c67..3b3f5430 100644
>>> --- a/mcstrans/share/examples/urcsts-via-include/secolor.conf
>>> +++ b/mcstrans/share/examples/urcsts-via-include/secolor.conf
>>> @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
>>>   range s5-s5:c0.c1023 = white blue
>>>   range s7-s7:c0.c1023 = black red
>>>   range s9-s9:c0.c1023 = black orange
>>> -range s15:c0.c1023 = black yellow
>>> +range s15-s15:c0.c1023 = black yellow
>>>
>>> diff --git a/mcstrans/share/examples/urcsts/secolor.conf b/mcstrans/share/examples/urcsts/secolor.conf
>>> index d35b3c67..3b3f5430 100644
>>> --- a/mcstrans/share/examples/urcsts/secolor.conf
>>> +++ b/mcstrans/share/examples/urcsts/secolor.conf
>>> @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
>>>   range s5-s5:c0.c1023 = white blue
>>>   range s7-s7:c0.c1023 = black red
>>>   range s9-s9:c0.c1023 = black orange
>>> -range s15:c0.c1023 = black yellow
>>> +range s15-s15:c0.c1023 = black yellow
>>>
>>> --
>>> 2.17.2
>>>
>>

