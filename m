Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCBC433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2BB206A4
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9GrQG3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgFKPzd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:55:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728496AbgFKPzd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591890931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LntZn5XkRBPgukffwIk1eT/Z54v2xPqZpGz8U+uIetA=;
        b=g9GrQG3s4YmxqWcPpiRu9o8iToYqhgUtVw0tye+ND4DDEA+30FhOiy3PBc4LiVhYZb/J/V
        ic3+2VEzkfOq0RPcsosK8zO8KThf3tGWDOgzIyrEbpQtfEL/wJKwyDggC6DwhBdS2RKJrv
        T0iQm6KFL5UJKhoUGOAyvXivUvhvOYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-4IeJYNSAMcOd_GbObAPrCw-1; Thu, 11 Jun 2020 11:55:27 -0400
X-MC-Unique: 4IeJYNSAMcOd_GbObAPrCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D73118A8220;
        Thu, 11 Jun 2020 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5584512FE;
        Thu, 11 Jun 2020 15:55:24 +0000 (UTC)
Date:   Thu, 11 Jun 2020 17:55:22 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bill.c.roberts@gmail.com,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: Re: [PATCH] ci: dont use hardcoded project name
Message-ID: <20200611155522.GB468661@localhost.localdomain>
References: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
 <20200611140557.6359-1-william.c.roberts@intel.com>
 <20200611153434.GA468661@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200611153434.GA468661@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 05:34:34PM +0200, Petr Lautrbach wrote:
> On Thu, Jun 11, 2020 at 09:05:57AM -0500, bill.c.roberts@gmail.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >=20
> > Not everyone's github project is "selinux" so use the projects
> > name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> > the absolute path to the project checkout on disk, so the
> > basename should be sufficient.
> >=20
> > Tested on Travis CI here:
> >   - https://travis-ci.org/github/williamcroberts/selinux/jobs/697201376
> >=20
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  scripts/ci/travis-kvm-setup.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-set=
up.sh
> > index 864dbac96a46..ceedaa6f4e27 100755
> > --- a/scripts/ci/travis-kvm-setup.sh
> > +++ b/scripts/ci/travis-kvm-setup.sh
> > @@ -120,6 +120,7 @@ fi
> >  # we don't get blocked on asking to add the servers key to
> >  # our known_hosts.
> >  #
> > -ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipadd=
y" "/root/selinux/$TEST_RUNNER"
> > +project_dir=3D"$(basename "$TRAVIS_BUILD_DIR")"
> > +ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipadd=
y" "/root/$project_dir/$TEST_RUNNER"
> > =20
> >  exit 0
> > --=20
> > 2.17.1
> >=20
>=20
> Thanks!
>=20
> I'm running a new job again with this fix. But I guess you need to change
> fedora-test-runner.sh as well. There's also hardcoded "selinux":=20
>=20
> ~~~
> # Move to selinux code and build
> #
> cd "$HOME/selinux"
> ~~~
>=20

https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697271=
776

~~~
# Move to selinux code and build
#
cd "$HOME/selinux"
/root/SELinuxProject-selinux/scripts/ci/fedora-test-runner.sh: line 61: cd:=
 /root/selinux: No such file or directory
The command "scripts/ci/travis-kvm-setup.sh" exited with 1.

Done. Your build exited with 1.
~~~

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7iU+MACgkQviIJHj72
InW7TQ//XbpcBTz67zrxIQmR7HKVb1V02WpOx7km7N8OqfLGKT3BhD68uiSCzJ9K
7KUMvN5VDfnwQfptTucW0kVC05MMsVnwi3FDdZJDTLs+sAsVpd7QjutYPBrKyVGr
cM2hxAUDAJdZZJVoxSC/LfFKTBKsojzvr1zhjIUUHSO/qG6WghmUS0a91jdXx5ve
KJYVILBgQVNTWlhfqwHIMTpiBxA5PsllSURVESczIm0hyspEHTAW/PDtNxFGNWoh
x22kfG8RDcUOHnjFPpknqcJ0+yVN4CM9nvMXM1Ds+BCf8I6XboF3D5gKm6nFl8CM
tu5q22mfTUXxi+EFSaRnoIiadrTMMk7GDAq90eeRxDNO39BsW/Te4dUZRmRmS3i+
XMEZ5PFDF3OGKPoDGFj7FdfBJKpsGvehLqjlywRwc/VI3WBblwjqTgK6vSXBtqBy
thPp7okKy1g8nm1Lfep+Mi9WiW6MaZ2QgaCq87JS5KFWI3MfE8W8jWiUitwAno58
KAYmGmNVlDWtW2LuyoFKyGAtkrovDsDWyLMKHf6biUn6FhxKUUMsxtqQqgrpyA2I
EJw0TLvcbzLljY4fq8jdrSpZn6OvIbvQ++MJjItWETdwDkq6sDuRnBgWRb629MRU
//l5HxD96BtS0J5vC49SKYm7UtzcUFanA2kPvBULvj2ujNRadAo=
=Z3oe
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

