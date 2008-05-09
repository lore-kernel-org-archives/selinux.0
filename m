Subject: Re: I think this is a bug in the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <4824560E.8060500@redhat.com>
References: <4824560E.8060500@redhat.com>
Content-Type: text/plain
Date: Fri, 09 May 2008 10:14:15 -0400
Message-Id: <1210342455.6434.209.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-05-09 at 09:47 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=445709	
> 
> libvirtd is clearly not ptracing the unconfined_t domain.  It is
> problably looking under /proc for some information about the app that is
> communicating with it.  It might be reading unconfined_t environment.  I
> am not sure, but we generate a ptrace and stop the app from working.  My
> only choice is to allow virtd to ptrace unconfined_t processes which is
> not a good idea.  This has to be fixes in the kernel.

We do have an item on the kernel todo list to split up the proc ptrace
checking to let us distinguish between reading process state vs.
manipulating/controlling a process.

However, in this case, I notice that you are not only getting a ptrace
permission check between the processes but also a sys_ptrace capability
check.  That manes that virtd is trying to access /proc private info for
a process with a different set of uids, gids, or capabilities.

Splitting up the SELinux check won't help with that.

I'd suggest taking a harder look at libvirtd to see what it is doing and
whether it can achieve the desired result in a cleaner manner that
requires less privilege.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
