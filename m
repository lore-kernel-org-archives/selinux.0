Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04NY1Ii028957
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 18:34:01 -0500 (EST)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04NW9PZ003890
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 23:32:09 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j04NY1Wj028144
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 17:34:02 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id DFFD64A626
	for <selinux@tycho.nsa.gov>; Tue,  4 Jan 2005 17:34:01 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25524-09 for <selinux@tycho.nsa.gov>;
	Tue, 4 Jan 2005 17:34:01 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 9582F4A624
	for <selinux@tycho.nsa.gov>; Tue,  4 Jan 2005 17:34:01 -0600 (CST)
Date: Tue, 4 Jan 2005 17:34:01 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [patch] screen_macros.te
Message-ID: <20050104233401.GA11885@yggdrasil.localdomain>
References: <20050104230149.GA10317@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
In-Reply-To: <20050104230149.GA10317@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bCsyhTFzCvuiizWE
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2005 at 05:01:49PM -0600, Greg Norris wrote:
> One of the entries had the parameters backward, which prevented screen
> from HUPing it's parent.  This was causing "power detach" to fail.

After further testing, it seems that screen actually requires both=20
variations.  Here's an updated patch... please disregard my original=20
version.

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="screen_macros.te.diff"
Content-Transfer-Encoding: quoted-printable

--- screen_macros.te.orig	2004-12-11 00:13:45.000000000 -0600
+++ screen_macros.te	2005-01-04 17:31:01.000000000 -0600
@@ -77,6 +77,7 @@
=20
 allow $1_screen_t self:process { fork signal_perms };
 allow $1_t $1_screen_t:process signal;
+allow $1_screen_t $1_t:process signal;
 allow $1_screen_t self:capability { setuid setgid fsetid };
=20
 dontaudit $1_screen_t shadow_t:file read;

--liOOAslEiF7prFVr--

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2yfpgrEMyr8Cx2YRAveHAJ9VRGzNorU+nkNB4xMbrBf1SJkltgCgqi10
tW1PP2kucaI+3VCoiSy812M=
=9ap+
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
