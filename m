Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VGCmZr006456
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 12:12:48 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VGCPSk007516
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 16:12:27 GMT
Subject: Re: type transitioning script race condition?
From: Joshua Brindle <jbrindle@tresys.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
In-Reply-To: <20060831154635.GC12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com>
	 <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org>
	 <1157030632.3106.7.camel@localhost.localdomain>
	 <1157032383.24429.90.camel@twoface.columbia.tresys.com>
	 <20060831154635.GC12307@w-m-p.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 12:13:14 -0400
Message-Id: <1157040794.24429.116.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 10:46 -0500, Klaus Weidner wrote:
> On Thu, Aug 31, 2006 at 09:53:03AM -0400, Joshua Brindle wrote:
> > On Thu, 2006-08-31 at 09:23 -0400, Karl MacMillan wrote:
> > > If you write a C program that wrapper both issues should be greatly
> > > mitigated because you are no longer gaining privilege on the script
> > > execution - see
> > > http://svn.python.org/view/python/trunk/Misc/setuid-prog.c?rev=11583&view=auto. I've been meaning to do this for semanage for a while but haven't gotten to it yet.
> > 
> > The one you referenced is specific to python but I'd like something more
> > general, basically what I'm envisioning is a wrapper that you symlink
> > all your interpreters to:
> > 
> > /usr/bin/perl -> /usr/lib/wrapper/envcleaner (or whatever)
> > same with python, php, etc
> > 
> > and when the wrapper is run it looks at how it was run argv[0] and
> > checks a config file, something like:
> > 
> > /usr/bin/python:
> > (from the above link)
> > bad_vars: LD_* _RLD* PYTHON IFS CDPATH ENV
> > 
> > or whatever, something generic that we can use to protect any kind of
> > interpreted script, it could check for uid changes as well as do an
> > atsecure check to decide if it needs to cleanse the environment.
> 
> I think this is the wrong way around - it doesn't protect against the
> race, and a perl or pythin script can easily clean its own environment
> and doesn't need a helper program to do that.
> 

The race is insignificant compared to the environment. The scripts
cannot clean their own environment because the environment affects the
interpreters potentially before the script is started (like PATH
variables specific to the interpreter, or preload like PYTHONSTARTUP
(run before the script is started).

> The traditional method is to create an executable file that launches a
> specific script, and make that executable suid, type transitioning or
> whatever. This takes care of some issues such as LD_* variables
> automatically.
> 

right, only the variables that affect the linker, not ones that affect
the interpreter.

> The python wrapper Karl linked to does part of the job, but if you're
> paranoid there are more things you need to protect against:
> 
> - other environment variables may be dangerous, for example program "foo"
>   launched indirectly from the script may look at a FOORC variable to
>   find its config file. In general it's safer to completely wipe the
>   environment and only retain specific variables from a whitelist.
> 

applications that use their own environment and are trusted within a
specific domain are a non-issue, we already trust them to act
appropriately within the confines we've given.

> - set up file descriptors - close extra ones, and make sure 0/1/2 are
>   open. A nasty hack is closing fd 2 (stderr) before launching the
>   trusted app. The application opens a file for writing, gets fd 2 from
>   the OS from that, and now anything it's intending to write to stderr
>   such as warning or progress messages will also go to that file.
> 

right, I mentioned this in another email, we could do this for security
critical apps like semanage but not in a general way.

> - make sure that resource limits are reasonable. Another hack involved
>   setting the max file size to a very low value and calling passwd(1),
>   which then truncated /etc/shadow due to the limit.
> 

not sure why this helps.

> These things should be done for all suid/privileged programs, not just
> scripts, because they may be using system(3) or equivalent to call a
> program via the shell which could then get contaminated by $IFS or other
> malicious settings.

privileged programs already handle this if they are binary (atsecure
cleanses things that can affect the binary that are out of its control)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
