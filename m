Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6981Q9D001325
 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2014 04:01:26 -0400
Message-ID: <617426951.7751.1404892888617.JavaMail.root@bureau-frontal2.univ-amu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: selinux@tycho.nsa.gov
Subject: SELinux with overlayfs between squashfs and jffs2
From: Antoine MOISE <antoine.moise@etu.univ-amu.fr>
Date: Wed, 9 Jul 2014 10:01:28 +0200 (CEST)
Reply-To: Antoine MOISE <antoine.moise@etu.univ-amu.fr>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,
I try to use SELinux on embedded system, which contains an overlay used for saving changes of the rootfs.
The rootfs is stored on a squashfs read-only, and the rootfs' changes are stored in a jffs2 partition.
In this situation changing file's context is impossible because SELinux tried to modify the squashfs inode, not creating or modifying inode in the overlay to store the new SELinux context.
Is it a security purpose of not supporting such mecanism?


Best Regards
Antoine MOÏSE

Aix-Marseille University
