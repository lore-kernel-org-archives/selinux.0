Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C1C001B0
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjHHUrQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjHHUqq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 16:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2E34E5A
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+UV7HanGYBHPu0zknEay8A81vd6NnCt4Mzl+0IoCCA=;
        b=FQ/tdsTZk6Hbc4ZKu95CqCpxVReI2lotWSfje28a5qiNEzqK+DRtbAiVc973p4z8UBrsSa
        DxwYqJmaJP3f+44xMWCmBHV7AK7W9fFMyF31Vo9nVgWf6jYRm7m0GsoGzEVlc5MLRzUqly
        0mDFmF0swubqEmBZtmyAQ69eqvXboyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-fJsw37TrOx6e9Gl2wdf1IQ-1; Tue, 08 Aug 2023 06:30:56 -0400
X-MC-Unique: fJsw37TrOx6e9Gl2wdf1IQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54B8B80557C;
        Tue,  8 Aug 2023 10:30:56 +0000 (UTC)
Received: from localhost (unknown [10.45.224.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 157BE492C13;
        Tue,  8 Aug 2023 10:30:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] python: Use isinstance() instead of type()
In-Reply-To: <20230803134024.20849-1-jwcart2@gmail.com>
References: <20230803134024.20849-1-jwcart2@gmail.com>
Date:   Tue, 08 Aug 2023 12:30:55 +0200
Message-ID: <87wmy5su5c.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> CI testing fails while running flake8 on python scripts with the
> message "./python/semanage/seobject.py:250:16: E721 do not compare
> types, for exact checks use `is` / `is not`, for instance checks use
> `isinstance()`"
>
> Use "isinstance(args, str)" instead of "type(args) == str"
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


> ---
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 361205d1..cc944ae2 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -247,7 +247,7 @@ class semanageRecords:
>          global handle
>          if args:
>              # legacy code - args was store originally
> -            if type(args) == str:
> +            if isinstance(args, str):
>                  self.store = args
>              else:
>                  self.args = args
> -- 
> 2.41.0

