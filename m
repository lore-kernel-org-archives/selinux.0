Message-Id: <200507071645.j67GjKQ4010377@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Cc: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: RE: Useradd patchset - seeking comments..
Date: Thu, 7 Jul 2005 12:45:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1120686244.24068.32.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Wednesday, July 06, 2005 5:44 PM
> To: Daniel J Walsh
> Cc: sds@tycho.nsa.gov; kmacmillan@tresys.com; selinux@tycho.nsa.gov
> Subject: Re: Useradd patchset - seeking comments..
> 
> Here's what the patches do in summary:
> 

<snip>

> libsepol-6-bools.diff
> 
> Mark things extern:
> libsepol-10-extern.diff
> 

I'll try to look at these - are they against the latest CVS with the module
infrastructure? Quick comment is that I don't think that the extern patch is
useful and worth the trouble. Things in headers are, by definition, exported.
Extern has no effect and does not add clarity IMHO.
http://www.eskimo.com/~scs/C-faq/q1.11.html

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> Library routines for manipulating files,
> that everything else uses:
> libselinux-3-records_file.diff
> 
> Support for manipulating file contexts, ports,
> sel_users, and map entries (in the
> user->sel_user map file). Ports are
> not implemented yet, just a record.
> 
> libselinux-4-context_record.diff
> libselinux-5-sel_users.diff
> libselinux-5-fscon.diff
> libselinux-5-ports.diff
> libselinux-6-map.diff
> 
> Higher-level interface that works with
> the patches above to provide functionality
> to add/delete/remap users:
> 
> libselinux-7-users.diff
> 
> Remove backup files from tarball:
> policycoreutils-cleanup.diff
> 
> Utility for getting valid roles
> from policydb (not sure if it's
> needed):
> policycoreutils-getroles.diff
> 
> Load policy, rewritten to use
> libselinux helper routines:
> policycoreutils-load_policy.diff
> 
> Changes to various utilities to
> deal with the new way to map users
> to sel users:
> policycoreutils-map2.diff
> 
> Changes to matchpathcon and genhomedircon
> to handle per user file contexts files
> (due to lack of a better solution). This
> has been hacked a bit to not generate
> a file if the sel_user's primary role
> matches the default user's primary role.
> policycoreutils-genhomedircon-move_user_contexts.diff
> libselinux-8-move_user_contexts.diff
> 
> Shadow-utils integration:
> shadow-selinux.diff



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
