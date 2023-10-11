Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D4CD98F5
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 07:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbjJKHSe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 03:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbjJKHSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 03:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD8290
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697008671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=y3AfBEeUt+6V/YnWoXTb3c2maEKp45V/c8gYL4BJNM0=;
        b=TVM2l/sSXp2M3sJWpnkvqBu2tlPfnKju39eyeClB+3tUdcvHRO40aL5EGdXVN39rzMBqtO
        IvAC3eOui/+KFnSMG2ajw6S5RZ3LAgRFRDnZjgK//N4KMPZGrCFf6y6fjtQf1b16MlWn3M
        7tKGUwMB/7dhQu5+Ehyq5FI50iKLCBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-vnRx5vEBOu6YSDzBxo8dSw-1; Wed, 11 Oct 2023 03:17:48 -0400
X-MC-Unique: vnRx5vEBOu6YSDzBxo8dSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 442A1887E47
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 07:17:48 +0000 (UTC)
Received: from dhcp-0-146.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09855C5796D
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 07:17:47 +0000 (UTC)
Received: from dhcp-0-146.brq.redhat.com (localhost.localdomain [127.0.0.1])
        by dhcp-0-146.brq.redhat.com (8.17.1/8.16.1) with ESMTPS id 39B7HkjX006208
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 09:17:46 +0200
Received: (from petr@localhost)
        by dhcp-0-146.brq.redhat.com (8.17.1/8.17.1/Submit) id 39B7HkOP006207
        for selinux@vger.kernel.org; Wed, 11 Oct 2023 09:17:46 +0200
X-Authentication-Warning: dhcp-0-146.brq.redhat.com: petr set sender to ppisar@redhat.com using -f
Date:   Wed, 11 Oct 2023 09:17:46 +0200
From:   Petr Pisar <ppisar@redhat.com>
To:     selinux@vger.kernel.org
Subject: An X.509 certificate for selinuxproject.org web server has expired
Message-ID: <ZSZMGtFFycCLmjNb@dhcp-0-146.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bK8Jbhxl2HdokPx2"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--bK8Jbhxl2HdokPx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A TLS certificate for <https://selinuxproject.org/> has expired:

$ gnutls-cli --port https selinuxproject.org=20
Processed 367 CA certificate(s).
Resolving 'selinuxproject.org:https'...
Connecting to '207.210.245.134:443'...
- Certificate type: X.509
- Got a certificate list of 3 certificates.
- Certificate[0] info:
 - subject `CN=3Dselinuxproject.org', issuer `CN=3DR3,O=3DLet's Encrypt,C=
=3DUS', serial 0x04ef96d84dee2bf82c3fd430379377422cc5, RSA key 2048 bits, s=
igned using RSA-SHA256, activated `2023-07-12 19:10:38 UTC', expires `2023-=
10-10 19:10:37 UTC', pin-sha256=3D"MrgWqS/CGL+3idYpvJbFP3KfXfWmDboEKJTsCXFm=
c28=3D"

-- Petr

--bK8Jbhxl2HdokPx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmUmTBoACgkQT9GuwzZa
979OhA/+L6KaH3+mHwhzIq+7dA6kwbzkukK6m2pgaujdIoKDhCB7/SL+VLWwE1sm
WuxLG5boYybZ09RczzHHM5U8jA366wP5oGIo+MS1y2F+BS7G1A2VrK7BklO2syuD
x7sI/3nkC1O/GAVCu4kaWD22ECXz/XcSpadplSIj6qTxP5YOOcx1tnsIdLE0d9Bv
2VGHbNTgIIFgUchKLgdQlflpGF1o0bJgAKpEIp5UESOGMmE42wXYsu9Sq39WuafZ
8Rre5V5sGxvr7oHDkI/1o1HATRfxwx1Is9oX7t9HQ4fp9p2YEFyW6ML2uqvejLwO
5NfQfP8wP7YWENSSXCcFKWz1y8yFSIjmwKjNowiGBahAoktorbm0A22V4VW9Zvtn
I3Xagki067R8hhk0giFoL3NqeXx5enqNumambMNy3Ocm5gn5RDN92w97lOABZXSK
omKtE2zDQTkQvqs55IVjJ/2UOEHyvNhfkEnqLLAhdxTjNJlyE5E9Hi7JnwaBcaKb
zTwK927fERew5c/d/S0cqc6sPAJoGPV4VJoLc9gtWGhH4gd+koXiGp7VXgLXE7MP
2319SOr4eRkKRTN2rPnneV3cmlnv/OyaW7wymsIUl2zJDTISBcFbg3IysaosfJIq
mhn84YyjJSdMu8Vg2eqU7mz4s3DlvGPVatoNP5TsjMVu8jFS2os=
=kzJN
-----END PGP SIGNATURE-----

--bK8Jbhxl2HdokPx2--

