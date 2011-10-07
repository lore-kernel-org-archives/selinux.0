Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p97IOHWK002000
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2011 14:24:17 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p97IOF6k019103
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2011 18:24:16 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p97IOFTq028841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2011 14:24:15 -0400
Received: from [10.16.62.230] (dhcp-10-16-62-230.boston.devel.redhat.com [10.16.62.230])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p97IOE8O004396
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2011 14:24:15 -0400
Message-ID: <4E8F43CE.7010605@redhat.com>
Date: Fri, 07 Oct 2011 14:24:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: I am working to further shrink the size of policy in Fedora 17.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Right now, every domain that transitions to another domain gets the
following rule written.

   dontaudit SOURCE TARGET : process { noatsecure siginh rlimitinh } ;

In Fedora 17 policy right now we have 2152 rules, out of Dontaudit:
     9415


sesearch --dontaudit -p noatsecure | wc -l
2152

We could rewrite this with one rule.

dontaudit domain domain:process { noatsecure siginh rlimitinh } ;

Of course this is more lenient then what we have now, although since
it is dontaudit rules, not sure it matters.

Comments?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6PQ80ACgkQrlYvE4MpobMn5ACeJMpRnEYe5nvpyWjhKbqpANw4
kB8AnA0ORPBkKS6Ww0AWzedMAnD+Teth
=Q6g9
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
