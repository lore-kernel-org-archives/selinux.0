Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A121C4363D
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342AE239CF
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgF5lutD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgIXKMN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727352AbgIXKMN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 06:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600942331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Yexv8547XbWE7oLa9jl8gdNzgYc6mRgY5SBMbvEknmM=;
        b=LgF5lutDgW7irjpRhMc/e4m9TmfXO+8xwPcSE5FABpDjzs0wZtlcpMqxZEEvtuFAci77uZ
        xI3MQgpX0ybNilI4ts1hLXst2g7bEya4lsg3EQU8u4JlDKX5QJDKQXtqlZ4gr2r/QMQYhb
        w4UxVIYjXURseyYnJZIlX6vAKtGYD2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-JztWKnupNtuQgm5Od29lkg-1; Thu, 24 Sep 2020 06:12:09 -0400
X-MC-Unique: JztWKnupNtuQgm5Od29lkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D9BF186DD33;
        Thu, 24 Sep 2020 10:12:08 +0000 (UTC)
Received: from workstation.lan (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BAD65D990;
        Thu, 24 Sep 2020 10:12:05 +0000 (UTC)
Date:   Thu, 24 Sep 2020 12:12:01 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        cbuissar@redhat.com, dwalsh@redhat.com, zpytela@redhat.com
Subject: Re: `fixfiles -C` does not apply to all paths
Message-ID: <20200924101201.GA609742@workstation.lan>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5BczUFZ82C4bnioSiFLwqv4uvBaGP1afmAf4+amOraAQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 02:53:06PM -0400, Stephen Smalley wrote:
> On Thu, Sep 17, 2020 at 10:44 AM Cedric Buissart <cbuissar@redhat.com> wr=
ote:
> >
> > Hello all,
> >
> > I would like to discuss the possible removal of the static path list
> > in fixfiles' differential update mode (`fixfiles -C`).
> >
> > Here is how it works :
> >
> > 160 # Compare PREVious File Context to currently installed File Context=
 and
> > 161 # run restorecon on all files affected by the differences.
> > 162 #
> > 163 diff_filecontext() {
> > 164 EXCLUDEDIRS=3D"`exclude_dirs_from_relabelling`"
> > 165 for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC
> > /home /tmp /dev; do
> > 166     [ -e $i ]  && EXCLUDEDIRS=3D"${EXCLUDEDIRS} -e $i";
> > 167 done
> > 168 LogExcluded
> > 169
> > 170 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> > 171     TEMPFILE=3D`mktemp ${FC}.XXXXXXXXXX`
> > 172     test -z "$TEMPFILE" && exit
> > 173     PREFCTEMPFILE=3D`mktemp ${PREFC}.XXXXXXXXXX`
> > 174     sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
> > 175     sed -r -e 's,:s0, ,g' $FC | sort -u | \
> > 176     /usr/bin/diff -b ${PREFCTEMPFILE} - | \
> > 177         grep '^[<>]'|cut -c3-| grep ^/ | \
> > 178         egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
> > 179     sed -r -e 's,[[:blank:]].*,,g' \
> > [...]
> > 199     ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -=
f -; \
> >
> >
> > lines 165-167 and 178 statically prevent some paths to be updated with
> > the new policy. I suspect this was done for efficiency and historical
> > reasons.
> >
> > I would propose the removal of these path because :
> >
> > - restorecon is (by default) automatically ignoring paths that are not
> > mounted with `seclabel`. There shouldn't be a need to statically treat
> > paths differently
> > - Some paths currently in this list (e.g. `/home`) may require
> > updating. During a policy update, packages (at least RHEL and Fedora)
> > are using `fixfiles -C` to make the policy more efficient, resulting
> > in a possibly incomplete policy update.
> > - The admin may not be aware of the manual steps required to fully
> > apply the new policy after an update.
> >
> >
> > How about removing these lines ?
>=20
> Looking at the list, I note that several of them have seclabel set in
> /proc/mounts so they would no longer be excluded after such a change.
> The biggest concern is probably /home due to making fixfiles very
> slow.  I think the whole idea of fixfiles -C was to try to minimize
> time spent on a policy update.  Maybe we need to re-think the whole
> approach.  Android has taken a different approach to allowing
> efficient relabeling on Android upgrades.  They save a hash of the
> matching file_contexts entries as an extended attribute of
> directories, and only descend into the directory during relabeling if
> the hash no longer matches.  Upstream, this is only enabled if the -D
> option is passed to setfiles/restorecon since it requires
> CAP_SYS_ADMIN to set the additional xattr.  Perhaps fixfiles should be
> extended with this option and we should be using it instead of -C?
>=20

I'd like to say that I'm aware about this problem but I don't have answers =
yet.

It seems to be related to the way how `fixfiles -C` translates regexps to
glob's, e.g. '/home/[^/]+/\.yubico(/.*)?' would be translated to '/home/*' =
and
relabeling whole /home could be long and delicate? action as it would touch=
 users
data.

As a short term workaround, I'd suggest that policy package maintainers enf=
orce relabeling
of particular directories inside /home when they know it's really needed.

Petr

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl9scOsACgkQviIJHj72
InUlSQ/+Or6837sow9cYT5BqxfpwGPyVDuwm+tIl6p5BuZew5wJ0d7guVFd+BUNd
UkUDRBg819STS1S7HWiODKBZnS6j8/gZnSCI3Io/R/h2aSS2wLUtLYGvSnOhX9pv
GZQ+gV2EgbQB9xOUTFPY6D238zmcMqd5wWbnHtAtNeT3K+vKs+HPkflfswQMrgaL
/nDM6Y4S9cZsUCO3CGfaQeUhJ8uUELR97nvEuj4i2hMYwL4XjQlvgBkUYu9m/8tp
yP8t6rW3jVfVFoFnctYNw5+0QwiFssLmDxq5t+u5H/znuD7aCgm4L65Kz8sGCzJi
D1H3SN3QAOPmEPDjPl6B/QAFZ5LSUojMrIl2zLZF604wVyukastLjBe6LDVqfZrx
RfM6CogsQnQD4qH+fCUDJ+wYn0fR08PIGLcdj/Rvl+K6dK2kl91FnX+dLXKboR9/
XeN+VzI33klGhXXhxaE2sHcDl7KJ+FnsmefSL0XWevJ8VaV2fjeIZiCpdrh3xtGI
g+ORd62NzO/Coy8zhQ5qqAl5VyPjmZs4y0C1yY6ztQGoqp2u+Hh6tKm65w4iPG29
xl8ynkT8m7NaqqiMmaZ9KRuBBsJyNwl63DkNcL/Tyen5Opw0qmOjWrJIP/zfc7eL
sIKU413fTXmscQup9L5pBNJ4g2LaGF4Gd9y0OBAl6y8zrr1S9bc=
=zDtI
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

