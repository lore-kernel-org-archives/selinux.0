Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Richard Mayo" <rmayo@caci.com>, SELinux@tycho.nsa.gov
Subject: Re: SE Linux Auditing
Date: Thu, 5 Dec 2002 23:55:35 +0100
References: <OFB4BC1BEA.C8493AB0-ON85256C86.00536EFC@caci.com>
In-Reply-To: <OFB4BC1BEA.C8493AB0-ON85256C86.00536EFC@caci.com>
MIME-Version: 1.0
Message-Id: <200212052355.35084.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Dec 2002 16:14, Richard Mayo wrote:
> Does anybody know if there any tools that could be used to put the SELinux
> audit logs into a user friendly (human readable) format?  For example, with
> Solaris there is an Audit Reduction Tool that removes all of the "junk".

What exactly does this ART do?

Being able to sort logs by identity or role would be handy.  But it would be 
merely a sub-set of a good event logging program.  If I had an immense amount 
of spare time (or a good sponsoring deal) I'd write a proper event and server 
management tool.  Something like CA Unicenter but that works (IE doesn't 
SEGV, doesn't kill servers, doesn't take 60M of RAM per server, and has 
partial failure modes).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
