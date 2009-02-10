Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1AJMwuj011095
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2009 14:22:58 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1AJJhCK004347
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2009 19:19:43 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1AJMs0g022907
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2009 14:22:54 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1AJMsNW003851
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2009 14:22:55 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1AJMrlM028341
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2009 14:22:54 -0500
Message-ID: <4991D40C.1000205@redhat.com>
Date: Tue, 10 Feb 2009 14:22:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: Re: bind-mounted homedirs]
Content-Type: multipart/mixed;
 boundary="------------020106090701040508070205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020106090701040508070205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Still trying to think of a good solution for alternate file layouts.

This email below points out another problem in addition to /home mapping.

Maybe we could add a
semanage  fcontext --duplicate /home /exports/home
semanage fcontext --duplicate /var/log /cluster/log

Which would cause semanage to duplicate all file context mappings that
begin with the prefix /home to /exports/home.

What do you think?



- -------- Original Message --------
Subject: Re: bind-mounted homedirs
Date: Wed, 4 Feb 2009 09:26:06 +0000
From: pgega@secpay.com
Organization: PayPoint.net
To: Daniel J Walsh <dwalsh@redhat.com>, Paul Howarth <paul@city-fan.org>
CC: fedora-selinux-list@redhat.com
References: <49787F7C.2090907@city-fan.org>
<20090126203147.75c37c15@metropolis.intra.city-fan.org>
<497F13A8.9050105@redhat.com>

Hello,

> File, but I think the solution is to be able to add alternative roots in
>  the libsemanage.conf file and have it do the labeling for you.

I do have a very similar problem - I run a bit modified version of base
filesystem (for cluster purpose) and some directories are moved to /node
or /cluster and symlinked to original location.
For example there is /var/log which is a symlink to /node/var/log. And
during relabels/restorecon log files in /node/var/log are not labeled
properly (labeled as default_t).

It's not really possible to give alternative root paths in
semanage.conf, is it ?
If so ,that would solve my problem.

Kind Regards,
Pawel Gega

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmR1AwACgkQrlYvE4MpobMiwwCgutTQapXKuhwdIjDhGU3wPoBb
EV8AoOtxtO8PN22CTw2jRnndTaS+Zl0W
=Bfta
-----END PGP SIGNATURE-----

--------------020106090701040508070205
Content-Type: text/plain;
 name="Attached Message Part"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message Part"

--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
https://www.redhat.com/mailman/listinfo/fedora-selinux-list

--------------020106090701040508070205
Content-Type: application/octet-stream;
 name="Attached Message Part.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Attached Message Part.sig"

iEYEABECAAYFAkmR1AwACgkQrlYvE4MpobP5GgCdFX+qRizwyBDVf4FezElalJZbE0sAn0FF
TNWfmLxqGwOS9Ha3OJFuOrVR
--------------020106090701040508070205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
