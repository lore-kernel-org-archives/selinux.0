Return-Path: <SRS0=1V8V=AA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B924C433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 12:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E5E20809
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 12:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBfdM7AH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgFSMrq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:47:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731492AbgFSMrp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 08:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tat4S6vx/ORxN0oKyBdkTRk+RI1Plv90ineWIEYdHc8=;
        b=dBfdM7AHLFvsYn7uwCXELdAvYT6FgzHWL/vVoP/DW2/jzOEpAmilXhkpZInnHFzmPPFTTW
        wz/rJmULux2ItPeDpE40Mt4PqKLEnfUoUY6Vj52E7P0WS+zhVsbzwdfF8PDUISWc8xC981
        m7w4F7N8mLRym8U0B0FJQH/AmlQhsHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-2bI6KRXROS-sydBOklybpQ-1; Fri, 19 Jun 2020 08:47:27 -0400
X-MC-Unique: 2bI6KRXROS-sydBOklybpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AD48018AB
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 828C210013C4
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 12:47:26 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:47:23 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: Still Failing: SELinuxProject/selinux#444 (master - b3d8b99)
Message-ID: <20200619124723.GD785659@localhost.localdomain>
References: <SELinuxProject/selinux+700041658+stillfailing@travis-ci.org>
 <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 12:03:51PM +0000, Travis CI wrote:
> Build Update for SELinuxProject/selinux
> -------------------------------------
>=20
> Build: #444
> Status: Still Failing
>=20
> Duration: 17 mins and 45 secs
> Commit: b3d8b99 (master)
> Author: Petr Lautrbach
> Message: Update VERSIONs to 3.1-rc2 for release.
>=20
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> View the changeset: https://github.com/SELinuxProject/selinux/compare/08f=
5e3017721...b3d8b99f0cb0
>=20
> View the full build log and details: https://travis-ci.org/github/SELinux=
Project/selinux/builds/700041658?utm_medium=3Dnotification&utm_source=3Dema=
il
>=20

Seems to be related to outage in Fedora infrastructure -
https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org=
/thread/MAGJJTVR777ARZ4TVMBQQ3YK6RC7ODE6/

There's also ongoing datacentre move -
https://lists.fedoraproject.org/archives/list/devel-announce@lists.fedorapr=
oject.org/thread/5DNRZ4OUUNGSUJONQLEXXP3CKME43SCE/=20


--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7ss9UACgkQviIJHj72
InW4LA/+N5FUbko2zWt4YvlBYx/rtgctMbatSOLtcl7+qzMe271jE+bARC0tkeeh
VHAPsGKGgKX9JCQxUTBN/Q3lncpOsi8IZpkCeOhbtmF+SZ6o0hHpO7ysRQryIYXi
6Rlzxge59tjw74JhjK+RFkJwKvfALFhzMnj7sIQZiryq2BklE6VZ7qetOhJB464T
WuZnH3Nw5mLaLLS1WLuQFfdx2hG/L+iYzL1IaC2A2QY8lHgnrEuEGb/uWLhumyCb
0sn2/pyR1q8essCptEnQT1cWYWpMKaP/XM29e77nugOtA/bv8XYgxtYsNgEmf3m3
3GL8ftxC5+Jkn3sImQ79KsOsKPvrnvgKVHx3sf3LmJ1v36cronHVH2USID0UnZYU
lQ6VfR8jpHgkqCAtF07W1Xbgo9NvRMY40eKVVVkxiS7U+s+xV0/Ndbk6qESbb2FI
Jw5idNcE6llmyTDe23ukRR7H7Pe2T5LyrXET1ISKNjB5AfLHKf/MNFrWBWuMzyMF
/8ygtFpz9RMF5lS8kOE6T8lCGbn5nINR2rCjENGD841ocZUV+QrDMcLBNkpACwC8
XxK+yWXJGYwoUB/XWEIKoM/R9QUJ+OV3MVVMrxZhLHzk5yrsBhvnR1H8szK9u94K
P4n41eAhuI/RDjWJTTLefC1b1dfgBZtjPTv9Vetyanc+bwAQXoQ=
=bRzf
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--

