Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u96BA01t027130
 for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2016 07:10:03 -0400
Received: from workstation.fluency.net.uk ([185.34.9.224]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0MIuft-1buaT73SJN-002XjT for
 <selinux@tycho.nsa.gov>; Thu, 06 Oct 2016 13:09:56 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
Date: Thu,  6 Oct 2016 12:09:40 +0100
Message-Id: <cover.1475590141.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

New version of the previous genhomedircon-rbacsep patch with some changes.  A
bit of a delay as I had to get in a libsepol/cil fix which was blocking this.

1. Remove semanage.conf option
2. Drop unrelated change
3. Adds a new homedir_role member to the genhomedircon_user struct.
4. Sets homedir_role if the SELinux users prefix is a valid role for that user.
5. Replaces all roles with homedir_role in context specifications if homedir_role is set.

One issue that came up when writing these patches is that genhomedircon
squashes logging [1] for some reason, which can result in no warning / info
messages and an empty file_contexts.homedirs file if policy has been
incorrectly configured.  Can we get rid of this behavior or add a flag to
conditionally enable logging?

Dominick Grift helpfully created some test images that demo DSSP policy working
with both RBACSEP and non-RBACEP:
https://tfirg.asu.su/2016/10/03/garys-patches/

There are still some rough edges though, for example in policy you can't write a
statement like: (userprefix id role) and put it in an abstract namespace,
since it is interpreted as a literal:

(block usersubj
    (blockabstract usersubj)
    (user id)
    (role role)
    (userrole id role)
    (userprefix id role))

(block wheel
    (blockinherit usersubj))

Which leaves us with a (userid, prefix) tuple of (wheel.id, role) [wheel.id
might even just be id here, haven't checked if users are expanded or also taken
as literals].

Though this is something I can look at later if all is well here.

[1] https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L568-L572

Gary Tierney (1):
  genhomedircon: use userprefix as the role for homedir content

 libsemanage/src/genhomedircon.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

-- 
2.4.11
