Message-Id: <200302101824.NAA08357@moss-shockers.ncsc.mil>
Date: Mon, 10 Feb 2003 13:24:58 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: question about role dominance relation....
To: SELinux@tycho.nsa.gov, kimhc@kjist.ac.kr
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Testing with role dominance relation,
> 
> dominance { role A; role B; }
> In this case, what role dominates the other role??

Neither.  In the above statement, role A and role B are incomparable.
If you want role A to dominate role B, try:

dominance { role A { role B; } }

> And I also want to know an example, saying
> "A role A dominates a set of roles B, C..."

That would be:

dominance { role A { role B; role C; } }

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
