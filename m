Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j19DD4L9004493
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 08:13:04 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107915334.6602.1.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 09 Feb 2005 08:06:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-08 at 21:15, Ivan Gyurdiev wrote:
> Which of those rules would be required for stdin/stdout?

Depends on what your stdin/stdout references, naturally.

> allow $1_$2_t tty_device_t:chr_file rw_file_perms;

This rule shouldn't be necessary.  A user domain or associated program
domain should only be acting upon a tty that has already been relabeled
to one of the $1_tty_device_t types.  Only processes that need to act
upon ttys that are not necessarily associated with any session should
have permissions to tty_device_t itself, e.g. system initialization
processes, login, etc.

> allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;

This rule allows access to a tty that has already been relabeled for
your domain.  I think it should only be needed for console sessions,
although we typically haven't restricted it in the past for user domains
and their associated program domains.

> allow $1_$2_t devtty_t:chr_file rw_file_perms;

This rule allows access to the /dev/tty device that is always mapped to
the controlling terminal of the process if any.  Should be allowed.

> allow $1_$2_t devpts_t:dir r_dir_perms;
> allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;

This rule allows access to a pty that has already been relabeled for
your domain or that was initially created by your domain.  Necessary for
X terminals, ssh sessions, etc.  Should be allowed.  Note that you also
need permissions to ptmx_t if your domain needs to actually create
ptys.  This is typically covered by the can_create_pty macro.

> What about proc permissions required?

Sorry, what do you mean?  Do you mean being able to access
/proc/self/fd/n?  If so, then you need to be able to search proc_t:dir,
proc_t:lnk_file, self:dir, and read self:lnk_file.

> Can some of those rules be put in a macro of some sort.
> I see tty rules all over the selinux policy, and perhaps
> they could be made more consistent with a macro.

Possibly.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
