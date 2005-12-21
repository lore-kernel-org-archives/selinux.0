Subject: Re: Adding audit messge to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Chris Wright <chrisw@osdl.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1135181425.18223.72.camel@moss-spartans.epoch.ncsc.mil>
References: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
	 <1135181425.18223.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 11:42:55 -0500
Message-Id: <1135183375.18223.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-21 at 11:10 -0500, Stephen Smalley wrote:
> Why don't you drop capabilities first, then switch to the real uid?
> Otherwise, you have a task with the caller's uid and full capabilities
> for an interval of time, right?

Hmm...I see - you need CAP_SETUID around still in the effective set to
perform the setuid() call to the real uid.  Looking about for how others
handle this same logic, I did see:
http://lists.samba.org/archive/rsync/2004-January/008403.html

Looks like they shed the capabilities in the permitted and inheritable
sets before the setuid(), then drop from the effective set afterward.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
