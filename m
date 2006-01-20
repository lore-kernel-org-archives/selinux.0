Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1137784500.31152.6.camel@twoface.columbia.tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1137784500.31152.6.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 15:49:41 -0500
Message-Id: <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-20 at 14:14 -0500, Joshua Brindle wrote:
> attached patch addresses all of the concerns with the prior patch. The
> main change is to make a function called semanage_access_check that
> returns error, existance, readable or writable. Depending on where the
> check is done test against one of them. 
> 
> I am now able to query the store as a non-root user after giving read
> access to /modules and /modules/active{,/*} and read/write to
> modules/semanage.read.LOCK
> 
> as expected I can query the store but not write to it, I also added a
> check for writability at the beginning of begin_transaction so that the
> user gets a nicer error when this happens.

Better, but a few lingering issues/questions:
1) Running semanage as a non-root user with existing default modes on
the policy module tree yields "SELinux policy is not managed."
So we aren't quite providing the right information to the user yet.

2) I'm still not sure about the check on the binary policy install
directory; not all "write" operations truly require rebuilding the
kernel binary policy, and we already have rollback code if that
installation fails, so I suspect that the writability check on the
active module store is good enough here.

3) I normally would have expected checking write access to the container
directory for the lock file rather than checking access to the lock file
itself, but I suppose since you create the lock file on the first
transaction and never remove it and use lockf for locking, it should
always exist if the store itself has been initialized?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
