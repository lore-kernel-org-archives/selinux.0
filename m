Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94FmkrT018681
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 11:48:46 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94Fmks6016051
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 15:48:46 GMT
Subject: Re: BUG: looks like net contexts is being ignored
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040926214625.GK28076@lkcl.net>
References: <20040926214625.GK28076@lkcl.net>
Content-Type: text/plain
Message-Id: <1096904763.32008.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 11:46:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-09-26 at 17:46, Luke Kenneth Casson Leighton wrote:
> i'm using cvs linux2.6 from 2 weeks ago.
> latest cvs policy, tools and libs selinux-usr.
> 
> the bug is that any tcp or udp port access by any program appears to be
> attempted as reserved_port_t.

Using the latest checkpolicy from cvs?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
