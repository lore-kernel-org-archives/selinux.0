Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C4DC47096
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2EE613E6
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 11:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCLVO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Jun 2021 07:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhFCLVN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Jun 2021 07:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622719168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAsw96s+mQctHpFwHC10CFQOEQ8Qyox3Sxaklpq+fzY=;
        b=Aeb5f0nGelmDH3dUpJl/TAPs3ajcI8DB46A3FP7JQXO/OebPEqIC06IA+aOTkoCIrzYtJZ
        HIwlCfHEkKzdebveRWTI72xEkIvkXZMLuc6PaLimwm2Hj2aLQr2BmC/JiR5XzKVOPd0tsb
        6KjpMLjaLBm9Gc8Aul4zZgciAJdhb70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-DLafeG62NX-ase2sN-HKZg-1; Thu, 03 Jun 2021 07:19:27 -0400
X-MC-Unique: DLafeG62NX-ase2sN-HKZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCAAF1020C57;
        Thu,  3 Jun 2021 11:19:26 +0000 (UTC)
Received: from localhost (unknown [10.40.194.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63741687EC;
        Thu,  3 Jun 2021 11:19:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: selinux_status_open: return 1 in fallback mode
In-Reply-To: <20210601150523.7016-1-cgzones@googlemail.com>
References: <20210601150523.7016-1-cgzones@googlemail.com>
Date:   Thu, 03 Jun 2021 13:19:25 +0200
Message-ID: <87r1hjp54y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> In case of a recurring call to `selinux_status_open(3)`, which
> previously has been opened in fallback mode, return `1` according to its
> documentation.
>
> Fixes: c5a699046f4 ("libselinux: make selinux_status_open(3) reentrant")
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libselinux/src/sestatus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 531a522c..89c1f621 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -283,7 +283,7 @@ int selinux_status_open(int fallback)
>  	uint32_t	seqno;
>=20=20
>  	if (selinux_status !=3D NULL) {
> -		return 0;
> +		return (selinux_status =3D=3D MAP_FAILED) ? 1 : 0;
>  	}
>=20=20
>  	if (!selinux_mnt) {
> --=20
> 2.32.0.rc2

