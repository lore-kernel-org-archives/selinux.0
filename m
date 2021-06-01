Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED10C47080
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494FE60FE5
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhFAOPR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234077AbhFAOPR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Jun 2021 10:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622556815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU7ATh05ZwWwuelmGoVAdb6Htk20sBsX22d0c0CUuhk=;
        b=GYnoz81K6r5O/h6eKu9+eGgC73xqdQ4ot2uBGAfDA1q5wf2oe7QDCVrVfw5LT9Y600OzLi
        svPMXCWTblEeHfXTQ5ct8Jd0hz+SUeO+CI38EAtz6f0Y7MTJ9p4j9XIl9eCt/adBY0Orxc
        Se9khWABHNSaWZ40kQMhFSKWi8yy7tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-j8VhbzUkMiSXv-iMYYfAZw-1; Tue, 01 Jun 2021 10:13:30 -0400
X-MC-Unique: j8VhbzUkMiSXv-iMYYfAZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ED67180FD63;
        Tue,  1 Jun 2021 14:13:29 +0000 (UTC)
Received: from localhost (unknown [10.40.192.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2903A6087C;
        Tue,  1 Jun 2021 14:13:28 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 3/3] libselinux: do not use status page fallback mode
 internally
In-Reply-To: <20210510105648.14635-4-cgzones@googlemail.com>
References: <20210510105648.14635-1-cgzones@googlemail.com>
 <20210510105648.14635-4-cgzones@googlemail.com>
Date:   Tue, 01 Jun 2021 16:13:27 +0200
Message-ID: <87y2btllko.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Currently `avc_init_internal()`, called by `avc_open(3)` and
> `avc_init(3)`, does open the SELinux status page with fallback mode
> enabled.
>
> Quote from man:selinux_status_open(3):
>     In this case, this function tries to open a netlink socket using
>     .BR avc_netlink_open (3) and overwrite corresponding callbacks
>     (setenforce and policyload).  Thus, we need to pay attention to the
>     interaction with these interfaces, when fallback mode is enabled.
>
> Calling `selinux_status_open` internally in fallback mode is bad, cause
> it overrides callbacks from client applications or the internal
> fallback-callbacks get overridden by client applications.
> Note that `avc_open(3)` gets called under the hood by
> `selinux_check_access(3)` without checking for failure.
> Also the status page is available since Linux 2.6.37, so failures of
> `selinux_status_open(3)` in non-fallback mode should only be caused by
> policies not allowing the client process to open/read/map
> the /sys/fs/selinux/status file.

Acked-by: Petr Lautrbach <plautrba@redhat.com>

All 3 are merged now.

Thanks!

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 8314d7ba..daaedbc6 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -214,7 +214,7 @@ static int avc_init_internal(const char *prefix,
>  		avc_enforcing =3D rc;
>  	}
>=20=20
> -	rc =3D selinux_status_open(1);
> +	rc =3D selinux_status_open(0);
>  	if (rc < 0) {
>  		avc_log(SELINUX_ERROR,
>  			"%s: could not open selinux status page: %d (%s)\n",
> --=20
> 2.31.1

