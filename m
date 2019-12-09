Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE9C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1029320836
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 18:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="L7ThWQt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLISEz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:04:55 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:65482 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLISEz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 13:04:55 -0500
X-EEMSG-check-017: 55551173|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="55551173"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Dec 2019 18:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575914692; x=1607450692;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MgfMPihTfaEFVKDvDyC0ny9pXQuOqe71fmXfKzl2eJ0=;
  b=L7ThWQt+oT3YyUAwX19QQrIdQBh8QKd1B8wnQGJcStaJwtRqdkLmc2Rk
   L0+V8gjMBN9XpZg8u/smldjEBkvFiqQfVC6ZiX/DH1u92o0niZegh7nO0
   BW+5+frRechiX0i8vS12IUYvrWvcIDC1pHOgQRt+6V5F3cH5RZIa3G3ZC
   wq+h77j0iLv4ywk121CPPinxdUVeL7RjKFt1Ujhaw/Vx+PyTzp2jRMvIA
   kzbonbn9HrqTMjGxiEpvCoyMCC7YOEHkn+BmEmFfEv5I5E2re6OWqVu/M
   WLVGsDyYYn7BY4TWlJFIxsh1TFgbjQuChdvfFmUrbXvkHwQKdTsJYgVJy
   A==;
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="36508868"
IronPort-PHdr: =?us-ascii?q?9a23=3AJzuwpBXfA0xkLSba41vG3aVFesrV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSHuKdThVPEFb/W9+hDw7KP9fy5AipZsM7K6ShdOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjfu8UMnIdvLro9xh?=
 =?us-ascii?q?TUrndUeeld2H9lK0+Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdF+g6JBpBKqugJxzYjaboqIMPZyZ63QcNcfSW?=
 =?us-ascii?q?dHQ81fVTFOApmkYoUSEeQBM+ZWoYrzqVQAohSxBxWjCuz0xz9UhHL7x7E23/?=
 =?us-ascii?q?gvHAzE2gErAtIAsG7TrNXwLKocTPy1w7fQzTXDcfxW3yr25pXNch87pfGMWa?=
 =?us-ascii?q?x/cMrMwkQoDAPKk06QpJf5PzKVyusNs2+b4/BmVeK0kWErsQ5xoj+xxso1jI?=
 =?us-ascii?q?TCm4Ebykjc+Clkz4s4Kse0RU5mbdK+DpdduD+WO5FrTs4kXmpmojw1yqcctp?=
 =?us-ascii?q?6+ZCUKzZMnyAPBZPGfaIiI5w7jVP6WITdlmHJpYLK/iAi28Uin0uD8StO70E?=
 =?us-ascii?q?xLripYidnArHEN1xrd6siAUfty4Fuu1SyT1wHT9u5EIUc0mbDdK5E92b4/io?=
 =?us-ascii?q?AfsUHCHi/ygEn2jamWeVs4+uWw9ujqbbrrqoWcOoNpkA3yLKsjltKlDeglKg?=
 =?us-ascii?q?QOWnKU+eW41L3t5035R7BKg+UtkqbEq5DXPtgbp66lDA9V1YYv8RC/Dyy839?=
 =?us-ascii?q?gCknkHK0xFdAqdj4f1I1HOPOz4DfCnjlS2izdrxu3JMaDmApXPL3jOi6vufb?=
 =?us-ascii?q?Fg5EFC0gUz0Mpf55VOCr4bOv7zXVXxtNPABB8jLwO02/rnCMl61o4GQmKAHK?=
 =?us-ascii?q?uZMKLUsV+V6eMiOPeMZIALtzbnMfQl5ODhjWU/mVADeamlx5wXaGq3Hv5+OU?=
 =?us-ascii?q?WWfWLsgssdEWcNpgc+VPbliECGUTNIf3a9Rb885jUiBIKjCofDQZqtj6Kb0C?=
 =?us-ascii?q?inGZ1WY3hMCkqQHnfwa4WER/AMZTqWIs9glDwESLegR5Y61R6wqAD61qBnLu?=
 =?us-ascii?q?vI+iwYrJ7j0d916PDOlRE26zN5FNqd026TQGFuhG8IRCE53Lp5oUNjzlePy6?=
 =?us-ascii?q?94g+ZXFY8b2/QcSBw7OZLbze1SANf+VwvcZNCTQRChWNriSSo8StM33s8mfU?=
 =?us-ascii?q?lwAZOhgwrF0i7sBKUaxJKRA5lhyb7Rx3j8IY5Gzn/C0KQwxw09TtBnKXythq?=
 =?us-ascii?q?k58RPaQYHOjRPKxO6Raa0A0XuVpy+4xm2UsRQdC199?=
X-IPAS-Result: =?us-ascii?q?A2A3AwApi+5d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IFsASASKoQCiQOGZwEBBAaBN4lpkUUJAQEBAQEBAQEBNwEBhEACgj04EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KYJvAQUjBBFBEAsYAgImAgJXBwwGAgEBgl8/g?=
 =?us-ascii?q?lMlrSl/M4VPgzqBSIEOKIwyeYEHgREnD4JdPodZgl4EjWKINGJGlxuCOII7k?=
 =?us-ascii?q?yUGG5oyLY4dnDwigVgrCAIYCCEPgydQERSMcheOQSMDMI8QAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Dec 2019 18:04:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB9I4b8Z190778;
        Mon, 9 Dec 2019 13:04:37 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     rsiddoji@codeaurora.org, selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
Date:   Mon, 9 Dec 2019 13:05:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
> Hi team ,
> Looks like we have  issue in handling the  "active_nodes" count in the
> Selinux - avc.c file.
> Where  avc_cache.active_nodes increase more than slot array   and code
> frequency calling of avc_reclaim_node()  from  avc_alloc_node() ;
> 
> Where following are the 2 instance which seem to  possible culprits which
> are seen on 4.19 kernel . Can you  comment if my understand is wrong.
> 
> 
> #1. if we see the  active_nodes count is incremented in  avc_alloc_node
> (avc) which is called in avc_insert()
> Where if the code take  failure path on  avc_xperms_populate  the code will
> not decrement this counter .
> 
> 
> static struct avc_node *avc_insert(struct selinux_avc *avc,
> 				   u32 ssid, u32 tsid, u16 tclass,
>   				   struct av_decision *avd,
> ....	
> 	node = avc_alloc_node(avc);  //incremented here
> ....
>                rc = avc_xperms_populate(node, xp_node);  // possibilities of
> this getting failure is there .
> 		if (rc) {
> 			kmem_cache_free(avc_node_cachep, node);  // but on
> failure we are not decrementing active_nodes ?
> 			return NULL;
>   		}

I think you are correct; we should perhaps be calling avc_node_kill() 
here as we do in an earlier error path?

> 
> #2.  where it looks like the logic on comparing the  active_nodes against
> avc_cache_threshold seems  wired  as the count of active nodes is always
> going to be
>   more than 512 will may land in simply  removing /calling  avc_reclaim_node
> frequently much before the slots are full maybe we are not using cache at
> best ?
>   we should be comparing with some high watermark ? or my understanding wrong
> ?
>   
> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
> 
>   	if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>   	    avc->avc_cache_threshold)      //  default  threshold is 512
>   		avc_reclaim_node(avc);
> 

Not entirely sure what you are asking here.  avc_reclaim_node() should 
reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly that should be 
configurable via selinuxfs too, and/or calculated from 
avc_cache_threshold in some way?

Were you interested in creating a patch to fix the first issue above or 
looking to us to do so?


