Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5L7JIi003206
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:07:19 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5L60gk015857
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 21:06:00 GMT
Subject: Re: patch: add assert statement for syslog
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041101102345.GA3377@jmh.mhn.de>
References: <20041101102345.GA3377@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1099689004.16488.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 16:10:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-11-01 at 05:24, Thomas Bleher wrote:
> The following patch adds an assertion so that only domains with the
> "privlog"-attribute can actually syslog.
> 
> Please apply.
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
