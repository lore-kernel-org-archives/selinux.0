Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72CZjrT011542
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:35:46 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72CZiKV008669
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 12:35:44 GMT
Subject: Re: hacked Makefile to use 17 instead of 18
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040731122835.GO3378@lkcl.net>
References: <20040731122835.GO3378@lkcl.net>
Content-Type: text/plain
Message-Id: <1091449694.23449.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 08:35:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-07-31 at 08:28, Luke Kenneth Casson Leighton wrote:
> well, i'm about to find out if it's okay, but i hacked the 1.14-1
> Makefile to forcibly put policy file of type 18 into a file named
> policy.17.

Policy version number is put into the header of the binary policy as
well, and the kernel will reject a version it doesn't support (for good
reason).  Build with checkpolicy -c 17 if you want to generate
policy.17.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
