Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17694C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CFA2051A
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C20ThgEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3Om2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:42:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgD3Om2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 10:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588257746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uiPsXiTH3/VbTe5HTRGt7djXYDTNBD7jPEjB0C7tosA=;
        b=C20ThgEu/gG6ykfVmZZZ94meIPkC9nPv4L/r2up+igwi/Uv9LhSFOG7tHzz4oUTTEcHKcm
        eHNLEEMJtvuZH3ohUhDgHN3tvpLOYTJ/xFWxgBApfj5tM3wZ/V69lwFmsOHbc+//jOyXg7
        W750TPu8ckwkKN1K96qikyojB5gHuZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-geykn4-yOC2XM8kNK6T4jQ-1; Thu, 30 Apr 2020 10:42:22 -0400
X-MC-Unique: geykn4-yOC2XM8kNK6T4jQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F08E107ACF8;
        Thu, 30 Apr 2020 14:42:21 +0000 (UTC)
Received: from workstation (unknown [10.40.195.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A69AB2B4C6;
        Thu, 30 Apr 2020 14:42:20 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:42:17 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] sepolicy-gui: fix columns in transitions view #232
Message-ID: <20200430144217.GA139885@workstation>
References: <20200429171935.8619-1-toiwoton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200429171935.8619-1-toiwoton@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 08:19:35PM +0300, Topi Miettinen wrote:
> Delete an unused column from view "Application Transitions From". The
> second column displays names of the executable files instead of
> booleans.
>=20
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
>  python/sepolicy/sepolicy/sepolicy.glade | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/se=
policy/sepolicy.glade
> index 8f6ad650..52407887 100644
> --- a/python/sepolicy/sepolicy/sepolicy.glade
> +++ b/python/sepolicy/sepolicy/sepolicy.glade
> @@ -2876,20 +2876,10 @@ Enabled</property>
>                                              </child>
>                                            </object>
>                                          </child>
> -                                        <child>
> -                                          <object class=3D"GtkTreeViewCo=
lumn" id=3D"treeviewcolumn27">
> -                                            <child>
> -                                              <object class=3D"GtkCellRe=
ndererText" id=3D"cellrenderertext34"/>
> -                                              <attributes>
> -                                                <attribute name=3D"text"=
>1</attribute>
> -                                              </attributes>
> -                                            </child>
> -                                          </object>
> -                                        </child>
>                                          <child>
>                                            <object class=3D"GtkTreeViewCo=
lumn" id=3D"executable_file_from">
>                                              <property name=3D"resizable"=
>True</property>
> -                                            <property name=3D"title" tra=
nslatable=3D"yes">Boolean name</property>
> +                                            <property name=3D"title" tra=
nslatable=3D"yes">Executable File</property>
>                                              <property name=3D"expand">Tr=
ue</property>
>                                              <property name=3D"clickable"=
>True</property>
>                                              <property name=3D"reorderabl=
e">True</property>
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6q48MACgkQviIJHj72
InVCdBAAmqVWEOLt7YI1yf4wouSyUUwOH+2xuOn4T6NpRw2oKIZ3dtBJruCxlM7K
1VSIS/BhAMyTZxHlOso2fQOZkwZTcXLEDRsLtsQsu2lzmSdMude+j094OzTE8j+y
Z4FumMnObulpeU4pbROTN2S7XRcmctwHIFmVKQhHSP2hyS6euCvpAZjjBlUKsOJ7
HQsXo7R2U7FokO1eE80p6wytrWtsPzubjvySniUh3YVrHuWtp6lW11vXtwySDpR2
BIXY5fDkujbNgH2OUOo+lhQg1gB9cXIPyGtbmwSlWth6f2P8/frxKpu2+M45Bs46
RDXBWu5OZppoFJ9cYOJxzTTv5YrT4rTfJiDMr9qGwxXcfMAGrOL2sEMTaJGIrINg
zCDTV3tvkq0SC66bZQ6DaMcmfeECOigEZvT/MsEQiqIYgi85HgVLiRuf8Z3C2VC3
KhUFNXnERhs0s8GgQRbLOGooRZXhuag7R5tWicpZj4TFuWlvKBNCZ5OGlo1YPquq
7MqTXH7O38ezAkFGU0eFAwvw8sMh9p9xOXYi4CwxRTBDe1QdlZSkD4yRN41hAZCT
sTYC98lUftNLTxwVcCQ7KNRdfhfjB8UYJWnr/W2g8q5IBB2ImQWHvlxZwYgo3eL1
xZTmZBYBofwzt4+8aHIrJZH8LIz+jeudHYlPZhbUkkiUa+LEeN4=
=k6hm
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

