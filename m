From: gdsmarshall@hushmail.com
Message-Id: <200206271655.g5RGtjM07176@mailserver4.hushmail.com>
To: Selinux@tycho.nsa.gov
Subject: errors installing.....
Date: Thu, 27 Jun 2002 09:55:45 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

After taking Russell's advice, I have upgraded debian, and installed the extra selinux packages which come with it.  I have also installed the packages he had on his website, and followed the instructions at http://www.coker.com.au/selinux/install.html following step 4, I get the following error.

/etc/selinux# make -C /etc/selinux relabel
make: Entering directory `/etc/selinux'
/usr/bin/load_policy /ss_policy
security_load_policy: Invalid argument
make: *** [tmp/load] Error 2
make: Leaving directory `/etc/selinux'

In /var/log/messages, I get
Jun 27 17:51:52 gatekeeper kernel: ss:  loading policy configuration from /ss_policy
Jun 27 17:51:52 gatekeeper kernel: security:  policydb magic number 8 does not match expected magic number -109248628

does anyone know what the problem is please? and how do I fix it.

Many thanks,

Spencer
-----BEGIN PGP SIGNATURE-----
Version: Hush 2.1
Note: This signature can be verified at https://www.hushtools.com

wmAEARECACAFAj0bT5kZHGdkc21hcnNoYWxsQGh1c2htYWlsLmNvbQAKCRC4zrK67KP4
zyzdAKCnrwu9knlaLrlnGccIvunQjCgwDQCfdPcXZfxK9f06aLnqkb7HFx7cr04=
=H8B8
-----END PGP SIGNATURE-----


Communicate in total privacy.
Get your free encrypted email at https://www.hushmail.com/?l=2

Looking for a good deal on a domain name? http://www.hush.com/partners/offers.cgi?id=domainpeople


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
