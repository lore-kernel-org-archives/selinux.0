Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters
	for dbus.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <413F1DD8.2000201@redhat.com>
References: <413E1DE0.9050905@redhat.com>
	 <1094645825.20215.33.camel@moss-spartans.epoch.ncsc.mil>
	 <413F1DD8.2000201@redhat.com>
Content-Type: text/plain
Message-Id: <1094656361.20215.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Sep 2004 11:12:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-08 at 10:57, Daniel J Walsh wrote:
> It is the feeling here to keep the init program as simple as possible 
> for maintainability, bugs in it are very difficult to debug, so the
> restorecon will remain in the rc.sysinit scripts.

Is the patch for rc.sysinit available somewhere we can look at it?  You
want to apply restorecon as early as possible in it to minimize the set
of programs that access /dev before it has been restored.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
