Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13664
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 11:51:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA13585
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 15:50:51 GMT
Received: from mail.ispko.com ([210.16.10.89])
	by jazzswing.ncsc.mil  with ESMTP id PAA13581
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 15:50:50 GMT
Received: from [210.16.6.253] ([210.16.6.253])
	by mail.ispko.com (8.12.3/8.12.3) with ESMTP id g6GFvOCN020718
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 23:57:27 +0800
Date: Tue, 16 Jul 2002 23:51:08 +0800 (PHT)
From: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
To: selinux@tycho.nsa.gov
Subject: cant gain sysadm_r via ssh
Message-ID: <Pine.LNX.4.44.0207162339590.448-100000@coffeesaur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I cant transition from an unpriviledged account to sysadm_r.
There is no way I can gain sysadm_r via ssh at all. If I login as root,
ssh denies access to sysadm's .ssh directory. It was disallowed in the
policy config. If I log in as an ordinary user i can su to root but
newrole fails with "cannot find your entry in the passwd file". When check
my sid, it was unchanged when I su to root. When I checked the newrole
source code I find out that user_u cant become sysadm_r at all. Newrole
uses the user name int the context string. Should I add my user name to
the policy? Like "user rogelio roles { sysadm_r user_r }" in the users
file? I tried that and it worked.

Also what should the context be for /dev/tts devices? I am using
tty_device_t and I get a lot of denial messages when I do  "run_init
pon provider".



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9NED06r8UsQIvzXwRAtzOAJ9Pz/XnWhib6RDzbeVFItgsJatj2ACgkYF4
7DYk4NCJgjCLI0kVM4PXUGU=
=47Ma
-----END PGP SIGNATURE-----



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
