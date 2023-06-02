Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8895CC7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 14:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjFBOaE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjFBO3p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 10:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB72AE55
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685716141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdr6+Et9h+sX0BzqK6ZWoWKOisR31PgmCi237aluS5Q=;
        b=UR9LTUAkj6u/5BqgnJ8223SJMt8GwuV/ikV5/ivYTwnY0pj4TCWjhyZwWKKS91EIRYV8T3
        C1xcK8F/peZbeWITHzbtdFDlJugr2T+L2y1eDAkluK3XsBrG6aqznxbokv7RM/iXsn2SVC
        vyOMarWdQgPoojuVUJfQQhD3IvaKet0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-Xjh01vZbNSe6-_WneVdTYQ-1; Fri, 02 Jun 2023 10:28:58 -0400
X-MC-Unique: Xjh01vZbNSe6-_WneVdTYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012CF3C13926;
        Fri,  2 Jun 2023 14:28:58 +0000 (UTC)
Received: from localhost (unknown [10.45.224.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B637C1410F26;
        Fri,  2 Jun 2023 14:28:57 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] secilc: consider DESTDIR in tests
In-Reply-To: <20230602130646.24835-1-cgzones@googlemail.com>
References: <20230602130646.24835-1-cgzones@googlemail.com>
Date:   Fri, 02 Jun 2023 16:28:57 +0200
Message-ID: <87bkhyj5ue.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Use the script `env_use_destdir` to preload libsepol from the DESTDIR
> location to support development changes like policy version bumps.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

It would not work when run from secilc-...tar.gz sources. In such case I
would expect that the environment is already prepared from outside.


> ---
>  secilc/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 94be0481..5a85df67 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -34,9 +34,9 @@ $(SECILC): $(SECILC_OBJS)
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>=20=20
>  test: $(SECILC)
> -	./$(SECILC) test/policy.cil
> -	./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/=
opt-input.cil
> -	$(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
> +	../scripts/env_use_destdir ./$(SECILC) test/policy.cil
> +	../scripts/env_use_destdir ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/n=
ull -o opt-actual.bin test/opt-input.cil
> +	../scripts/env_use_destdir $(CHECKPOLICY) -b -C -M -o opt-actual.cil op=
t-actual.bin >/dev/null
>  	$(DIFF) test/opt-expected.cil opt-actual.cil
>=20=20
>  $(SECIL2CONF): $(SECIL2CONF_OBJS)
> --=20
> 2.40.1

