Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AM6qrT002116
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 18:06:53 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AM6maH026307
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 18:06:48 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 22:06:49 -0000
Date: Thu, 10 Jun 2004 22:04:05 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Magnus Therning <magnus-work@therning.org>, selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040610220405.GS2861@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <20040609175001.GC5727@lkcl.net> <200406101813.12520.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406101813.12520.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 06:13:12PM +1000, Russell Coker wrote:
> On Thu, 10 Jun 2004 03:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > 2) DO NOT add selinux.lemuria.org/newselinux to your /etc/apt/sources.list
> >
> > 3) DO add selinux.lemuria.org/walters to your /etc/apt/sources.list
> 
> Colin has not been working on his for quite some time.  Why would you want to 
> use a repository with old versions that is not being maintained instead of a 
> repository that is actively maintained with the latest versions?
 
 uhm... i don't know?   it seemed like a good idea?  i couldn't do
 mount (even as sysadm_t) of nfs filesystems and such-like, and
 went,
 
 "argh, what random thing can i try that might have a possible
 chance of working, hm, let's try installing one of those
 old walters packages, yeh, that sounds like a long-shot, hm,
 that broke, let's try something else, oh _that_ one works,
 okay, it ain't broke now, so leave it alone!"

 not that i would recommend to anyone _else_ to try this kind
 of approach unless you have a lot of time on your hands *lol* :)


> > 4) DO install the (probably downgraded) cron, logrotate, coreutils etc.
> >    from /walters
> 
> Why not install the latest versions of cron, logrotate, coreutils etc from my 
> repository which requires no special effort as they are a minor sub-version 
> greater than the versions in Debian/unstable?

 i have those, and then for certain things that were missing (and/or
 broke for me), i just ended up adding _some_ of the walters ones.


> > 5) use the 1.12 .debs for libselinux1 and selinux-policy-default
> >    and selinux-utils policycoreutils etc. they are the latest and they
> >    ARE in [ftp/http].*.debian.org
> 
> They are also only tested with the latest versions of the packages from my 
> site, not from the /walters repository.

 i understand.


> > 6) once you have installed the 1.12 selinux-policy-default and stuff,
> >    YOU MUST go to http://sf.net/projects/selinux and download a
> >    replacement genhomedircon from the
> >    selinux-usr/policycoreutils//scripts/ directory.
> >
> >    the version presently released is brain-dead and does something
> >    different and unexpected.
> 
> I've uploaded a new policycoreutils package that fixes this, along with a new 
> policy source package to match.
 
 oo! great.
 
 i'm tempted to try that, i really am, but i am close to having
 something "that works for me", now, and am reluctant to do
 anything that would a) mean more work/testing b) break what
 i have.

 hm, maybe i will take a hard-drive snapshot and continue from there.

 l.

-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
