Message-ID: <4152EA0A.9060606@diyab.net>
Date: Thu, 23 Sep 2004 11:21:46 -0400
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: patch: correct default policy type
Content-Type: multipart/mixed;
 boundary="------------000409060204030605090407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000409060204030605090407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've noticed that the release on the NSA site installs the policy into
/etc/selinux/strict but libselinux looks for a targeted policy by
default.  Attached patch changes the default in libselinux to be strict.
~ Please apply.

Timothy,


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBUuoKPT0XLCkCs2ARAmXpAJ4hg5OHoSgSgLl10UjC2kG1SOl9ewCeLgT2
66+gfzjqam3uqTjx81YyPWo=
=yS7Z
-----END PGP SIGNATURE-----

--------------000409060204030605090407
Content-Type: text/plain;
 name="libselinux-policytype.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-policytype.patch"

--- tmp/selinux_config.c	2004-08-06 09:00:34.000000000 -0400
+++ src/selinux_config.c	2004-09-23 01:22:10.289004968 -0400
@@ -7,7 +7,7 @@
 
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
-#define SELINUXDEFAULT "targeted"
+#define SELINUXDEFAULT "strict"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
 

--------------000409060204030605090407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
