Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VFejpK005325
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 11:40:45 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VFe0i7009046
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 15:40:05 GMT
Subject: Re: type transitioning script race condition?
From: Joshua Brindle <jbrindle@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: russell@coker.com.au, Klaus Weidner <klaus@atsec.com>,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
In-Reply-To: <1157038164.14623.6.camel@localhost.localdomain>
References: <20060830223937.GB12307@w-m-p.com>
	 <200608310918.03263.russell@coker.com.au>  <44F6539E.7090800@gentoo.org>
	 <1157030632.3106.7.camel@localhost.localdomain>
	 <1157032383.24429.90.camel@twoface.columbia.tresys.com>
	 <1157038164.14623.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 11:41:01 -0400
Message-Id: <1157038861.24429.110.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 11:29 -0400, Karl MacMillan wrote:
> On Thu, 2006-08-31 at 09:53 -0400, Joshua Brindle wrote:
> > On Thu, 2006-08-31 at 09:23 -0400, Karl MacMillan wrote:
> > > On Wed, 2006-08-30 at 23:12 -0400, Joshua Brindle wrote:
> > > > Russell Coker wrote:
> > > > 
> > > > >On Thursday 31 August 2006 08:39, Klaus Weidner <klaus@atsec.com> wrote:
> > > > >  
> > > > >
> > > > >>This sounds as if it suffers from the well known race condition that
> > > > >>makes setuid shell scripts a bad idea - is there any protection in place
> > > > >>to prevent users from exploiting the race condition to run code of their
> > > > >>own choice in the new domain?
> > > > >>    
> > > > >>
> > > > >
> > > > >Correct.  As long as the script is run in a domain that has less privileges 
> > > > >than the calling code this isn't a problem.  If running a script causes a 
> > > > >transition to a more privileged domain then that's a policy bug.
> > > > >
> > > > >  
> > > > >
> > > > this happens quite a bit, including our own selinux management script 
> > > > semanage. In addition to the race condition (that is not fixable on 
> > > > Linux AFAIK) there are other environmental contamination issues,
> > > > 
> > > > There are some plans to fix the environmental contamination issues using 
> > > > a wrapper that cleanses the environment ala atsecure but the race is not 
> > > > fixable as far as I know.
> > > > 
> > > 
> > > If you write a C program that wrapper both issues should be greatly
> > > mitigated because you are no longer gaining privilege on the script
> > > execution - see
> > > http://svn.python.org/view/python/trunk/Misc/setuid-prog.c?rev=11583&view=auto. I've been meaning to do this for semanage for a while but haven't gotten to it yet.
> > 
> > I think we need to consolidate efforts because we are starting to work
> > on a wrapper here as well. 
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
> > 
> 
> I think this general solution is going to be a hard sell because of
> compatibility problems. So I think it is best to go in two directions -
> a practical per-application solution and the more complete and general
> solution.
> 

it will only do anything in the case of atsecure being set, most of the
time this shouldn't cause compatibility problems. If something that has
atsecure set (and therefore has some security change like setuid or a
domain transition) and it breaks then the script has a major security
issue anyway. I don't see this as a problem at all.

> > One thing, you said both issues can be mitigated, how can the race be
> > mitigated? The app executes the interpreter with the argv you pass into
> > it so the race to swap the file still exists (and the privilege has
> > already been raised via the wrapper)
> > 
> 
> Sorry - started one message and sent another. If you embed the script
> (as a string) and interpreter in the C wrapper you can avoid the race.
> 

right.. 

> In practice - for the scripts we are discussing - if you have sufficient
> privilege to modify the script or the environment to take advantage of
> the race condition you likely have a more direct attack vector. So the
> environment cleansing seems more important to me.

maybe, you might not be able to write to the type of the script but if
you can, for some reason, copy over it with a different script of a
different type then you can take advantage. This should be mitigated by
policy for the most part, environment cleansing is currently an achilles
heel.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
