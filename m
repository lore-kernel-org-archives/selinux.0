Subject: Re: Problems with /dev/tty on reboot.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <3FC4BDD3.8090504@redhat.com>
References: <3FC4AF2B.3060301@redhat.com>
	 <1069856081.30315.55.camel@moss-spartans.epoch.ncsc.mil>
	 <3FC4BDD3.8090504@redhat.com>
Content-Type: text/plain
Message-Id: <1069860803.30315.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 10:33:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-26 at 09:50, Daniel J Walsh wrote:
> Ok, moving the ifdef(`dpkg.te') rule allowed login to relabel the tty
> and me to login, but should we still make the change to getty to
> relabel the tty?  If yes, how should getty determine what context to
> set the tty too?  Do we need to add something to default_contexts or
> is there another way to determine this?

If getty already resets the ownership, then it makes sense to also patch
it to reset the context.  It can pull a single context from a config
file like run_init does, or this could be the time to create that
libselinux function that returns the matching context from the file
contexts configuration for a given pathname...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
