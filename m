Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJGIXZ010906
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:16:18 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJExMb021165
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:14:59 GMT
Subject: Re: screen patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041026120629.GC24672@rom.cip.ifi.lmu.de>
References: <20041026120629.GC24672@rom.cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1099077306.12321.88.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:15:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2004-10-26 at 08:06, Thomas Bleher wrote:
> The following patch allows users to start screen with some other program
> than the shell, e.g. "screen vim /some/file". The given command forms
> the first session inside of screen.
> 
> Please apply.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
