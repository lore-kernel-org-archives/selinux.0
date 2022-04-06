Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2AFC433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 17:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiDFRNV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiDFRMO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 13:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6798B43D80C
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649255606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/T+vcMj+coq2sYC/xuWKXSB+8bJ/D+AJAkbl5ZpREO4=;
        b=HSeHp652kOabCc09v4yLbGCP0OUHj9pEk/dApjKqxrSc9ouD9LDBNg+vDzdAHd/UjTuvfW
        yxozTbXdGOLkKnBFlPq858tTHZO/0jHnRigrIFqFzQjBpYf5bjE9uXAZuUEvOnUTVVzHOu
        KDXdVjwbW7Rt7baQ5r/nveLK3kO5XAQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-oD_TOP_7OXS9iq8VZLHgXw-1; Wed, 06 Apr 2022 10:33:25 -0400
X-MC-Unique: oD_TOP_7OXS9iq8VZLHgXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A731F3C01C34;
        Wed,  6 Apr 2022 14:33:24 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58FB8428F0C;
        Wed,  6 Apr 2022 14:33:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2 2/6] libsepol/cil: drop unused function cil_tree_error
In-Reply-To: <20220405133548.51598-2-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com>
 <20220405133548.51598-2-cgzones@googlemail.com>
Date:   Wed, 06 Apr 2022 16:33:23 +0200
Message-ID: <87y20inux8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> It seems to be unused since its initial addition in 76ba6eaa
> ("Squashed 'libsepol/cil/' changes from 08520e9..28ad56e").
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Already merged from
https://patchwork.kernel.org/project/selinux/patch/20220331144752.31495-2-c=
gzones@googlemail.com/
based on ack from https://lore.kernel.org/all/CAP+JOzRYFWE=3DsL05iWJJSYxr+0=
bAXKBe=3Dd9Kim1h4=3DjAZ85xZQ@mail.gmail.com/


> ---
>  libsepol/cil/src/cil_tree.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 525b60d4..6376c208 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -41,15 +41,6 @@
>  #include "cil_parser.h"
>  #include "cil_strpool.h"
>=20=20
> -__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void ci=
l_tree_error(const char* msg, ...)
> -{
> -	va_list ap;
> -	va_start(ap, msg);
> -	cil_vlog(CIL_ERR, msg, ap);
> -	va_end(ap);
> -	exit(1);
> -}
> -
>  struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node,=
 char **info_kind, uint32_t *hll_line, char **path)
>  {
>  	int rc;
> --=20
> 2.35.1

