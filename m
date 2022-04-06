Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418EC433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 17:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiDFROr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiDFROY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 13:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3B05C36C
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649255717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oa9IrWW1yC/fjYlbuyw6FpW5U9ArsNZTK8AMqSSDbWM=;
        b=DwwmkEGvS2q2llVj9/3SLgkEXWtdVJ59oPWMsLI3RQ1ZoJcj8jGw0YotQbsw1iJrrBkJR/
        4UsPYs4sginKt6P4vFZ36qPMVV3KBHobSsDRnxcu9EnHz/PYv2JNNtdixYgmh1aaWueUIb
        gSEcMbyA0GPW3CmUzm+dybSUAhBq2QA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-h3USeqbcOYKTbN-T7YHP_Q-1; Wed, 06 Apr 2022 10:35:16 -0400
X-MC-Unique: h3USeqbcOYKTbN-T7YHP_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 528EF28025AB;
        Wed,  6 Apr 2022 14:35:16 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 017D940D1B98;
        Wed,  6 Apr 2022 14:35:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] libsepol/cil: post process pirqcon rules
In-Reply-To: <20220405133548.51598-3-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com>
 <20220405133548.51598-3-cgzones@googlemail.com>
Date:   Wed, 06 Apr 2022 16:35:15 +0200
Message-ID: <87v8vmnuu4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Already merged from
https://patchwork.kernel.org/project/selinux/patch/20220331144752.31495-3-c=
gzones@googlemail.com/
based on ack from
https://lore.kernel.org/all/CAP+JOzTokM6k+wTVneEeSLGGhH5A2r7XayLLotiu8XuFn=
=3DGW7g@mail.gmail.com/


> ---
>  libsepol/cil/src/cil_post.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 7f33cd9e..714ce227 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2434,6 +2434,12 @@ static int cil_post_db(struct cil_db *db)
>  		goto exit;
>  	}
>=20=20
> +	rc =3D __cil_post_process_context_rules(db->pirqcon, cil_post_pirqcon_c=
ompare, cil_post_pirqcon_context_compare, db, CIL_PIRQCON, CIL_KEY_IOMEMCON=
);
> +	if (rc !=3D SEPOL_OK) {
> +		cil_log(CIL_ERR, "Problems processing pirqcon rules\n");
> +		goto exit;
> +	}
> +
>  	rc =3D __cil_post_process_context_rules(db->iomemcon, cil_post_iomemcon=
_compare, cil_post_iomemcon_context_compare, db, CIL_IOMEMCON, CIL_KEY_IOME=
MCON);
>  	if (rc !=3D SEPOL_OK) {
>  		cil_log(CIL_ERR, "Problems processing iomemcon rules\n");
> --=20
> 2.35.1

