Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: <SELinux@tycho.nsa.gov>
Subject: RE: Security policy analysis
Date: Wed, 10 Oct 2001 14:09:14 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIGENIJPAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3BC47F1C.B24952C4@mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: root@smtpsrv1.mitre.org [mailto:root@smtpsrv1.mitre.org]On Behalf
> Of Jon Crowley
> Sent: Wednesday, October 10, 2001 1:02 PM
>
> We intend on developing functions to do the following first:
>
> <list deleted>

We have very similar thoughts, though our goal is to define a building block
policy configuration for SE Linux and then methods for building upon that
building block for a variety of applications.  The analysis tool is a
by-product.

> However, our take on checkpolicy is that it is intended
> to compile policies and to assist in debugging specific to security
> identifiers.  We are thinking it might be cleaner to keep policy
> analysis tools separate from a policy compiling/debugging tool.  Though
> perhaps we have the wrong take on checkpolicy.  More thoughts on this?

We looked quickly at checkpolicy and came to the same conclusion, i.e., that
it
compiles policies for a different reason and has a policy DB not suited for
our purpose.  That's not a strong opinion.  We're also just incrementally
building quick tools and creating our own database format was simpler.  The
only code we're currently using from checkpolicy is the lex code, the yacc
framework and parser (though all the semantic logic is new), and the
associated queue.c. However, it is conceptually simple to integrate our
logic into checkpolicy
if we wanted to.  Essentially we would just add our logic to the functions
already in policy_parse.y, with changes to the main() function in
checkpolicy.c
for our menu items plus a few other housekeeping items.

I will also say that our analysis policy structure is quick and dirty
without
much effort spent on performance issues like sorted insertions and searches.
It
hasn't been any issue since once we digest the policy and build the policy
DB,
everything else is fast enough (we don't have the burden of building a
kernel
database like checkpolicy does!)



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
