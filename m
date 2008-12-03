Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB3NvEKK010983
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2008 18:57:14 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB3NvBCN021711
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2008 23:57:13 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mB3NvALa007699
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2008 18:57:11 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mB3Nv9hV032403
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2008 18:57:10 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mB3Nv7e7009234
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2008 18:57:09 -0500
Message-ID: <49371CD3.1060007@redhat.com>
Date: Wed, 03 Dec 2008 18:57:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I think it is time for us to put the attributes back into policy
 file.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am getting several complaints from people wanting to see these
attributes.  I would like to be able to list all "Domains" so you could
choose which domains you want to put in permissive mode.

I would like to see which attribute is giving a certain permission to a
domain, without having to query the source.

I am sure there are other uses.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkk3HNMACgkQrlYvE4MpobPCNgCg5t0UqNvz+GbzVsbLMuCDQrpV
VNkAoIoxKVwCqJ0BHXmRrWDGRTjDixjr
=LU0h
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
