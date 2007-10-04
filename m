Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l94DdDL3024214
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2007 09:39:13 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l94DdCEU010770
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2007 13:39:12 GMT
Message-ID: <4704ECF8.8050708@redhat.com>
Date: Thu, 04 Oct 2007 09:39:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>
Subject: One more problem with genhomedircon replacement.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shadow-utils and perhaps others execute genhomedircon when adding users
or modifying the homedir.  They are blowing up because the executable
genhomedircon no longer exists.  I would like to just put out a script
that would call semanage to tell it to run the semanage_genhomedircon().

I also think it is useful to have the ability to execute this without a
rebuild/reload of policy for when the admin executes vipw or any other
way of adding a user to the system

But there are no Python bindings and no way to call this via semodule.

I can call semanage -Bn, but this is slow and cumberson.


I looked into why semanage_genhomedircon is not in a python binding, but
it uses sepol_policydb_t * policydb, which we would need to build.

So what is the best way to do this?

Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHBOz4rlYvE4MpobMRAhPkAKCO4WCyQYQyxkSyfOOufo77HtgaCgCeMatS
f6pmBcQoObZevpjtTdCFMHo=
=wCF/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
