Subject: Re: Some sort of explicit labeling for ipc?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, kmacmillan@tresys.com
In-Reply-To: <1150744162.27852.8.camel@localhost.localdomain>
References: <1150744162.27852.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 15:29:49 -0400
Message-Id: <1150745389.7487.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-19 at 15:09 -0400, Eric Paris wrote:
> When I was ask to do the socket create labeling patch it was mentioned
> that an ipccreate labeling patch might also be useful for some use.  I'm
> not sure who wanted it or for what.  But if someone can explain to me
> what they want in the way of ipccreate labeling and what the use case
> would be it might be something I can look into getting the kernel hooks
> for.

For System V IPC objects, e.g. to create message queues in a particular
security context rather than having them always fall into the creating
task's security context.

Then there are POSIX mqueues, but they are handled via a pseudo fs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
