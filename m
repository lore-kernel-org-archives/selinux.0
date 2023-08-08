Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83617C001DB
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 19:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjHHTcq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjHHTc1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 15:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7135C22727
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691516175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6cRon06Hl8GTz6/8IwrjqSOlGttGxf7yOEZh/0gRGk=;
        b=fLvBT1MFBGDPOmRB1wOC0pAqw+O3rbpyXEdzN9ctd8B8WQcMcgMi27zj+3lYzKKTUp+Tc8
        KTxvT+tqai5PMmURhbOlbFHbwuSx9i3R8RXPvX8zky82XdByW9TPHgo5OJifIdcB56/udB
        6n5u8owmvd0/uL2DellIFevfqOA3JM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-lvNK2diTOu21P_b06IlnJQ-1; Tue, 08 Aug 2023 06:30:25 -0400
X-MC-Unique: lvNK2diTOu21P_b06IlnJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5943685CBE8;
        Tue,  8 Aug 2023 10:30:25 +0000 (UTC)
Received: from localhost (unknown [10.45.224.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8412026D68;
        Tue,  8 Aug 2023 10:30:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [RFC PATCH] semanage: use instance check
In-Reply-To: <20230807185510.237623-1-cgzones@googlemail.com>
References: <20230807185510.237623-1-cgzones@googlemail.com>
Date:   Tue, 08 Aug 2023 12:30:24 +0200
Message-ID: <87zg31su67.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Please flake8:
>
>     ./python/semanage/seobject.py:250:16: E721 do not compare types, for =
exact checks use `is` / `is not`, for instance checks use `isinstance()`
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


Thanks, but it's already proposed

https://lore.kernel.org/selinux/20230803134024.20849-1-jwcart2@gmail.com/T/=
#u


> ---
> This currently breaks the GitHub CI.
> ---
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 361205d1..cc944ae2 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -247,7 +247,7 @@ class semanageRecords:
>          global handle
>          if args:
>              # legacy code - args was store originally
> -            if type(args) =3D=3D str:
> +            if isinstance(args, str):
>                  self.store =3D args
>              else:
>                  self.args =3D args
> --=20
> 2.40.1

