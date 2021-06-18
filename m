Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B990C48BE8
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C86861260
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 14:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhFROxf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234383AbhFROxd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 10:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624027883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2SUNiDJUoHnmZNK+W4d6Cp+tI2g53D5rb/a5fHVnNo=;
        b=gd4bW8LkQg97A3uvf/3xcsCxNhWWuN9c4SNmOnIwEcMQDkXUrTCskEwK9+Rn1up32W0leS
        QeY6attDFAwxQYsRmFq6nMwaIeeVJxNgkwUCKbedjgpAk2X+ocpV8034TA2g3Wxk4kNjPa
        fipRMpW/WLIM70AfmSoIFC58tz+fdDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209--Qyi9CW9PR-Fwa30y7SjbQ-1; Fri, 18 Jun 2021 10:51:21 -0400
X-MC-Unique: -Qyi9CW9PR-Fwa30y7SjbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E1E800C78;
        Fri, 18 Jun 2021 14:51:20 +0000 (UTC)
Received: from localhost (unknown [10.40.195.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E82160C2B;
        Fri, 18 Jun 2021 14:51:20 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] selinux.8: document how mount flag nosuid affects SELinux
In-Reply-To: <20210612090738.22408-1-toiwoton@gmail.com>
References: <20210612090738.22408-1-toiwoton@gmail.com>
Date:   Fri, 18 Jun 2021 16:51:19 +0200
Message-ID: <87pmwj1b14.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> Using mount flag `nosuid` also affects SELinux domain transitions but
> this has not been documented well.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged. Thanks!


> ---
>  libselinux/man/man8/selinux.8 | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> index 0ef01460..5842150b 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -94,6 +94,13 @@ and reboot.
>  also has this capability.  The
>  .BR restorecon / fixfiles
>  commands are also available for relabeling files.
> +
> +Please note that using mount flag
> +.I nosuid
> +also disables SELinux domain transitions, unless permission
> +.I nosuid_transition
> +is used in the policy to allow this, which in turn needs also policy capability
> +.IR nnp_nosuid_transition .
>  .
>  .SH AUTHOR
>  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
> -- 
> 2.30.2

