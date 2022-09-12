Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D959C6FA83
	for <selinux@archiver.kernel.org>; Mon, 12 Sep 2022 13:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiILNGY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Sep 2022 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiILNGW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Sep 2022 09:06:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E62A436
        for <selinux@vger.kernel.org>; Mon, 12 Sep 2022 06:06:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E70372026A;
        Mon, 12 Sep 2022 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662987976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WP5hnqN3N1z6Mbv/8FElMyFU8GGOYpb8OOQR6lDvZ8Q=;
        b=PLe8/+OqzJQOI1Pl6b6nt80V6rdLYfJEVnOYifwALLL9GVibaMNLET2C1v2uqWe5JF6m3U
        VRq7Z/pM9f9Te80H3oMb09qHzkQrHvpW2DzThESNrATm//iOzs4Y7KgAigV506QAliC7HY
        73x2tTYk97DGSTEPJUzUj8xm6hbQ7OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662987976;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WP5hnqN3N1z6Mbv/8FElMyFU8GGOYpb8OOQR6lDvZ8Q=;
        b=HuiOo3w69Dr8PGgqqcJZPCktyhoTk4m2rPkIJlZrN9/WuF50fSfOA0BNRvFghI7fs/0e37
        DeaFTSHK14MbnMDQ==
Received: from suse.com (unknown [10.163.25.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0D722C141;
        Mon, 12 Sep 2022 13:06:16 +0000 (UTC)
Date:   Mon, 12 Sep 2022 15:06:15 +0200
From:   Johannes Segitz <jsegitz@suse.de>
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] python/chcat: Don't fail on missing translation files
Message-ID: <20220912130615.GE5803@suse.com>
References: <20220912074043.GB5803@suse.com>
 <67b3cb8d-bc04-2585-f27a-1e74c4fa78f9@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <67b3cb8d-bc04-2585-f27a-1e74c4fa78f9@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2022 at 08:51:32AM -0400, Daniel Burgener wrote:
> I believe this was already fixed by https://lore.kernel.org/selinux/87tu8=
3r2zk.fsf@redhat.com/T/#m55d405c1504f7bc4ffff5f5ea9152b45fdf6848d
> (commit 344463076b2a91e1d2c7f5cc3835dc1a53a05e88)?

yes, looks like it. I sent this as a PR a few months ago and only came
around to sent it correctly now. Please diregrad the patch then

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstra=DFe 146, 90461 N=FCrnberg=
, Germany
Gesch=E4ftsf=FChrer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moer=
man
(HRB 36809, AG N=FCrnberg)

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmMfLscACgkQvCfdnSzE
/Wbdjw//TyO/42FRDZcuHCalzXU7tlLTtNUSHr92Rp1hReif91fVju0C4im6GMvB
iAbXdj/j6F39k/WI73+B91pfPxkKCFo5tH/twx0Nv8KqTM15jNPiyHFbSdGw49XK
vt+EqPIZhvnsaeyHCtQ3OjxKz29rwedHdKonnzC0l6Ce0dAZlpDwo+lufraS9Ngt
DX6AQKy2H50QrvmgyMHkPQO1E7reufTif76WU273AMnuoPPEdlqTkwbBhj4E0vfo
VGU8TP8WWVEjfNOBPMMrmc0uCKiRblO/WdwAEFre+cWzUbypyjdjgraKNyHZRr95
EhHPMK9tIWGfexPy5DxfAI2GPBIkMOP85ZoHifOtj++XvJ7/1lgolVk91IKOsOTw
w/HbaoR35uMUDq124INRy4EiIEVO0Spaab2gfFkIFpT5NHepp+GPfIYi8bXX7uCw
jRF4a0UpOgCFyZtXxLtPbaTM0FDB+SBFLqUxhg/LaAPO7hpC+yiPGooaxeI1Tkgf
C2rTWqzncwoL/lG9+7+OWMGo3KdVXqqQFghZ4aAfKqt3oLhfqiUodfwJ3s5fIwFj
pu77il5OshCkrqNKlL2cY5vEPNw3vVLAAPyt1f6CkOMVjwnkBa6KDLviAqqCQva2
OHTlw+PutyRHDthIybJDoRc0TZp4OEklidMXjFNH8OFRQfowNcA=
=v2cX
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
