Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94GJgrT019003
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 12:19:42 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94GIYYE023779
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 16:18:34 GMT
Date: Mon, 4 Oct 2004 17:30:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: BUG: looks like net contexts is being ignored
Message-ID: <20041004163046.GK20930@lkcl.net>
References: <20040926214625.GK28076@lkcl.net> <1096904763.32008.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096904763.32008.51.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 04, 2004 at 11:46:04AM -0400, Stephen Smalley wrote:
> On Sun, 2004-09-26 at 17:46, Luke Kenneth Casson Leighton wrote:
> > i'm using cvs linux2.6 from 2 weeks ago.
> > latest cvs policy, tools and libs selinux-usr.
> > 
> > the bug is that any tcp or udp port access by any program appears to be
> > attempted as reserved_port_t.
> 
> Using the latest checkpolicy from cvs?
 
 as of last week at the time of writing, yes.  hi stephen, you're back
 then?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
