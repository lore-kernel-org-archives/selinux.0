Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3TFtejK009982
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 11:55:40 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3TFtaXC022356
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 15:55:40 GMT
Subject: refpolicy roles / RBAC separation RFC
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 29 Apr 2008 11:54:10 -0400
Message-Id: <1209484450.6110.47.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For those interested all of the user roles have been separated out into
individual modules in a new roles refpolicy layer, in refpolicy trunk.
This should enable interested users to add and remove roles more easily.
Each of the user roles has a module named after it (e.g., sysadm module
for sysadm_r), except user_r, which has a name unprivuser, since its not
possible to use "user" as a module name since it is a policy keyword.

Next we will be doing an experiment attempting to use the SELinux RBAC
functionality to separate users instead of SELinux TE.  What this means
is that the role field will start being used more substantially than it
currently is.  In a nutshell, this means that all user objects will have
the user's role rather than object_r.  Then the separate types will be
collapsed into one type where possible.  This will result in per-role
types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
(mozilla_t).

So for example, all of the home directory types will be collapsed into
home_t and home_dir_t.  This results in /root having the context
root:sysadm_r:home_dir_t.

My current idea for RBAC rules is to group object classes in RBAC
constraints similar to the current MLS constraints (e.g. file classes
together, network classes together).  The basic RBAC rule will be:

constrain { dir file ... } { getattr read write .... }
	r1 == r2
	or r1 == system_r
	or r2 == object_r
	or r1 == rbac_subj_role_file_exempt
	or r2 == rbac_obj_role_file_exempt
	or t1 == rbac_subj_type_file_exempt
	or t2 == rbac_obj_type_file_exempt;

Is this too coarse?  Do we want to break it down into read and write
rather than just exempt?

Unfortunately this necessitates some kernel and userspace changes:

Roles aren't respected on objects in the kernel.  So if you create a
file in a directory that has the role staff_r, the file will have an
object_r role instead of staff_r.

Login programs and newrole will have to be changed to set the role on
the terminal.

The above example rule utilizes a role attribute, which doesn't exist.
In the absence of role attributes, role dominance can be used, but its
unclear if the dominance code works, since no one uses it.

Genhomedircon may need to be updated.

Tools such as audit2allow will need more audit2why-like support and
policy info to fix RBAC denials (a general constraints usability issue).

Comments?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
