Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B5C4332F
	for <selinux@archiver.kernel.org>; Tue, 31 Oct 2023 17:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbjJaREY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Oct 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJaRDo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Oct 2023 13:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9368E10FD
        for <selinux@vger.kernel.org>; Tue, 31 Oct 2023 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698771771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dTycNRej7uoiARRZt/Tdde52ToB+Vho1BpSumrIUtks=;
        b=YGbwMVYtfivsF82g+p6czbA7SesR4uNCCXrkPBB1ImLZ9ZiDB+OUGS9g7qSkbbgUNhkC+G
        VM2JIcpcmmF9g7++usb+ILSN+L10V250YmlbLjIKYi9N+Alr9mp8k4HQGuR5IZjsf729nR
        Q1XugrRffVIlhWmNV2t+dso3v0NS+rc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Isx1tTOBNtiMt17xd0Jm5Q-1; Tue, 31 Oct 2023 13:02:47 -0400
X-MC-Unique: Isx1tTOBNtiMt17xd0Jm5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 688758723E1;
        Tue, 31 Oct 2023 17:02:47 +0000 (UTC)
Received: from localhost (unknown [10.45.224.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29840492BE0;
        Tue, 31 Oct 2023 17:02:46 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Huizhao Wang <wanghuizhao1@huawei.com>, selinux@vger.kernel.org
Cc:     weiyuchen3@huawei.com, dongxinhua@huawei.com,
        wanghuizhao1@huawei.com
Subject: Re: [PATCH] restorecond: compatible with the use of EUID
In-Reply-To: <20230805070650.197744-1-wanghuizhao1@huawei.com>
References: <20230805070650.197744-1-wanghuizhao1@huawei.com>
Date:   Tue, 31 Oct 2023 18:02:45 +0100
Message-ID: <87lebihgi2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Huizhao Wang <wanghuizhao1@huawei.com> writes:

> The `EUID` does not exist in some shell environments. To ensure compatibility,
> use `id -u` instead of `EUID` when `EUID` does not exist.
>
> Signed-off-by: Huizhao Wang <wanghuizhao1@huawei.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  restorecond/restorecond.init | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/restorecond/restorecond.init b/restorecond/restorecond.init
> index c1cbb247..4e71a2c6 100644
> --- a/restorecond/restorecond.init
> +++ b/restorecond/restorecond.init
> @@ -29,7 +29,11 @@ PATH=/sbin:/bin:/usr/bin:/usr/sbin
>  [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled || exit 7
>  
>  # Check that we are root ... so non-root users stop here
> -test $EUID = 0  || exit 4
> +if [ $EUID  ]; then
> +	test $EUID = 0  || exit 4
> +else
> +	test `id -u` = 0  || exit 4
> +fi
>  
>  test -x /usr/sbin/restorecond  || exit 5
>  test -f /etc/selinux/restorecond.conf  || exit 6
> -- 
> 2.12.3

