Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCD8C433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB133207DD
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTk1QZar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFRTgT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:36:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726879AbgFRTgT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 15:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592508978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MENPlqLSDMfRrSoR0V2KyHT8HLbBnXPB4D9F0r1mFkc=;
        b=CTk1QZargYyXqb/CxyMpXTBO1/EEhUphvv1CVb2GiGasldjIORYv5vFRmIOm/0zY4XjMrb
        r+jgWww0hyS7zZkCk135mYt1C5YWpmEjCrvUzeZxWIi+diOV/Xqjz2TZGiybcyIA2lIEWK
        w9raFpNNQyA5jWjul/zh3qWqHVvXjP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-MX2fcAxWMJWtSAq5q0DbrQ-1; Thu, 18 Jun 2020 15:36:13 -0400
X-MC-Unique: MX2fcAxWMJWtSAq5q0DbrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A5D1005512;
        Thu, 18 Jun 2020 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5CE75D9E5;
        Thu, 18 Jun 2020 19:36:11 +0000 (UTC)
Date:   Thu, 18 Jun 2020 21:36:08 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Peter Whittaker <pww@edgekeep.com>
Subject: Re: [PATCH v2] Add restorecon -x option to not cross FS boundaries
Message-ID: <20200618193608.GE689512@localhost.localdomain>
References: <20200608162010.122077-1-pww@edgekeep.com>
 <CAEjxPJ4HAUZf4sSFxXv-Kkb2QQHp4DnoSdMo5MR632Z6Vo2z_g@mail.gmail.com>
 <CAGeouKE+ZNbh3PJO8bNfvEf6qJtKvRsoy5K+BYgakuhUJ-JpDg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGeouKE+ZNbh3PJO8bNfvEf6qJtKvRsoy5K+BYgakuhUJ-JpDg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 10:29:30AM -0400, Peter Whittaker wrote:
> Yeah, I wondered about that, couldn't see a reasonable pattern, and
> put it in where it seemed, uh, least awkward?
>=20
> Thanks for your patience on getting this built, it was an education!
>=20

Applied, thanks!


>
> Peter Whittaker
> EdgeKeep Inc.
> www.edgekeep.com
> +1 613 864 5337
> +1 613 864 KEEP
>=20
>=20
> On Tue, Jun 9, 2020 at 7:56 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jun 8, 2020 at 12:21 PM Peter Whittaker <pww@edgekeep.com> wrot=
e:
> > >
> > > Fixes: https://github.com/SELinuxProject/selinux/issues/208
> > >
> > > Signed-off-by: Peter Whittaker <pww@edgekeep.com>
> >
> > Only question I had is about the order of options in the usage and man
> > pages but that's a nit and doesn't seem
> > terribly consistent currently.
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>=20

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7rwiEACgkQviIJHj72
InW86RAAsv/eLvm5u1P8zkbTl8elgiTCRuvfQYq5aptFFoR3Xe9L/QjxmsxjcO84
WtYlI9mkShxy08s+sJ1hbHWIerXQRSr1+gPTCz/LhekL0CtQNjibCTsSx46Cvkxe
cejVFHk0w3ASNosBMrWcvFBHIlv6HCzOJR6iq5ahAskpSKzzi67dW1LJyDCdxw50
eu1Bk5pex6/52qrjfCx+TB7D7ouBxANZk/3OD2fvxIkwrj1aQQJ5WSbkKtOU4TVN
a4up8UD/j1dnR2HXLVtx4KglZwjLZx3YwGO+LUKXdR0GVnVtW7CWpZJUC0mO/+5z
8CUcL4bJ2WrI+PmwC7dsnReblXdtvEn6XtItSrnxL998F/qsr6X57QaTgDsk2hUR
wQipwZhx0zin3JKZ8mncr2UKSIDpzKgmkdaVGCqvaBEF3NntCX1oo+NJFYjVUMyU
NBeQSoxOJF3oDsp58baIc+XWaq2PIWXo0TpbV5zVPsZGWI0og4T+PP1ay5E0dJUx
YccYF5+3TT++fYZ/222jxwD8nygnFYQL8+mdib8etKhVC0QRN0zAscgou7P5R0In
dc323TjMa9aBhKQYim4v2uXDhbRATh14rZsIDB81PsSmKEfLvpi6E4JRiaQd/flR
uRHBoQLKspg87IIFNC+pn82LH9b/IXt0BoS30smxnOhffBH/PXE=
=koM/
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--

