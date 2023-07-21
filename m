Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B3EB64DC
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 07:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGUHnD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jul 2023 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjGUHmu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jul 2023 03:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC330D6
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689925316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaZ2LJGT3FelkWmiArR817HklHWV4cxn03KYTWihQTc=;
        b=MvH4pce5H9yMYj7jTQRn55NyQrpT0oipKZxKF+QZHEo5cQPCN0oH4BjljEo+D+aYwoMPPg
        vyrGpkKhrODJo9rnOMwPrUfG0QnD+c80UO/tShwKpVvcGqeRDVekcP/HdAKs5jCyPljvTV
        iXK7PEQHKoxgKASp9m7Y3Ue7MRiXWE4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-8Y1AVHSUPGWMyFAy55yRKQ-1; Fri, 21 Jul 2023 03:41:55 -0400
X-MC-Unique: 8Y1AVHSUPGWMyFAy55yRKQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-402fa256023so4347761cf.0
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 00:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925314; x=1690530114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NaZ2LJGT3FelkWmiArR817HklHWV4cxn03KYTWihQTc=;
        b=DzrEX8WRKHjRvbl8Bg85oyrOmFopMTYYY6RKqScfekJa+XSap8ZGMuzIm1gwJzdQFQ
         dN6Nl1Lpck0+yTMCQate0IZPsWceERTv6cLucz2OzaI0D8j1CSXKG4gnaLSfC0PM91/2
         AUAFFbpQFRnr2w0uwyCe7ACv8s4ju+jMk6sUOtDLhLkjgpC2OwvZErcxuDwRX1zdvnu6
         XWglaqMCW9Vrsx+mnA1yk+XEZ0JkfeeeibDTZh+pT/OgtaJdLxCCw4GWOHj1vrCyF+by
         wANunFoQ+kYek3//+UCxvg/EBhUOzRwBfSHDCJcBRkP1RfDaXVGNwSQpbRjZjrRWwUGA
         tZpA==
X-Gm-Message-State: ABy/qLalApOAVpjY/UbcVFZK63dvcw0n1xrKesGATtlMM41UtpYkxe3o
        1N0jumr9Sn91lE0IqUdkPKjjbgGpFz9mSvcGsUtmg+c6AJt+3H4plA6B/qe+uPAGEyg6srsIykS
        SeK42SDDSCvjIx91/Xs0V8WdrgQ==
X-Received: by 2002:ac8:5f4d:0:b0:403:b11f:29f0 with SMTP id y13-20020ac85f4d000000b00403b11f29f0mr1699188qta.0.1689925314640;
        Fri, 21 Jul 2023 00:41:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESMgUHKplR1ZeqNN1P+qx8tXt0MuPCDjl4MukdiNfEt+1Vp2J41BKTYAjyZzT2CmeDb8cvlg==
X-Received: by 2002:ac8:5f4d:0:b0:403:b11f:29f0 with SMTP id y13-20020ac85f4d000000b00403b11f29f0mr1699181qta.0.1689925314377;
        Fri, 21 Jul 2023 00:41:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id hf1-20020a05622a608100b003ef2db16e72sm1019610qtb.94.2023.07.21.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:41:54 -0700 (PDT)
Message-ID: <242c259961bbcc16752b1ec3165ae1794becb8f8.camel@redhat.com>
Subject: Re: [PATCH] selinux: fix a 0/NULL mistmatch in
 ad_net_init_from_iif()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date:   Fri, 21 Jul 2023 09:41:51 +0200
In-Reply-To: <20230720203116.316250-2-paul@paul-moore.com>
References: <20230720203116.316250-2-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On Thu, 2023-07-20 at 16:31 -0400, Paul Moore wrote:
> Use a NULL instead of a zero to resolve a int/pointer mismatch.
>=20
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307210332.4AqFZfzI-lkp@i=
ntel.com/
> Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() helpe=
rs")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6f53fa71fbdb..5194f12def97 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -246,7 +246,7 @@ static void ad_net_init_from_iif(struct common_audit_=
data *ad,
>  				 struct lsm_network_audit *net,
>  				 int ifindex, u16 family)
>  {
> -	__ad_net_init(ad, net, ifindex, 0, family);
> +	__ad_net_init(ad, net, ifindex, NULL, family);
>  }
> =20
>  /*

Oops, my fault! Thanks for fixing it!

Acked-by: Paolo Abeni <pabeni@redhat.com>

/P

