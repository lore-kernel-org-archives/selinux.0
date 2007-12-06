Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6IAIjQ029210
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 13:10:18 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB6IAHlR012366
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 18:10:17 GMT
Message-ID: <47583B05.1020906@redhat.com>
Date: Thu, 06 Dec 2007 13:10:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More nsswitch changes.
References: <47558E0A.1090600@redhat.com> <1196956556.12626.52.camel@gorn.columbia.tresys.com>
In-Reply-To: <1196956556.12626.52.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Tue, 2007-12-04 at 12:27 -0500, Daniel J Walsh wrote:
>>  policy/modules/admin/alsa.te          |    6 ++----
>>  policy/modules/admin/vpn.te           |   10 ++--------
>>  policy/modules/apps/thunderbird.if    |   15 ++-------------
>>  policy/modules/services/apache.te     |    2 ++
>>  policy/modules/services/mta.if        |   13 ++-----------
>>  policy/modules/services/postgresql.te |   10 ++--------
>>  policy/modules/services/rshd.te       |    8 ++------
>>  policy/modules/services/samba.te      |   14 ++------------
>>  policy/modules/services/sendmail.te   |   14 ++------------
>>  policy/modules/services/xserver.te    |    5 -----
>>  policy/modules/system/authlogin.te    |    8 --------
>>  policy/modules/system/mount.te        |    4 ----
>>  12 files changed, 18 insertions(+), 91 deletions(-)
> 
> I dropped the alsa, apache, because I think the nis/nscd that is
> currently in those are potentially wrong.  Back in the example policy,
> there was some liberal usage of nis an nscd, and I suspect these are
> just carryovers.  The netlink_route_socket usage provides a little more
> evidence.  The other ones are merged.
> 
Ok, greping through the source of alsa-utils shows no getpw.  So I will
remove that policy and wait for the avc's.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWDsFrlYvE4MpobMRAvL1AKC3r122CuFPNuo/2hhL+eRhxPHFKQCdHjtF
Jr8N/HK7V+fyD1VoqfVOXCM=
=n3Ke
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
