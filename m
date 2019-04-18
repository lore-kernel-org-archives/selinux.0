Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A83C10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4BA217D7
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pEgEM5UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfDRN1G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:27:06 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:15889 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfDRN1G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 09:27:06 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 09:27:05 EDT
X-EEMSG-check-017: 8993855|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Apr 2019 13:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555593452; x=1587129452;
  h=subject:to:references:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0yRtt3KMzZLR7/K1M3r4KNeJ6zXVI4f1neTEtbLk1Gk=;
  b=pEgEM5UU5LQIrkyHflEOhDWDlspMKM+IGXF6iVOpYXhGPcylrT33luue
   MEvjhQAk18CRNqpj08Kvwh0t9gqZ4BKa7GdJN7XDA/DTVlhSBJghIjYJy
   DH9alv0SeWaZEUgUHfee7fF/fnbk/0QJSc/Blqh3BrYfqpOpt15vR0GIv
   TfBhJYAnmn2Zo7NUxxbKPOVIQqhTfsqCAxBXYjun+r6P2e8uzC4NWFvkf
   61TGtsbA3FnNwJbIKjZPyULFPxKwgFWw9zjhosRn258Y0X1zUn0FlOb5s
   bgePniomNSRF+IF7c93Jhm3TLmlZ49D56duJO7+vXSsdM21C1+XZJwKWr
   A==;
X-IronPort-AV: E=Sophos;i="5.60,366,1549929600"; 
   d="scan'208";a="26472843"
IronPort-PHdr: =?us-ascii?q?9a23=3AZ+RIIR3oUqHJtqL9smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMVKfad9pjvdHbS+e9qxAeQG9mCsrQf1qGN7uigATVGvc/Z9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMq8Uam4VvJ6Y+xh?=
 =?us-ascii?q?bHonZDZuBayX91KV6JkBvw+9u88IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sOvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqqwN/ozez3MgskJ?=
 =?us-ascii?q?XJipwIwV3D9yV4zpo6KseiSE5nf9KpC4dQtiGGOIt2RcMuWWdouD0gxbEctp?=
 =?us-ascii?q?67ezYKxY0hyhXCaPKHa5CF7g/sWeueOzt1hG9pdKihixu970Ss0PDwW8+p21?=
 =?us-ascii?q?hQtCVFiMPDtnUV2hzW7ciIV+Vy81+62TaKywDT8uZEIV0olabDK54u3Lowlp?=
 =?us-ascii?q?0LvETfBCD2gkT2jLKNdkk+5uip6/joYrXhppOGMY97lhr+Pbg0lsy6AOQ4Nh?=
 =?us-ascii?q?ACX2md+euiyL3u5VD1TbpFg/EskqTVrYrWKdoUq6KnGQNZz54v6xOlADen1N?=
 =?us-ascii?q?QYk2MHLFVAeB+fjYjoNU3BL+riDfejnVihiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudzXFBA5KQy1z/z7CNV8yIweQ2SPDb?=
 =?us-ascii?q?GZMa7Jv1+H/PkvI/WJZIAPuTb9L+Ip6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO1?=
 =?us-ascii?q?6ZbmTogtcAF2cKowU/Qff0iF2NTzFTfWy+X6Ei6TEhDoKpE4PDSpqqgLyb0y?=
 =?us-ascii?q?foVqFRM09PEEHELXblbYOJSr9YZyuIM4l9kzEeU7WwY4Eozg2rvQ7+jbFgK7?=
 =?us-ascii?q?yQsjYVsZPlychd+eLej1cx+CZyAsDb1HuCHE9umWZdRSA91bpj+wQpyEiI2L?=
 =?us-ascii?q?Jk2dREBNdT4LVPSQ58OpnCmb8pQ+vuUx7MK4/aAG2tRc+rVHRoE4M8?=
X-IPAS-Result: =?us-ascii?q?A2DTAABweLhc/wHyM5BlHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?WYqgTkBMiiEDoh7jDqYSoF7PAGCEoIuAoYZIzYHDgEDAQEBBAEBAQECAWwog?=
 =?us-ascii?q?jopAYJnAQUjFUEQCwkPAgImAgJXBgEMBgIBAYJfP4IJqQaBL4VHhGaBCycBi?=
 =?us-ascii?q?0mBVkCBOIJrPodOglcEgSsBkFlPk3QGA4IIhT2MYQYbgguKCIh0i3iWKggpg?=
 =?us-ascii?q?VYrCkGBaIFOgkWOJyMDMIEGAQGPagEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Apr 2019 13:17:31 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3IDHVYL023319;
        Thu, 18 Apr 2019 09:17:31 -0400
Subject: Re: [Non-DoD Source] [PATCH 0/2] checkmodule: allow building modules
 of a specific version
To:     Gary Tierney <gary.tierney@fastmail.com>, selinux@vger.kernel.org
References: <20190417163731.3434-1-gary.tierney@fastmail.com>
Cc:     Steve Smalley <sds@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <3ef5bbf3-4d1b-26a2-aa18-d32044259064@tycho.nsa.gov>
Date:   Thu, 18 Apr 2019 09:17:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417163731.3434-1-gary.tierney@fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/17/19 12:37 PM, Gary Tierney wrote:
> These changes come from a report by a user on the Freenode IRC channel that
> they were unable to build policies for a machine that has an older version of
> libsepol installed.
> 
> A new `-c` option that mirrors checkpolicy's own has been added to checkmodule,
> and the output of a simple test is shown below:
> 
> $ cat > test.te <<EOF
> module test 1.0;
> 
> require {
>      type domain;
>      type file_type;
>      class file { read write };
> }
> 
> allow domain file_type : file { read write };
> EOF
> $ obj/usr/bin/checkmodule -m -M -c 10 -o test.mod test.te
> $ checkpolicy/test/dismod test.mod
> Reading policy...
> ... snip ...
> Binary policy module file loaded.
> Module name: test
> Module version: 1.0
> Policy version: 10
> 
> Worthy of note, however, is that these policy version numbers differ from those
> used by the kernel policy format.
> 
> Gary Tierney (2):
>    checkmodule: add support for specifying module policy version
>    dismod: print policy version of loaded modules
> 
>   checkpolicy/checkmodule.8 |  5 ++++-
>   checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
>   checkpolicy/test/dismod.c |  4 ++--
>   3 files changed, 33 insertions(+), 5 deletions(-)
> 

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
