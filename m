Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9VEAkWt019025
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 09:10:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9VEAdKl012862
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:10:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9VEAd5m012859 for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:10:39 GMT
Subject: Re: successfull loaded policy on s390, 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031031085045.GA29900@wavehammer.waldi.eu.org>
References: <20031024210709.GA17189@wavehammer.waldi.eu.org>
	 <Pine.LNX.4.53.0310301830290.6332@rmt-desk.bmc.com>
	 <20031031085045.GA29900@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1067609436.30233.370.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 31 Oct 2003 09:10:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-31 at 03:50, Bastian Blank wrote:
> On Thu, Oct 30, 2003 at 06:30:43PM -0600, Richard Troth wrote:
> > > i'm pleased to announce the successfull load of a policy on a 64bit
> > > zSeries with 31bit userland.
> > This is great news!
> 
> I forgot to say, that it wav a 2.6.0-test8. -test9 lockups like shit so i
> can't do real testing. I hope IBM will provide patches for this problems
> rather fast.

And how different is your userland from the upstream at this point?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
