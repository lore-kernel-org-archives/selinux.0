Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HSHIi014091
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:28:17 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HQbPU007981
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:26:40 GMT
Subject: Re: Single home directory type for all roles.
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux ML <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <rcoker@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B8826D.30105@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 12:28:18 -0500
Message-Id: <1102613299.10785.21.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 11:50 -0500, Daniel J Walsh wrote:

> 1.  Causes problems with sharing files between users,   IE a staff user 
> coping a file to tmp and then the user
> can't read it, because it has the wrong type. 

I feel that what we really need is an explicit file sharing area; for
example the gnome-user-share program uses /home/$USER/Public.  Having a
special label for public files like this will also allow us to write
policy for the gnome-user-share Apache daemon.  It does seem wrong to me
for any user_t to have access to my staff_t temporary files, and also
the other way around (remember that user_t/staff_t prevents /tmp race
conditions).  I run a strict server on which I have several users who I
don't *entirely* trust.  The extra assurance the user_t/staff_t
distinction brings is nice.

> 2.  Requirement that selinux-policy-strict-sources be installed and a 
> rebuild of policy in order to change the roles of a user.

I'm not sure I see what's so bad about this.  I would assume that most
people running strict will have to customize policy anyways.

> 3.  But the number one problem I have is with relabeling files.  If I 
> were to implement roles management in
> system-config-securitylevel/adduser, I would need to trigger a relabel 
> any time a role of a user was changed.  This
> relabel would have to be inteligent enough to figure out not only the 
> home directories, but also the files in /tmp and potentially
> files in html files scattered over the system.  I find this an 
> unworkable situation.

Hmm.  But the fact that in the default strict policy user_r and staff_r
are nearly equivalent in terms of functionality is really a special
case, no?  I imagine most people really using RBAC will be defining
specialized roles such as webmaster_r, nurse_r, developer_r, etc.  In
this situation it seems to me that it would be unusual for a person to
switch roles entirely; much more likely they would gain a role.  And if
they *did* switch roles, it seems likely that they would not have access
to their old files at all.  

> So yesterday I went though the policy and created a new tunable 
> single_user_file_type, that causes the policy to share a common
> filetypes between staff and users.  (Haven't completed this for http yet). 

I'm not saying it's not useful to have an option, but before
recommending this, I'd like to think a bit more about any other possible
solutions.  I don't have any good ideas about how to handle user_r ->
staff_r in general right now though.

> With SELinux Policy Modules, can I build an system-config-user/adduser 
> that would modify a file under /etc/selinux/strict/roles/
> (the users file) and then reload just that policy?

I haven't looked in detail at binary policy modules, but my guess is
that they can't *delete* a role, type, or permission.  So it seems
difficult to use a binary policy module to change a user's role, e.g.
from user_r to staff_r as you suggest.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
