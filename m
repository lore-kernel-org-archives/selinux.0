Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAMDKQIi004474
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 08:20:27 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAMDKTCv009395
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 13:20:30 GMT
Subject: Re: gentoo diff for snmpd
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: petre rodan <kaiowas@gentoo.org>, SELinux <selinux@tycho.nsa.gov>,
   Chris PeBenito <pebenito@gentoo.org>
In-Reply-To: <41A022C6.8050100@redhat.com>
References: <4198D752.2020405@gentoo.org>
	 <1100808061.26930.18.camel@moss-lions.epoch.ncsc.mil>
	 <419DF805.80002@gentoo.org>
	 <1100893806.31793.29.camel@moss-lions.epoch.ncsc.mil>
	 <41A022C6.8050100@redhat.com>
Content-Type: text/plain
Message-Id: <1101129762.3264.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 22 Nov 2004 08:22:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-11-21 at 00:08, Daniel J Walsh wrote:
> James Carter wrote:
> 
> >I put an "ifdef(`distro_gentoo'" around all of these rules and merged
> >them.
> >
> >  
> >
> Are you sure the proc_net changes are specific to gentoo?

I don't see why it couldn't be used in the other distributions.  
I guess I put the ifdef's in because I knew only Gentoo was using it.  I
don't have a problem with the ifdef's being removed.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
