Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EajrT012771
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:36:45 -0400 (EDT)
Date: Mon, 2 Aug 2004 15:47:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: lkm rootkitted, or issue with selinux 2.6.7 kernel?
Message-ID: <20040802144743.GD4194@lkcl.net>
References: <20040801124138.GA15205@lkcl.net> <1091452021.23449.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091452021.23449.31.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 09:07:02AM -0400, Stephen Smalley wrote:
> On Sun, 2004-08-01 at 08:41, Luke Kenneth Casson Leighton wrote:
> > hello, hello,
> > 
> > i have a slight situation with the fireflier and mysql packages:
> > their use results in chkrootkit's lkm (linux kernel module) test
> > showing a warning.
> > 
> > what i wondered was has anyone _else_ seen this issue, on debian/unstable,
> > with a 2.6.7 kernel.
> 
> I have no direct knowledge here, but I have seen discussions on various
> lists indicating that chkrootkit is buggy/racy at least with respect to
> Linux 2.6, yielding false positives.  
 
 ah.  *whew*.  thanks.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
