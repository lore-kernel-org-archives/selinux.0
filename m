Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2GKX150016256
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 16:33:01 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2GKX0Sj012044
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 20:33:00 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2GKWxmW029162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 16:32:59 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p2GKWwk6027075
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 16:32:59 -0400
Message-ID: <4D811E7A.6060902@redhat.com>
Date: Wed, 16 Mar 2011 16:32:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: I have been asked for a use case that says I want to allow X domain
 to only be able to use eth1.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

For example if you wanted to allow httpd_t to only use eth1, you have a
problem.  You need to label all of the devices on your system as
something other then netif_t. And then add a rule like

semanage interface -a -t public_t eth0
semanage interface -a -t private_t eth1

allow { domain -httpd_t } public_t:netif *;
allow httpd_t private_t:netif *;

If you wanted all other processes to also use eth0, you would add
allow domain private_t:netif *;

Now ignoring the fact that I used domain instead of some attribute to
indicate all domains that use the network.

Even if I did the code above, if a new interface showed up later httpd_t
would be allowed to use it since it can use netif_t, which is the
default for all interfaces.

The problem is I can not change the default.

semanage interface -a -t public_t *

For example would not work, I don't think.

I guess I can do something hackly like I am with unlabelednet.pp and
just put all of the netif rules into a module that I can disable, but I
wanted to know if anyone has a better way.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2BHnoACgkQrlYvE4MpobP3TwCdHqFajpxDmoGlf7IsjvZdESsj
aywAoKLuY8SfVBCM7g2SV5gS1Y97rtUy
=5R0X
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
