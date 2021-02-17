Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A40C433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38C064DF0
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 17:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhBQRCQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234338AbhBQRB5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Feb 2021 12:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613581230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpfeOXQxElOLokpSxzPtW966JaqaldWofHI0AoPSL1U=;
        b=Kn1BRaGlrJivOH60V+NNSlCGE3mPUGbnMvVxeNlV2mdBsh4RRx8UqMmlSBLGXVqrog+WPn
        4zjkCDp9sQ4iRbluJ0QHH/uY5JsrVEtee9uxixwGRTiZwhhWIka5AXAsElO3nhEj9xiBtw
        D+BuZe8qWJ0+24u3N1WWd+cvI3wY+S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-8lx4MrvDPX-ZRn-YxeWi2Q-1; Wed, 17 Feb 2021 12:00:28 -0500
X-MC-Unique: 8lx4MrvDPX-ZRn-YxeWi2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F02CE1020C28;
        Wed, 17 Feb 2021 17:00:25 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1876A03C;
        Wed, 17 Feb 2021 17:00:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] libselinux/getconlist: report failures
In-Reply-To: <20210203171654.37002-1-cgzones@googlemail.com>
References: <20210203171654.37002-1-cgzones@googlemail.com>
Date:   Wed, 17 Feb 2021 18:00:24 +0100
Message-ID: <8735xuhbo7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Check the given context a priori, to print a more user friendly message,
> opposed to a generic following get_ordered_context_list/_with_level
> failure.
>
> Notify the user about failures of get_ordered_context_list/_with_level,
> so no-context-found and a failure results are distinguishable.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/getconlist.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
> index 29c16640..76654b75 100644
> --- a/libselinux/utils/getconlist.c
> +++ b/libselinux/utils/getconlist.c
> @@ -58,8 +58,14 @@ int main(int argc, char **argv)
>  			free(level);
>  			return 2;
>  		}
> -	} else
> +	} else {
>  		cur_context =3D argv[optind + 1];
> +		if (security_check_context(cur_context) !=3D 0) {
> +			fprintf(stderr, "Given context '%s' is invalid.\n", cur_context);
> +			free(level);
> +			return 3;

3 is already used for "memory allocation failure: %d(%s)\n" error
But I'm not sure if it's important



> +		}
> +	}
>=20=20
>  	/* Get the list and print it */
>  	if (level)
> @@ -72,6 +78,11 @@ int main(int argc, char **argv)
>  		for (i =3D 0; list[i]; i++)
>  			puts(list[i]);
>  		freeconary(list);
> +	} else {
> +		fprintf(stderr, "get_ordered_context_list%s failure: %d(%s)\n",
> +			level ? "_with_level" : "", errno, strerror(errno));
> +		free(level);
> +		return 4;
>  	}
>=20=20
>  	free(level);
> --=20
> 2.30.0

