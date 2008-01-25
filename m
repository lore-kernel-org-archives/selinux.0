Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0PGTou5025735
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 11:29:50 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0PGTnbY005933
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 16:29:50 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0PGTnIK025605
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 11:29:49 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0PGTmle013498
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 11:29:48 -0500
Received: from localhost.localdomain (dhcp-10-12-34-108.boston.devel.redhat.com [10.12.34.108])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m0PGTlN3016223
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 11:29:47 -0500
Message-ID: <479A0E7B.7000109@redhat.com>
Date: Fri, 25 Jan 2008 11:29:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Is it time we removed the version number from policy.22/policy21?
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just got burned by the policy version bumping.  I blogged about how
cool audit2why is and then policycoreutils/libselinux had a bug.

They were hard coded to use the policy version of the kernel that was
running to look for policy.

They were both doing the equivalent of
/etc/selinux/targeted/policy/policy.`cat /selinux/policyvers`

But I guess we just bumped the version of policy to 22 in libsepol.  (My
mistake for not noticing).  But the kernel still only supports 21.

So a freshly installed machine has 22 on it and audit2why blows up with
a missing policy because it is looking for 21.  On my test machine I
have a policy.21 and a policy.22 so I never noticed.  (this in my
opinion is a bug in semanage.  It should have cleaned up the old version.

I think this just points out the problem of adding the version number to
the policy file on disk.  This really serves no purpose other than to
create bugs every time we bump the version.

I would like to suggest that we switch to just building
/etc/selinux/TYPE/policy/policy
and have a symbolic link for backwards compatibility
/etc/selinux/TYPE/policy/policy.22 -> policy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeaDnoACgkQrlYvE4MpobPKgACfXe34vNKs7cObfgncFZUoJTte
1DMAoN58Hkba5GzZzGhO0vddOiMQu+g5
=XU4s
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
