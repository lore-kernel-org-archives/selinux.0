Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QKR0q8020983
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 15:27:00 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0QKRxaF009596
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 20:27:59 GMT
Subject: Re: [redhat-lspp] Problem SSH-ing into LSPP system with multiple
	categories
From: Tomas Mraz <tmraz@redhat.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: dwalsh@redhat.com, redhat-lspp@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1169842300.6956.129.camel@localhost.localdomain>
References: <1169842300.6956.129.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 21:27:54 +0100
Message-Id: <1169843274.3194.10.camel@perun.kabelta.loc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-26 at 12:11 -0800, Kylene Jo Hall wrote:
> I have been unable to ssh into an LSPP system with multiple categories.
> 
> For example the following work:
> ssh testuser/user_r/s2@localhost
> ssh testuser/user_r/s2:c0@localhost
> ssh testuser/user_r/s2:c1@localhost
> 
> But these do not:
> ssh testuser/user_r/s2:c0.c1@localhost
> ssh testuser/user_r/s2:c0,c1@localhost
> 
> Policy version: selinux-policy-mls-2.4.6-28.el5
> Kernel version: kernel-2.6.18-1.3015.2.1.el5.lspp.63
> 
> We have tested this on multiple architectures to no avail.  Any
> suggestions?
Could you modify LogLevel in /etc/ssh/sshd_config to DEBUG3 and look
into the /var/log/secure what messages are there when the login fails?

-- 
Tomas Mraz
No matter how far down the wrong road you've gone, turn back.
                                              Turkish proverb


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
