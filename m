Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i525R2rT001625
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 01:27:02 -0400 (EDT)
Received: from imf24aec.mail.bellsouth.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i535QkeD019687
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 01:26:47 -0400 (EDT)
Message-ID: <40BD6515.2090802@bellsouth.net>
Date: Wed, 02 Jun 2004 01:26:45 -0400
From: Jim McCullough <jwmccull@bellsouth.net>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Russell Coker <russell@coker.com.au>, SE-Linux
 <selinux@tycho.nsa.gov>
Subject: Re: dpkg-reconfigure xserver-xfree86
References: <20040601122114.GI8312@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have noticed the same issue with woody on one build when using 
xf86config to build the config file for X. Same system also gave me 
errors out the wazzu with handling support for X11-forwarded sessions 
over ssh. Rerunning the postinst script usually fixes anything i decide 
to monkey around with and break. Plus checking iptables first to make 
sure I didnt add any ports that I shouldnt have.

Jim McCullough


Luke Kenneth Casson Leighton wrote:

>russell, hi,
>
>ah ha, you missed one :)
>
>i frequently use dpkg-reconfigure xserver-xfree86 to reconfig X.
>
>and of course a run_init /etc/init.d/kdm restart throws a wobbly
>because the /etc/X11/XF86Config-4 file is owned by
>root:sysadm_r:sysadm_t instead of system_u:...
>
>so!
>
>the setfiles trigger, /etc/dpkg/postinst.d/selinux, needs to
>be re-run after people use dpkg-reconfigure.
>
>[luke smiles widely - or more specifically, turns corners of
> mouth up and shows lots of teeth]
>
>  
>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
