Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HPfIi014066
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:25:41 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HO3PS007823
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:24:03 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <rcoker@redhat.com>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B8826D.30105@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
Content-Type: text/plain
Message-Id: <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 12:20:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 11:50, Daniel J Walsh wrote:
> One problem I still have with RBAC though is the labeling of files based 
> on the role of the user.  IE (staff_home_t versus
> user_home_t).  I believe this causes many problems, without much benefit.

The benefit is providing separation among the roles.  If user_t can
write to staff_home_t, then the only thing preventing a user_t process
from injecting arbitrary commands into a staff user's .bashrc file or
otherwise corrupting a staff user's data or reading arbitrary files
created by the staff user is DAC.    

> 1.  Causes problems with sharing files between users,   IE a staff user 
> coping a file to tmp and then the user
> can't read it, because it has the wrong type. 

If you want to share files, you just need to define a file type that is
accessible to both domains and label the shared directory with it.  Then
users from both roles can create and modify content under that shared
directory without losing protection on their own data.  Note that
unifying the home directory type doesn't solve #1 for you, because cp
/home/user/foo /tmp/foo will create /tmp/foo in the default type, e.g.
staff_tmp_t; cp only preserves contexts when explicitly told to do so. 
And unifying the temporary types would again open a vulnerability
between the roles, classical insecure tmp file issues.

> 2.  Requirement that selinux-policy-strict-sources be installed and a 
> rebuild of policy in order to change the roles of a user.

You mean to update the file_contexts?  One could certainly build a tool
to apply selective modifications to an existing file_contexts
configuration without requiring the full sources.

> 3.  But the number one problem I have is with relabeling files.  If I 
> were to implement roles management in
> system-config-securitylevel/adduser, I would need to trigger a relabel 
> any time a role of a user was changed.  This
> relabel would have to be inteligent enough to figure out not only the 
> home directories, but also the files in /tmp and potentially
> files in html files scattered over the system.  I find this an 
> unworkable situation.

Not clear that such relabeling should be automatic anyway.  Some
review/sanitization may be necessary.

> With SELinux Policy Modules, can I build an system-config-user/adduser 
> that would modify a file under /etc/selinux/strict/roles/
> (the users file) and then reload just that policy?

You can actually do that today without policy modules.  Recall that I
created a genpolusers utility a while back that takes an existing binary
policy and a new users text configuration and generates a new binary
policy that is identical except it has the new user declarations.  So
you only need a copy of the users source file on the machine, and you
can then modify it, use genpolusers to rebuild the binary policy against
it, and then load the new binary policy.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
