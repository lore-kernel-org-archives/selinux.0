Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20050914140508.GC27187@vnl.com>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu> <43279AED.7040605@cornell.edu>
	 <1126703779.12299.43.camel@moss-spartans.epoch.ncsc.mil>
	 <20050914140508.GC27187@vnl.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:07:23 -0400
Message-Id: <1126721243.12299.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 15:05 +0100, Dale Amon wrote:
> On Wed, Sep 14, 2005 at 09:16:19AM -0400, Stephen Smalley wrote:
> > As for threads, Alan Cox said it best:  "A computer is a state machine.
> > Threads are for people who cant program state machines.".
> 
> A true statement, but... complexity explosion makes
> it useful to move to techniques which make 'what is
> happening' clearer and easier to understand and to
> verify.

Sorry, that isn't a motivation to move to threads.  Quite the opposite.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
