From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: SUDO package
Date: Fri, 25 Apr 2003 04:07:10 +1000
Cc: SELinux@tycho.nsa.gov
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com> <200304231710.34773.russell@coker.com.au> <1051205517.20300.71.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1051205517.20300.71.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304250407.10413.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Apr 2003 03:31, Stephen Smalley wrote:
> I prefer extending the domain name with the type suffix, but this is
> obviously not a big deal as long as we are consistent.  It is likely
> easier to quickly see what types are associated with a given domain if
> they use the domain name as the prefix.

OK.  I had been tending towards the same conclusion, but hadn't been looking 
forward to the hassle of changing it.

I have now re-written most of the policy for such things, I'll test it out 
over the next few days and I'll have something ready for you to look at 
within a week.

BTW  What shall we do about all the other changes I've made recently?  The 
unified diff between my tree and yours is probably in excess of 5,000 lines, 
it would probably be most conveniant for everyone if we try getting things 
merged now.

Is there someone else who can look into this?  I know you're really busy with 
2.5 stuff right now.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
