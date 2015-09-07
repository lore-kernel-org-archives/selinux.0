Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t87GEutg029655
 for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2015 12:14:56 -0400
Received: by wiclk2 with SMTP id lk2so88934011wic.1
 for <selinux@tycho.nsa.gov>; Mon, 07 Sep 2015 09:14:53 -0700 (PDT)
Date: Mon, 7 Sep 2015 18:14:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: kuangjiou <kuangjiou@huawei.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: got some problems with the type_transition rules
Message-ID: <20150907161449.GA12835@x250>
References: <60ABE64B4BE4AC45964F1A967BA76CB201F75356@SZXEMI502-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB201F75356@SZXEMI502-MBS.china.huawei.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2015 at 11:22:26AM +0000, kuangjiou wrote:
> Hello,everyone!
>=20
> I am trying to use the optional file name feature in type_transition rule=
s , And I test it in my OS (with kernel 3.0.76 and selinux userspace 2.1.0 =
),
>=20
>=20
> 1.       I add the type_tansition rule in my policy like this : filetrans=
_pattern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,"123"), It can be com=
piled and installed successfully
>=20
>=20
>=20
> But , every files that I creat in the tpm_dentry_t dentry , I will get th=
e stmfile_lst_t type, not just the file named 123
>=20
>=20
>=20
> 2.       I add two type_tansition rules in my policy like this :
> filetrans_pattern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,"123")
>=20
> filetrans_pattern(unconfined_t,tpm_dentry_t,trust_log_t,file,"456")
>=20
>=20
>=20
> It can be conpiled successfully, But got some error when install
>=20

I would have a look at applicable type_transition rules with sesearch to
see what is there.

sesearch -ASCT -s unconfined_t | grep type_transition | grep tpm_dentry_t

>=20
>=20
>=20
> libsepol.expand_terule_helper: conflicting TE rule for (unconfined_t, tpm=
_dentry_t:file):  old was stmfile_lst_t, new is trust_log_t
> libsepol.expand_module: Error during expand
> libsemanage.semanage_expand_sandbox: Expand module failed
>=20
> semodule:  Failed!
>=20
>=20
>=20
>=20
> Can anyone help me with this problem, Thank you!
>=20
>=20
> pS: I got the selinux userspace 2.1.0 from here
>=20
> https://github.com/SELinuxProject/selinux/wiki/Releases
>=20
>=20

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV7bf1AAoJENAR6kfG5xmc4zEMAI2ECGG2gIspcP0o061KRO6b
DKBRKxeDmfw5q4l2wJ0mkn4NcSvNEPKaXwS2t8UJL3dkJLdsLUN4BlXD0r4auFFp
z9kZH+t1G08OMTaUJt5MFFoZutpu44l2SneaYoGB9v+uE4AHdRSs5CwJu7oy8vbS
DMAlaseuNT4I/8t64q4HEF7yzjAnO+UE8BnGWFf0hMHVeG+iPTQE/W6CHupKHLj2
kqwfeX8tB+LYxp9rJvfwwbMfDi7HENggVoRaN2b9oyDvSahrIyuSRsmX98D3KnGp
KY+EHSL7Us/6DOeG0eDxgrW69RHLKlDwmq8QBcEqZgu9XQ51+XKwcEdjjcCsQiUA
O5cAFunl6n8dLqO6y5f5jhs7N5Je+wr+9QLY3bRzeIdaSfVZXyL+yVWeMP2gcKo6
tnfpAAMtdtoOsaDGYG59bBx9WaY6283ljWgtzRm6MmE9gP8cPrxtr/pV8vKOVpy1
KBcL6FZJkjMnguQh/vaErwXLJj0XTbm53Qb4F7fSgA==
=ka+L
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
