Subject: Re: [PATCH 1/2] SELinux: do not check open on dir path walk
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1225291378.6588.46.camel@moss-spartans.epoch.ncsc.mil>
References: <1225290845.23553.2.camel@localhost.localdomain>
	 <1225291378.6588.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 11:19:17 -0400
Message-Id: <1225293557.23736.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-29 at 10:42 -0400, Stephen Smalley wrote:
> On Wed, 2008-10-29 at 10:34 -0400, Eric Paris wrote:
> > Things like link_path_walk check for MAY_EXEC on directories as it walks path
> > names.  The open perms checking was actually checking open on these as well.
> > This patch excludes checking open when the only requested permission on the
> > dir was MAY_EXEC.  open and opendir both still require open perms.
> 
> Would these issues (both directory search and unix socket) have been
> avoided if you had put the open check in the dentry_open hook instead of
> the inode_permission hook?

Both are the result of explicit calls to inode_permission so yes, they
would have been avoided.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
