Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D229C47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 14:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E680E20675
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 14:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwmK8nRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEEO3E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 10:29:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54252 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728749AbgEEO3D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 10:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588688942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVj+ZAEY/myfI5ihbvc2gFubowEVcyekXgECvKsb1g8=;
        b=JwmK8nRaciqe+fS3rkixcpf0NLRMIcnvMvq6ZI0z3xQRefIux/i08jdjxDfoqivPl0Sy6j
        er9ZmkzPFeLt/8tfUjHKxHF9X+uJcf2EqclCMKUCLW+dtUEiLQsrZjuUS0yS692Y26aDnb
        UXi8PiaFb5CLvsMYTJp9IIwQOfgDmRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-ewdJz74UNDGndCjPGkfZkg-1; Tue, 05 May 2020 10:28:58 -0400
X-MC-Unique: ewdJz74UNDGndCjPGkfZkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DCA2107ACF3;
        Tue,  5 May 2020 14:28:57 +0000 (UTC)
Received: from workstation (unknown [10.40.195.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A90A1100164D;
        Tue,  5 May 2020 14:28:55 +0000 (UTC)
Date:   Tue, 5 May 2020 16:28:51 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Subject: Re: Intent to release 3.1-rc1
Message-ID: <20200505142851.GE7308@workstation>
References: <20200505135727.GD7308@workstation>
 <CAJ2a_DfH-faLvYsE2jabaSHFbTBNqDpU1Q5xre00OCS-3g7c0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DfH-faLvYsE2jabaSHFbTBNqDpU1Q5xre00OCS-3g7c0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 04:21:37PM +0200, Christian G=F6ttsche wrote:
> Am Di., 5. Mai 2020 um 15:57 Uhr schrieb Petr Lautrbach <plautrba@redhat.=
com>:
> >
> > Hello,
> >
> > I'd like to release 3.1-rc1 until end of this week.
>=20
> sounds good
>=20
> > https://patchwork.kernel.org/patch/11392367/ libselinux/getconlist: add=
 verbose switch to print more information
>=20
> This patch can be ignored.
>

Marked as Deferred.

> Quoting Stephen Smalley:
> > More generally, the libselinux utils could stand an overhaul:
> > - a number of them are really just examples or tests of using the
> > libselinux APIs and not really suitable for end users in their current
> > form,
> > - some of them should be prefixed with some kind of namespacing (e.g.
> > se or selinux) to avoid potential conflicts,
> > - there is overlap among getdefaultcon, getconlist, and getseuser;
> > probably should be coalesced or some dropped
>=20
> Maybe we can discuss the libselinux utils in general during the next
> release cycle.
>=20
> > https://github.com/SELinuxProject/selinux/pull/174  Use quote include f=
or files located in the local directory
>=20
> I think this pull request is obsolete now as the dso headers are gone.
>=20

Closed.

Thanks!

Petr
--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6xeB0ACgkQviIJHj72
InXUnxAApPwQia1bC5ACyR+VWPpvPxotTc9NcEUgzZDmnUWa4m/UBqh9pS/IITJ5
xf5HtodKRHRNqm6E2kSjgcphKHXMfWgYQIk2YUr5lEpiP+dtzqqaOmhmU3s+Olms
M0M3D4rZT7URsRJ7mtAb54PPNLf5EHd/2JF8HxAemAv3uvmvcNp2w0y4rfDvvFCT
0RcoRum6CMJL/+WGuQjLcXAUIiq8MfVkzXSAu90mEfJeENFTXnpqfxLZy8rbDVIk
fJxnGXSC8jdBJv+SZ/PFpsFPp2HqUENntiSDNkG5PzX+X5vuFWAWh568VeOArl5r
sL0MRTibAd6wT4kcjEvBg3aLDkTBAgYiPw0fZvEdbXPxy6Jftc9h9ZHg1/yU/fDA
Gj5rlNd7/D+amq/6CKFT5Q+ZMnhVDz/BYs95ZS7G7VLcUMBZhxkiyq2RyaFg6wfc
CJ1rxJwymD+R21pQfMnEeJXxYVcx7H/ghmMmGc4hqeEFV2L9gCLCaXWpf6uSXw0z
OJSoHSu1u6dh+j6uBQdFTeUCGOgtmhCfugEXqk06kAR/wbkcjH3uKlCwid94Ot2K
+wK+yjIfw9oY+DILRPC4Xkb3w7GQ5TsOGHTZoM9eExw/JVjwN/RaGOeGEdzlUJTw
JN2jbugnRCaLskyJfDcuLEW0L836ysR79XlxH29MyV+bJBcmB4E=
=J1pa
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--

