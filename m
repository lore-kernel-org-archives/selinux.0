Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m381VqIF017066
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 21:31:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m381VoBp011345
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 01:31:50 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m381VnDI008109
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 21:31:49 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m381VmRB021752
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 21:31:48 -0400
Received: from localhost.localdomain (vpn-14-147.rdu.redhat.com [10.11.14.147])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m381Vlnf026315
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 21:31:48 -0400
Message-ID: <47FACB0F.5050208@redhat.com>
Date: Mon, 07 Apr 2008 21:31:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: upstart/SELinux problem loading the wrong policy with kernel version
 change
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If you have a kernel that supports policy.21 and a tool chain that
supports policy.22 newer versions of policy and semanage changes will
update policy.22.  However if there is a policy.21 around upstart will
load this on a reboot.  (I guess init would have done the same.)

If the policy.21 does not exist libselinux will grab the highest policy
version and try to load it.

This is causing unlabeled_t files to be showing up.  Basically if I
install a new policy with a new type, and then assign the context to a
file, the next reboot will cause the file to be labeled unlabeled_t.

I suggest that we either remove policy versioning all together, or
change libselinux to default to loading the highest policy version.
Either way the current loading of policy is broken.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkf6ywoACgkQrlYvE4MpobPKuwCePdHBoGYI13pVvugI/B9veFGo
88UAoKjr7Dp5gIaVW91rfbxgJQhngLCZ
=sAa6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
