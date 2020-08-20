Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC61C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 20:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D992076E
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 20:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXXqxult"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHTUbU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:31:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728200AbgHTUbU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 16:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597955478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cORLOutO/poQwG9IxztMMVSO/T4jcpKhvFitueH9jIY=;
        b=NXXqxultSHtJIFL4F4XTO2GQ7I6o8qjO6PWKik5zOVGAJqD9b0oJmV11cqnlHPwqHpoJZw
        SfFt3DgIDNDVfZQGt4AHo7sc8ohFZ70z7gpMu+qvXR0xbjje4GPdssO2VoIp/k0Qw/9aAq
        uwWm3qpoquJcQtLgMbmK3u7vfF+wtCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-BedT42lfOyuE5HqYXQ2v1g-1; Thu, 20 Aug 2020 16:31:16 -0400
X-MC-Unique: BedT42lfOyuE5HqYXQ2v1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 097D08030A4;
        Thu, 20 Aug 2020 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E6645DA79;
        Thu, 20 Aug 2020 20:31:13 +0000 (UTC)
Date:   Thu, 20 Aug 2020 22:31:10 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
Message-ID: <20200820203110.GB57975@localhost.localdomain>
References: <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain>
 <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAEjxPJ6Kw8i_z_i2Y0A3HcK23DMoazWUZxMtNa7ErQv_bjm=QQ@mail.gmail.com>
 <33cb7940-ebd2-1ded-4f19-9c75013a8204@gmail.com>
MIME-Version: 1.0
In-Reply-To: <33cb7940-ebd2-1ded-4f19-9c75013a8204@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 12:58:31PM -0400, Stephen Smalley wrote:
> On 8/19/20 3:16 PM, Stephen Smalley wrote:
>=20
> > On Wed, Aug 19, 2020 at 3:07 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> =
wrote:
> > > There are some corner cases currently, e.g. you can't remove the
> > > security.selinux xattr if SELinux is enabled currently, and there are
> > > various hardcoded error cases in the SELinux hook functions that coul=
d
> > > potentially occur.  Beyond that there is the memory and runtime
> > > overhead.  Getting people to start using selinux=3D0 if they want to
> > > disable SELinux is definitely preferable.
> > We could try to eliminate those error cases by checking early for
> > selinux_initialized(state) in more of the hooks and bailing
> > immediately with success in that case, but we'd have to go through and
> > identify where we need that.
>=20
> I did a quick look through error cases in the hook functions and it appea=
red
> that the only case where we would return an error that isn't already
> protected by a selinux_initialized() test or a test of enforcing mode is =
the
> removexattr() check.=A0 So I just posted a patch to lift that restriction=
 if
> policy hasn't been loaded. Hopefully there aren't any other user-visible
> differences.
>=20

Thank you.

I'll be next 3 days offline but I'll document it and test it on Monday.


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8+3YcACgkQviIJHj72
InVz3hAAoGvo39pS5CCp6B8euOCUQm7jc1VNdMSN7F54xsBDDeCsSnvpfmj0k1VL
gpmU3FG4WG91EVaMYR7AeQ3bwfXAJV3IRAOBSXI2Tt5KdBjtVwWKj75QX1ou9D+r
MhOEnE99s8kQHoeP2t+8bOc1BrvbRFUptTMqLvwzd9NzDcCj8jzZTsmFjH4SQieX
r6AkQaSNExu/zgJtR7RFlWCuZVGP35m40/wpP1HA+D5xk48yyh0nK84OTRKyVP0B
k1HQK8uywTbHVTQ6egp+EN9MGqNXFQztkCq74VpaI5XM5IaKJVW1/oRmHXB32ldN
rMdUkfHjyUnXd1pdCPR5U/t+ELFcKpnouV39vAEt+4fE/gEmJT4GEayS1VbBRvVz
xZyx4p1ZPRMyUa5kUnOdfrFO69Aear2HyVBSNv5f5uvmi1CzYmrAp7jWqqjyWD7s
oHm5Kn7MDsk1Q+DExp36EGL+JpmNNXz24x7HLidvdydPSQ1cu81OMH5jslAmx/Zr
gcx6Ptw7hXHWzby8POdtpRlMK5bpB40r33YezfaHALYYSYLeG6RVAMIrcXdlCBmf
Ctrf2lRk3sClXp/LSE+FISCyAZXmpHpP49mLzAz4iMVtNo2X2K8CkJkzkIwhkkYu
Js2Xbiu8uwqyBoh7PSgMcLynz7AFFPcbULfXzwknCjpnnL2iGG8=
=lMc5
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

