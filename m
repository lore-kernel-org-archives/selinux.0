Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HlbIi014297
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:47:37 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HlcEj002254
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:47:39 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 04:47:24 +1100
Message-Id: <1102614445.4509.25.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 12:20 -0500, Stephen Smalley wrote:
> On Thu, 2004-12-09 at 11:50, Daniel J Walsh wrote:
> > One problem I still have with RBAC though is the labeling of files based 
> > on the role of the user.  IE (staff_home_t versus
> > user_home_t).  I believe this causes many problems, without much benefit.
> 
> The benefit is providing separation among the roles.  If user_t can
> write to staff_home_t, then the only thing preventing a user_t process
> from injecting arbitrary commands into a staff user's .bashrc file or
> otherwise corrupting a staff user's data or reading arbitrary files
> created by the staff user is DAC.    

Yes.  This is how two SE Linux "play machines" have been demonstrated to
be inadequately secured.  One of the two machines was demonstrated to be
insecure by stealth and is believed to be the machine that caused
spender to think that my machine had been cracked (can't be sure as
spender doesn't answer questions).

> > 1.  Causes problems with sharing files between users,   IE a staff user 
> > coping a file to tmp and then the user
> > can't read it, because it has the wrong type. 
> 
> If you want to share files, you just need to define a file type that is
> accessible to both domains and label the shared directory with it.  Then

Or just have them in the same role.

> users from both roles can create and modify content under that shared
> directory without losing protection on their own data.  Note that
> unifying the home directory type doesn't solve #1 for you, because cp
> /home/user/foo /tmp/foo will create /tmp/foo in the default type, e.g.
> staff_tmp_t; cp only preserves contexts when explicitly told to do so. 
> And unifying the temporary types would again open a vulnerability
> between the roles, classical insecure tmp file issues.

However there still are issues because sysadm_t can read symlinks of
type user_tmp_t, so a user can attempt a symlink race condition attack
on the administrator.

Having a tunable to allow user roles to read each other's temporary
files would be much better than any other "solution" to this problem.

> > 2.  Requirement that selinux-policy-strict-sources be installed and a 
> > rebuild of policy in order to change the roles of a user.
> 
> You mean to update the file_contexts?  One could certainly build a tool
> to apply selective modifications to an existing file_contexts
> configuration without requiring the full sources.

I think he's referring to the users file which is compiled into the
policy.  But you've addressed that later in your message.


I think that the real issue here is making a SE Linux system work for
someone who doesn't want SE Linux.  We can make the targeted policy work
for such people, but trying to make the strict policy work for them is
not going to do any good, all it will result in is a less effective
strict policy and such people still won't use it anyway!

Last I heard Lindows had everything running as root.  Some people like
having the minimum amount of security in return for a small amount of
usability.  There's nothing that we can do in strict policy to make such
people happy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
