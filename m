Subject: Re: [PATCH] semanage-functionality 4/17
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
In-Reply-To: <4339B036.5090900@cornell.edu>
References: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com>
	 <43397960.5070905@cornell.edu>
	 <1127851738.21671.147.camel@moss-spartans.epoch.ncsc.mil>
	 <4339B036.5090900@cornell.edu>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 16:57:27 -0400
Message-Id: <1127854647.21671.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-27 at 16:48 -0400, Ivan Gyurdiev wrote:
> Most likely my fault - I introduced the pointer ones for records - that 
> can be changed if necessary. The nice thing about pointer typedefs is 
> that the pointer is hidden within the data type, which makes it possible 
> to eliminate, if necessary - type can be replaced with a primitive 
> without changing any of the functions to get rid of the star.... not 
> that we're ever going to use primitive types for any of those things.

Yes, and I'm dubious that such elimination is practically useful; you
still have to audit the code for correct usage and in any case where it
affects an exposed interface, you have the whole stable API/ABI issue to
deal with.

> Then we'll have to type struct everywhere...

Yes, I see it as a benefit to be able to easily see from the code
whether a function (and the code) is dealing with a pointer or a struct
without needing to look up a separate type definition.  Think in terms
of long term code maintainability / readability, particularly for
patches.  Besides, typing "struct foobahblaz" isn't so much worse than
typing "foobahblaz_t".  The kernel maintainers are right on the issue of
typedefs...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
