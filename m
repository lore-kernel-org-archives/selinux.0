Message-ID: <5027952B.8060405@redhat.com>
Date: Sun, 12 Aug 2012 07:36:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <pmoore@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: I think we need to quiet SELinux in log files on setattr.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
