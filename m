Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55728C38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A7420838
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 13:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6FtQriH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgEGNNl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 09:13:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725900AbgEGNNl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588857219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n410Lon/gJPafNEN/PIXyL5EGXU6AJ/DbF7Z1mmqeyk=;
        b=c6FtQriH7rk/TiaKsTb2sM0ruQbNwTwf4azfDVxSfsdxyshNW5v3GE2sROPRzaTknvQWqk
        M4CGzCnw5+WVPvRW1SYTJWfjpoZDKcWeQ4PNtQGXmYcmrukc1ZuCrssWOe5COJEtZZdz9l
        tSvi19ng3lXDfkBnJRSZds/ZmvfABS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-AABsqYqjPD6hr5sZMuiarw-1; Thu, 07 May 2020 09:13:31 -0400
X-MC-Unique: AABsqYqjPD6hr5sZMuiarw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3C6835B4F;
        Thu,  7 May 2020 13:13:29 +0000 (UTC)
Received: from workstation (unknown [10.40.194.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B844434211;
        Thu,  7 May 2020 13:13:26 +0000 (UTC)
Date:   Thu, 7 May 2020 15:13:22 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Laurent Bigonville <bigon@debian.org>,
        Russell Coker <russell@coker.com.au>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
Message-ID: <20200507131322.GA69292@workstation>
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv>
 <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 08:51:59AM -0400, Stephen Smalley wrote:
> On Thu, May 7, 2020 at 4:46 AM Laurent Bigonville <bigon@debian.org> wrot=
e:
> >
> > Le 6/05/20 =E0 18:37, Russell Coker a =E9crit :
> > > On Thursday, 7 May 2020 1:50:46 AM AEST Stephen Smalley wrote:
> > >> on that running instance, but not to specify custom kernel parameter=
s
> > >> initially or to reboot the system before proceeding with further
> > >> commands (if anyone knows differently, speak up). We'd have to get t=
o
> > >> the point where enabling SELinux in Debian is possible without
> > >> requiring a reboot at all.  And then we'd have to wait for that
> > >> support to find its way into one of the Ubuntu images supported by
> > >> travis-ci.  Might be easier to just get travis-ci to support Fedora =
or
> > >> CentOS images in the first place. Regardless, allowing the testsuite
> > >> to be run by users of other distributions is worthwhile IMHO.
> > > In the past there hasn't been much demand for a smoother installation=
 process.
> > > If you are setting up a traditional Unix server system the Debian SE =
Linux
> > > installation thing doesn't make things much more difficult.  Past com=
plaints
> > > about it have been more about an imagined difficulty of using SE Linu=
x and have
> > > ended when I showed and wrote about how to do it (one time I showed
> > > screenshots of the process in an LCA lightning talk and didn't have p=
roblems
> > > with time).
> > >
> > > I don't think that the people who maintain the Debian installation re=
lated
> > > packages would have a great objection to adding SE Linux features, al=
though it
> > > might take a bit of time for it to migrate from Debian to Ubuntu.
> > >
> > > We can make this a priority.
> > >
> > If people are using preseed installations (kickstart equivalent), I
> > think that enabling SELinux in the installer shouldn't be too difficult
> > (installing the needed packages, modifying the files and relabeling wit=
h
> > fixfiles). It's obviously not user friendly, but the question is what's
> > the target here.
>=20
> The visionary end state goal would be to allow one to specify some
> kind of option in a travis-ci configuration and get a SELinux-enabled
> image on which we could perform travis-ci validation of
> selinux-testsuite, selinux userspace, and maybe even the kernel.  I
> don't think that is possible in the near term though and will require
> changes to travis-ci itself.  At the moment our travis-ci validation
> of the testsuite and userspace is limited to building and in the
> latter case running some limited tests that do not depend on having
> SELinux on the host.
>=20
> The nearer term goal is to minimize obstacles to using SELinux in
> Debian, one of which is the need to install Debian and then install
> SELinux as a separate step (with two reboots along the way) rather
> than an installer option.  We can't use that approach in travis-ci
> AFAICT because we cannot reboot the instance and then proceed with
> testing.  If we can tell the installer to include the necessary grub
> and pam configurations up front and to label the filesystems during
> installation (which can happen even while SELinux is disabled in the
> kernel; only requires filesystem xattr support), then we can avoid the
> need for any extra reboots post install.
>=20

I'm experimenting with using Fedora CI for this, see https://src.fedoraproj=
ect.org/rpms/policycoreutils/pull-request/15

It uses Fedora Rawhide images and runs
https://src.fedoraproject.org/fork/plautrba/rpms/policycoreutils/blob/a9622=
b610a0f7cfb968d4cb216c9c5c42e87b6dd/f/tests/upstream/runtest.sh
script which is part of this PR


You can see a failure in Fedora CI:
https://jenkins-continuous-infra.apps.ci.centos.org/blue/organizations/jenk=
ins/fedora-rawhide-pr-pipeline/detail/fedora-rawhide-pr-pipeline/3441/pipel=
ine/
-> Artifacts -> package-tests/logs/FAIL-upstream.log -
https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-p=
ipeline/3441/artifact/package-tests/logs/FAIL-upstream.log

So far there's only userspace build and tests but it can be used for
selinux-testsuite and (Fedora) kernel.

It has one downside, it can be triggered only by a pull request on https://=
src.fedoraproject.org/rpms/policycoreutils

Petr
--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl60CWwACgkQviIJHj72
InVYMQ//UnSW/GG7xUG6/e+dz+tdvaqbtA4ZRb7Q2+P5O5x44IF2Jm44nehlHH+I
3lULovPkcAbqfDARi8MB+2FQxEQ3WkBMUWXXcIm4TBAPGqeDn5q4PVAOGP3e1z4J
QugdWz/Z3Cp6Dyb8W7veIeSu90KC9Oy0JOvMzTP1bF1Aa63a1EwfVG3CLkw+5iFd
9nS5HYmY1nsDks2AEFBR9smQ50USX3u4+6sMQVIAv3b++eQYIuVQkSYI5HTZyehY
O3x7U292AavB1UrfjiUcEnOOwQUb2aMyw4ETGyiunLf2DDKGvvA6gQHwPzhRT/MH
TBcU7DBZFJmMG6LORr1bVTA6WmOZzzrbns2DYv+LBYt9Tw7y3NZh+nBM3h0hnZ/7
f5OydVG+misYqUKtr8+0H2H5kS05Ue4mj7mO1i27cIoNwHX2gLIDfXE9xULMNGh7
I+lYsMXyowv/tUbuMNtWG+7E8vO9Uw8LNJkaRwGWBdPzSZ5b4BX3sAE7Q/76TqMZ
aIXca1kIwaTst8bLIU0sZyxuH70XgtNu8/taCKbtzdUae0i00gcHzws4D5ZU8cuV
RFbRc9qcUg0Fdip+TA2lO/UmlfTTZ+/khdonlf5101itH2KoPt7lKARgp1wAnskk
k1TdNgTZ736/PdQN+/N61Vs+robFTniw0VZ57tecBIqD+qrXi3g=
=Rpa3
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

