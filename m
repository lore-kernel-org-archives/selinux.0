Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04596
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 10:12:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA12296
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 15:12:13 GMT
Received: from my.snu.edu (gw.SNU.EDU [204.126.2.27])
	by jazzband.ncsc.mil  with SMTP id PAA12291
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 15:12:13 GMT
Message-Id: <sac2fc61.090@my.snu.edu>
Date: Thu, 29 Mar 2001 09:11:46 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <william.r.kutz@lmco.com>, <selinux@tycho.nsa.gov>
Subject: Re: A New Virus
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me that for this virus to be able to infect linux executables from within windows you must have a umsdos partition. What if you have an ext2 partition and are dual booting? I don't think this virus could affect you. It's really sad that this virus is claimed to be the only windows/linux virus, I wouldn't really call it much of a linux virus since the only way it circumvents filesystem permissions and access controls is to run from within windows. 


Joshua Brindle
UNIX Administrator
SNU

>>> "Kutz, William R" <william.r.kutz@lmco.com> 03/29/01 07:13AM >>>
There are reports of a new virus that infects both Windows and Linux
platforms: 
http://dailynews.yahoo.com/h/nm/20010327/wr/virus_winux_dc_1.html 

As the popularity of Linux grows, this will become more of the norm, and it
would be interesting to know if a standard configuration of selinux is more
capable of withstanding & controlling the infection and subsequent
propagation of the virus. Real world examples like this can go a long way
toward demonstrating the value of the security features prominent in systems
like selinux.

Keep up the good work; I think this is a call that we clearly need more
contributions like that provided by the team at NSA.

Bill
 

Bill Kutz

M&DS Lockheed Martin
william.r.kutz@lmco.com 
610-354-7149



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
