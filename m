Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9OMJhXZ029307
	for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2004 18:19:44 -0400 (EDT)
Received: from hero.office.dclabs.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9OMJeZJ019038
	for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2004 22:19:43 GMT
Date: Mon, 25 Oct 2004 08:19:30 +1000
From: Rene Cunningham <rene@dclabs.com.au>
To: ryan.graham+cr@gmail.com
Cc: selinux@tycho.nsa.gov
Subject: Re: login as sysadm_r remotely
Message-ID: <20041024221930.GY8603@eden.office.dclabs.com.au>
References: <20041023112327.GW8603@eden.office.dclabs.com.au> <42efd06904102412571e81d4e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42efd06904102412571e81d4e1@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 24, 2004 at 12:57:58PM -0700, Ryan Graham wrote:
> I think they built a toggle for this into tunable.te. At least it is
> there in whatever version I am running on fedora.

Yes, i did see that option. tunables/tunable.te has the following

define(`ssh_sysadm_login')

Enabling that still doesnt allow me to login as sysadm_r via ssh. I also
tried setting the boolean option ssh_sysadm_login

# setsebool ssh_sysadm_login true
error setting boolean ssh_sysadm_login to value 1

# getsebool ssh_sysadm_login
Error getting active value for ssh_sysadm_login

-- 

Rene Cunningham
DCLabs Pty Ltd
http://www.dclabs.com.au
----------------------------------------
"Don't fear the pen. When in doubt, draw a pretty picture." 
   --Baker's Third Law of Design.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
