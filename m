Subject: Re: threads
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1074647474.953.40407.camel@cube>
References: <1072454081.827.103.camel@cube>
	 <1072712224.845.66.camel@moss-spartans.epoch.ncsc.mil>
	 <1074647474.953.40407.camel@cube>
Content-Type: text/plain
Message-Id: <1074692850.9767.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 21 Jan 2004 08:47:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-01-20 at 20:11, Albert Cahalan wrote:
> This is not quite right. A server daemon using
> per-thread contexts is clearly within your trusted
> computing base, just as the kernel is. This can
> improve security over the obvious alternative of
> having the server run in a context that can do
> anything.

With such a model, you'll quickly end up with everything in your TCB and
your system will be just as easily broken as before.  Split your daemon
into multiple processes running in different contexts instead.  Improve
security?  No, just provide an illusion of it; no real separation is
ensured.

> I was assuming you wouldn't hand out such
> privilige willy-nilly.

Once such a capability exists, people will use it for everything, and
never even consider proper decomposition of their daemons.

> Isn't this the way LOMAC works?

Yes.  But that doesn't mean it is a good idea.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
