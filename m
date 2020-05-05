Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C4CC47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5253E20746
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 13:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr68uA+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgEEN5n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 09:57:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729032AbgEEN5m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 09:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588687061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=jBqXIA2aubTsoenmlpyyq4p6qLDO797SizY4ELRGj7w=;
        b=Jr68uA+CixgLMSRu3cZZoiVAAHXOYej/t7s9fVMwmTCkO3tCvZzSfNG1D0FHcnek2noHU7
        zM3fu6zd6W3SFqmj3L28txfPll8s4rx64X8p6QdPr0DNJ34fhCLVULJ+DfAYhujbQ38OLO
        vo0NdC4KaD6KnFzWi79ii3AaCHQpuyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-wLkL-oteMQWHGw-iKzXiXQ-1; Tue, 05 May 2020 09:57:34 -0400
X-MC-Unique: wLkL-oteMQWHGw-iKzXiXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DE84100CCCB
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 13:57:33 +0000 (UTC)
Received: from workstation (unknown [10.40.195.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E11110013D9
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 13:57:30 +0000 (UTC)
Date:   Tue, 5 May 2020 15:57:27 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Intent to release 3.1-rc1
Message-ID: <20200505135727.GD7308@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to release 3.1-rc1 until end of this week.

Looking at https://patchwork.kernel.org/project/selinux/list/ I see:

- 3 acked patches which are ready to be merged (and I'll merge
them tomorrow if there's no other comment):

https://patchwork.kernel.org/patch/11525435/ libselinux: Add missing errno =
setup
https://patchwork.kernel.org/patch/11527311/ tree-wide: introduce PYTHON_SE=
TUP_ARGS to customize setup.py calls on Debian
https://patchwork.kernel.org/patch/11527463/ Travis-CI: upgrade to Ubuntu 1=
8.04 and latest releases of Python and Ruby=20

- 1 patchset which should be postpone for the next release as it breaks set=
ools
https://lore.kernel.org/selinux/20200502190828.3555858-1-omosnace@redhat.co=
m/T/#t

- 1 patch without response:
https://patchwork.kernel.org/patch/11392367/ libselinux/getconlist: add ver=
bose switch to print more information

- 1 RFC related to other kernel RFC
https://patchwork.kernel.org/patch/11436953/ [RFC] selinux: add unprivilege=
d sandboxing capability
https://patchwork.kernel.org/patch/11436955/ [RFC] libsepol,secilc,policyco=
reutils: add unprivileged sandboxing capability=20


There are 2 opened github PRs without Signed-of: and matching patch on the
mailing list:
https://github.com/SELinuxProject/selinux/pull/174  Use quote include for f=
iles located in the local directory=20
https://github.com/SELinuxProject/selinux/pull/135  More robust ausearch ti=
me input


Have I missed something? Do you have any comments, objections to release?

Petr



--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6xcMEACgkQviIJHj72
InVT9xAAnqZ90vvts3Ynd9dX3SnJ03hTmDNLfNorpFUSaruNvNv74KbR2ubi3U9e
XXbPNKVBsXVeZt6koimwFcprqcrbbWjnjZ64to69Zmefu5/qRyo3qMAn8gQSFUaP
eF89r0ByLHt5jUBg5qK2okCH8O4FkbpEZmjBdgmThIpD2fIIoAOCmcbtoboy9X29
SDHftpVsD7lcjVOSNhFYZak2b+OjFm91Wgx7CEqlr87cI8XObjZH+EXooQVfjyKv
EyB1QpnILQTLLAZaNhuA4n9NPE8G1RFVpXuy8gw6vl2yjEBfyvOdU6HJWJQfu4yI
zbgSRmCNEpmLB83+kOz3CxZGBD0jAhdN5YKv71JOVbIVTWBBkP8sG9EYUdWnOMz4
BAf6Kp/qTjCrSm61ZPaqkmo6SJOjosJOi6vfUm1p47qs3nzhy0WuRERFYmYrywc8
E01UR5E9wFRK4fVRXfwsSxmaXwslUJjaLSJGgzZ8dZWsijaV7pNOIDUXWB4ibauY
TUgNm3joXnFHlhf/VrX8/mLlI/IBwG8cwRqFEKnLdR75FAT55hMAxlDxUXH/7esq
CB/YoMlIXSKbMT+Qlngw9Ny8t2L6AK+uRG3x55ujXCw2aeuaY6Pw/FsCnY4JzwSU
UBMkTn2e5kVN/E4H7Kf3TzVdInWTLYRxpTwWsB7JSsQohlE7wmc=
=bO10
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

