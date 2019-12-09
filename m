Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39850C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04E22077B
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iQIYv2N7";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Qbyd3o3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLIP4A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:56:00 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:42718
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbfLIP4A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 10:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575906959;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=4Cga0lZOowX0o4Q6/b5Uqw434bX5zOMw4GgYknmuCXg=;
        b=iQIYv2N7m+lnvrZmfq3Z2rBsDtcm6GJ0fSOvfIcrCCvsh9rAFEBIbPLeZ3QLnvU1
        HaRUnu8aA4cT6WGlV9tdB+OGC64nHv95xjED/qkCjAVqPpTDwuzR37j4CyTwqBR3+gP
        JG8HE8lBzbRwcsLVFdOsArpN44Yg0RG7X6S9nihU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575906959;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=4Cga0lZOowX0o4Q6/b5Uqw434bX5zOMw4GgYknmuCXg=;
        b=Qbyd3o3zZOyvcPqJIUFPiATxbwQm2IZyDdHHTq61RMXMMTK7Hl4yWQoJxG0SwPRC
        oWNKVv7U3VTjZuSbpEz1KWO52C2774vlIdoY/BZE/bTcko//P7P/KCUtaIV5NUKZWLD
        RDX/KTvo6vODxebTEuOinJCNiZ0t7TfLh6uiqTac=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07307C447AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   <rsiddoji@codeaurora.org>
To:     <selinux@vger.kernel.org>
Cc:     <paul@paul-moore.com>, <linux-security-module@vger.kernel.org>,
        <sds@tycho.nsa.gov>
Subject: Looks like issue in handling   active_nodes count  in 4.19 kernel .
Date:   Mon, 9 Dec 2019 15:55:59 +0000
Message-ID: <0101016eeb5fe01d-f423431d-d9d9-4290-ae38-8b451ffc3eef-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdWuphyeVQIzpEdGQ+WvGTVrgnJThA==
Content-Language: en-us
X-SES-Outgoing: 2019.12.09-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi team , 
Looks like we have  issue in handling the  "active_nodes" count in the
Selinux - avc.c file. 
Where  avc_cache.active_nodes increase more than slot array   and code
frequency calling of avc_reclaim_node()  from  avc_alloc_node() ;

Where following are the 2 instance which seem to  possible culprits which
are seen on 4.19 kernel . Can you  comment if my understand is wrong.


#1. if we see the  active_nodes count is incremented in  avc_alloc_node
(avc) which is called in avc_insert() 
Where if the code take  failure path on  avc_xperms_populate  the code will
not decrement this counter . 


static struct avc_node *avc_insert(struct selinux_avc *avc,
				   u32 ssid, u32 tsid, u16 tclass,
 				   struct av_decision *avd,
....	
	node = avc_alloc_node(avc);  //incremented here
....
              rc = avc_xperms_populate(node, xp_node);  // possibilities of
this getting failure is there .
		if (rc) {
			kmem_cache_free(avc_node_cachep, node);  // but on
failure we are not decrementing active_nodes ?
			return NULL;  
 		}

#2.  where it looks like the logic on comparing the  active_nodes against
avc_cache_threshold seems  wired  as the count of active nodes is always
going to be
 more than 512 will may land in simply  removing /calling  avc_reclaim_node
frequently much before the slots are full maybe we are not using cache at
best ?
 we should be comparing with some high watermark ? or my understanding wrong
?
 
/*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */

 	if (atomic_inc_return(&avc->avc_cache.active_nodes) >   
 	    avc->avc_cache_threshold)      //  default  threshold is 512 
 		avc_reclaim_node(avc);


Regards,
Ravi

