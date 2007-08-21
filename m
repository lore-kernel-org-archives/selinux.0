Subject: Re: weird mprotect error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com>
	 <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil>
	 <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 10:18:45 -0400
Message-Id: <1187705925.1451.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-08-20 at 21:09 -0500, Joe Nall wrote:
> On Aug 17, 2007, at 2:47 PM, Stephen Smalley wrote:
> 
> > On Fri, 2007-08-17 at 11:05 -0400, Christopher J. PeBenito wrote:
> >> I was working on a RHEL 5.1 beta machine with MLS policy, and I  
> >> get a weird mprotect EACCES error in enforcing.  I have the  
> >> folowing hello-world program:
> >> ...
> >> init_ranged_daemon_domain(mlstest_t,mlstest_exec_t,s4:c0.c253)
> >> ...
> >> #mls_fd_use_all_levels(mlstest_t)
> >>
> >> Without the one mls rule, I get a denial, as expected, since  
> >> mlstest_t's level is not equal to initrc_t's:
> >>
> > mprotect/mmap checks are against the "open file" object aka struct  
> > file,
> > and thus include a fd use check (if the open file was originally  
> > created
> > by a task in another label).  So you could very well get such a denial
> > from mprotect on a mapping of ld.so.
> 
> Any recommendations on how to start an unprivileged non SystemLow  
> daemon? This seems broken.

Maybe I don't understand the actual problem.

Is it reproducible with an upstream (or Fedora) kernel?

What's the exact test case?  Trying to run an /etc/init.d script that
calls that mlstest program using run_init?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
