From: gdsmarshall@hushmail.com
Message-Id: <200207041319.g64DJ8448572@mailserver2.hushmail.com>
To: SELinux@tycho.nsa.gov
Subject: This does not look correct....
Date: Thu,  4 Jul 2002 06:19:08 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

I know I have not been trying to configure SELinux for very long, but this does not look correct to me.  Should ssh have a getty_t definision?  I know it needs one to prevent this error message, but is it correct for ssh to have a getty_t definision?

Jul  4 08:05:33 gatekeeper kernel: avc:  denied  { use } for  pid=339 exe=/usr/b
in/ssh path=/dev/tty3 dev=03:01 ino=71770 scontext=root:sysadm_r:sysadm_ssh_t tc
ontext=system_u:system_r:getty_t tclass=fd

I am running debian (woody), with kernel from NSA, and packages from Russell's site.

Many thanks in advance,

Spencer
-----BEGIN PGP SIGNATURE-----
Version: Hush 2.1
Note: This signature can be verified at https://www.hushtools.com

wmAEARECACAFAj0kVwUZHGdkc21hcnNoYWxsQGh1c2htYWlsLmNvbQAKCRC4zrK67KP4
z0DlAJ9ACPH8CG6Pw2HI4Ld6nxULeC8sogCfeYsD+vujZTeTgiBQ5rPgneoXpOs=
=KdUn
-----END PGP SIGNATURE-----


Communicate in total privacy.
Get your free encrypted email at https://www.hushmail.com/?l=2

Looking for a good deal on a domain name? http://www.hush.com/partners/offers.cgi?id=domainpeople


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
