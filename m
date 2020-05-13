Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C90AC433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7EB207CD
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL+CA61A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgEMPLE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:11:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEMPLD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589382662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyKphzxvMTTnfD8Rey5uxPxtmT6V+cM4EMzu7NzXPDI=;
        b=CL+CA61AfYHh8ejKjoRpsD1SxKT6HFIUGoEcrqa2qCBWy7mVjZKSze36pL1I2VFiZdHIoK
        RagpfFYoX1NXiAssmb2QkUmbdQaIKal4yNCc4cEQbruxCeGlK7A9X7OgGbIrr18gR2jAsx
        FTuR+FaDRdmUZ2nnij9dQmmKY27gsMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-MD_rANpGOdCXJs5jVZ15RA-1; Wed, 13 May 2020 11:10:59 -0400
X-MC-Unique: MD_rANpGOdCXJs5jVZ15RA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2C301005510
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 15:10:58 +0000 (UTC)
Received: from workstation (unknown [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60A375D9C5
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 15:10:58 +0000 (UTC)
Date:   Wed, 13 May 2020 17:10:55 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH] run-flake8: Filter out ./.git/ directory
Message-ID: <20200513151055.GA184174@workstation>
References: <20200511120332.26029-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20200511120332.26029-1-plautrba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 02:03:32PM +0200, Petr Lautrbach wrote:
> When a branch has '.py' suffix git creates a file with the same suffix an=
d this
> file is found by the `find . -name '*.py'` command. Such files from './gi=
t' need
> to be filtered out.
>=20
> Fixes:
>=20
>     $ PATH=3D"$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
>     Analyzing 189 Python scripts
>     ./.git/logs/refs/heads/semanage-test.py:1:42: E999 SyntaxError: inval=
id syntax
>     ./.git/refs/heads/semanage-test.py:1:4: E999 SyntaxError: invalid syn=
tax
>     The command "PATH=3D"$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" ex=
ited with 1.
>=20
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

> ---
>  scripts/run-flake8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/run-flake8 b/scripts/run-flake8
> index 24b1202fde99..67cccfe99e5f 100755
> --- a/scripts/run-flake8
> +++ b/scripts/run-flake8
> @@ -7,7 +7,7 @@ if [ $# -eq 0 ] ; then
> =20
>      # Run on both files ending with .py and Python files without extensi=
on
>      # shellcheck disable=3DSC2046
> -    set -- $( (find . -name '*.py' ; grep --exclude-dir=3D.git -l -e '^#=
!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | sort -u )
> +    set -- $( (find . -name '*.py' ; grep -l -e '^#!\s*/usr/bin/python' =
-e '^#!/usr/bin/env python' -r .) | grep -v '^\./\.git/' | sort -u )
>      echo "Analyzing $# Python scripts"
>  fi
> =20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl68DfkACgkQviIJHj72
InXblQ//T2fWjobFYPjuNmdtTmqpGOj1HpZ75iK6gYUP6MffjU8SzeeBGz0aADR9
zdn+87HvYLyvo8moqax8fafo/VP96RnVoe8D+u7va3UGrC091NX8rE3YJmFO1ZwD
HYjKbmbezZfS/EwwMfVhKcw8HDz3AxFRyW3leN0PB0uv+NP0tMhYCtDRMocuKrad
s8ch/6m0jg1Qeo+8+7YggDNjTk2Tw0YssP/hu9L2SNnMuyaLBywb5zY3pxPqnltl
qOm2Ccr/B3z0jGBQ9pTPpfF5cKeFzKAUzI0ivsAdHwkdC80sYzptMg49Sh7mGIe4
1Rl7WTguf0Fn7mblrELAVcOqlZlZpghAH1BEdx+VJCqSb9ft7kdqXlPSi2i4fokz
cL5hY8z5XgSEAyd3eiyWR51kevl0+odZ8BNo7b2kIyTm6JxyHBTz4Nk7vaNv9u7m
tf+/KOH4E9YCwS5coV2glouK+Lzwu+Ca4fKjfM1XunJgRbj4nrHX71JyPBVjYOeh
qNDWRMd21/TAZTv28O9aVC1hh0bi60fVSMxkaA7HXzeJ9FoonShTC4VRMx7WPczt
KeK9f/q8mkmk/7ckfA5o0iHSyPionyzPxSMY/zkilE54pOBsxQw+qxLQfFSN0kZv
nBuytwIjJ+6qduVHN/cn1fwv1jndOa+/yTGshEsIpYX+TRtl+pA=
=7LOT
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

