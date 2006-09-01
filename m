Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81DDP2M007365
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 09:13:25 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81DD4rI024553
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 13:13:04 GMT
Subject: Re: type transitioning script race condition?
From: Joshua Brindle <jbrindle@tresys.com>
To: russell@coker.com.au
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Klaus Weidner <klaus@atsec.com>, selinux@tycho.nsa.gov,
        Stephan Mueller <smueller@atsec.com>
In-Reply-To: <200609012248.56275.russell@coker.com.au>
References: <20060830223937.GB12307@w-m-p.com>
	 <1157030632.3106.7.camel@localhost.localdomain>
	 <1157032383.24429.90.camel@twoface.columbia.tresys.com>
	 <200609012248.56275.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:13:53 -0400
Message-Id: <1157116433.20971.18.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 22:48 +1000, Russell Coker wrote:
> On Thursday 31 August 2006 23:53, Joshua Brindle <method@manicmethod.com> 
> wrote:
> > The one you referenced is specific to python but I'd like something more
> > general, basically what I'm envisioning is a wrapper that you symlink
> > all your interpreters to:
> >
> > /usr/bin/perl -> /usr/lib/wrapper/envcleaner (or whatever)
> > same with python, php, etc
> 
> Do all interpreters have the same requirements for environment cleaning?  Is 
> there a case where cleaning the environment for interpreter A will break 
> interpreter B in some way?
> 

you seem to have skipped the bottom half of my email where I proposed a
configuration file for the wrapper that instructed it how to behave for
each interpreter it wraps.

> > and when the wrapper is run it looks at how it was run argv[0] and
> > checks a config file, something like:
> 
> We are talking about a wrapper that does something similar to suid-perl.  The 
> security history of suid-perl isn't that good, I am concerned that a program 
> which is designed to suit more than one interpreter will be harder to 
> secure...
> 

It can't be worse than it is now:

[root@twoface ~]# cat ./os.py
import selinux

(ret,con) = selinux.getcon()
print "I'm running in"
print con

[root@twoface ~]#
PYTHONPATH=.:/usr/lib64/python2.4/site-packages/ /usr/sbin/semanage
I'm running in
user_u:system_r:semanage_t



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
