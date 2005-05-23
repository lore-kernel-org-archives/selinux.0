Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NKPAgA011503
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 16:25:10 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NKKFhG028041
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 20:20:15 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NKKjRH015373
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 16:20:45 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 23 May 2005 16:21:14 -0400
Message-Id: <1116879674.3267.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.23.17 2005-05-23
* Merged minor fixes by Petre Rodan to the daemontools, dante, gpg,
kerberos, and ucspi-tcp policies.
* Merged minor fixes by Russell Coker to the bluetooth, crond, initrc,
postfix, and udev  policies.  Modifies constraints so that newaliases
can be run.  Modifies types.fc so that objects in lost+found directories
will not be relabled.
* Modified fc rules for nvidia.
* Added Chad Sellers policy for polyinstantiation support, which creates
the polydir, polyparent, and polymember attributes.  Also added the
support_polyinstantiation tunable.
* Merged patch from Dan Walsh.  Includes mount_point attribute,
read_font macros and some other policy fixes from Ivan Gyurdiev.  Adds
privkmsg and secadmfile attributes and ddcprobe policy.  Removes the
use_syslogng boolean.  Many other minor fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
