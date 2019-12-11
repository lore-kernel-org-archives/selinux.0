Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ABC43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C18214D8
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YwpmLulX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfLKOgw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:36:52 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:26550 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfLKOgw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 09:36:52 -0500
X-EEMSG-check-017: 37423694|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="37423694"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Dec 2019 14:36:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576075009; x=1607611009;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=V7TKKmR1W79bm3+n6v9uZkD2rN0UNWCr9v9v3+4ip5U=;
  b=YwpmLulXMCDi+QmZWBBMj6RI5WkN/lg4qtBuFtlPUGH+vG1ZmA1bqnV8
   0d6GFJR2ny6KKar70AkWQdctONQjUJvwAX0CwawMqByCVXH3ZbUC7wNfM
   LRXX/+77uYYZ2eEO4y0C200ztltZ07jdMIP0h/O/6r4TpRvQ8pi9Ud9sX
   AY8elPRR7xOZpdLnbMFcNqZlHndRuipa70l1OQiGXXQkJRGL9VF5OZwpc
   HVW5W10xD4fXjhMs4XCTGYrq19xrcKLk7juy7DzAAgHo+edjir5/ELI50
   uUqjStqHhsOjqNE9oAZWK+pzYYiXISwLd41zCPBiOdUzix1JF2B1k25vH
   A==;
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="36601933"
IronPort-PHdr: =?us-ascii?q?9a23=3AqCd1sRIH1nvK87XXI9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvz5rarrMEGX3/hxlliBBdydt6sfzbOH7uu9CCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAHRu8UZgYZvLrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gygJLT459HzchNJ2gqxVvRmtowVzz5DQbY2QMvd1Y6HTcs4ARW?=
 =?us-ascii?q?dZQ8hfSSJBDIO/YYUBAeUOMuRXoJXyqVYVsRuzBxOhCP/zxjJGhHL727Ax3e?=
 =?us-ascii?q?Q7EQHB2QwtB88AsGjKo9XtNKcdT+a1x7TVwzXGdfxW3TP955bIcxs8pvyMRq?=
 =?us-ascii?q?9/cdHKxEkzFwLKklWQqYv/MzOTzeQCqXKX7+VnVeKxkmMqrRx6rDu3xso0l4?=
 =?us-ascii?q?XEiY0YxkrE+Clk2oo5O9K1RFBhbdK5FpZbqjuUOJFsQsw4RmFloCM6yrobtp?=
 =?us-ascii?q?GlZCUK05EnxwLHa/yAboiI/grvVOaPLjd8g3JoYK6/iAyo8Uih1+38TdO40F?=
 =?us-ascii?q?dMripLldnMrW4C2ADJ5sibSvpy4keh2TGV2wDV9u5EOlw7mbDeK54gxr48jp?=
 =?us-ascii?q?sTsULdES/qgEj6kaCbe0o+9uWo9ujreKvqq5CCO4Nulw3yKqEulda+AeQ8PA?=
 =?us-ascii?q?gORW+b+eGk2b344EL5W65HjuE2k6bFsJDaIt4XpqiiAwBPyIoj5BG/Dym+3N?=
 =?us-ascii?q?QCgXYHNE5FeA6Aj4XxIVHOO/H4AuqijFSrkjdrxuvLMaHmAprQMHfMiqrhfa?=
 =?us-ascii?q?x6605G0gU/19df54hbCrsZOvL8RlfxtMDEDh8+KwG02PjoCNF81oMYRGKODb?=
 =?us-ascii?q?SUML3dsVCW/OIjOeqMa5EPuDb7Nfcl4+TijXgjmV8SZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWLsjc0cEWcOpQc+VPbliECGUTJKYnayWKU85islB468EYjDQYWtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfsdoWEXeoMaS2LLs96jDMLSaWhS5Ug1RGytA720r9nLu?=
 =?us-ascii?q?3J9S0FsZLsysN45/PclR4s7zx4Fced3H+XT2FygGwIQyU63KdloUxymR+/1v?=
 =?us-ascii?q?1imP1UGdtR5ttCVQs3PIPGyPZzTdfoVUaJZdqNSVC7Uv24DjwrCNE82dkDZw?=
 =?us-ascii?q?B6AdrxoArE2n+RH7INl7GNTKcx+6bY0mm5c91x0F7axaIhiB8gWcIJOmq40P?=
 =?us-ascii?q?0svzPPDpLExh3K352hcr4RiWuXpWo=3D?=
