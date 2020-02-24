Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746AC11D2F
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0B82080D
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 17:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBXRHX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:07:23 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:43496 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgBXRHW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 24 Feb 2020 12:07:22 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 8B84B132004B
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 18:07:21 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:07:20 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: strange issue with name-base type trans
Message-ID: <20200224170720.GA684511@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The scenario:

(in user
(macro obj_type_transition_mytmp1 ((type ARG1)(class ARG2))
(call .file.tmp_obj_type_transition (ARG1 tmp ARG2 "thisworks")))
(macro obj_type_transition_mytmp2 ((type ARG1)(class ARG2)(name ARG3))
(call .file.tmp_obj_type_transition (ARG1 tmp ARG2 ARG3))))

(call .user.obj_type_transition_mytmp1 (user.subj chr_file))
(call .user.obj_type_transition_mytmp2 (user.subj chr_file "thisdoesntwork"=
))

The outcome:

[root@myguest ~]# sesearch -T -s user.subj -c chr_file,blk_file | grep tmp
type_transition user.subj file.tmp:chr_file user.tmp ARG3;
type_transition user.subj file.tmp:chr_file user.tmp thisworks;

[root@myguest ~]# uname -a
Linux myguest 5.5.5-200.fc31.x86_64 #1 SMP Wed Feb 19 23:28:07 UTC 2020 x86=
_64 x86_64 x86_64 GNU/Linux
[root@myguest ~]# rpm -qa libsepol
libsepol-3.0-3.fc32.x86_64
[root@myguest ~]# rpm -qa libselinux
libselinux-3.0-3.fc32.x86_64

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5UAsEACgkQAlFoDzf+
eRODLRAAmV1vgv9svjTRMJEJ5HBMR3CVuLPP1k5esXBsX4K6sIuc4lS/Kh8ZabeI
+BHAYsKnTfNb3k2yK6h7DWvcS8VCU35uLMHcJjEBHQX1xbbKfAstaLYUCkT7qH64
rFu0VkKaDAW7tuMtCGscbHzkCK5MChpN4S+hOB3Ag7tL7Z5DoUMZaT2r+Tcztdur
G3yD//btP2AmZT2Th10Toeb+qPUifMGSnd2NeBgCdrCeJDbu2bYHaRjXiU/NUyVs
lRG8cgYnLPkOm/67ga60JpjvqFAlDU5ZLN6+EW8mOCFLc543fuVzeP9DpD+5rxal
Sg44lspQxduw92AvKmhW0dEwiqaSNXIeCK3a53HyiqjGVAvMUC8giQtDQE7DdalA
Hc4gUHCy2yA5yassGwLadDJ5crtD0NWvsszEPZVvZdMAd+czntghT8WxtY/sUxj3
EsjML/l5erwV3sZuvfaP56nK/brt4b+K71MHQ+UTMlub1x1m76VWtMhEZag4BT/A
zEPaH33sUCeSaKYtzA/tgXJSharv71YJS06rTp9TCCwjczpDVhFyVQiojxfDgBvW
+IdTfelHjUW7pGBkXILBBA/b8WLr2/YwlhIFPXr8yeKOY8yII5aCBxYihccvt3+s
+ecnkbGlaSxqGlRdayY0QbeT0QjgSBC1bihIiMZdqobeS7topUU=
=wjiZ
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
