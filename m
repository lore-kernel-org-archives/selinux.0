Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FG3GgA012322
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 12:03:16 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FFwuBp009445
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:58:56 GMT
Subject: Re: [RFC] selinux management API
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42D7CC53.9030803@tresys.com>
References: <42D7CC53.9030803@tresys.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 11:56:30 -0400
Message-Id: <1121442990.4488.87.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To expand on that, the plan is to make libsemanage (new name for 
libsemod) become the central access point for anything that manipulates
the policy. It would implement things like policy access, configuration
files, and transaction guarantees.

Libsepol, which currently handles access to the binary policy file,
would become a static backend library for libsemanage and checkpolicy - 
it would supply common code to work with the policy image.

Libselinux would only contain code necessary for access decisions,
and communicating with the kernel policy. 

===========================

During a teleconference meeting with Tresys, and Stephen, we 
discussed Karl's proposal for mapping users to selinux users 
many-to-one (see previous discussions), and several key points were
established:

1) Granularity at the Unix user level (and not just the selinux user
level) is useful for implementing the categories for the MCS policy
that Redhat is developing. As a result, we plan to move MLS categories
from the selinux user config file into the map file (or alternative
backend), where they can be associated with users, and not just selinux
users. The set of accessible categories will be configured by login
programs. Sensitivities would remain associated with selinux users.

2) It is desirable for the selinux libraries to have no knowledge
of Unix users, and to only work with SELinux users. So, instead
of changing get_ordered_context_list to accomplish the discussed
mapping, all callers will be changed to pass in the sel user.
API compatibility is not broken, until the fallback to the user_u
default user is removed from get_ordered_context_list.

3) It is important to be able to select from multiple backends
for storing the user-to-sel_user mappings, just like you can
select where to store the users. The current plan is to add
a "selusers" field in nsswitch.conf, and write the corresponding
support in libnss_files.so. In the course of doing that, we cannot
add library dependencies to libnss_files.so, so any parser and related
code has to be self-contained.

4) Management of file_contexts is still a point of contention, and I 
am not clear exactly how the current API as proposed by Tresys will
solve this problem.  

5) I would also like to see single record query functions implemented 
by the libsemanage APIs (as opposed to iterating lists), as well as 
a way to modify records. I think the add methods should take a
structure.

6) It is also planned to change the configuration files from being
the authoritative data source, to something that's merged into
the binary policy on every transaction (not every function call).
What this means is, when a user is added, the modifications
will be written to the binary file, and load_policy and init
will no longer read the config file on startup, and risk failure.
The purpose of config files is as the source to be compiled 
into the binary policy, not loaded on every boot. On upgrades,
a utility (genpolicy) would read in all relevant files and
modules (Tresys' loadable modules work), and construct the
new image. 

I hope this summarizes what we've been discussing off-list 
to some degree. Please make corrections as necessary.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
