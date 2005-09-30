Subject: Re: seinfo and binary policy endianness
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ltcgcw@us.ibm.com
Cc: SELinux <SELinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>,
   Emily Ratliff <ratliff@austin.ibm.com>
In-Reply-To: <1128034546.6256.15.camel@ea.austin.ibm.com>
References: <20050929222619.GA21890@us.ibm.com>
	 <1128034546.6256.15.camel@ea.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:12:01 -0400
Message-Id: <1128089521.12459.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 17:55 -0500, George Wilson wrote:
> Attached is Emily's patch, which is far more elegant than a borrowed.h
> hack.  It seems like borrowed.h should really go away.

Even better would be for setools to just use libsepol, which is _the_
library for manipulation of binary policies...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
