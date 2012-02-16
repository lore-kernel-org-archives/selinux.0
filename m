Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1GElGSN007687
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2012 09:47:16 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1GElEuI017875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2012 09:47:14 -0500
Received: from dhcp-189-250.bos.redhat.com (dhcp-10-16-62-208.boston.devel.redhat.com [10.16.62.208])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q1GElDdR013057
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2012 09:47:13 -0500
Message-ID: <4F3D16EF.6080904@redhat.com>
Date: Thu, 16 Feb 2012 09:47:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Another change we would like to make to libselinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently we have lots of apps trying to figure out which policy is
installed on the system,  We have a function
selinux_binary_policy_path which returns a path like
'/etc/selinux/targeted/policy'

Then these apps do stuff like:

VER=`cat /sys/fs/selinux/policyver`
while [ -e '/etc/selinux/targetd/policy. + $VER' ]; do
      VER=$VER-1
done

While we have had /sys/fs/selinux/policy for a while now.

I wanted to add an interface to return this path, but I was trying to
figure out a name selinux_loaded_policy_path for example, but as Eric
pointed out to me, selinux_binary_policy_path is what most users would
expect to return this.  If you look at the man page it even suggest this.

man selinux_binary_policy_path
...
       selinux_binary_policy_path() - binary policy file loaded into
kernel


Currently the users of this function are the libselinux package,
setools and policycorutils (sepolgen-ifgen).


I am torn between adding stealing this function to return the
/sys/fs/selinux/policy and then adding selinux_installed_policy_path
for the original function, then updating the effected packages.

The problem with this is we would have different behaviour between
older versions of the library. The other options would be to come up
with a better name for the new function and fix the man pages.

Suggestions welcomed.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk89Fu8ACgkQrlYvE4MpobNimgCeIIpi+6Yee+GfyUlRV+n7jvaE
39MAn064N3sRCAdpyseBKFrGR3+ojrEI
=+Byb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
