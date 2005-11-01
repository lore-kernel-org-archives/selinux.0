Subject: Re: [ SEMANAGE ] Some seusers mapping validation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4367044C.1000501@cornell.edu>
References: <4366EE1B.1060303@cornell.edu> <4366F160.2070005@cornell.edu>
	 <4367044C.1000501@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:50:24 -0500
Message-Id: <1130874624.22731.280.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 00:59 -0500, Ivan Gyurdiev wrote:
> We might also want to validate the MLS range, and the Unix name. I am 
> not clear on how to validate the MLS range - what's happening with the 
> old (local.users) MLS range? Is it deprecated? Are they supposed to 
> match? How to handle this?

users.local allows you to define additional SELinux users and authorize
them for role sets and ranges.  seusers allows you to map Linux users to
SELinux users defined in either the policy modules or users.local, and
to assign the Linux user a subset of the range authorized for the
SELinux user.  Hence, validation of the MLS range in seusers would
consist of:
- validating the range by itself as usual,
- validating that the range is a subset of the range authorized for the
SELinux user.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
