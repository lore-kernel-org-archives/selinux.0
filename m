Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDDC433B4
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 08:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20F8611C9
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 08:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELILM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 04:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhELILL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 04:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620807003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHpGX61IkL3fAajwgAXkY+0iylI9Y82GpIXp4MZVGKU=;
        b=N+/bSrr7cpg4kRyiCbGyamYGFHylwkaaJcWbet4jeDTtI759GE8NSeqHkdDVNW7i+WI5lw
        iTpsHItLVormUC/KSo0Y1Kz2IY+mIBegkhZulzabN1HBdeAkG9KLNP8daFAysIjrk+DnBX
        /NKqpB2HMRXFFnxynNNcQMF+ldXMW6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144--_7JouUBPaGROBcltL5FFQ-1; Wed, 12 May 2021 04:10:01 -0400
X-MC-Unique: -_7JouUBPaGROBcltL5FFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E94C800D62;
        Wed, 12 May 2021 08:10:01 +0000 (UTC)
Received: from localhost (unknown [10.40.194.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7438A19D7C;
        Wed, 12 May 2021 08:10:00 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2] libselinux: selinux_check_passwd_access_internal():
 respect deny_unknown
In-Reply-To: <20210510101238.6741-1-cgzones@googlemail.com>
References: <20210503174636.54579-1-cgzones@googlemail.com>
 <20210510101238.6741-1-cgzones@googlemail.com>
Date:   Wed, 12 May 2021 10:09:58 +0200
Message-ID: <87v97ogyp5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
> Align the behavior with `selinux_check_access(3)` and respect
> the deny_unknown setting in case the security class is not defined.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Merged, thanks!

> ---
> Fixed function name in commit message, spotted by Petr Lautrbach.
>
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

