Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RHc8e2008335
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 13:38:09 -0400
Received: from mail.fluendo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RHc7VS014601
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 17:38:08 GMT
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id C13642500F9
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 19:38:03 +0200 (CEST)
Received: from deathwing00.fluendo.lan (core.fluendo.com [195.10.6.237])
	by mail.fluendo.com (Postfix) with ESMTP id 596A12500F5
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 19:38:03 +0200 (CEST)
Message-ID: <483C46FA.9030904@flumotion.com>
Date: Tue, 27 May 2008 19:38:02 +0200
From: Ioannis Aslanidis <iaslanidis@flumotion.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Quick question
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I do not know if this is the proper place for this; however, neither on
IRC in #selinux on freenode nor in other places related to SELinux I was
able to get the appropriate help. I have also spent over a month reading
through documentation and googling around to find something similar to
what I needed, but to no avail.

I would like to know how to create a module or policy or modify the
current policy so that users of the system are:
1. Unable to list the /home directory
2. Unable to get into other users directory using SELinux rules
3. (optional) Be able to list /home, but be unable to see anything apart
from his home.

I have specific needs in my production environment which require these
specifications. Normal permissions are not an option in my environment,
because of shared permissions of nfs mounts.

Getting a template and working over it or converting deny rules to allow
rules is not an option for me, as I need to be able to understand and
allow others to understand the text and be able to easily maintainy and
modify it.

In order to prevent the users from getting any data in /etc/passwd I
plan to use PAM + LDAP or a similar solution.

I hope you can give me a hand with this.

Regards,

Ioannis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFIPEb6Fq+8w76sCAARArB0AKCTYt7EWWnjnhvx86wJDHj/NuUTLgCgrex7
RoyVndANCtwStrM+7+WsX5E=
=vSb3
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
