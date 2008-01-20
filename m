Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0K52Alq004510
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2008 00:02:10 -0500
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0K529ER010320
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2008 05:02:09 GMT
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com,
        Paul Moore <paul.moore@hp.com>
Subject: Re: 2.6.24-rc8-mm1 and SELinux MLS - not playing nice....
In-Reply-To: Your message of "Fri, 18 Jan 2008 20:17:00 +1100."
             <Xine.LNX.4.64.0801182015180.21631@us.intercode.com.au>
From: Valdis.Kletnieks@vt.edu
References: <15439.1200642661@turing-police.cc.vt.edu>
            <Xine.LNX.4.64.0801182015180.21631@us.intercode.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1200805301_2788P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 20 Jan 2008 00:01:41 -0500
Message-ID: <3757.1200805301@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1200805301_2788P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jan 2008 20:17:00 +1100, James Morris said:

> This looks the same as what akpm hit.  Paul Moore has updated his labeled 
> networking patches (see Subject: [RFC PATCH v12 00/18] Labeled networking 
> changes for 2.6.25), and you could try dropping those into the broken out 
> -mm in place of the existing git patch, or just wait for a new -mm.

Confirming - I took V12 0-18, cat'ed it into one file, plopped that on top
of the broken-out/git-lblnet.patch and quilted up a test -rc8-mm1 and that
booted without complaints - dmesg says:

SELinux:8192 avtab hash slots allocated. Num of rules:164754
SELinux:8192 avtab hash slots allocated. Num of rules:164754
security:  5 users, 8 roles, 2043 types, 102 bools, 16 sens, 1024 cats
security:  67 classes, 164754 rules
security:  class peer not defined in policy
security:  permission recvfrom in class node not defined in policy
security:  permission sendto in class node not defined in policy
security:  permission ingress in class netif not defined in policy
security:  permission egress in class netif not defined in policy
security:  permission forward_in in class packet not defined in policy
security:  permission forward_out in class packet not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev configfs, type configfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: policy loaded with handle_unknown=deny
type=1403 audit(1200804071.837:2): policy loaded auid=4294967295 ses=4294967295



--==_Exmh_1200805301_2788P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHktW1cC3lWbTT17ARAggUAJ0eGGJ+gs1U+xAaLDMLtI7HnqzS6wCglcsi
FUiYdg41pIx1Od1p9mn6b1k=
=3l5V
-----END PGP SIGNATURE-----

--==_Exmh_1200805301_2788P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
