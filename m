Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i920gBrT005966
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 20:42:11 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i920g9EZ019524
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 00:42:10 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id i920a1pS029941
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 19:36:01 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 838254A658
	for <selinux@tycho.nsa.gov>; Fri,  1 Oct 2004 19:42:08 -0500 (CDT)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02234-09 for <selinux@tycho.nsa.gov>;
	Fri, 1 Oct 2004 19:42:08 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 4F3134A650
	for <selinux@tycho.nsa.gov>; Fri,  1 Oct 2004 19:42:08 -0500 (CDT)
Date: Fri, 1 Oct 2004 19:42:08 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: selinux@tycho.nsa.gov
Subject: Re: bash_profile: Permission denied
Message-ID: <20041002004208.GA28117@yggdrasil.localdomain>
References: <E6E16A6D4277CD459BBDE6713766033CB71F3E@exchange.mvalent.local> <41530866.4020306@redhat.com> <1096670260.4161.18.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <1096670260.4161.18.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 02, 2004 at 12:37:40AM +0200, Erich Schubert wrote:
> What is the preferred way for having login being done as staff_r, but
> still having some profile files for root/staff_r?
> (staff_r doesn't necessarily need to write them, but i'd like him to be
> able to read them. So i can at least have a macro for "newrole -r
> sysadm_r" or a bash history entry...)

Have you looked at the "staff_read_sysadm_file" entry in=20
tunables/tunable.te?  I think that does what you want (assuming I'm=20
understanding you correctly).

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFBXflggrEMyr8Cx2YRArK4AJYujqCutZwGkHWQ9DlvuWV9ovyeAJ9DIbC9
DvdnHoohNQtSsLdlVZHqbg==
=Q9K5
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
