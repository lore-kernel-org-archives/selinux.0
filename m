Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F9C433B4
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 10:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93786141E
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 10:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhEGKGw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 06:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234097AbhEGKGw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 06:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620381948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QT8QB/4/1fn3sJXAQrv6LrZysVNND6Zm7Cgjhjsxifs=;
        b=LuhkFjdCBitrArWKfaQd+nYclPHuPLnVgNkODonscSvZaUeCgCQ3sBFHn4j4tcXYD+h2qt
        zSfYMNpGh0k6MubHq5IdfBWhwyBHEZwLw02lLBMYjTtbvbSSiswo5MW/dmYnlms043QL27
        2i6qxNiGsKFaTB18YV1DjWERgt4jA5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-vV8mg-i0MLakIFvDD7PSQQ-1; Fri, 07 May 2021 06:05:46 -0400
X-MC-Unique: vV8mg-i0MLakIFvDD7PSQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B55107ACED;
        Fri,  7 May 2021 10:05:45 +0000 (UTC)
Received: from localhost (unknown [10.40.192.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4142370137;
        Fri,  7 May 2021 10:05:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: selinux_check_passwd_access_internal():
 respect deny_unknown
In-Reply-To: <20210503174636.54579-1-cgzones@googlemail.com>
References: <20210503174636.54579-1-cgzones@googlemail.com>
Date:   Fri, 07 May 2021 12:05:44 +0200
Message-ID: <87im3uhn9j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> `selinux_check_passwd_access_internal()`, and thereby
> `checkPasswdAccess(3)` and `selinux_check_passwd_access(3)`, does not
> respect the policy defined setting of `deny_unknown`, like
> `selinux_check_access(3)` does.
> This means in case the security class `passwd` is not defined, success
> is returned instead of failure, i.e. permission denied.
>
> Most policies should define the `passwd` class and the two affected
> public functions are marked deprecated.
>
> Align the behavior with `selinux_check_passwd_access(3)` and respect

Should it be "Align the behavior with `selinux_check_access(3)`" ?

> the deny_unknown setting in case the security class is not defined.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libselinux/src/checkAccess.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index b337ea64..022cd6b5 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -78,7 +78,9 @@ static int selinux_check_passwd_access_internal(access_=
vector_t requested)
>  		passwd_class =3D string_to_security_class("passwd");
>  		if (passwd_class =3D=3D 0) {
>  			freecon(user_context);
> -			return 0;
> +			if (security_deny_unknown() =3D=3D 0)
> +				return 0;
> +			return -1;
>  		}
>=20=20
>  		retval =3D security_compute_av_raw(user_context,
> --=20
> 2.31.1

