Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F3C4167B
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiLPOND (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 09:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiLPOM7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 09:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB92BB06
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 06:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671199937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bm5zkNNvaWFIoEff9MlHmY4ezvY8eMgtT/aACI19x8I=;
        b=cgpUPUV3GnRcuntLFswIRB1QdSzFgf0GS8WQ3y9CVxpgy9tp56N6UUFD96HGcuGs/OG14G
        hUNf58iqIXThJ9LCLLeWmGADK1pQ7Dgkruc2MFOsSnX1+MN1Wrk0yiCnAVX8+YSs102eg3
        EN6K/4k75sWzqwsCcKZhl/1vj76Njo0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-lKppGk-ANCq-AsykcJup-Q-1; Fri, 16 Dec 2022 09:12:15 -0500
X-MC-Unique: lKppGk-ANCq-AsykcJup-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A608281DE75;
        Fri, 16 Dec 2022 14:12:15 +0000 (UTC)
Received: from localhost (ovpn-192-144.brq.redhat.com [10.40.192.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51BFD492C14;
        Fri, 16 Dec 2022 14:12:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     kkz <izhaoshuang@163.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] sepolicy: fix a spelling mistake
In-Reply-To: <20221216041602.19344-1-izhaoshuang@163.com>
References: <20221216041602.19344-1-izhaoshuang@163.com>
Date:   Fri, 16 Dec 2022 15:12:14 +0100
Message-ID: <871qozbfpd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

kkz <izhaoshuang@163.com> writes:

> From: kkz <zhaoshuang@uniontech.com>
>
> Signed-off-by: kkz <zhaoshuang@uniontech.com>

Signed-off-by: needs to contain your real name - no pseudonyms or
anonymous contributions. Without this it doesn't serve its purpose, see

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---
>  python/sepolicy/sepolicy/templates/script.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/templates/script.py b/python/sepolicy/sepolicy/templates/script.py
> index c79738b8..564a6b38 100644
> --- a/python/sepolicy/sepolicy/templates/script.py
> +++ b/python/sepolicy/sepolicy/templates/script.py
> @@ -75,7 +75,7 @@ rpmbuild --define "_sourcedir ${pwd}" --define "_specdir ${pwd}" --define "_buil
>  """
>  
>  manpage="""\
> -# Generate a man page off the installed module
> +# Generate a man page of the installed module
>  sepolicy manpage -p . -d DOMAINTYPE_t
>  """
>  
> -- 
> 2.20.1

