Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p51DlwWA012845
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 09:47:58 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p51Dlv8U022437
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 13:47:57 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p51DlupR027597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 09:47:56 -0400
Received: from localhost.localdomain (vpn-9-247.rdu.redhat.com [10.11.9.247])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p51Dlt1b021027
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 09:47:56 -0400
Message-ID: <4DE6430B.8080604@redhat.com>
Date: Wed, 01 Jun 2011 09:47:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Can we eliminate or optimize nodups_specs within libselinux
References: <4DE64180.50302@redhat.com>
In-Reply-To: <4DE64180.50302@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/01/2011 09:41 AM, Daniel J Walsh wrote:
> We are costing boot 1.5s
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=709014

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

This seems to be something libsemanage should do to verify the
file_context file is good, but libselinux should just figure the
file_context file is sane.  And be optimised to read access.

Might be a reason tools like install run slow also.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3mQwsACgkQrlYvE4MpobMxHwCghBRuPpL2c8wGITLeF6jAGRsO
3yUAnimXDBNaeM4aNYuVQSv7zBOaigmF
=9XXq
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
