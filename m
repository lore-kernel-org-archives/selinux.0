Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2DNT2UU009908
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:29:02 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2DNT13k022909
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 23:29:01 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2DNT1Lk004072
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:29:01 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2DNT0BR011463
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:29:01 -0400
Received: from localhost.localdomain (dhcp-10-12-34-104.boston.devel.redhat.com [10.12.34.104])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m2DNT0Ox018703
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:29:00 -0400
Message-ID: <47D9B8BB.2080402@redhat.com>
Date: Thu, 13 Mar 2008 19:28:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux/matchpathcon has a memory leak
References: <47D9B0DB.90308@redhat.com>
In-Reply-To: <47D9B0DB.90308@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
> Looks like the selabel stuff is leaking.
I think if I call

matchpathcon("/etc", &scon)
matchpathcon("/etc", &scon)
matchpathcon("/etc", &scon)

It will leak.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfZuLcACgkQrlYvE4MpobO/pACgqvR1OLLm9WwSg6tk9b0Zmi2+
S4gAoLt23JGAfU/esg04pdPl+M3wil0s
=+Rlr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
