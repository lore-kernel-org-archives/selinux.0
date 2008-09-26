Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8Q3YgoW025749
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 23:34:42 -0400
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8Q3Xh1O024891
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 03:33:43 GMT
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
In-Reply-To: Your message of "Wed, 24 Sep 2008 09:18:16 +0900."
             <48D98748.6090408@ak.jp.nec.com>
From: Valdis.Kletnieks@vt.edu
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
            <48D98748.6090408@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1222400049_7097P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 25 Sep 2008 23:34:09 -0400
Message-ID: <9546.1222400049@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1222400049_7097P
Content-Type: text/plain; charset=us-ascii

On Wed, 24 Sep 2008 09:18:16 +0900, KaiGai Kohei said:
> James Morris wrote:
> > Is there a programmatic way to determine the type of SELinux policy 
> > configured on a system? (e.g. "targeted")
> > 
> > I've looked in the SELinux userspace and SETools repositories but not 
> > found a library call to do this.
> 
> I also want to know the way to obtain the list of policy types,
> because it is necessary to make a specfile which provides policy
> modules.

There be dragons here. :)

Keep in mind that the list of available policies on the machine that you
create an RPM spec file and do the 'rpmbuild' may differ from the actual
install environment.  So keep straight your Requires: and Build-Requires: ;)

--==_Exmh_1222400049_7097P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFI3FgxcC3lWbTT17ARAm5+AKD975ndLQ4jKYll69GAIXPYK9EaJQCgyLZz
XB0F8sdTn/H7Q3ydtle6/QM=
=tEVk
-----END PGP SIGNATURE-----

--==_Exmh_1222400049_7097P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
