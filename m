Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D52C2D0D2
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFA221582
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="puxvVVcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfLQQXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:23:25 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:62451 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfLQQXZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 11:23:25 -0500
X-EEMSG-check-017: 38929291|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="38929291"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 16:23:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576599800; x=1608135800;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qf5MG/6StXmkltm26fo5hZmet/UlD8Ve+FZMWDw6mB0=;
  b=puxvVVcOlEOkFBwCEQxczEhdDOsv3X5al7GkTje01afOnON4va+aRRpZ
   EcxhgPWzKnjCD+AXwJr8RCWFuyJRMbNrTt3B2gHPmHqRofgVQKKXPgXnw
   WsnkI+wLpES2z7aQReGHKSq6JN0nb5H6OPIwvHeIGPYNRvdVtMINIe98G
   9U++04TkHWOFbiMuegrkxzO4uyYN8R0p0AjE8QMibSCcpEVSPQWa5coFb
   FU3z0EXpj8CAZb9qoDrVP//Q9Ev0cvlJ+GpYx68qtk0zRpCTFIUfmOT0o
   cpEQ2wHQRxu2yEt0mN8RWXWV7gtgXuBGut3rnnGgnDOI8jSdUV5xCXAOV
   w==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="36849656"
IronPort-PHdr: =?us-ascii?q?9a23=3Ap/3qlBSPoGsxobse+3GrlM6ZJtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBKPt8tkgFKBZ4jH8fUM07OQ7/m7HzZYvt3R7TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZdgJ6o+yR?=
 =?us-ascii?q?bEomZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0gw+EdIAs3raotv6O6gQXu+pw6fF1inDYvBM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqsBIOnyWkDsqdPYCR05Mw2vzun7D9Vyy50RVniSAq?=
 =?us-ascii?q?+DN6PSq0WH6vgoI+mWa48foCz9JOQ95/7ykX85nkcQfbK30psTaXC4GOlmIk?=
 =?us-ascii?q?qCbHryjdcOD30KshA9TOP0kl2CVyBcZ3KoU6I7/DE7B5qsDZ3fSYC1nLyBwC?=
 =?us-ascii?q?C7E4VOZm9cF1CMFWzld52eVPcRbCKeO8phkjsDVbi7VYAtzw2htAj/y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTkRAy9TppD8WSym2NVH97kX8VRz8s3aB/vUx8xk6G0a?=
 =?us-ascii?q?h/nvNYCNhT6O1SXwckOp7T0fZ6B8rxWg3fZNeJTkipQtG8DTE2VNIxzIxGX0?=
 =?us-ascii?q?EoIdy8j1jgwi+jGfculrCHA541/avG3jClPd18x3rB1qgJhF4qT8JSL2q8j+?=
 =?us-ascii?q?h47QeFQ8bSnkGYkbu6XboT0TSL92qZy2eK+kZCX11eS6LACEsDa1PWoNKx3U?=
 =?us-ascii?q?bLS7ujGPxzKQda4dKTIatNLNvyhBNJQ+m1a4eWWH64h2rlXUXA/biLdoe/Pj?=
 =?us-ascii?q?xGjSg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BNAAAJAPld/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoF0gRhVIBIqhASJA4Z0BAaBN4lqj16BZwkBAQEBAQEBAQEjF?=
 =?us-ascii?q?AEBhEACgjw4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMECwEFQRAJA?=
 =?us-ascii?q?hgCAiYCAlcGAQwGAgEBgl8/AYJSJZIlm3R/M4kMgUiBDiiMMnmBB4ERJw+CX?=
 =?us-ascii?q?T6EEhIOgyeCXgSXUpczgj6CQoRtjlsGG4JDdIcCkBAtjiCBRpsYIoFYKwgCG?=
 =?us-ascii?q?AghD4MnCUcRFJNbiBsjAzCPP4JBAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Dec 2019 16:23:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHGMv8K104662;
        Tue, 17 Dec 2019 11:22:57 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
 <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
 <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
 <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
 <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
Message-ID: <0f6b6f32-e4bc-1ec0-dc27-2f4214ea479a@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 11:23:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/17/19 10:52 AM, Stephen Smalley wrote:
> On 12/17/19 10:40 AM, Ravi Kumar Siddojigari wrote:
>> Yes  indeed this is a stress test on ARM64 device with multicore  
>> where most of the cores /tasks are stuck  in avc_reclaim_node .
>> We still see this issue even after picking the earlier patch " 
>> selinux: ensure we cleanup the internal AVC counters on error in 
>> avc_insert() commit: d8db60cb23e4"
>> Where selinux_state  during issue was as below where all the slots 
>> are  NULL and the count was more than threshold.
>> Which seem to be calling avc_reclaim_node always and as the all the 
>> slots are empty its going for full for- loop with locks and unlock and 
>> taking too long .
>> Not sure what could make the  slots null , for sure its not due to 
>> flush() /Reset(). We think that still we need to call  avc_kill_node  
>> in update_node function .
>> Adding the patch below can you please review or correct the following 
>> patch .
>>
>>
>>    selinux_state = (
>>      disabled = FALSE,
>>      enforcing = TRUE,
>>      checkreqprot = FALSE,
>>      initialized = TRUE,
>>      policycap = (TRUE, TRUE, TRUE, FALSE, FALSE, TRUE),
>>      avc = 0xFFFFFF9BEFF1E890 -> (
>>        avc_cache_threshold = 512,  /* <<<<<not configured and its with 
>> default*/
>>        avc_cache = (
>>          slots = ((first = 0x0), (first = 0x0), (first = 0x0), (first 
>> = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), 
>> (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first   
>> /*<<<< all are NULL */
>>          slots_lock = ((rlock = (raw_lock = (val = (counter = 0), 
>> locked = 0, pending = 0, locked_pending = 0, tail = 0), magic = 
>> 3735899821, owner_cpu = 4294967295, owner = 0xFFFFFFFFFFFFFFFF, 
>> dep_map = (key = 0xFFFFFF9BEFF298A8, cla
>>          lru_hint = (counter = 616831529),
>>          active_nodes = (counter = 547),   /*<<<<< increased more than 
>> 512*/
>>          latest_notif = 1)),
>>      ss = 0xFFFFFF9BEFF2E578)
>>
>>
>> -- 
>> In AVC update we don't call avc_node_kill() when avc_xperms_populate()
>> fails, resulting in the avc->avc_cache.active_nodes counter having a
>> false value.In last patch this changes was missed , so correcting it.
>>
>> Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
>> Signed-off-by: Jaihind Yadav<jaihindyadav@codeaurora.org>
>> ---
>>   security/selinux/avc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index 91d24c2..3d1cff2 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -913,7 +913,7 @@ static int avc_update_node(struct selinux_avc *avc,
>>          if (orig->ae.xp_node) {
>>                  rc = avc_xperms_populate(node, orig->ae.xp_node);
>>                  if (rc) {
>> -                       kmem_cache_free(avc_node_cachep, node);
>> +                       avc_node_kill(avc, node);
>>                          goto out_unlock;
>>                  }
>>          }
>> -- 
> 
> That looks correct to me; I guess that one got missed by the prior fix.
> Still not sure how your AVC got into that state though...
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

BTW, have you been running these stress tests on earlier kernels too? 
If so, what version(s) are known to pass them?  I ask because this code 
has been present since v4.3 and this is the first such report.

