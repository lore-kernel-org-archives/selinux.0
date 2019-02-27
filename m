Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08214C43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 08:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D49218E0
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr48VzoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfB0IVM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:21:12 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43222 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfB0IVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 03:21:12 -0500
Received: by mail-ed1-f51.google.com with SMTP id m35so13097682ede.10
        for <selinux@vger.kernel.org>; Wed, 27 Feb 2019 00:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5qocRaeLNNBL17RTbvZ1dco5Yx6aopJBavPBwW5RKg=;
        b=Cr48VzoYbfknPaOWQVi6UAaiQsEGpPtrs/BhTg5psqXcfJFrttsZuR2Q1hvBZ/goWd
         5PaoMbRsKE5UPNwSMBwqABkSVtlwSs8mumLa/A0msNooKVCKhVRf3eZSl3EEqPbGUh+W
         wNiK54Hmx2PpOjB3XUGdsydwrYE4kzXR82Pk6n3NQUkGgGp2j64Jj1KshnllT3sJlfDy
         oaZ0XKvJLrzjNJTlWLJNNvKRvJWfc+96Dj4Cn9wu0wsnNXBiu2yRe2MHkb0yhZDb7WIl
         zpM9nZplv8Sa1mJ7Z4YpsJv7VXpwCcpp27E3rQuk/YIntgf84S8yLyu99TtNJ5sL96ne
         PAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=d5qocRaeLNNBL17RTbvZ1dco5Yx6aopJBavPBwW5RKg=;
        b=fpI5cJ+JiFJdI/Vr5h4tTvhnhZuulHOwjxWGCvXaEyGT+nduRbA+BWKCRZJ3p81V1+
         TLXr3zLrWLHeV2D7zSuzyV2eYXcACHgg2flnqoLVDPTWYMAcSfVFrk8dlYtRYMqZYvcv
         B8fCMVBH3Jtwg9wONxJPfdX54QwjsNObWxmyDsOIXBIwAnSYOs5Odpz+tzkmKeBY6Ny3
         Jxwv+gF+z13iax5kPKkZcXTRob5invZmi2ZjUVOPcz9mILKKdjmKN4dnPwOqUk9ZdbqH
         1pXPdt0buQFY8+s53TcxsEK7pRk+e/L3xgJ9geMBZ5uZfh+HkKsJ1H2XKlZmEUVXOGat
         mbRA==
X-Gm-Message-State: AHQUAubYMGuUsxcQW2xxB6RmC5faOJyXilQtwyg5IhulFESXl+J7d1SA
        xmQjUR3fvwgHFUobB0Et/tI=
X-Google-Smtp-Source: AHgI3IaHr3j/wCZR2UJz3mMavAnWV01aT929sHmnKPWO5sceMtyKtuFOuzcw2nUOUze99QLK7KMHXQ==
X-Received: by 2002:a50:a48f:: with SMTP id w15mr1308910edb.91.1551255670286;
        Wed, 27 Feb 2019 00:21:10 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id m19sm1099552ejz.69.2019.02.27.00.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 00:21:09 -0800 (PST)
Date:   Wed, 27 Feb 2019 09:21:07 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Ted Toth <txtoth@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: RHEL auth_role using logging_send_audit_msgs
Message-ID: <20190227082107.GA17179@brutus.lan>
Mail-Followup-To: Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
References: <CAFPpqQEHRb5pW7HGx7-yZgBbneA3US_nb4HqRAG5uSkYbxg+Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAFPpqQEHRb5pW7HGx7-yZgBbneA3US_nb4HqRAG5uSkYbxg+Jw@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 04:20:42PM -0600, Ted Toth wrote:
> The RHEL version of the auth_role macro which we are getting through
> our use of userdom_unpriv_user_template uses logging_send_audit_msgs
> which give a type the audit_write capability and allow rules for a
> number of netlink_audit_socket operations. It seem counterintuitive to
> give an unprivileged user type audit write related policy.The
> ref-policy version of auth_role does not use logging_send_audit_msgs.
> We're considering patching our policy but I wanted to see what others
> though about giving unprivileged user types this policy?
>=20
> Ted

I think this should indeed probably be dontaudited (i have a few of those i=
n my policy as well, so do as i say not as i do)

Might have been added because of some unpriviliged user space object manage=
r trying to log to audit. These would not have been allowed anyway.

XSELinux, old dbus come to mind.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlx2SG4ACgkQJXSOVTf5
R2lMGAv8D2AqLkCvb+JCh5EtaPHjndkciuDd3fLR3INLOUIOmg/3T64bdnB/AEdI
2KRaqdDs53p7fs5wFZkjjxa4HLiOgi+qX/jbwMGCYVGqCcPMkJM+ujOlC9CVpgSz
xKnC8gSYzj/7GMNhHkuvRYbqoG+SQprwZmiUssmQ3ibdFfMWfAe/9I7BlLbYuW53
ptw4RV9pd/KIIfL0hhHCyoDbMKMf6+sepR0Me4p2sZDJcUsHY45mpGGCtTvX3KMu
swbhHFqkLdFK82TzjJsrW/eYj6qLju/CB/eqVpKSuTCPI8J9eVt3MH4CPReNuVGI
EC/L/lmmaSindqN4GCO8GpPPD94M9RjAUc9zZ+ANSrT+hrL0w/YHBJN8anWVt8Jx
TSs8UoC8j+I4A2DzGbBvejVhEN/p4PPiYoS8+ynEMfsPmRTgPr0WznejnTEig4OO
Z1yR7TDHcc/thXqNtNmLSXpiNJ2WdbKFfJGDzg/sHhyarxXf1nhrKUESBsw6wBQN
uYr1r7zI
=yJd4
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
