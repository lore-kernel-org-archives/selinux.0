Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37NP0gM012705
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 19:25:00 -0400
Received: by mail-io0-f196.google.com with SMTP id z133so14087725iod.1
 for <selinux@tycho.nsa.gov>; Thu, 07 Apr 2016 16:24:59 -0700 (PDT)
Date: Fri, 8 Apr 2016 02:24:49 +0300
From: "leon@leon.nu" <leon@leon.nu>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 09/13] ib/core: Enforce PKey security when
 modifying QPs
Message-ID: <20160407232449.GB20252@leon.nu>
Reply-To: leon@leon.nu
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-10-git-send-email-danielj@mellanox.com>
 <20160407163100.GA5808@leon.nu>
 <DB5PR05MB11113874870EBBE896E0D601C4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160407211056.GD12844@leon.nu>
 <DB5PR05MB11115DF816F6CEAD7738201EC4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
In-Reply-To: <DB5PR05MB11115DF816F6CEAD7738201EC4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 09:23:04PM +0000, Daniel Jurgens wrote:
> I can change this patch to the common flow above, and then introduce "my
> flow" in the patch that requires it.  Another option would be to squash
> the two together.  They are both relatively large so I am hesitant to do
> that.

It is up to you. There are two things which you can take into account
while doing it: correct code and easy review.

Thanks.

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBuxBAAoJEORje4g2clinlu4P/2LYqVE3MLRZT+x9gjTFYwQS
22IBviafL/8mAXeORtE6Z4yMdaQ3eHhviBJ3j//t/byW9hS8Nn7cpD77Qpwsvdy5
cjoS36MwHK+6vWZJqeMsJl1hbSgeZkt+/yjQuB3sHZGK3jIt6Yp1Ksy46OpkZnH/
+W7YRB/Yw/RfesxkQCdSH11dtniIXQgvUCblofjWngKig7LyAkBP1krEkMpTFZI1
dcBKKTz0tF7W0HbQWx7LAAeRWJ22WZZ1tSlhZKf/Mr27LspWeesWGIQd7tc+dL8l
+K/xBQXIQ0yXbIw/puwfKX9cUYrdUZh+xVzecmTCG3W07w53iujoHTEth2EnQTHh
AAwT3WsMFjGU9hWy+u412X4DBDmUo3Q/7mEylWL9seO2ekhLyQCga+hj74hEBNXX
1flkTa5Ed7NwlEXIZwBSfYpTedGNbJL2E8Vvle6dY4tRHGLJc+iEQgOfceJJENDw
TOC6x7N7pEgvSavH4M5tZFv77xseyzzLRD2jcF1MtEZ63GmCv/AJtzaX5DIi4Nod
hmHPyTCOwZsS97ipTqdvRKDLLGqS9KVkT4/Nsyf2nZYiVo26TxzAssP0V9hVkkQT
qOxSCOFJb6TgYYNlHSYRxoEp0YlfugLiN5Pgfe8Mobwi5B0Pw8I73Wm9rm6snjxi
/9MMM0h2EjhyCTznB8Kg
=cnkz
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
