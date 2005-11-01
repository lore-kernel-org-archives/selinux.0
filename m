Subject: Re: [ SEMANAGE ] Install seusers, rename some files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <4367D7DF.7080504@tresys.com>
References: <4366C114.9080708@cornell.edu>
	 <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>
	 <4367D13A.1050305@cornell.edu> <4367D674.4060004@cornell.edu>
	 <4367D7DF.7080504@tresys.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:10:05 -0500
Message-Id: <1130879405.22731.319.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 16:02 -0500, Joshua Brindle wrote:
> This is a question we should be answering soon. There are a couple 
> options but because of time constraints on FC5 test 1 it will probably 
> be the base rpm putting stuff in there directly, at least for now. The 
> ideal way would be to bootstrap the whole thing through libsemanage but 
> there is bit of work to be done before this is possible.

I don't really see the point in supporting it in the libsemanage API
when it is purely a migration-time import of existing data.  The module
case is different in that the API already has to support importing an
entire module, but the local APIs are properly at the individual record
level.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
