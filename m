Subject: Re: SUDO package
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200304250407.10413.russell@coker.com.au>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
	 <200304231710.34773.russell@coker.com.au>
	 <1051205517.20300.71.camel@moss-huskers.epoch.ncsc.mil>
	 <200304250407.10413.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051299719.3679.11.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Apr 2003 15:41:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm going to take on some of the example policy coordination work to try
relieve Stephen a little.  Try not to bury me too deep in policy patches
the first week. :-)

On Thu, 2003-04-24 at 14:07, Russell Coker wrote:
> On Fri, 25 Apr 2003 03:31, Stephen Smalley wrote:
> > I prefer extending the domain name with the type suffix, but this is
> > obviously not a big deal as long as we are consistent.  It is likely
> > easier to quickly see what types are associated with a given domain if
> > they use the domain name as the prefix.
> 
> OK.  I had been tending towards the same conclusion, but hadn't been looking 
> forward to the hassle of changing it.
> 
> I have now re-written most of the policy for such things, I'll test it out 
> over the next few days and I'll have something ready for you to look at 
> within a week.
> 
> BTW  What shall we do about all the other changes I've made recently?  The 
> unified diff between my tree and yours is probably in excess of 5,000 lines, 
> it would probably be most conveniant for everyone if we try getting things 
> merged now.
> 
> Is there someone else who can look into this?  I know you're really busy with 
> 2.5 stuff right now.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
