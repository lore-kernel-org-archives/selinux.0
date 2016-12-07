Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7CGQM6031145
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 07:16:28 -0500
Received: from workstation.localdomain ([185.34.9.224]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MDm4o-1cSHjY2VeY-00H5i6 for <selinux@tycho.nsa.gov>; Wed, 07 Dec 2016
 13:16:18 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] cil: remove avrules that have no associated types
Date: Wed,  7 Dec 2016 12:15:58 +0000
Message-Id: <1481112959-26208-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a minor improvement to the CIL -> policydb code which will remove
unused AV rules.  In the past you could create 2 type attributes like so:

(typeattribute x)
(typeattribute y)
(type z)
(typeattributeset y z)

And an avrule (which would be kept in the resulting policydb):

(allow x y (process (transition)))

Now the avrule would be removed, since the source of the rule has
no associated types.  Similarly, the rule would have been removed if the
target had no associated types when the source does.  The exception to this
rule is neverallows, since AOSP checks for them in their resulting policy.conf.

There's a small difference in fedora-selinux:

[root@localhost ~]# sesearch -ACS original.30  | head -1
Found 101204 semantic av rules:
[root@localhost ~]# sesearch -ACS modified.30  | head -1
Found 101030 semantic av rules:

And a more noticeable difference with Dominick Grift's dssp1:

[root@localhost ~]# sesearch -ACS dssp_original.30 | head -1
Found 11270 semantic av rules:
[root@localhost ~]# sesearch -ACS dssp_modified.30 | head -1
Found 2574 semantic av rules:

Gary Tierney (1):
  libsepol/cil: remove avrules with no affected types

 libsepol/cil/src/cil_binary.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.4.11
