Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E2C48BDF
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 14:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9523610A3
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhFROzX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234718AbhFROzW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 10:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624027992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEDN9Dh+DinsZnWf36SJlbXI7/KxXOGDZRqeeSNeNDc=;
        b=WlHmrg+W/XZGkDpzkCnslrCk41Jux2GLqnB6Zw094WhD5wfP2hOXgPqPtu0OYPJLxNUpTv
        BZU2yvWfPBa1UPcInaV9CeZRpDK6kisbRf9jXlmdjFy46Xqp03h7FL+hig1fqMyJCWePag
        C50NCW9cz4lpmHJEfXkm9o0s8wNsPn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-BLFboKwVPWmmU38X-5AxRQ-1; Fri, 18 Jun 2021 10:53:11 -0400
X-MC-Unique: BLFboKwVPWmmU38X-5AxRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4476AEC1A5;
        Fri, 18 Jun 2021 14:53:10 +0000 (UTC)
Received: from localhost (unknown [10.40.195.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEDE660CC9;
        Fri, 18 Jun 2021 14:53:09 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libsepol: Quote paths when generating policy.conf from
 binary policy
In-Reply-To: <20210616144843.79344-1-jwcart2@gmail.com>
References: <20210616144843.79344-1-jwcart2@gmail.com>
Date:   Fri, 18 Jun 2021 16:53:08 +0200
Message-ID: <87mtrn1ay3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> submitted a similar patch
> to quote paths when generating CIL policy from a binary policy.
>
> Since genfscon and devicetreecon rules have paths which are allowed
> to contain spaces, always quote the path when writing out these rules.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> ---
>  libsepol/src/kernel_to_conf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 5db47fe4..ffdf179a 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2527,7 +2527,7 @@ static int write_genfscon_rules_to_conf(FILE *out, =
struct policydb *pdb)
>  				goto exit;
>  			}
>=20=20
> -			rc =3D strs_create_and_add(strs, "genfscon %s %s %s", 3,
> +			rc =3D strs_create_and_add(strs, "genfscon %s \"%s\" %s", 3,
>  						 fstype, name, ctx);
>  			free(ctx);
>  			if (rc !=3D 0) {
> @@ -2992,7 +2992,7 @@ static int write_xen_devicetree_rules_to_conf(FILE =
*out, struct policydb *pdb)
>  			goto exit;
>  		}
>=20=20
> -		sepol_printf(out, "devicetreecon %s %s\n", name, ctx);
> +		sepol_printf(out, "devicetreecon \"%s\" %s\n", name, ctx);
>=20=20
>  		free(ctx);
>  	}
> --=20
> 2.26.3

