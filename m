Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200706141944.35457.russell@coker.com.au>
References: <20070611204336.GA30846@sergelap.austin.ibm.com>
	 <200706132116.05065.russell@coker.com.au>
	 <1181737910.17547.315.camel@moss-spartans.epoch.ncsc.mil>
	 <200706141944.35457.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 07:03:11 -0400
Message-Id: <1181818991.17547.554.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-14 at 19:44 +1000, Russell Coker wrote:
> On Wednesday 13 June 2007 22:31, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2007-06-13 at 21:16 +1000, Russell Coker wrote:
> > > On Wednesday 13 June 2007 01:57, Stephen Smalley <sds@tycho.nsa.gov> 
> wrote:
> > > > Well, first, no script should be allowed a capability that is not given
> > > > to its caller directly ;)
> > >
> > > Why not?  Isn't that the entire point of this authoritative granting of
> > > capabilities patch?
> >
> > _script_, not program.
> 
> OK, that's a bit of a topic change.
> 
> I've been thinking about the script issue.  It seems to me that a problem we 
> face is the replacement of executables by scripts (which often happens in 
> distributions and sometimes happens with programs that are relevant to system 
> integrity).
> 
> We could write a policy that correctly allows a domain transition on executing 
> an ELF binary only to find that the next version of the distribution replaces 
> it with a BASH or Perl script then there is the potential for an exploit.
> 
> Apart from initrc_exec_t are we relying on domain transitions on execution of 
> shell scripts for anything?

It isn't just "shells", but any interpreter.  cgi-bin scripts?
semanage?  etc.

Solaris solution was to have the kernel create a fd to the script file
and pass /dev/fd/<n> as the first argument to the interpreter so that
there is no separate lookup when dealing with suid scripts.  Naturally,
that doesn't address environmental contamination issues (and AT_SECURE
doesn't do enough cleansing to protect scripts), and it can yield
confusing results for scripts that aren't expecting their argv[0] to be
like that.

> Currently common shells have special-case code to deal with the case of 
> uid!=euid and gid!=egid.  I think that this could be considered precedent for 
> having the shell check whether it is run in a different domain to it's parent 
> process, and if so whether the parent domain is permitted to execute 
> shell_exec_t in the current domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
