Subject: Re: setsebool and togglesebool patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1099679009.20150.150.camel@pham.columbia.tresys.com>
References: <1099679009.20150.150.camel@pham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099682764.6373.254.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 14:26:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 13:23, Karl MacMillan wrote:
> Unfortunately, this race isn't avoided entirely with your approach -
> there is no guarantee that only one instance of the tools is running and
> of course other processes can be toggling the booleans directly
> via /selinux. Even if two processes are changing orthogonal booleans, a
> commit by one of the processes in the middle of the other's transaction
> can cause an inconsistent state.

True, but I think they are particularly concerned about
system-config-securitylevel using setsebool to set a collection of
booleans as a single transaction, and this does help in that situation.

> Whom means linux username, SELinux username, process type, a
> combination?

At present, it appears that it only logs Linux username.  Should also
include security context, IMHO, although one could correlate with the
corresponding audit message to get that information.

> > Does this mean the policy or the boolean configuration? 

Looks like just the boolean configuration.  

> This gives these
> tools a lot of power that wasn't there before. You are essentially
> requiring that setsebool have permission to change any bool, or if you
> are writing the policy to disk permission to change anything.

No; it still only sets the booleans specified on the command line, and
it only writes the boolean configuration file if you specify that
option.  Hence, you can still use it even with limited permissions.

> This is work that needs to be done and I'm glad that you are tackling
> it. Unfortunately, it seems to me that the full solution requires some
> more engineering.

Agreed, but it seems like a good start.  Committed to the sourceforge
CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
