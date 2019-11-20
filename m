Return-Path: <SRS0=kO0s=ZM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08CC432C3
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BAB2088F
	for <selinux@archiver.kernel.org>; Wed, 20 Nov 2019 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u++4DUnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfKTSHE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:07:04 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53966 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTSHD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Nov 2019 13:07:03 -0500
Received: by mail-wm1-f52.google.com with SMTP id u18so633716wmc.3
        for <selinux@vger.kernel.org>; Wed, 20 Nov 2019 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dw7LW8Ma++Cwp2PIpylOo4I5hd/3NgoumwiJIMHgOdg=;
        b=u++4DUnxm12hLJ0k7w8Bjr1bs3jdmMgll6+Uy1SKw6Z1YThFlvN0iL2JDIB/f0qytk
         ub0yleI8i1GZgyNw/L2j8bGBlaCMHKH92cteZCec08H5jeKY9qvx3Q2G2NC/JdVjnfmE
         LevLVsNO5PPN04/wERU6lW52Q8DvQm/VfUGLkAfPP9jvqXvbUKXTTFEqfXdy7mzhukaU
         9VedzgGU02yEHtul9ie7CbzkWvFG/7iRwJsf8aUGMzg0YUlBOldqEgVQYNBOu5dpGyVn
         53weDX4YCBlvNYsHpA+ZyT97n556kFCJXGENfcZapZhAOywvpe9xKrN8TnMiSY5gb9nm
         EAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dw7LW8Ma++Cwp2PIpylOo4I5hd/3NgoumwiJIMHgOdg=;
        b=JvbtlL7pjeXsWqxpnWUZovViO1/onJalutWhRx2vk8rEf+pH6dvX7voH79nwwKTa+h
         doW8VEdb4/6liIpuQZ9+D0IqymNHaOACzWw11O70ad0ICqNqQWjVU+dh4TMIP7l6nKhZ
         obFNHsEOtVhG3gax1+6LxAo7SnAoQoSbWjbqMOojm2DmbjpTjUqxg66maUXAm5/HjzK4
         0/blU5qB6LYV44JDYQxVZzlaFzINyAEf8tQaH2HpHU757DPWRSi1jd6na/7A0ImtKgBK
         oQY5gRC5TaHS3DOpfPAoSdo3piAq4bW1ME5xZD+FzJpAwjdgXNawMPv8UolOhCao1VwD
         JwuA==
X-Gm-Message-State: APjAAAVbsAH2O6IKvflclQNrgTsIuCzhG+VyggSmMApdP++wRB8o5vqy
        NaGvSWgkumHsUo7+ZbXWr4Kyrmfl
X-Google-Smtp-Source: APXvYqwVa4Isz+lHGwUi03NyQeTiPzbNs2+NdnfxOK6Y8eYodUmlSO2crzh6KQSLXLT8lQ7v7dWK8A==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr4714223wma.177.1574273220048;
        Wed, 20 Nov 2019 10:07:00 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id d9sm90351wrj.10.2019.11.20.10.06.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:06:58 -0800 (PST)
Date:   Wed, 20 Nov 2019 19:06:56 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: Re: RFC:
 https://github.com/SELinuxProject/selinux/issues/140#issuecomment-556049712
Message-ID: <20191120180656.GA1792905@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
References: <20191120160858.GA1624071@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20191120160858.GA1624071@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 05:08:58PM +0100, Dominick Grift wrote:
> I was reminded of issue in topic.

I think that, if anything, I should limit my effort to just renaming the us=
erprefix statement in CIL.

It would be up to any users of -P/--prefix in semanage to address that chal=
lenge.
As there currently aren't any such users, I believe that the way this is cu=
rrently handled in semanage is probably the right way (not exposing -P/--pr=
efix)

>=20
> "userprefix" functionality has been removed from reference policy since 2=
008, in favor of "rbacsep role".
>=20
> I am currently the only (known) user of "rbacsep role".
>=20
> I guess the CIL "userprefix" statement would probably have to be renamed =
to something like "rbacsep_role", and the -P/--prefix to something more acc=
urate (any naming suggestions?)
>=20
> Am I overlooking some other visible/exposed references to this deprecated=
 "userprefix" functionality?
>=20
> As the only user of this functionality (although I am not a user of seman=
age) I feel obliged to some how try to address this.
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3VgLwACgkQJXSOVTf5
R2llNAwArtGWrSQukXbrTziqziH8Ne6y9GKSMpO6CHKbEKtmCX12t9oYKR26Nf11
w0JQrFUaCR52o31eiHrY4FJ7uQrHq7YCyz1r0Dk67GPbeRngKHCPeo9EQywWH+Hp
6NhbXAnIKbbKYqa3gFlbuwDb5vR5fXygzPh+8G9MUIfsxUnRJ2QG7NwrcHj/RQTG
EEIx18iB9gbi1iDLZLyApccR8byGuTWbw/cPP9rQxfP4HFyfmjMhdzVkVwWyJ6zn
R3i12lGD89naN+8Rn7TTN2Fgn7bM7f59QOtVF+qqFXL/k0nu1dFXlwY4Jj8PVbzH
C6KIWMLc0P0pS0R2ypHsmMSGE5SVi413bddr8LgqNEhUknzPxzwadsX+laSA0inJ
TIxvDU842O+B9LXHJMeLpI0dEplHUwZC2vZTPgZoBRy162NjUeRoFZHL0CsfvQei
lOTjwN/+P2OUfwCTBOOvXwvLIXvyL1e/thliCRAEvnQDtUfpuw28PgFZXb8Kykv+
fzVxiVX8
=AGE5
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
