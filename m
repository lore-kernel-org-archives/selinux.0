Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5L7nIi003249
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:07:49 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5L7qF9011079
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 21:07:52 GMT
Subject: Re: patch: arpwatch cleanup
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041102213312.GB3804@jmh.mhn.de>
References: <20041102213312.GB3804@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1099689038.16488.21.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 16:10:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2004-11-02 at 16:33, Thomas Bleher wrote:
> The following patch cleans up the arpwatch policy. It does not add any
> new permissions, it just organizes them more cleanly.
> It also adds /var/lib/arpwatch to the file_contexts file since this is 
> the place where both SuSE and Debian store arpwatch data.
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
