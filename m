Message-ID: <4251BA1E.9040406@trustedcs.com>
Date: Mon, 04 Apr 2005 17:05:18 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: policy hierarchy patch
References: <1112631282.19526.18.camel@localhost>	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil> <1112643447.19527.30.camel@localhost>
In-Reply-To: <1112643447.19527.30.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Yes you appear to be right. It turns out that this is a hard problem,
> currently '.' is treated as a terminal some of the time and part of an
> identifier other times. We tried to fix this problem by using lex start
> states to disambiguate mls identifiers and normal ones but this became
> problematic in contexts. Namely the following is currently valid:
> 
> user:role:type:s0-s9:cat1. cat2
> 
> note the space, now currently parts of the language require 2 contexts
> in 1 rule, specifically netifcon:
> 
> netifcon user:role:type:s0:cat1 user:role:type:s1:cat1
> 
> If the context were always the last thing on the line we could end the
> lex start state but since that isn't the case the yacc lookahead causes
> the next identifier to be treated as an mls_identifier.
> 
> I said all that to ask if it is feasible to combine identifier and
> mls_identifier in the patch and remove the terminal '.'. This would
> cause category ranges to be 1 identifier and they'd have to be split
> manually but otherwise it should work. The only visible change would be
> that spaces would no longer be allowed between the category and the '.'.
> 

Sounds good to me.  I should actually be able to take a look at it tomorrow and 
help you out with the code.  I know that the parsing isn't the prettiest...  I 
think I may be able to make it look better in C code.  And we didn't really like 
the spaces anyway.

-- 

Darrel (Go Illini!)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
