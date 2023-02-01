Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE77C05027
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 15:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjBAPII (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjBAPHu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 10:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA96C11E
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 07:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675263842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ISx+/p8VOMpkYmH1RPS2XxMV2pIX3uzURlUUuQRGg5Q=;
        b=gAj7h7nsPyX9Gi5hiStlQO5Hsjpyhs3olBOtvyFaDluNoOIb0uZ5gTBmIj/qHSxWNaKu3M
        zpPS+vOekGmWpA3X/b3tidWp/s5FY1LRSTs/OK1MbAf9kNQx//fJOVhjefGZTJ1+WTA5Z6
        xXlnhE2nDa1QNYlALJgQ9pd0bnlhels=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-kPfiA1IpNrSMTn9mANhz2A-1; Wed, 01 Feb 2023 10:04:00 -0500
X-MC-Unique: kPfiA1IpNrSMTn9mANhz2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 128EB3801F51;
        Wed,  1 Feb 2023 15:04:00 +0000 (UTC)
Received: from localhost (ovpn-193-64.brq.redhat.com [10.40.193.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE133C15BAE;
        Wed,  1 Feb 2023 15:03:59 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] mcstrans: preserve runtime directory
In-Reply-To: <20230117172050.18462-1-cgzones@googlemail.com>
References: <20230117172050.18462-1-cgzones@googlemail.com>
Date:   Wed, 01 Feb 2023 16:03:58 +0100
Message-ID: <87tu0577hd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Do not remove the runtime directory /run/setrans/, which is the parent
> for the security context translation socket .setrans-unix, when the
> service is stopped, so the path can not be taken over by a foreign
> program, which could lead to a compromise of the context translation of
> libselinux.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I lost Jim's Acked-by mail but according to
https://lore.kernel.org/all/CAP+JOzSvvg_2pZ6aeLGs9Oqh2nK0zpBGAURwbofh9DSAT3=
9iVw@mail.gmail.com/
it was acked and it's merged now.

Thanks.



> ---
>  mcstrans/src/mcstrans.service | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
> index c13cd09a..fdcfb0d4 100644
> --- a/mcstrans/src/mcstrans.service
> +++ b/mcstrans/src/mcstrans.service
> @@ -9,6 +9,7 @@ Conflicts=3Dshutdown.target
>  [Service]
>  ExecStart=3D/sbin/mcstransd -f
>  RuntimeDirectory=3Dsetrans
> +RuntimeDirectoryPreserve=3Dtrue
>=20=20
>  [Install]
>  WantedBy=3Dmulti-user.target
> --=20
> 2.39.0

