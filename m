Return-Path: <SRS0=znNI=EC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D9C388F9
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016DD22281
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELQiVTO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811209AbgJ0QiD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1811194AbgJ0QiB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Oct 2020 12:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603816679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZFQyQtfvNCFUvg5ewC8uNUVFyswODz4Hw/JM7xytUCU=;
        b=ELQiVTO4Gl++QmtqYnY4MOzyoh+dAMX5ogo+P6F1QkCC1q7KAEtw6RGRhxKObr76B17fMB
        hstQn2KD3HVA4TSqr2OcnZp6waguhN7Mf2q0aVYUSkzqfyifHGLvaAAgA+0zliZfu2WHKz
        A5PbttE3QzhtplAEYM0jNAtYZlnKlxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-MImJlhQeN9OTqIZ7CAWjqw-1; Tue, 27 Oct 2020 12:37:55 -0400
X-MC-Unique: MImJlhQeN9OTqIZ7CAWjqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E488E101F75E;
        Tue, 27 Oct 2020 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 509EF62A0B;
        Tue, 27 Oct 2020 16:37:53 +0000 (UTC)
Date:   Tue, 27 Oct 2020 17:37:49 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
Message-ID: <20201027163749.GA25212@localhost.localdomain>
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
 <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 07:04:52PM -0400, Paul Moore wrote:
> On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> > Hello everyone (mainly the maintainers of projects on GH, but to avoid
> > a huge cc list, I'm sending this to the ML),
> >
> > As you may or may not know, Travis is migrating open-source projects
> > to their main site [1][2] (to .com from .org, where they have been
> > until now). AFAIK, the functionality stays pretty much the same, they
> > just want to have open-source and private projects under the same
> > infrastructure to unify things.
> >
> > Recently, they started migrating runners away from the .org site [3],
> > resulting in new builds being queued for a very long time. [4]
> >
> > I tried to migrate some of my forks (selinux-testsuite and selinux) to
> > the new site and it went smoothly. The only downside seems to be that
> > the build history is not migrated immediately (but it did show up
> > after a while). The queue times were indeed resolved after the
> > migration.
> >
> > So, I'd like to propose to start migrating the projects under
> > SELinuxProject that use the Travis CI (selinux, refpolicy,
> > selinux-testsuite, setools) now, so that we are not affected by the
> > lack of workers.
> >
> > If there are no objections until next week, I'll migrate the
> > selinux-testsuite, for a start. The other projects I'll leave for the
> > other maintainers, unless they choose to mandate me to do so :)
>=20
> Sounds good to me.
>=20

Please do it for selinux too. Thank you!

Petr

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+YTNcACgkQviIJHj72
InWCEw/8C3XMhrMVBy4p+X6hxXxjxhguID0I+UJ5ZIhtKVnsM40f/rcUHxqBuOxi
vbVjPSVBut0rQnCRNR16SmrkiKYkYrhJ4JtkszvjU2X0H05XdQXt4UXxUmf+dHJJ
Yybe4DqUwh7EDugqTqUm7UyG2wR/bgb+fFaVrQpliBKL9RA01EuZxir3tuaZbg+9
vpy6FENhJqOW8eB5AKS+Ap4K7qTAMs0BgGF9Pgui5E8apeyacmGNsE3DFuyiUYz2
CGL4dRkLRODD05dn8KEXF3oyu9SBDGwzpYLUCyt93x44kDrFv2ycYb5B3aRN8Bir
qHCx1KOS6+hegSQuHZHlyumgpPmKM11CexpBHjt6se1MnnCCRJAggT5VkjvbthOW
t06O48bvS2ANQ5Ka+fcvjh4A617n/vEtK1DksR/QWWEP4jj0wYZ12qgM4mXYARpw
rPZriDSLfC9Jr+kWJN6VZbDaPdwuumIpgXefGQQmLMC0RmB/VFiwAbF8JFzMW5pT
yrX1txRbQxIE7Px0aHkDpOqJLh8IZQvkfJo6jtUVNc8au+b8OHKfP/rF4dpdLho9
Ia34OCV4SKbLUOecCkarZwszRYHf7oIdMP1eAU4UCbDXp+hqRt5hY/b3DixKNzfN
1iQNro7ORZTlv1z0WeH1OAMv5Ws55YI7c7wkjMrRgj5YuoPY/24=
=okGg
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

