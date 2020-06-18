Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383CC433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF532070A
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwO2J5L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgFRTgv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:36:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgFRTgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 15:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592509008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YibtRBcV5jqWS+uhSYITcLOYE+oZNJ8ZGNamAcsHRn0=;
        b=JwO2J5L2oEH00m9DilfgFEuyLmgF0s0KDs2YRoQ0wR06SX7HEf5mNL74QH8H+J0GWDIoma
        3NnzIZEBHuawH8FK+sctjU6jdZe8Hoy17X9pZ51bS+NdSGNAzwNnZIz0Eys1DbLRxkLy4r
        gh0/sKRu9Dws6ObMdl3XZWFHwT3LEVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-GZAba373PFyWF2I-Y90aOg-1; Thu, 18 Jun 2020 15:36:46 -0400
X-MC-Unique: GZAba373PFyWF2I-Y90aOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3447D8005AD;
        Thu, 18 Jun 2020 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EC0D60BF4;
        Thu, 18 Jun 2020 19:36:44 +0000 (UTC)
Date:   Thu, 18 Jun 2020 21:36:41 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] python/sepolicy: Use xml.etree.ElementTree.Element.iter()
Message-ID: <20200618193641.GF689512@localhost.localdomain>
References: <20200608121823.109113-1-plautrba@redhat.com>
 <CAEjxPJ7TVrfWbgaYY+Li+83dsoZ8Xd+umYp4OvkKCEdqpv_DPA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7TVrfWbgaYY+Li+83dsoZ8Xd+umYp4OvkKCEdqpv_DPA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 12:23:49PM -0400, Stephen Smalley wrote:
> On Mon, Jun 8, 2020 at 8:19 AM Petr Lautrbach <plautrba@redhat.com> wrote=
:
> >
> > xml.etree.ElementTree.Element.getiterator() was deprecated since Python=
 3.2 and
> > dropped in Python 3.9
> >
> > Fixes:
> > Verify sepolicy interface -c -i works ... Traceback (most recent call l=
ast):
> >   File "/usr/bin/sepolicy", line 691, in <module>
> >     args =3D parser.parse_args(args=3Dparser_args)
> >   File "/usr/lib64/python3.9/argparse.py", line 1819, in parse_args
> >     args, argv =3D self.parse_known_args(args, namespace)
> >   File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_ar=
gs
> >     namespace, args =3D self._parse_known_args(args, namespace)
> >   File "/usr/lib64/python3.9/argparse.py", line 2043, in _parse_known_a=
rgs
> >     positionals_end_index =3D consume_positionals(start_index)
> >   File "/usr/lib64/python3.9/argparse.py", line 2020, in consume_positi=
onals
> >     take_action(action, args)
> >   File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
> >     action(self, namespace, argument_values, option_string)
> >   File "/usr/lib64/python3.9/argparse.py", line 1208, in __call__
> >     subnamespace, arg_strings =3D parser.parse_known_args(arg_strings, =
None)
> >   File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_ar=
gs
> >     namespace, args =3D self._parse_known_args(args, namespace)
> >   File "/usr/lib64/python3.9/argparse.py", line 2061, in _parse_known_a=
rgs
> >     start_index =3D consume_optional(start_index)
> >   File "/usr/lib64/python3.9/argparse.py", line 2001, in consume_option=
al
> >     take_action(action, args, option_string)
> >   File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
> >     action(self, namespace, argument_values, option_string)
> >   File "/usr/bin/sepolicy", line 216, in __call__
> >     interface_dict =3D get_interface_dict()
> >   File "/usr/lib/python3.9/site-packages/sepolicy/interface.py", line 1=
49, in get_interface_dict
> >     for i in m.getiterator('interface'):
> > AttributeError: 'xml.etree.ElementTree.Element' object has no attribute=
 'getiterator'
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.

> > ---
> >  python/sepolicy/sepolicy/interface.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/se=
policy/interface.py
> > index 7d4ebd7ecdba..bdffb770f364 100644
> > --- a/python/sepolicy/sepolicy/interface.py
> > +++ b/python/sepolicy/sepolicy/interface.py
> > @@ -146,12 +146,12 @@ def get_interface_dict(path=3D"/usr/share/selinux=
/devel/policy.xml"):
> >              tree =3D xml.etree.ElementTree.fromstring(xml_path)
> >          for l in tree.findall("layer"):
> >              for m in l.findall("module"):
> > -                for i in m.getiterator('interface'):
> > +                for i in m.iter('interface'):
> >                      for e in i.findall("param"):
> >                          param_list.append(e.get('name'))
> >                      interface_dict[(i.get("name"))] =3D [param_list, (=
i.find('summary').text), "interface"]
> >                      param_list =3D []
> > -                for i in m.getiterator('template'):
> > +                for i in m.iter('template'):
> >                      for e in i.findall("param"):
> >                          param_list.append(e.get('name'))
> >                      interface_dict[(i.get("name"))] =3D [param_list, (=
i.find('summary').text), "template"]
> > --
> > 2.26.2
> >
>=20

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7rwkMACgkQviIJHj72
InVZ0xAAxw7s09STToYN8+IsNc7QfgvJH8FyEnhJ8fH1V56XBL4ywH6akou/acvz
LyWlJst/OODRbaxDjgKTa8873nCP/DDoBXpcuekZWNoOHwsq7wvQI8crJZ9tZVoV
gmd9lOx59X0RiUrTl3DsHTc9l5GMkOxNtl2w5He/ECar9oLjnFyYaFQuXeuJmq/c
erXNtmV0Ohnk4rTAkOESPfM6f5J0zFLCKLQGoN14Mym/eGQu56Yqkt38rKrJFMP4
WsYB+3FdKGt//cyLmn5EMkzRSO7MdAzT8A6dNnB0N0ZyLcqb2K0Wx7DHDbyIB7+e
W0x75mX2D/Saxlaj7rnfPuezgWhgwJxP2AE8GyXgJxnzKf4CtYgWCmUaWnH7dZ/n
A1wJYEIe/giPPWq8aZgb1tR1B/LeqvyVrpPWGPCYn48f1BDXaNPk6gc/WDJZt+ux
h0iUVMhl1qfKszB3I5ZRkomEFrWWq3/34zXBaKV9lEiUs+fAHcyAP90pg8RB8u5a
4Y7gErtkPxY0Ar5uIwRT73a9LdjTZOt1TBgprj3HPKYFtnPKh8dH3tHw21ptfPd4
zblPJyHQ72E+8UpuRn7dBLCoMiv/hN/1+pKrdT2tKRXxrUpo9nll5/ICwk2r5ipm
qFENczrt2O0tvJhaPCKjP6TiCt7nlCykgci4QRENjOi9Z3ULEAY=
=P78v
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--

