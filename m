Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8DC4727C
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC66206F7
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 15:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHUx9m1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3P43 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgI3P43 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 11:56:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601481387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FagvMvgUWu0n30ShUrnYjb8E1Kp7Zu9HDpmEx63p148=;
        b=ZHUx9m1/zrXaehN3dWziLl+3OLDtDcq0k5ruPyDaNM67X6N1HggE5ye2uf0GLkkCJQQmWg
        HsDJmKg5E2BVr6mO5CSAzMFN+bL5hWohdL30pBvMBfpXvdBPABFuTebmHXWLgf1cB2zIgR
        77RZdRUdZBlyk2GheBe0i/UdKxMudQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-mokgQqQeOiedKu4pviwJwQ-1; Wed, 30 Sep 2020 11:56:19 -0400
X-MC-Unique: mokgQqQeOiedKu4pviwJwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 965B1109106C;
        Wed, 30 Sep 2020 15:56:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B8A78806;
        Wed, 30 Sep 2020 15:56:17 +0000 (UTC)
Date:   Wed, 30 Sep 2020 17:56:14 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
Message-ID: <20200930155614.GA864960@fedora.redhat.com>
References: <20200930145031.910190-1-plautrba@redhat.com>
 <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 11:22:21AM -0400, Stephen Smalley wrote:
> On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.com> wro=
te:
> >
> > It's due to the previous ABI incompatible change
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> My only real question is what are the implications for distros for
> this change?  Would Fedora end up having to carry both so versions for
> a time?  Or can you cleanly switch from the old to the new without
> disruption?
>=20

Fedora and other distribution will need to temporary ship something like li=
bsepol-compat and
libsemanage-compat with libsepol.so.1 resp libsemanage.so.1 in order not to
break buildroots. Also all packages which require so.1, see bellow, will ha=
ve to
be rebuilt against so.2

# dnf repoquery --whatrequires libsepol.'so.1()(64bit)'
libselinux-utils-0:3.1-3.fc34.x86_64
libsemanage-0:3.1-2.fc33.x86_64
libsepol-devel-0:3.1-3.fc33.x86_64
parted-0:3.3-6.fc34.x86_64
policycoreutils-0:3.1-4.fc33.x86_64
python3-setools-0:4.3.0-5.fc33.x86_64
secilc-0:3.1-2.fc33.x86_64

# dnf -C repoquery --whatrequires 'libsemanage.so.1()(64bit)'
libsemanage-devel-0:3.1-2.fc33.x86_64
policycoreutils-0:3.1-4.fc33.x86_64
python3-libsemanage-0:3.1-2.fc33.x86_64
shadow-utils-2:4.8.1-4.fc33.x86_64
sssd-common-0:2.3.1-4.fc33.x86_64
sssd-ipa-0:2.3.1-4.fc33.x86_64

I've experienced with this, builds are available in
https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/

E.g. for libsemanage, I've added

+%set_build_flags
+CFLAGS=3D"$CFLAGS -fno-semantic-interposition"
+sed -i 's/LIBVERSION =3D 2/LIBVERSION =3D 1/' src/Makefile
+%make_build
+cp src/libsemanage.so.1 ${RPM_BUILD_ROOT}/%{_libdir}/libsemanage.so.1

to the spec file in order to get libsemanage.so.1 which is shipped by
libsemanage.so.1

Petr

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl90qpcACgkQviIJHj72
InUeWw/+JpkfWbrI+yJCoDABW5pKsC1aFkbtfbw50brdX7xuHJVmEH7zGuPSoGXG
UbJv2fliPPuogjQ3zw8zYQMZrcIJ/oO/eUQeyyukNFunuNtwQujAbteV02ZNQ4eu
EMsoajQe4sqC+EnT5DKTWivr7I90kSYzcQUlkT12L3UGvCQyffc7+L060PZu/WV3
26H3lINCmAVcLh+irVt+xBLGv8v4NVL8DxkehNiIfcOEf79zrIW5DLRmd4RuHphe
7SzCsJa0NzhPmQnt8lnSC3ZWc4bFS84U1Y43ls7dfOeQb+oqC5mrkYE1B8PTKC70
j4+7VIbSOSYV/c5ZxV/m/Ou61cj3vMHMwMCymj1hk0B+5UTmB8cydYeHiFznA6+7
VrcG+praBZKilEBH7rClQWZ5EEKbkuYDYlXMXNvpUyrO5nb+KETGiC2AwrOx8vkM
QLoewkFIamgcxFw+QCu+8nRzwxFtE4NvXeZWxMIGaJZ5tN6YjcXKegKrhpbLh326
AxBmHOlsrESvT3LbCMqvsJYTM+cSxLum0C0BrKZmy6k1kSMxLNkqRaNNPUCSFBqB
z62zzQ4eSdFk6Y5kbF1+lHbmVgbZdgn6b8U2dRY9cNA2puAUXgrzXN9T3brOAe2C
DLqS2wWBY/Psp+D34XByfE2jWU3cCSNf9UV+SstedPcRefGz4k0=
=cNGq
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

