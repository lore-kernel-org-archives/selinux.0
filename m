From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] disallow * and ~ in rules
Date: Fri, 24 Jun 2005 23:24:29 +1000
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
References: <1119543471.8955.5.camel@localhost> <200506241629.50884.russell@coker.com.au> <1119612908.12865.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1119612908.12865.11.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506242324.33247.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 24 June 2005 21:35, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2005-06-24 at 16:29 +1000, Russell Coker wrote:
> > I agree for dontaudit, but disagree for auditallow.
> >
> > Sometimes when debugging policy issues I want to see all the accesses to
> > an object.  Writing rules that cover everything can be a drag, and
> > running apol also takes time.  It's a lot easier to just do: auditallow *
> > foo_t:file *;
>
> But that can just as easily be written as:
> 	auditallow domain foo_t:file *;

I just did a quick test and found a .3% size difference.  I'm surprised, I had 
expected that as auditallow doesn't permit an operation the rules would not 
result in anything in the binary policy for an operation which is not 
permitted.  Does the current behavior really make sense?

> > Having role attributes would be handy.
> >
> > The in_user_role() macro is a gross hack, role attributes would remove
> > the need for it.
>
> Hmm...need a list somewhere that tracks all requests for improvements to
> the policy language...

I think that Tresys have an internal list.  When I was at the Symposium they 
were telling me about their work to implement a feature I had forgotten about 
requesting.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
