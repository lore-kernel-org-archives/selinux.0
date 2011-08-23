Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NDhi5M029569
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 09:43:44 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NDhhU0005784
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 13:43:43 GMT
Message-ID: <4E53AE8C.6020707@redhat.com>
Date: Tue, 23 Aug 2011 09:43:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: cpebenito@tresys.com, slawrence@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eliminating booleans would be great and replacing them with tunables,
but the tunables must be discoverable, and it must be easy for the
administrator to discover the "tunable" and turn it on.

Currently audit2allow/audit2why turns on all booleans in a policy and
checks to see if an AVC would be allowed with any boolean.  Then it
prints out the booleans that would have allowed the access.  We use
this functionality within setroubleshoot.  This is critical to making
selinux policy usable.

User wants to allow ftp to access homedirs, he sets up ftp and SELinux
blocks the access.  Setroubleshoot comes up and says turn on the
ftp_home_dir boolean to allow this access.


If we can not duplicate this functionality then I NAK the change from
booleans to tunables.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5TrowACgkQrlYvE4MpobPNxgCfZjsoX+jBRoIdG9IT+MfsHmn7
EjwAoItrrawS+hrhwyKc9pYNq+mSPJfF
=Y4VF
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
