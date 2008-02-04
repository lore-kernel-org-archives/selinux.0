Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14E3J3s027719
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 09:03:19 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14E3Ih9012174
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 14:03:18 GMT
Message-ID: <47A71B22.90506@redhat.com>
Date: Mon, 04 Feb 2008 09:03:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] samba
References: <1202029647.2674.1.camel@vogon>
In-Reply-To: <1202029647.2674.1.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> On Debian machines smbd needs append rights for samba logfiles.
> 
In Fedora smbd_t needs manage_files_pattern on smbd_log_t.  Our samba
developers informed me that this is ok, since these are not security
relevent log files.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkenGyIACgkQrlYvE4MpobMFSgCcCAOhKW0zrOmRyf/6zifGOBj0
IGcAoJ4dsNctCyp4k7LdaLbu468xbiK4
=iw9h
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
