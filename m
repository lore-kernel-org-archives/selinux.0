Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6MU0ub007289
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 17:30:01 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA6MTuLv000365
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 22:29:57 GMT
Message-ID: <4730EAD6.1060409@redhat.com>
Date: Tue, 06 Nov 2007 17:29:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: hkp port
References: <200711070000.53780.russell@coker.com.au>
In-Reply-To: <200711070000.53780.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell Coker wrote:
> http://etbe.coker.com.au/2007/11/06/squid-and-se-linux/
> 
> As described in the above URL I believe that port 11371 (for GPG key transfer) 
> needs to be labelled as http_port_t to permit GPG to use Squid.
> 
Why not just create a new type for this port



network_port(pgpkeyserver, udp, 11371,s0, tcp,11371,s0)

Then give connect access to apache and squid.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHMOrWrlYvE4MpobMRAn5iAJ4vJwqjiXSWAbuYuVAzu/HOWNtwvQCcDiFC
hblVcIld2Kb303R0igVStYo=
=IB7s
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
