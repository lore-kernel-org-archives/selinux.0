Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C931C48BCD
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5F461285
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 12:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhFIMia (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhFIMia (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 08:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623242195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWmzSsgvgp2elATp8t7akZk6IZ4vonCZmrxC/TeApJw=;
        b=ZwBWFbywifkVfePwc1fHKPIbIeVUnhSja+GRGi0GIne1JgSVlkaQzRIYpjhaVEwFDWUMLo
        3j49lZHLn99WXlrnasW/glkKPdGaTnKp1J4LIjpYD7FO9rAehutlTpyftl2X/twWaLjmr0
        SNc2Xl+vnGdI2huC0EOI2lK04wxcrBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-wyPF_Y0pMk6QqWgTrRO3_Q-1; Wed, 09 Jun 2021 08:36:34 -0400
X-MC-Unique: wyPF_Y0pMk6QqWgTrRO3_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8574F8AA180;
        Wed,  9 Jun 2021 12:36:33 +0000 (UTC)
Received: from localhost (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 186365D75A;
        Wed,  9 Jun 2021 12:36:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: fix typo
In-Reply-To: <20210608153644.29176-1-cgzones@googlemail.com>
References: <20210608153644.29176-1-cgzones@googlemail.com>
Date:   Wed, 09 Jun 2021 14:36:31 +0200
Message-ID: <87mtrznrjk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libselinux/src/regex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
> index 10c3df78..2dfa2534 100644
> --- a/libselinux/src/regex.h
> +++ b/libselinux/src/regex.h
> @@ -44,7 +44,7 @@ struct mmap_area;
>  char const *regex_arch_string(void) ;
>=20=20
>  /**
> - * regex_verison returns the version string of the underlying regular
> + * regex_version returns the version string of the underlying regular
>   * regular expressions library. In the case of PCRE it just returns the
>   * result of pcre_version(). In the case of PCRE2, the very first time t=
his
>   * function is called it allocates a buffer large enough to hold the ver=
sion
> --=20
> 2.32.0

