Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KHooRb021238
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 13:50:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KHmOB2014205
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:48:24 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
	by jazzswing.ncsc.mil  with SMTP id i4KHmNwi014202
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:48:24 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 20 May 2004 17:50:45 -0000
Date: Thu, 20 May 2004 17:48:03 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <rcoker@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: start of patch to dpkg's start-stop-daemon
Message-ID: <20040520174803.GA18182@lkcl.net>
References: <20040520084306.GL24597@lkcl.net> <200405210132.17391.russell@coker.com.au> <20040520162343.GL8810@lkcl.net> <200405210333.37234.rcoker@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405210333.37234.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 21, 2004 at 03:33:37AM +1000, Russell Coker wrote:
> On Fri, 21 May 2004 02:23, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > > it's a patch to dpkg 1.10.21's utils/start-stop-daemon.c
> > > > which causes a context switch just before
> > > > the setuid/setgid calls.
> > >
> > > What is the benefit in that?
> >
> >  it's easier than breaking pre-existing /etc/init.d/* scripts where
> >  people expect the -u option to act as it should?
> 
> How is it broken?  initrc_t has setuid and setgid capabilities so SE Linux 
> does not stop the regular function of start-stop-daemon.
 
 ..o*??  ah, cool, that's very smart, i wasn't expecting that.

 i learn something new every day :)

> >  in other words, the benefit in patching start-stop-daemon is to
> >  provide legacy transition support.
> 
> My systems have been working fine with a non-patched start-stop-daemon for two 
> years.  When I first started working on SE Linux I had a similar idea to 
> avoid the use of run_init, that turned out to be a bad idea and I've been 
> using the regular start-stop-daemon since then.
> 
> >  i _really_ don't want the -u option on my custom /etc/init.d/custom
> >  script to suddenly start running the daemon as root.
> 
> Why not?
 
 ignore all the rest of my comments: they were based on the assumption
 that initrc_t would not allow setuid or setgid.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
