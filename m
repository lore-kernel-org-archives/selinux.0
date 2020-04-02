Return-Path: <SRS0=xdbR=5S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D568DC43331
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7B2073B
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDU0+KS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgDBNyY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:54:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgDBNyY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Apr 2020 09:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585835663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8UC5TO6dPoqrEYtlJl+7m9daPOEOgDEN7h1OleJLOs=;
        b=ZDU0+KS1bwKNXbFqwPML1rklqFnnrXn7J1AS3GbKQQ9dHkmxE0Io6W1FkZ9ViJRzIFSnDE
        HbSQ90nPZOIuLEOnW/zmrt6HhlZfa1OEYyec/4dxvApPwkGhU7gm13YtNcaFp3uMaXB7dP
        jiuGbTk2lFToJQprvNaMIuKNWmwAtLg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-EG771f2-NEes4sPZBg999A-1; Thu, 02 Apr 2020 09:53:40 -0400
X-MC-Unique: EG771f2-NEes4sPZBg999A-1
Received: by mail-ot1-f71.google.com with SMTP id k18so942177otr.3
        for <selinux@vger.kernel.org>; Thu, 02 Apr 2020 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8UC5TO6dPoqrEYtlJl+7m9daPOEOgDEN7h1OleJLOs=;
        b=lY6NJsW+ouTtO69xn7lSquswYqXetSwfuyI8uHEVxQWfYyj1yta0Y+jShyRWnpQSsa
         Sr/tjGX6L2lhEQieTtJCaX+WfvboSnqxer/2itAXF64I5mPWoiBZVVR0g84h+qQbu7Pg
         6UB1PE5NJzVrhsqDJxTHE/iwDcCxSuI4CNlTqgk7dveVqpNT5mlDU8aXMj9NJvq4MZNa
         hX20rWyMAgOXuTB55KmqsgKeTG2iz5jULpAt1IRekIOiD+HdIYAccP2lMvz3YX4QKGaw
         EUMzrRdlqc/eDsKbzd4OQq6cMFQrGOAMW+qyriZf6G/LTC+r8EUDXK9J6Zp13FZwtIXS
         H2Hw==
X-Gm-Message-State: AGi0PubQj6Kk25cOl389P6Y1W3qthJD0gUbJ7kQQviFveiPyHIlz+BNK
        1XcIfLzTFhU4BgN4BUdhalw1cFEtuLoMkdHRRiwR4m6KkLu8KvZ7WTi7M/IOK6dn2u7FGx4jkSE
        sf/6NPZ7sjw9Dwe1W0rRU79n3cm0YOhbEZg==
X-Received: by 2002:aca:488a:: with SMTP id v132mr2317246oia.166.1585835618862;
        Thu, 02 Apr 2020 06:53:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypId9T2blTHrCy2yeIfe8SHl8dLD404b4gFhEDRVJ8l4VmQraRSUuJptUFLqeVwhXztmKDpI9HUhSXOnzKgpXQU=
X-Received: by 2002:aca:488a:: with SMTP id v132mr2317227oia.166.1585835618601;
 Thu, 02 Apr 2020 06:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200402133945.8427-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200402133945.8427-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 2 Apr 2020 15:53:27 +0200
Message-ID: <CAFqZXNvp=yAyNM84vOxFdMaNAQ_=FTL00favpQr1mJ4GG261Lg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add notify gitignore file
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 2, 2020 at 3:40 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Add .gitignore to stop format-patch sucking in binaries
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  tests/notify/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/notify/.gitignore
>
> diff --git a/tests/notify/.gitignore b/tests/notify/.gitignore
> new file mode 100644
> index 0000000..fd7c5db
> --- /dev/null
> +++ b/tests/notify/.gitignore
> @@ -0,0 +1,2 @@
> +test_inotify
> +test_fanotify
> --
> 2.24.1
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

