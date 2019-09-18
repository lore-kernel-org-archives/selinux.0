Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD6DC4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2824521897
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZQtl4a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfIRNqr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:46:47 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40100 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIRNqr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 09:46:47 -0400
Received: by mail-ed1-f48.google.com with SMTP id v38so29517edm.7
        for <selinux@vger.kernel.org>; Wed, 18 Sep 2019 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y7qeS3gi5KwCRjYF2MrMCiR6kMor8h6UCjygWuFUkCc=;
        b=LZQtl4a9W2V1jE2dl3JUElHPrGksByLhZZtE2u8ngL74k3SI6+fm1EeK2JHyEfXpp2
         wYzjNh6r+c8NTSlhjUy1NI7n5wCdIE3IJN/EpxEkSSUATZmxm9YAqDc3EAIXSeb9Y7bp
         JAdURk7LGOInRuMD9Lv67jXrRt8tOkgjFSuTRShzxu8EHjnoX+4Q7E5iovwRJH+xah6u
         LWIo0t/J3miiuv2n0Mia86YvDqpY5grQw6NNx8/Sz5usfKxYdsP285tZiyA57808pwbj
         TZ+KjKVURbAqPFfXun331lO9pykE/6iK5AcgE9dcxhH1mwrMcvq867zpAnYDsCrkJOml
         loBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=y7qeS3gi5KwCRjYF2MrMCiR6kMor8h6UCjygWuFUkCc=;
        b=WObdOvrsmRRdybRXih9sZoFLSjwx1SRs/bTts1CQ0QwE7IwKEfn4GR7IgNZPJvi/6p
         +sKx4QytvCdLBl7UPe3XGLgNdfKV+0sKUfZqEIyWTc+BinfIqWL5OdDa4hwnOhS37p04
         9xtza4FUZiILVuwozREMSQmPJ+GPriApbztrB8T5lVicforpcC/syGTikob4hXWGZN1N
         9d9MlpLtENjyJ5mIqbbbkc68XGKS7Vkh/Wopx8Pm3gaiMGohONFEIioqSJSZrUKCqjNh
         YP2W8G5CCeU2XHNRL+UVE95SfF4uwasPUsGzApmzfBSrLa5wTNwAi4vcQ+lQtDmZp4o6
         +F2w==
X-Gm-Message-State: APjAAAV7+iEFR91UOz404MSF1u4T6THcueZLn49BIUnTsEui4o6qRvGv
        fExuaUg7QlunjqFGvTpFQ1w=
X-Google-Smtp-Source: APXvYqy5GtKgGv/VBdqumk2d2EV38JRiGmHMuWfBQZGXhYOjumRyavnTTMQSejXYdNvgysgChjCrSQ==
X-Received: by 2002:a05:6402:34d:: with SMTP id r13mr10427982edw.20.1568814405269;
        Wed, 18 Sep 2019 06:46:45 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id a11sm1056712edf.73.2019.09.18.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:46:44 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:42 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ted Toth <txtoth@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: strange tclass in AVCs
Message-ID: <20190918134642.GA15688@seamus.lan>
Mail-Followup-To: Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 08:35:09AM -0500, Ted Toth wrote:
> I'm seeing things like tclass=3Dcontext#012 in some AVCs what is this tel=
ling me?

https://selinuxproject.org/page/ObjectClassesPerms#context

>=20
> Ted



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2CNT0ACgkQJXSOVTf5
R2nTDgwAhLm/WykAIZSzo148WV0ytYkQjM8nMTjmj5iUhflNtZmxE9ZCCZpK/aiE
HUeBLmhj2ik+EVvuAuNCbosV3rDWElwnyD4C43Lxwyy2pnIJEC17OrMJbc3k71Z/
rWu9DL1ElqwSXOg+/WtJhU2c+p9dthBQuTtEUVz0NQowPzRj1uzlMq2mVu9x1yR/
zBe3cEdYFum1UREV3rgvYQFNDsPRde7Glz6wsvpOa3bNmaAt3O3yeP99vpGcpdsF
TVLbQOGrQ/YOcc8iYB3qj3vlOFKg5VjmSrDDWVaoYn0AZCrgMaPOyJl2RfHcj/s5
dnO0iILd3q4u91vk1bD+QhPuI2o9D2dEItSsQ38COWdbvTioccYoMhwiXD3F2fLA
+ott6d188WbMmywh6xfJzgM6gZytGoF9ej3eUnQ3n1g7oH9/1N2+i8b/0mYTN/dh
Ryw9QHpJnkxz+I2ro3b1oS/1jdB1IMRrUTogBT47SIGti5miaUjW1McKR6lMr9jj
+cj6R3Ny
=xsky
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
