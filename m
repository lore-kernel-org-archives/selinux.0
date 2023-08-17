Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00602C27C7A
	for <selinux@archiver.kernel.org>; Thu, 17 Aug 2023 07:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbjHQHnb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Aug 2023 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348620AbjHQHnR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Aug 2023 03:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B752D6D
        for <selinux@vger.kernel.org>; Thu, 17 Aug 2023 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692258151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IVzx1cdBTqb0LE/PrSseJPSbTC904PyBnxTqJldFpf0=;
        b=bqEGzHerjMZsO2KuDNRLsUy70vB2Ir1tTzhU+xDtx/cB5j/b204Xue1mwWGeAUCaFdOD48
        O+tGBllWahwrkiSKdqZe4cbetzXuIuyanco2tDIF/3RRTJLSKXp+Zb832uPIBtyv2N52LU
        i+OPNKkvC85NVd83FU03toOmNz56FX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-0M42MezoP06l0DiR6Qfdsw-1; Thu, 17 Aug 2023 03:42:27 -0400
X-MC-Unique: 0M42MezoP06l0DiR6Qfdsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63B8280C909;
        Thu, 17 Aug 2023 07:42:27 +0000 (UTC)
Received: from localhost (unknown [10.45.225.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22FCB40C207A;
        Thu, 17 Aug 2023 07:42:27 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Subject: Re: [PATCH] libsepol: Fix the version number for the latest
 exported function
In-Reply-To: <20230816190934.729086-1-jwcart2@gmail.com>
References: <20230816190934.729086-1-jwcart2@gmail.com>
Date:   Thu, 17 Aug 2023 09:42:26 +0200
Message-ID: <87ttsyktct.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> cil_write_post_ast() should be in libsepol version 3.6, since version
> 3.5 has already been released.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libsepol/src/libsepol.map.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 6ad68f0b..e5e6608c 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -290,7 +290,7 @@ LIBSEPOL_3.4 {
>  	sepol_validate_transition_reason_buffer;
>  } LIBSEPOL_3.0;
>  
> -LIBSEPOL_3.5 {
> +LIBSEPOL_3.6 {
>    global:
>  	cil_write_post_ast;
>  } LIBSEPOL_3.4;
> -- 
> 2.41.0

