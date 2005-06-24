Message-Id: <200506241429.j5OESxqc014966@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <russell@coker.com.au>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'selinux'" <selinux@tycho.nsa.gov>
Subject: RE: [PATCH] disallow * and ~ in rules
Date: Fri, 24 Jun 2005 10:29:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119612908.12865.11.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Friday, June 24, 2005 7:35 AM
> To: russell@coker.com.au
> Cc: Joshua Brindle; selinux
> Subject: Re: [PATCH] disallow * and ~ in rules
> 
> On Fri, 2005-06-24 at 16:29 +1000, Russell Coker wrote:
> > I agree for dontaudit, but disagree for auditallow.
> >
> > Sometimes when debugging policy issues I want to see all the accesses to an
> > object.  Writing rules that cover everything can be a drag, and running apol
> > also takes time.  It's a lot easier to just do: auditallow * foo_t:file *;
> 
> But that can just as easily be written as:
> 	auditallow domain foo_t:file *;
> with no loss in what it truly provides (and definite improvement in the
> size of the resulting policy).  Note that we aren't eliminating use of *
> in permission sets, just in type sets and role sets.  The problem with *
> in type sets is that you never truly want all types (except in
> assertions checking for policy errors); you only want "all process
> types, i.e. domain" or "all file types, i.e. file_type", etc.
> 
> > Having role attributes would be handy.
> >
> > The in_user_role() macro is a gross hack, role attributes would remove the
> > need for it.
> 
> Hmm...need a list somewhere that tracks all requests for improvements to
> the policy language...
> 

We can put this on the policy server sf site as long as everyone knows that we
can't address all of these requests as part of that project.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
