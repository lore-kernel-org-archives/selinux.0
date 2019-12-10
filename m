Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C3C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0D2077B
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 13:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kQuj4mDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJNol (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:44:41 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:17422 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfLJNok (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 08:44:40 -0500
X-EEMSG-check-017: 34153941|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="34153941"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 13:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575985476; x=1607521476;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BqrXrOlH2AwEczMne19p4RzjhaG6eEPCHqHn8/2G4PA=;
  b=kQuj4mDp6PojT3wI+KVBCAXbiy5KvwucPCO8IwjFEAd2bNwUAosb6n48
   eBhPSpXp1GzJufsyQIGEl3IxJcg4I55jR95isalxqkGoxSIH0Mi8/gbNj
   exkN9AdawASUkFdUxHbhr+kdVlq5e4R5QnII2DeGfGqLqQPtZaSm+mLl0
   aHVjiMZnksLQNy/o62X3yvMRC7D0iZOa3G+F9ApmQmMV3IFUJgkhAHpA1
   VNqiC8kBd++1iwOlBjq+JaSTSQAmvagT7r5Lkq4vTFgDxKz1OBL94o7vV
   C5YFb4UL6eMmoKMZsZyELVoWLhqW/D0APoJ64YNdenUUZ7eMdnp8lfbum
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="36538632"
IronPort-PHdr: =?us-ascii?q?9a23=3AfFd2PRMe8IlpRgdqQHwl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z+pcbcNUDSrc9gkEXOFd2Cra4d0KyP4vurBDdIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjVuMQajotvJ6gswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhH551OF7EBJOn+Wlfru9zFCh81Kgm0w+HgCNVnyIwSQ36AAq?=
 =?us-ascii?q?icMKnKq1+H+vovI/WQZI8SoDv9MOYq5/rvjX8/hF8ccrKk3YUYaH+mBPRqOU?=
 =?us-ascii?q?aZbmT2gtcHD2gKuhAyTOvwiF2NSTRTfWq9X7og5jEnD4KrFZ3DRpusgLOcwS?=
 =?us-ascii?q?i7GZ9WZmFdB1+QFnfnapuLVO0RaCKIJc9hiCYLWaKmS4872hGkrBX6xKZ/Lu?=
 =?us-ascii?q?rI5i0Ysoru1Nx05+3ViBEz+iV4D9+D3G6RUmF0hGIIRyM23axmpEx9zUqM0b?=
 =?us-ascii?q?V8g/NGDtFT+fxJXRkgNZLGzOx1FcryWgTfcdeNUlqmRc+mAT5iBu42lucHfk?=
 =?us-ascii?q?I1PtKllB2LizKjHrs9j7WWANkx9aXG0j76IMMrjz7d2a0giUQ2atVAOHfgha?=
 =?us-ascii?q?Nl8QXXQYnTnBa3jaGvIJ8A0TbN+WHL9m+HuEVVQUYkSqnedWwObUvR69Li7w?=
 =?us-ascii?q?XNSKH4WudvCRdI1cPXcvgCUdbul1gTAa65adk=3D?=
X-IPAS-Result: =?us-ascii?q?A2BJAACJn+9d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQDiQOGZgEBAQEBAQaBN4lpkUYJAQEBAQEBAQEBN?=
 =?us-ascii?q?wEBhEACgic4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBAQECASMEEUEQC?=
 =?us-ascii?q?xgCAiYCAlcGAQwGAgEBgl8/glMFIKwtdX8zhU+DP4FIgQ4ojDJ5gQeBEScPg?=
 =?us-ascii?q?l0+h1mCXgSNNolGRpcigjmCO5MvBhuaOC2OHZxCIoFYKwgCGAghDzuCbFARF?=
 =?us-ascii?q?IxyFxWOLCMDMI8rAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Dec 2019 13:44:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBADiHkZ235780;
        Tue, 10 Dec 2019 08:44:17 -0500
Subject: Re: [RFC PATCH] selinux: ensure we cleanup the internal AVC counters
 on error in avc_insert()
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     rsiddoji@codeaurora.org, linux-security-module@vger.kernel.org
References: <157594281322.676903.11041338053333686450.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f7e43b67-3f46-e480-f8b0-e86eff85293f@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 08:44:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157594281322.676903.11041338053333686450.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/19 8:53 PM, Paul Moore wrote:
> In AVC insert we don't call avc_node_kill() when avc_xperms_populate()
> fails, resulting in the avc->avc_cache.active_nodes counter having a
> false value.

incorrect value?

   This patch corrects this problem and does some cleanup
> in avc_insert() while we are there.

submitting-patches.rst recommends describing in imperative mood and 
avoiding the words "patch" in what will eventually just be a commit log, 
ala "Correct this problem and perform some cleanup..."

Should probably add a:

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")

Might be easier to back port if you split the cleanup from the fix, but 
your call of course.

> 
> Reported-by: rsiddoji@codeaurora.org
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/avc.c |   51 +++++++++++++++++++++++-------------------------
>   1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 23dc888ae305..6646300f7ccb 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -617,40 +617,37 @@ static struct avc_node *avc_insert(struct selinux_avc *avc,
>   	struct avc_node *pos, *node = NULL;
>   	int hvalue;
>   	unsigned long flag;
> +	spinlock_t *lock;
> +	struct hlist_head *head;
>   
>   	if (avc_latest_notif_update(avc, avd->seqno, 1))
> -		goto out;
> +		return NULL;
>   
>   	node = avc_alloc_node(avc);
> -	if (node) {
> -		struct hlist_head *head;
> -		spinlock_t *lock;
> -		int rc = 0;
> -
> -		hvalue = avc_hash(ssid, tsid, tclass);
> -		avc_node_populate(node, ssid, tsid, tclass, avd);
> -		rc = avc_xperms_populate(node, xp_node);
> -		if (rc) {
> -			kmem_cache_free(avc_node_cachep, node);
> -			return NULL;
> -		}
> -		head = &avc->avc_cache.slots[hvalue];
> -		lock = &avc->avc_cache.slots_lock[hvalue];
> +	if (!node)
> +		return NULL;
>   
> -		spin_lock_irqsave(lock, flag);
> -		hlist_for_each_entry(pos, head, list) {
> -			if (pos->ae.ssid == ssid &&
> -			    pos->ae.tsid == tsid &&
> -			    pos->ae.tclass == tclass) {
> -				avc_node_replace(avc, node, pos);
> -				goto found;
> -			}
> +	avc_node_populate(node, ssid, tsid, tclass, avd);
> +	if (avc_xperms_populate(node, xp_node)) {
> +		avc_node_kill(avc, node);
> +		return NULL;
> +	}
> +
> +	hvalue = avc_hash(ssid, tsid, tclass);
> +	head = &avc->avc_cache.slots[hvalue];
> +	lock = &avc->avc_cache.slots_lock[hvalue];
> +	spin_lock_irqsave(lock, flag);
> +	hlist_for_each_entry(pos, head, list) {
> +		if (pos->ae.ssid == ssid &&
> +			pos->ae.tsid == tsid &&
> +			pos->ae.tclass == tclass) {
> +			avc_node_replace(avc, node, pos);
> +			goto found;
>   		}
> -		hlist_add_head_rcu(&node->list, head);
> -found:
> -		spin_unlock_irqrestore(lock, flag);
>   	}
> -out:
> +	hlist_add_head_rcu(&node->list, head);
> +found:
> +	spin_unlock_irqrestore(lock, flag);
>   	return node;
>   }
>   
> 

