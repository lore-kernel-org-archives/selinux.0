Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95J8KrT028997
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 15:08:20 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95J7CPe014716
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 19:07:12 GMT
Subject: Re: ssh_macros diff
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1096771573.7227.5.camel@chris.pebenito.net>
References: <1096771573.7227.5.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1097003237.30738.37.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 15:07:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sat, 2004-10-02 at 22:46, Chris PeBenito wrote:
> Heres a patch that moves the ifdef ssh-agent block out of the ifdef
> xdm.te block, since ssh-agent doesn't require X.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
