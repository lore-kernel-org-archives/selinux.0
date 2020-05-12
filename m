Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E70C54E8B
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25BA206DD
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 11:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzt4QssG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgELLUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 07:20:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22130 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELLUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 07:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589282415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLp+9Fl+7xb5nJUfSAHXmu7UjzpLJu1oHvAYvqJh0oQ=;
        b=hzt4QssGbAsQF1q9ZnvddZnenWoTrnvd/IZnFUqz7mYmKfbSGeqhxZ/qXZbopIYazQ9Plx
        V6du1xvOYiYdhk6ciJMLN5IoTmh3jwzwwt8SJzEk1HKGvE0ssB+UVGjejCPBIA1ANxsnQT
        6Ldd/b5syIoDKDCinGf1gcMFr8Ca2l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-36jYMYu_Muaa08yxxfL1OA-1; Tue, 12 May 2020 07:20:02 -0400
X-MC-Unique: 36jYMYu_Muaa08yxxfL1OA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C6F475;
        Tue, 12 May 2020 11:20:01 +0000 (UTC)
Received: from workstation (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22CF15D9E2;
        Tue, 12 May 2020 11:19:58 +0000 (UTC)
Date:   Tue, 12 May 2020 13:19:56 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
Message-ID: <20200512111956.GA108209@workstation>
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <3838641.zh4Wi6GlAV@liv>
 <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <1916523.qzzCliNl98@liv>
 <CAEjxPJ7oXd5EM_hB1tdRKZKLKZoeOh_w8UYevivMC5d1D2G1+w@mail.gmail.com>
 <CAFftDdpygOSWOGNQnbGzGOcKrtsd+3hHsfPY9chM5L90CZGHwg@mail.gmail.com>
 <CAEjxPJ44XXQibMfT00xU0F2ySTR_1+QjPNU35R6zLqgyakQAQA@mail.gmail.com>
 <CAFftDdp61vBDDwwsrDv2c1COc6TR4yD1JoPp9DwzQgqu2-CKqw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFftDdp61vBDDwwsrDv2c1COc6TR4yD1JoPp9DwzQgqu2-CKqw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 10:22:09AM -0500, William Roberts wrote:
> >
> > On Thu, May 7, 2020 at 11:02 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > >
> > > > On Thu, May 7, 2020 at 10:49 AM Russell Coker <russell@coker.com.au=
> wrote:
> > > > >
> > > > > On Thursday, 7 May 2020 6:35:11 PM AEST Laurent Bigonville wrote:
> > > > > > If people are using preseed installations (kickstart equivalent=
), I
> > > > > > think that enabling SELinux in the installer shouldn't be too d=
ifficult
> > > > > > (installing the needed packages, modifying the files and relabe=
ling with
> > > > > > fixfiles). It's obviously not user friendly, but the question i=
s what's
> > > > > > the target here.
> > > > >
> > > > > If we want to do that properly then I guess we want SE Linux enab=
led in the
> > > > > kernel that the installer uses and then have the policy installed=
 early in the
> > > > > installation so the files can have the correct labels from the st=
art instead of
> > > > > having a relabel process afterwards.
> > > >
> > > > That would be good but might be overreach for Debian since SELinux =
is
> > > > not the default there.  It isn't strictly necessary; ever since we
> > > > went to using extended attributes for file labels, you can set them=
 on
> > > > a non-SELinux-enabled kernel, so the installer can always set them
> > > > even if its kernel doesn't enable SELinux.  Optimally they would be
> > > > set by the package manager based on file_contexts; that is what rpm
> > > > does in Fedora/RHEL.  Or you can always run setfiles after package
> > > > installation but before rebooting into the SELinux-enabled kernel.
> > > > You don't need to defer labeling until you have SELinux enabled.
> > >
> > > On Thu, May 7, 2020 at 9:54 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > I found this:
> > >   - https://man.sr.ht/builds.sr.ht/compatibility.md
> > >
> > > It seems to have Fedora-30,31 and rawhide.
> > > It seems to be free as well (for now)
> > > I would be a little leary using it, seems new, its only in alpha,
> > > and looks like it could disappear at any moment.
> > >
> > > The travis ubuntu to fedora VM might be heavy, but it would at least =
provide
> > > us with something stable... for awhile or we look at getting some
> > > better infrastructure support for running a CI job on.
> >
> > Fedora's own CI infrastructure seems like a better bet for the near
> > term wrt testing on Fedora; Petr appears to be already exploring using
> > it.
>=20
> I though the Fedora CI was limiting the amount of testing and
> triggering tests, no?
> Or is that why he is exploring it to see if we can get around them?

The main purpose of Fedora CI is to test Fedora packages either when they'r=
e
built or when there's a pull request in pagure frontend [1]. It's configure=
d via
tests/tests.yml [2] file.

In Fedora we use a set of integration tests originally used in Red Hat [3]

I've created "Run upstream tests on upstream sources" pull request [4] whic=
h
disables RH tests and add "upstream" test. This tests clones github reposit=
ory,
build and install sources and runs `make test` from subdirectories. It's ki=
nd of
hack but seems to work [5]. I'd like to enable also Red Hat based tests for=
 this
"upstream" test to get more and better results.

AFAIK the amount of testing is limited only in sense that you can have one =
run
for one pull request at the time and in order to create a pull request you
need to have a Fedora account, but you don't have to be a packager  -
https://docs.fedoraproject.org/en-US/ci/pull-requests/#_you_are_not_a_packa=
ger=20


[1] https://src.fedoraproject.org/rpms
[2] https://src.fedoraproject.org/rpms/policycoreutils/blob/master/f/tests/=
tests.yml
[3] https://src.fedoraproject.org/tests/selinux/tree/master
[4] https://src.fedoraproject.org/rpms/policycoreutils/pull-request/15
[5] https://jenkins-continuous-infra.apps.ci.centos.org/blue/organizations/=
jenkins/fedora-rawhide-pr-pipeline/detail/fedora-rawhide-pr-pipeline/3462/a=
rtifacts


> > My goal here though is to improve the level of support outside of
> > just Fedora and its derivatives.
>=20
> Definitely a plus.
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl66hlYACgkQviIJHj72
InUHihAAkqRx8uNqfVaU47B47cTjpDeNJ3m/mYjQq4rB5hrTa7/Nm4xeBAQwTLZe
SqH/9cawXkDAAL5fLzm0bFCaBRYwiED2Z6umi0YPFc9J34kgtejwtHbxB3QfX4Eu
yhTXE4Jey1Ui3loblHuhi0bbuCkXAok3qQfpAMiEkiULmJoPvbiYWaReNW4crQCM
JNmny8bcRWoMSyMO2YUbPttbTrQW8BmV7Zz79E1UfasSHbHyGaywf9NKx2WX6B9a
EQ1QdqwoiWDpYbl0VX5dgw2tXWOXe9SLX3yHQeMx4+swLZi77hjOfdi6M1LR7ry8
jDAFTAr4BYEzonilhAszH+vVDi6RiOrvftWAogNgTOFApS+DR58t+lovfsFKVIwc
BNCyhvurXmoSNmBrYWg7Zn2vJ6TIyBbtbh/FftPauexAc9jPlT1879OrQi2sOSRT
EFMFs0f/9yg/Md4AEDQ3xoRKxHNCsdTf4tTEsYJ7B4uXnDOYnksX0OKCQQj4UiFX
nxEPvVRZNAYTP493VzLY8M1f4B0w5jHh/9Uaa1395jNZhFnnM1rpgxaNCyXIF1Bq
2wlWTZIgmstwrsOVf4h+Js40z4lvby91Gl0yBxhetNdbRKVCUVEmWwaorC21oDFF
bxxIHxcchTC1wSYsD3i5jciwRH5mypZ8mf/dZHWi3L9tZLjLPtg=
=g0MB
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

