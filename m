Subject: Re: [PATCH] semanage - rename instead of copy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <436FCC19.6020700@tresys.com>
References: <1131398734.21419.3.camel@twoface.columbia.tresys.com>
	 <1131399305.20591.151.camel@moss-spartans.epoch.ncsc.mil>
	 <436FCC19.6020700@tresys.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 08:34:48 -0500
Message-Id: <1131456888.20591.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-07 at 16:50 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > If you want to check for failure on the snprintf, you need something like:
> > 	int n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
> > 	if (n < 0 || n >= PATH_MAX)
> > 		return -1;
> > 
> good point, also strlen(dst) can't be PATH_MAX or the filename will be 
> truncated and you'll end up with rename(dst,dst).

That should be caught by the n >= PATH_MAX test above for the snprintf;
from the man page: "If the output was truncated due to this limit then
the return value is the number of characters (not including the trailing
'\0') which would have been written to the final string if enough space
had been available.  Thus, a return value of size or more means that the
output was truncated.  If an output error is encountered, a negative
value is returned."  

>  Do you want a new 
> patch or are you going to fix this before commiting?

I'll make the adjustment above, and then commit it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
