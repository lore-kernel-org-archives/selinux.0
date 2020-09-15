Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCBEC433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 21:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AF920732
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 21:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOuzDQ8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIOVB4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728069AbgIOUoR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 16:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600202656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGp6JSCVcBqhP/aj0WY0629F6XLqv+Q4AiokI5jFF8g=;
        b=SOuzDQ8a+9CI+IPbqBCJ0vbjd0sx80snRMlLmD7xDxtFI3JK7dbVYNDVrcH5i/t28BfOwK
        7bChF4xHbCOazX8b5tHKSppho2G300HbNBHtQU3ayNsenVHabw37fiyTUG6h1VHUt0rMu0
        Rzo6bfayonOPI6TGLCoUAhNptYyqaQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-bAylwabmONqeCJNQDFOQvA-1; Tue, 15 Sep 2020 16:44:14 -0400
X-MC-Unique: bAylwabmONqeCJNQDFOQvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7926801AE9;
        Tue, 15 Sep 2020 20:44:13 +0000 (UTC)
Received: from x2.localnet (ovpn-116-206.rdu2.redhat.com [10.10.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA9D10016DA;
        Tue, 15 Sep 2020 20:44:13 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     selinux@vger.kernel.org,
        Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: Re: [PATCH 2/2] libselinux: Change userspace AVC setenforce and policy load messages to audit format.
Date:   Tue, 15 Sep 2020 16:44:12 -0400
Message-ID: <2574836.mvXUDI8C0e@x2>
Organization: Red Hat
In-Reply-To: <20200915173332.574700-2-chpebeni@linux.microsoft.com>
References: <20200915173332.574700-1-chpebeni@linux.microsoft.com> <20200915173332.574700-2-chpebeni@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tuesday, September 15, 2020 1:33:32 PM EDT Chris PeBenito wrote:
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
> ---
>  libselinux/src/avc_internal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index 572b2159..53a99a1f 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
>  	int rc = 0;
> 
>  	avc_log(SELINUX_SETENFORCE,
> -		"%s:  received setenforce notice (enforcing=%d)\n",
> +		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
>  		avc_prefix, enforcing);
>  	if (avc_setenforce)
>  		goto out;
> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
>  	int rc = 0;
> 
>  	avc_log(SELINUX_POLICYLOAD,
> -		"%s:  received policyload notice (seqno=%u)\n",
> +		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
>  		avc_prefix, seqno);
>  	rc = avc_ss_reset(seqno);
>  	if (rc < 0) {

These look good from an audit perspective.

Thanks,
-Steve


