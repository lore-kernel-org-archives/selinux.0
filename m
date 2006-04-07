Message-ID: <4436BEF3.5030304@kakou.org>
Date: Fri, 07 Apr 2006 21:35:15 +0200
From: kakou <kakou@kakou.org>
Reply-To: kakou@kakou.org
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: audit PID of child process and end of process
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I work on a IDS based on the analyze of SELinux traces.
To do this, I generate a set of auditallow rules in order to detect
some events.
I need to audit the creation of process via fork()
auditallow type_t type_t:process fork;

But I need the PID of the child process in order to compute my analyze.
I also need to know when a process dead (or stop).

Anyone know if I can do this with auditallow rules?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENr7w3RS+hG/PB/URAiAbAKCR6bKJ0qC8red0ARa+sMaKMj6ymQCePTnY
T9dGCIkhKZptz7OQDNulc4o=
=rCLi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
