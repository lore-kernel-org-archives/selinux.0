Message-Id: <200303041525.KAA18983@moss-shockers.ncsc.mil>
Date: Tue, 4 Mar 2003 10:25:38 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: definition of domain transition permission
To: SELinux@tycho.nsa.gov, mayerf@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> One point of clarification, isn't it the case that process transition,
> program execute, and program entry as I list are all necessary and
> required for a domain transition to occur.  For example, process
> transition permission between two domains is never sufficient but always
> required, correct?

Yes, that is correct.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
