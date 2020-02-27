Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE95C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F3E2469C
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvfIevf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgB0UnY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:43:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51333 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726758AbgB0UnY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 15:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582836202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=524vUM8R9R/nRfaXhOXacr2VyopSBXibI/he0TsRa0g=;
        b=RvfIevf67ic8wETxLcOuLYmUAEG1ORd70f9rsuVusag9635iVYHoVEyqKl/ezCyuoZr4W9
        Wp1oGIXSIE5y/mwkUWsTCu0vuI0ru/ulAxD4odRC5mwWWbkLFu9aWNQ5kC3rg9LrEcIzY3
        0ZBsZ54UWTFmJv2+xmGygQSFxxMXFk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--nf0rkHJPdaSWjkzmpP1uQ-1; Thu, 27 Feb 2020 15:43:19 -0500
X-MC-Unique: -nf0rkHJPdaSWjkzmpP1uQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C66318014D1;
        Thu, 27 Feb 2020 20:43:18 +0000 (UTC)
Received: from p50.local (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D1ED8C07F;
        Thu, 27 Feb 2020 20:43:17 +0000 (UTC)
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
From:   Ulrich Drepper <drepper@redhat.com>
Autocrypt: addr=drepper@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WVmsggCgtSyTV5BVCQGM/GOFCKBnQhee7zU=
Message-ID: <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com>
Date:   Thu, 27 Feb 2020 21:43:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XDOAKkRFkx544p4aeLcTina1v0SHyLOQN"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDOAKkRFkx544p4aeLcTina1v0SHyLOQN
Content-Type: multipart/mixed; boundary="RgOIrroCR3Q4seln3akHqNq5wz7cdd5vi"

--RgOIrroCR3Q4seln3akHqNq5wz7cdd5vi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/27/20 9:03 PM, Ondrej Mosnacek wrote:
> Ulrich, could you help us understand the macros you proposed to add to
> the SELinux libraries (probably a very long time ago)? Specifically,
> we are talking about those defined in "dso.h" header files such as
> this one [1]. See also GH issue 204 [2] for related discussion.

The use of the hidden infrastructure is not just a means to reduce
overhead in the form of PLTs.  It also ensures that internals for the
library don't leak out.  If calls between functions within the same DSO
use the PLT they can be intercepted by DSO earlier in the search path of
the dynamic linker.  This can have unwanted consequences.

I advise that this isn't changed.  The infrastructure to do this should
change, though.  You could look at the code glibc uses today.  The
functionality is still there, just slightly changed.

An alternative is to use gcc's -fno-semantic-interposition option.  This
should ensure that PLT entries are avoided.  For Python this was used to
achieve significant speedups due to the PLT reduction.  I know you don't
care about speed that much but this is a way to achieve it.  Python uses
LTO but since the compiler is told about the symbol use there are not
problems.


--RgOIrroCR3Q4seln3akHqNq5wz7cdd5vi--

--XDOAKkRFkx544p4aeLcTina1v0SHyLOQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTVft2qDkIVG4RdR6vaKMI6ef9EdAUCXlgp4wAKCRDaKMI6ef9E
dGaSAKCi3DQIghn8xSIDw2a+Dfde9IHgzgCfZTsYJIbmmj7M3AgdZmzHbc40238=
=2rMP
-----END PGP SIGNATURE-----

--XDOAKkRFkx544p4aeLcTina1v0SHyLOQN--

