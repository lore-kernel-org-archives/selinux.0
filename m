Subject: Re: cvs repository at sourceforge (Was: Re: policycoreuitls patch)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1147701621.14426.53.camel@moss-spartans.epoch.ncsc.mil>
References: <4465E732.4080607@redhat.com>
	 <1147701621.14426.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 15 May 2006 10:30:18 -0400
Message-Id: <1147703418.14426.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-15 at 10:00 -0400, Stephen Smalley wrote:
> In other words, sourceforge cvs has switched hostnames
> (=>selinux.cvs.sourceforge.net), requiring a new checkout, and even
> worse, has regressed to an older snapshot of the tree.

I've re-updated the sourceforge cvs tree to the current version,
although I'd still advise switching to subversion.  It does not include
your latest patch, just the prior one.

> I'd recommend just switching to using the subversion repository, and
> re-base your patch against it (as it does indeed duplicate your prior
> patch).
> 
> svn co https://svn.sourceforge.net/svnroot/selinux 

I suppose the proper form would actually be:
svn co https://svn.sourceforge.net/svnroot/selinux/trunk selinux-usr
if you want to just get the trunk and have it named selinux-usr.

There are presently empty directories for branches and tags for future
use.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
