Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162F1C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CE6208E4
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqpTqp84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHZOQc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:16:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28818 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727933AbgHZOQb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598451389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ea5rQGFRyojB4+Jvzr1fpU2dhS8XrxTeP42jv6eTnPg=;
        b=XqpTqp84tG48+nRuRRQcVhwEQxeYXghHtwmmPX/y+u3b0aRr/P9eLuIHXiVmu8P2WI2Koq
        O/kv6PUTqYHE2p6gwE7vRhxqba5ODsnYk9PolPDe4ctLkNdOjGzt9jHO/TJ8ses2dXccOI
        3NdnPr2NGzUL70DgDrGLocJJ6VDYn0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-4ZljkAjxNOqmCwm9ZxY10w-1; Wed, 26 Aug 2020 10:16:25 -0400
X-MC-Unique: 4ZljkAjxNOqmCwm9ZxY10w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC488030D6;
        Wed, 26 Aug 2020 14:16:24 +0000 (UTC)
Received: from workstation (unknown [10.40.193.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12371712EB;
        Wed, 26 Aug 2020 14:16:22 +0000 (UTC)
Date:   Wed, 26 Aug 2020 16:16:19 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: Re: Userspace AVC auditing on policy load
Message-ID: <20200826141619.GC401602@workstation>
References: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
MIME-Version: 1.0
In-Reply-To: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 09:25:18AM -0400, Chris PeBenito wrote:
> I was looking into this dbus-broker audit message, which has the wrong au=
dit type:
>=20
> audit[422]: USER_AVC pid=3D422 uid=3D999 auid=3D4294967295 ses=3D42949672=
95
> subj=3Dsystem_u:system_r:system_dbusd_t msg=3D'avc:  received policyload =
notice
> (seqno=3D2)
>=20
> This is due to dbus-broker setting their avc log callback to send USER_AV=
C
> audit messages for everything that comes to the libselinux log callback. =
I
> think the right thing to do there is to change it to emit USER_SELINUX_ER=
R
> audit messages if the log message is SELINUX_ERROR, otherwise log the
> message using their regular method (stderr I think).

Similar problem existed in systemd. It was fixed by the following commit
https://github.com/systemd/systemd/commit/6227fc14c48c4c17daed4b91f61cdd4aa=
375790a
which lets systemd log callback to ignore everything but SELINUX_AVC and SE=
LINUX_ERR

I believe this is the same problem which should be fixed in dbus and dbus-b=
roker


> But the question became, why is the userspace AVC not simply emitting its
> own USER_MAC_POLICY_LOAD audit message instead of sending a message to th=
e
> log callback?
>=20
> --=20
> Chris PeBenito
>=20

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl9Gbq0ACgkQviIJHj72
InV7Vw/+MCugzGQFACDiwT0G0uiZ4kbYrI3+FdvV+n84Gh2EK+eaPdiam98sK5Zo
XgTv9RsgVSb0NucxWauh3fmKZd0cBNXwekiR1B3jzHmdWWn67UnmkaZ8FraFlxCQ
3Mstnf+VUe14OyXz8WgaMxYyobjDARvJdLizfOE4hO0Kxft8ivnBusYzvdJTZmq7
I57JJ0B68muZiEwHI7rZmdKLjjHNgHVYSPO4sIwPm8PS0BmDZeard1sQBpfngVCx
edUR+STFIWa8suzBL2J9cqyAdXIWGsHWuuDCYLz+irIr8udGm4aNEf87hTvhi86G
cWTEG2wJrhssyzZ8L8jnVV7+IX+ccEukFOPKKc24KlEN16TM5esdFwMJl+XHBt3T
W3QUnTRVIrbI/BIzmAIQw/j0LM8YuEwxgq2sywWR19DfdR8EUBRDUEZbvrUj7EFi
q6HblWCS4p0KkCFSIhmpSNf7FtMdZ5cRajp1Xf7m8ELbMa5w8A7sfWVl/VETtwef
srMYBgPK7nULwfjM/Enc1tNKn7uTSr4IKJ9iMVpHr4HnP5eIfxYDcHL9IdhdZHLW
43+snFVxZy4TpRpbocZ0Qcg7E4VcschzM1k5mMYVWvbeoxW2eYD4g3eyDdYzPbks
uHlDrp9rzbmKWUE+0SW2KuCYMzDoBl8pWD+Yv6qUXl+LFAtfDB4=
=1a7x
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--

