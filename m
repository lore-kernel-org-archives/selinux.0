Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r486ijkC015715
	for <selinux@tycho.nsa.gov>; Wed, 8 May 2013 02:44:45 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so1650753iag.28
        for <selinux@tycho.nsa.gov>; Tue, 07 May 2013 23:44:43 -0700 (PDT)
Date: Wed, 8 May 2013 06:44:07 +0000
From: Michael Seyfert <michael@codesand.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Current Makefile system is inconvenient/limited
Message-ID: <5189f45a.251c320a.570e.63cc@mx.google.com>
References: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
 <5187D755.2020001@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5187D755.2020001@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On 05/01/2013 08:14 AM, Michael Seyfert wrote:
> > The current system for building selinux requires a lot of workarounds like
> > C_INCLUDE_PATH and is also interdependent on setools. I was looking at the
> > debian packages and they require two build throughs of selinux just to get
> > things to compile properly. Am I the only one that thinks this is a
> > problem?
> > 
> Patches Welcomed.
> 
> I don't think anyone loves it, but most people do not hate it enough to fix it...

I'm switching selinux (not tools yet) over to SCons for my personal use and to learn
more about the code. I suppose I could upload my (incomplete) patch for
you guys to look at if you want.

-- 
Michael Seyfert

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
