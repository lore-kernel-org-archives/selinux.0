Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D89C25B47
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 10:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjJYKiC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 06:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjJYKhh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 06:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF611FE8
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698230149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWykZ5vtPqo0/815ZXb0i7VbEsrPBQAlOnYEeQK1jvg=;
        b=CfUO+CU9B7otMmXu9hAnz+BxJl1Ne2L52HB+T6mZNPmuaW/5NpYEWEXXpKgDoVl1gH6Gp5
        BtBo2tjgMygc2DT+LZZR3U/oWrb1/2dhXXA5NLnBuMWBUO0NRo6uCvrlpVRvONlTbcYFvp
        qDE3ZlLM1EFgdH/HsBENfcNm95QBgV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Z1YzsmKpPSOZbQL73mnswA-1; Wed, 25 Oct 2023 06:35:48 -0400
X-MC-Unique: Z1YzsmKpPSOZbQL73mnswA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D53F8891F29;
        Wed, 25 Oct 2023 10:35:47 +0000 (UTC)
Received: from localhost (unknown [10.45.225.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97455492BFA;
        Wed, 25 Oct 2023 10:35:47 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Cc:     selinux@suse.de, Cathy Hu <cahu@suse.de>
Subject: Re: [PATCH] sepolicy/manpage.py: make output deterministic
In-Reply-To: <20231025094923.248941-1-cahu@suse.de>
References: <20231025094923.248941-1-cahu@suse.de>
Date:   Wed, 25 Oct 2023 12:35:46 +0200
Message-ID: <8734xzhtvh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Cathy Hu <cahu@suse.de> writes:

> The list entries in the alphabetically grouped dict are
> not sorted, which results in non-deterministic output for
> index.html.
>
> Sort entries of those lists to make the output deterministic
> to be able to have reproducible builds.
>
> See https://reproducible-builds.org/ for reasoning.
> This patch was done while working on reproducible builds for openSUSE.

Looks good to me, thanks.

We just need you to provide Signed-off-by: tag, see
https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md#contributing-code
and Developer Certificate of Origin


> ---
>  python/sepolicy/sepolicy/manpage.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> index a488dcbf..62999019 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -156,7 +156,7 @@ def get_alphabet_manpages(manpage_list):
>              if j.split("/")[-1][0] == i:
>                  temp.append(j.split("/")[-1])
>  
> -        alphabet_manpages[i] = temp
> +        alphabet_manpages[i] = sorted(temp)
>  
>      return alphabet_manpages
>  
> -- 
> 2.42.0

