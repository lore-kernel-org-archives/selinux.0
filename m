Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C673C4160E
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670F564EC0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376661AbhCDAYZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244409AbhCCPLi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Mar 2021 10:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614784145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAkCcj6vA/bpWwdkURcgbxXzkdvMv6Bt/nOQ1LxzlMo=;
        b=MfBOeTGWcxqy3ldcwI9/XDCzJ7DbXKnpLj/w7SrBRoMRiEFdFhWf8G7pURfg3if3FGNVIg
        fK6XlUMRmTikvmgzE0lSICAv+09kUOhjxtef8yTF7HUnYysdVkfb2XLZLS6UWEqX8acAGe
        yBpFrhdVg1EgJO9Z+avwzZcZxO+pfhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-spOHDQSHPsCwnU0eIc5e7A-1; Wed, 03 Mar 2021 10:09:01 -0500
X-MC-Unique: spOHDQSHPsCwnU0eIc5e7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD934CC622;
        Wed,  3 Mar 2021 15:09:00 +0000 (UTC)
Received: from localhost (unknown [10.40.196.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D97360D07;
        Wed,  3 Mar 2021 15:08:59 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 1/1] restorecond: invalidate local_lock_fd properly when
 closing it
In-Reply-To: <20210228084809.8387-1-nicolas.iooss@m4x.org>
References: <20210228084809.8387-1-nicolas.iooss@m4x.org>
Date:   Wed, 03 Mar 2021 16:08:58 +0100
Message-ID: <871rcwjmut.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> If flock(local_lock_fd,...) fails, in function local_server(), the file
> descriptor to the lock file is closed but local_lock_fd is not reset to
> -1. This leads to server() calling end_local_server(), which closes the
> file descriptor again.
>
> Fix this double-close issue by setting local_lock_fd to -1 after closing
> it.
>
> This issue was found by using Facebook's Infer static analyzer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

and merged. Thanks!

> ---
>  restorecond/user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/restorecond/user.c b/restorecond/user.c
> index a24b8407b048..47b86823ff79 100644
> --- a/restorecond/user.c
> +++ b/restorecond/user.c
> @@ -230,9 +230,10 @@ static int local_server(void) {
>  		return -1;
>  	}
>  	if (flock(local_lock_fd, LOCK_EX | LOCK_NB) < 0) {
> -		close(local_lock_fd);
>  		if (debug_mode)
>  			perror("flock");
> +		close(local_lock_fd);
> +		local_lock_fd = -1;
>  		return -1;
>  	}
>  	/* watch for stdin/terminal going away */
> -- 
> 2.30.0

