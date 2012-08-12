To: sds@tycho.nsa.gov, pmoore@redhat.com, selinux@tycho.nsa.gov,
        dwalsh@redhat.com
From: Eric Paris <eparis@redhat.com>
Date: Sun, 12 Aug 2012 09:41:54 -0400 (EDT)
MIME-Version: 1.0
Subject: =?utf-8?B?UkU6IEkgdGhpbmsgd2UgbmVlZCB0byBxdWlldCBTRUxpbnV4IGluIGxvZyBmaWxlcyBvbiBzZXRh?=
 =?utf-8?B?dHRyLg==?=
Message-ID: <1848882875.7112155.1344778914020.JavaMail.root@zmail12.collab.prod.int.phx2.redhat.com>
Content-Type: multipart/mixed;boundary="__1344778929229TOUCHDOWN_BOUNDARY__"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--__1344778929229TOUCHDOWN_BOUNDARY__
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I started a patch for this. I'll work on it next week.  

-Eric


-----Original Message-----
From: Daniel J Walsh [dwalsh@redhat.com]
Received: Sunday, 12 Aug 2012, 7:36am
To: Eric Paris [eparis@redhat.com]; Stephen Smalley [sds@tycho.nsa.gov]; Paul Moore [pmoore@redhat.com]; SELinux [selinux@tycho.nsa.gov]
Subject: I think we need to quiet SELinux in log files on setattr.


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In openshift I am seeing lots of AVC's of SELinux errors that would definitely
 be blocked by DAC.  The problem is they end up as AVC's in the log files and
I really do not want to dontaudit them.  Can't we move the SELinux check on
setattr to after the DAC Check.  I believe the SELinux check should always
happen after the DAC Check, so we can write simpler SELinux policy.

Last nights logs for openshift, have lots of AVC's like the following. caused
by people installing apps think they attempt to change the attributes of
files/directories they do not own.

allow libra_t httpd_modules_t:dir setattr;
allow libra_t httpd_modules_t:file setattr;
allow libra_t lib_t:dir setattr;
allow libra_t root_t:dir setattr;
allow libra_t ssh_home_t:dir { read setattr };
allow libra_t usr_t:dir setattr;
allow libra_t usr_t:file setattr;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAnlSsACgkQrlYvE4MpobPwzwCfYtAhmbFp6gmpJ6Hg6UAOvQCO
V7gAn0uiplLNBwQu1rW8VUmGlxVUclce
=OUmh
-----END PGP SIGNATURE-----

--__1344778929229TOUCHDOWN_BOUNDARY__--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
