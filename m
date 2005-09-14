Date: Wed, 14 Sep 2005 08:00:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
Message-ID: <20050914070022.GD1257@lkcl.net>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu> <43264DAD.5090903@cornell.edu> <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil> <4327521D.5020605@cornell.edu> <1126652637.30915.18.camel@twoface.columbia.tresys.com> <432799F0.7060706@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432799F0.7060706@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 13, 2005 at 11:33:04PM -0400, Ivan Gyurdiev wrote:
> >The error system should be about passing descriptive messages to the
> >caller and this needs to be done by passing a buffer to the functions
> >that may return an error,
> >
> How do we pass such a buffer without rewriting the libsepol API?
> DEBUG has the advantage of being backwards compatible.
 
 okay.

 i refrained from replying regarding library design, which i
 learned about from an expert - andrew tridgell.  i refrained
 because i believed i would be seen as attemtping to teach
 people who already knew about these matters.
 
 given that there have now been at least three messages bouncing
 back-and-forth indicating that there have been some quite
 serious basic design mistakes (global variables, printfs for debug
 reporting etc.), i thought it best to chip in.

 properly libraries should never call _any_ functions that it has not
 explicitly been given access to.

 if there are lots of functions it needs, then the library should be
 passed in an array (vector table) of those functions.

 the best designed libraries should have ONE external function
 and ZERO global variables.  the external function should
 be setup function which returns a vector table pointing to
 static internal functions.

 one of those static internal functions should be an "initialisation"
 function, via which the library should RECEIVE a vector table pointing
 to functions that it needs to make use of - the most obvious ones being
 of course malloc, free and realloc.


 stuff backwards compatibility - royally.
 
 design the library properly.

 pass in a pointer to a memory free and a memory alloc function.

 pass in a debug reporting function, with clear instructions
 that the memory allocated to report the error should be freed
 by the caller (or some other technique e.g. a negotiation
 technique to request a buffer for error reporting of minimum
 size X, which could be static).

 
 the extreme case of library development is kernel programming,
 especially in Windows NT's design, for example the LSA -
 local security authority.  mostly, in NT, things are designed
 the way they are because MS can't make up their minds as
 to whether to have code in kernel or in userspace, so they
 design everything for kernelspace, just in case.

 anyway.


 i strongly advise you to consider _not_ putting backwards
 compatibility as a high priority over good library design.

 and to treat the library as if it was to be put into the
 linux kernel.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
