Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJJlMIi023360
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 14:47:22 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJJlOlF016741
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 19:47:24 GMT
Subject: Re: gentoo diff for snmpd
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>, Chris PeBenito <pebenito@gentoo.org>
In-Reply-To: <419DF805.80002@gentoo.org>
References: <4198D752.2020405@gentoo.org>
	 <1100808061.26930.18.camel@moss-lions.epoch.ncsc.mil>
	 <419DF805.80002@gentoo.org>
Content-Type: text/plain
Message-Id: <1100893806.31793.29.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 14:50:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I put an "ifdef(`distro_gentoo'" around all of these rules and merged
them.


On Fri, 2004-11-19 at 08:41, petre rodan wrote:
> Hi James,
> 
> James Carter wrote:
> > Merged.
> > 
> > Oops, there is no proc_net_t defined.
> > Petre, could you send me the proc_net_t stuff as well.
> 
> please see the attachment.
> 
> > On Mon, 2004-11-15 at 11:20, petre rodan wrote:
> > 
> >>Hi,
> >>
> >>gentoo as a special context for /proc/net:
> >>genfscon proc /net  system_u:object_r:proc_net_t
> >>
> >>so a small diff is needed for the snmpd policy. attached.
> 
> bye,
> peter
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
