Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8173C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F62D20890
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J342HO9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFRTcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:32:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726969AbgFRTcS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 15:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592508737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNF4i2kEI3mmdSPNQlkGybEiEIEAnPQxHQOvsIf8xr4=;
        b=J342HO9sQA+pwsXAV4RHYgHyWLnwZF1oyxFmx20BQB/nwhHrLo3ITQmwONo5jqWe7pzB6p
        7Hx0yIIRICr8LbdJgx6kvbpb+mstyFmrvC0VBiGSWqsabmIAg+C2Cma5KQT2PyyxiplLPd
        tuczXMwXlxnuHE2lI8F3o6rxO0gIQjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-1_sPgp_2NLCJbDodIuWHPQ-1; Thu, 18 Jun 2020 15:32:14 -0400
X-MC-Unique: 1_sPgp_2NLCJbDodIuWHPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACC7B835B8C;
        Thu, 18 Jun 2020 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8FFA1E2260;
        Thu, 18 Jun 2020 19:32:12 +0000 (UTC)
Date:   Thu, 18 Jun 2020 21:32:10 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v6 3/3] sepolgen-ifgen: refactor default policy path
 retrieval
Message-ID: <20200618193210.GB689512@localhost.localdomain>
References: <20200611135303.19538-3-cgzones@googlemail.com>
 <20200615150741.18526-1-cgzones@googlemail.com>
 <CAEjxPJ6tSKVSeJSJMYfrq53QSRVTWh1fQbHUchxvWysCKLPtxg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6tSKVSeJSJMYfrq53QSRVTWh1fQbHUchxvWysCKLPtxg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 12:30:43PM -0400, Stephen Smalley wrote:
> On Mon, Jun 15, 2020 at 11:08 AM Christian G=F6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On a SELinux disabled system the python call
> > `selinux.security_policyvers()` will fail.
> >
> > Move the logic to find a binary policy from the python script
> > `sepolgen-ifgen` to the C-helper `sepolgen-ifgen-attr-helper`.
> > Change the helper command line interface to accept an optional policy
> > path as second argument.  If not given try the current loaded policy
> > (`selinux_current_policy_path`) and if running on a SELinux disabled
> > system iterate over the default store path appending policy versions
> > starting at the maximum supported policy version
> > (`sepol_policy_kern_vers_max`).
> >
> > This changes the helper command line interface from:
> >     sepolgen-ifgen-attr-helper policy_file out_file
> > to
> >     sepolgen-ifgen-attr-helper out_file [policy_file]
> > and adds a linkage to libselinux.
> >
> > Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>=20

All 3 applied. Thanks!
--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7rwTIACgkQviIJHj72
InWFJA/+I0GIBCvrbRDlGRKCWp44FZXdcalpeSsFtHiaBr2L9atYMICcXSkpj8oo
OeVYzvuyJrHnYOVu3oUAWQW7VQc8gKFQ0kBsm/Hv334r2nSbcoOoC/zHXXZ+1UM3
rKV8dPuhWKd2ulx3+gn+exPAougrOB68OlRt1YlQ4wMPtKtBojshWQDdpO1Qd3TO
ElxRvlFh9OHs81eXVmMblDeVRdMyahgH5KT/Spb0RO9gsiG8CGVwFINCXrFEhFVl
TH7PFP5Ts6O7rXkoQlXGVqiKfjqNkbeALPbwct3+w0ZAFO+sivFUzcBeVGIBYtYN
KTN23b0hCM77g+maS5AdBI2urM3heHKIEAGLjMwiquKVRc2U/+wLzWrzZgBeNLDw
KwyIheuXV5Yuo8yRBDktofq8N5xEbbcppsFWx/qa7KjICVQlEgdYXHIIfe3MFMI6
xU7v+GGAaiQuAq2k2bZ0H56GJe/oQioB+p4z9/ONFjKx8BAbYUsGwQqbYyjhO8TD
Ow89o4wUFRcOlM5BEA+P2v81O4syyacUdArn1iozhuLitRy7xdNqZd/zeg6G8g0q
FLI9ajgdz/x829cR1XEocHdMJCfdobvHcOpdQRKrsWjp74qorUFpEiw0CkxrhzLz
hMzpQIIgcm+L6UVAFXow29pNytgizbCWX1iR/psVqRt47ykdT68=
=/DwC
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