X-IPAS-Result: =?us-ascii?q?A2D1AAB5/vBd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEA4kDhmsBAQEBAQEGgTeJaZFGCQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oIpOBMCEAEBAQQBAQEBAQUDAQFshUOCOymCegEBAQEDIwQRQQwECxEEAQEBA?=
 =?us-ascii?q?gImAgJPCAcMBgIBAYJfP4JTJaw7dX8zhU+DQIFIgQ4ojDJ5gQeBEScPgl0+h?=
 =?us-ascii?q?1mCXgSNZog6YkaXI4I5gjyTNAYbmkAtjh2cSSKBWCsIAhgIIQ+DJ1ARFIxyF?=
 =?us-ascii?q?45BIwMwDI8ZAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Dec 2019 14:36:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBBEaXbr149397;
        Wed, 11 Dec 2019 09:36:33 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     rsiddoji@codeaurora.org, selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
Date:   Wed, 11 Dec 2019 09:37:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/19 1:30 PM, rsiddoji@codeaurora.org wrote:
> Thanks for quick response , yes it will be helpful if you can raise the change .
> On the second issue  in  avc_alloc_node we are trying to check the  slot status  as    active_nodes  > 512 ( default )
> Where  checking the occupancy  should be corrected as     active_nodes > 80% of slots occupied  or 16*512 or
> May be we need to use a different logic .

Are you seeing an actual problem with this in practice, and if so, what 
exactly is it that you are seeing and do you have a reproducer?

> 
>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
>>
>>    	if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>    	    avc->avc_cache_threshold)      //  default  threshold is 512
>>    		avc_reclaim_node(avc);
>>
> 
> Regards,
> Ravi
> 
> -----Original Message-----
> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On Behalf Of Stephen Smalley
> Sent: Monday, December 9, 2019 11:35 PM
> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
> Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
> 
> On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
>> Hi team ,
>> Looks like we have  issue in handling the  "active_nodes" count in the
>> Selinux - avc.c file.
>> Where  avc_cache.active_nodes increase more than slot array   and code
>> frequency calling of avc_reclaim_node()  from  avc_alloc_node() ;
>>
>> Where following are the 2 instance which seem to  possible culprits
>> which are seen on 4.19 kernel . Can you  comment if my understand is wrong.
>>
>>
>> #1. if we see the  active_nodes count is incremented in
>> avc_alloc_node
>> (avc) which is called in avc_insert()
>> Where if the code take  failure path on  avc_xperms_populate  the code
>> will not decrement this counter .
>>
>>
>> static struct avc_node *avc_insert(struct selinux_avc *avc,
>> 				   u32 ssid, u32 tsid, u16 tclass,
>>    				   struct av_decision *avd,
>> ....	
>> 	node = avc_alloc_node(avc);  //incremented here ....
>>                 rc = avc_xperms_populate(node, xp_node);  //
>> possibilities of this getting failure is there .
>> 		if (rc) {
>> 			kmem_cache_free(avc_node_cachep, node);  // but on failure we are
>> not decrementing active_nodes ?
>> 			return NULL;
>>    		}
> 
> I think you are correct; we should perhaps be calling avc_node_kill() here as we do in an earlier error path?
> 
>>
>> #2.  where it looks like the logic on comparing the  active_nodes
>> against avc_cache_threshold seems  wired  as the count of active nodes
>> is always going to be
>>    more than 512 will may land in simply  removing /calling
>> avc_reclaim_node frequently much before the slots are full maybe we
>> are not using cache at best ?
>>    we should be comparing with some high watermark ? or my
>> understanding wrong ?
>>    
>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
>>
>>    	if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>    	    avc->avc_cache_threshold)      //  default  threshold is 512
>>    		avc_reclaim_node(avc);
>>
> 
> Not entirely sure what you are asking here.  avc_reclaim_node() should reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly that should be configurable via selinuxfs too, and/or calculated from avc_cache_threshold in some way?
> 
> Were you interested in creating a patch to fix the first issue above or looking to us to do so?
> 
> 
> 

