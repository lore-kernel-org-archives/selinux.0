Subject: Re: Useradd patchset - seeking comments..
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: sds@tycho.nsa.gov, kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1120684883.24068.16.camel@celtics.boston.redhat.com>
References: <1120684883.24068.16.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 17:44:04 -0400
Message-Id: <1120686244.24068.32.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's what the patches do in summary:

Fixes headers and a memory leak:
libsepol-0-fix.diff 

Debugging enhancements, that I'm still
not happy with:
libselinux-1-debug.diff   
libsepol-1-debug.diff 

Make policydb an opaque data structure:

checkpolicy-policydb_opaque.diff     
policycoreutils-audit2why-policydb_opaque.diff 
libsepol-3-policydb_opaque.diff

Introduce functions to easily convert
between (data,len) pair and policydb.

libsepol-4-policydb_convert.diff 

User and boolean support, rewritten
to work with policydb, and with
user parsing removed (focusing on
adding sel user into policy):

libsepol-5-users.diff 
libsepol-6-bools.diff 

Mark things extern:
libsepol-10-extern.diff 


Library routines for manipulating files,
that everything else uses:
libselinux-3-records_file.diff  

Support for manipulating file contexts, ports,
sel_users, and map entries (in the 
user->sel_user map file). Ports are 
not implemented yet, just a record.

libselinux-4-context_record.diff
libselinux-5-sel_users.diff
libselinux-5-fscon.diff  
libselinux-5-ports.diff 
libselinux-6-map.diff

Higher-level interface that works with
the patches above to provide functionality
to add/delete/remap users:

libselinux-7-users.diff 

Remove backup files from tarball:
policycoreutils-cleanup.diff 

Utility for getting valid roles
from policydb (not sure if it's
needed):
policycoreutils-getroles.diff   
 
Load policy, rewritten to use
libselinux helper routines:
policycoreutils-load_policy.diff  

Changes to various utilities to
deal with the new way to map users
to sel users:
policycoreutils-map2.diff  

Changes to matchpathcon and genhomedircon
to handle per user file contexts files
(due to lack of a better solution). This
has been hacked a bit to not generate
a file if the sel_user's primary role
matches the default user's primary role.
policycoreutils-genhomedircon-move_user_contexts.diff 
libselinux-8-move_user_contexts.diff   

Shadow-utils integration:
shadow-selinux.diff  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
