Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EbbrT012792
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:37:37 -0400 (EDT)
Date: Mon, 2 Aug 2004 15:48:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: hacked Makefile to use 17 instead of 18
Message-ID: <20040802144840.GE4194@lkcl.net>
References: <20040731122835.GO3378@lkcl.net> <1091449694.23449.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091449694.23449.10.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 08:35:05AM -0400, Stephen Smalley wrote:
> On Sat, 2004-07-31 at 08:28, Luke Kenneth Casson Leighton wrote:
> > well, i'm about to find out if it's okay, but i hacked the 1.14-1
> > Makefile to forcibly put policy file of type 18 into a file named
> > policy.17.
> 
> Policy version number is put into the header of the binary policy as
> well, and the kernel will reject a version it doesn't support (for good
> reason).  Build with checkpolicy -c 17 if you want to generate
> policy.17.

 rats!  could have done with that tidbit at the w/e ah well i will
 know for next time, 2.6.8 or 9 or so.

 ta stephen.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
