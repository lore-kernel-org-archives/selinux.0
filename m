Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKIUoIi016173
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 13:30:52 -0500 (EST)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKIUheP023504
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 18:30:52 GMT
Message-ID: <41C727B1.4080709@tresys.com>
Date: Mon, 20 Dec 2004 14:27:45 -0500
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
Subject: Re: paranoid FC3 setup: banning all login access (!)
References: <20041220160039.GE24188@lkcl.net>
In-Reply-To: <20041220160039.GE24188@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:
> hi,
> 
> i have a requirement for setting up a server that might even ban
> logins - even admin logins.
> 
> the only things that should be allowed are reboot (ctrl-alt-delete at
> console) and services (e.g apache).
> 
> my question is, therefore: is it possible to _conveniently_
> load a completely different selinux policy file (by typing
> "linux init 3" or other incantation at the grub prompt)
> 
> what i want to be able to do is say to my customer "yes, in
> order to do upgrades and maintenance, you press ctrl-alt-delete,
> selection option 2) on the boot-loader menu, and you will be
> dropped into standard admin mode.  when you are done, reboot
> again and let it go back into 'paranoid' mode")
> 
> can anyone help advise?
> 

How about using a conditional expression (aka "boolean")?  That way you can 
have a whole chunk of plicy that gets turned on only when you need it 
(maintenance mode).  All of the types would always be defined, but the 
rules would only be active when the conditional expression/boolean is 
turned on/off.  That way you also don't run into the labeling insanity you 
might encounter with two distinct policies.

David

-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
