Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C4BC4332F
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 17:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbiEDRKV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356773AbiEDRJm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 13:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0869219C1A
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651683332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/8tEEIRxqpe4ElSJJ94RDqsuPUh4CaZRSGMppcSKdg=;
        b=a+K2K+amcFUdhggZShXpTwC1b6yClxc2XfbeH9dYws5vrU9o+bS3q0msNMCWjubrfMtiJb
        9dSjnt0I8XQWRm2I6TpbKlieVHtj+FlE5pJfIt6b2MWXDyV0OX0sJFudJd9ZET0WYf31vQ
        y5crbZM6BDxww2Tk+QnoudKkRECbVFw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-psgnwU4DMBCM9cxtH7R4Kw-1; Wed, 04 May 2022 12:55:31 -0400
X-MC-Unique: psgnwU4DMBCM9cxtH7R4Kw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB54C1D32368;
        Wed,  4 May 2022 16:55:30 +0000 (UTC)
Received: from localhost (unknown [10.40.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56FB843E77A;
        Wed,  4 May 2022 16:55:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] checkpolicy: mention class name on invalid permission
In-Reply-To: <20220426105914.15817-1-cgzones@googlemail.com>
References: <20220426105914.15817-1-cgzones@googlemail.com>
Date:   Wed, 04 May 2022 18:55:29 +0200
Message-ID: <87ilql8cfy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> When a permission for a constraint statement cannot be found also
> mention the related class name.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 16b78346..a4c24115 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3627,7 +3627,7 @@ int define_constraint(constraint_expr_t * expr)
>  				}
>  				if (!perdatum) {
>  					yyerror2("permission %s is not"
> -						 " defined", id);
> +						 " defined for class %s", id, policydbp->p_class_val_to_name[i]);
>  					free(id);
>  					ebitmap_destroy(&classmap);
>  					return -1;
> --=20
> 2.36.0

