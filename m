Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5G2YtgA027569
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2005 22:34:55 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5G2PsPv007880
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 02:25:54 GMT
Message-Id: <200506160226.j5G2QJG3009777@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Colin Walters'" <walters@verbum.org>,
   "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "'SELinux Mail List'" <selinux@tycho.nsa.gov>
Subject: RE: ANN: SELinux Reference Policy Release
Date: Wed, 15 Jun 2005 22:26:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1118874951.24338.35.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Colin Walters
> Sent: Wednesday, June 15, 2005 6:36 PM
> To: Christopher J. PeBenito
> Cc: SELinux Mail List
> Subject: Re: ANN: SELinux Reference Policy Release
> 
> On Wed, 2005-06-15 at 17:42 -0400, Christopher J. PeBenito wrote:
> > The first release of the SELinux Reference Policy is now available on
> > Sourceforge from http://serefpolicy.sourceforge.net.
> >
> > This is an experimental release, and definitely is not usable as a
> > drop-in replacement for the current policy, as it can only boot a very
> > limited RHEL4 system.  It is directed towards policy developers, to
> > generate community feedback and discussion.
> 
> Wow.  This looks quite fantastic.  I really, really like the inline
> documentation work.
> 

Thanks - I honestly think that the documentation could become the most important
part of all of this. What we have now in refpolicy is some infrastructure and a
few comments - I can see the documentation growing to the point of being a
general reference for how Linux systems are put together and the security
implications of each access. The knowledge behind each policy decision is the
hard part - not figuring out how to deal with types, attributes, etc.

I'd just like to take this opportunity to solicit help from anyone that is
interested to create some of this documentation. Much of the knowledge is in the
current policies (in the access that is) - it is just hard to get it out
sometimes.

> This work reminds me though; I was thinking a week or so ago about what
> it would be like to write e.g. an Eclipse plugin for policy writing.
> One of the core problems one would run into (and I bet the polgen people
> hit this too) is that it's a nightmare to deal with m4; how do you know
> what macros are available and what they do?  The macros form the real
> policy language, so an IDE would need to understand them.
> 
> You're left with basically hardcoding a list of them, or resorting to
> some evil hack to try to extract the macro names and filter unwanted
> macros.
> 
> The inline documentation in the reference policy is really a form of
> easily parseable metadata that could also be used for this purpose.

We have some Java code lying around that can parse the generated XML if you want
it. We are also working on an eclipse based policy development environment.
Unfortunately I don't think that it will be targeted towards general policy
development any time soon, but you might be able to repurpose some of the code.
The only docs available are at
http://www.selinux-symposium.org/2005/presentations/session6/6-1-wilson.pdf.

> However, it's a bit verbose now.  Let's take an example:
> 
> ########################################
> ## <interface name="selinux_get_enforce_mode">
> ##      <description>
> ##              Allows the caller to get the mode of policy enforcement
> ##              (enforcing or permissive mode).
> ##      </description>
> ##      <parameter name="domain">
> ##              The process type to allow to get the enforcing mode.
> ##      </parameter>
> ## </interface>
> #
> define(`selinux_get_enforce_mode',`
>         gen_require(`$0'_depend)
> 
>         allow $1 security_t:dir { read search getattr };
>         allow $1 security_t:file { getattr read };
> ')
> 
> You have to declare "selinux_get_enforce_mode" twice; it's verbose
> and error-prone.
> 

Agreed - we could actually generate the M4 from the XML (and we are currently
generation some config files in this way). That has some drawbacks - like an
extra compile step.

> What if we actually extended checkpolicy with the notion of "policy
> functions"?  For example, suppose we had syntax like this:
> 

This would have many benefits beyond simpler syntax and has been mentioned a few
times on the list. I would avoid the name function, though. I think it is best
to avoid any suggestion that policy is a programming language with control flow.
Why not interface - though it is not that much better I guess?

Perhaps the largest win for putting these interfaces in the base language is
that loadable module dependencies would be based on the interface rather than
types, making the refpolicy modularity real and allowing third party loadable
modules some chance of successfully linking to various policies.

We can argue about the syntax (and Javadoc vs. C# comment styles), but I agree
that it would be nice to have the infrastructure. It is a bit beyond the scope
of this project, unfortunately. We may be able to devote some resources to this
in the future, but nothing right now.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> # Allows the caller to get the mode of policy enforcement (enforcing or
> # permissive)
> # @param basetype The process type to allow to get the enforcing mode.
> function selinux_get_enforce_mode(domain basetype) {
>   allow basetype security_t:dir { read search getattr };
>   allow basetype security_t:file { getattr read };
> }
> 
> Much nicer, no?
> 
> Ok, so that's a pretty simple function; here's a more complicated
> example, from your apps/gpg.if:
> 
> #######################################
> #
> # Per user domain template for this module
> #
> # gpg_per_userdomain_template(userdomain_prefix)
> #
> define(`gpg_per_userdomain_template',`
>         type $1_gpg_t;
>         domain_type($1_gpg_t)
>         domain_entry_file($1_gpg_t,gpg_exec_t)
>         role $1_r types $1_gpg_t;
> 
>         ...
> 
>         # transition from the userdomain to the derived domain
>         allow $1_t $1_gpg_t:process transition;
>         allow $1_t gpg_exec_t:file rx_file_perms;
>         type_transition $1_t gpg_exec_t:process $1_gpg_t;
> 
>         ...
> 
> Wouldn't it be nice if we could do instead:
> 
> # Define derived domains for GPG from @userdomain
> # @param user The user domain to derive from
> # @param userrole The user role to authorize for GPG
> function gpg_per_userdomain(domain user, role userrole) {
>   derivedtype gpg_t from user
> 
>   domain_type(gpg_t)
>   domain_entry_file(gpg_t, gpg_exec_t)
>   role userrole types gpg_t
> 
>   ...
> 
>   allow user gpg_t:process transition;
>   allow user gpg_exec_t:file rx_file_perms;
>   type_transition user gpg_exec_t:process gpg_t;
> 
>   ...
> }
> 
> The key idea here is that an IDE could actually parse this, and easily
> determine programatically what types and roles are generated by the
> function, without doing hacks like expanding the M4 and parsing that,
> and then guessing.
> 
> Your policy modules work removes one of the major uses of M4 in the
> policy (that being ifdef(`foo.te')), and having policy functions would
> kill the other major use.
> 
> Since you're embarking on rewriting the policy, I thought I'd bring this
> up now.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
