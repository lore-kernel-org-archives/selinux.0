Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76ELSrT012317
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:21:28 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76ELNO0023464
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:21:23 GMT
Message-ID: <411393AB.6020305@tresys.com>
Date: Fri, 06 Aug 2004 10:20:27 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil> <1091800968.8590.39.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091800968.8590.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2004-08-02 at 14:53, Stephen Smalley wrote:
> 
>>As a minor issue, we should also reconsider the names of the boolean
>>utilities, as they are too generic and could easily conflict in the
>>future with other non-SELinux programs.  Also, Chris PeBenito posted a
>>toggle_bool utility a while back that would likely be useful to add.
> 
> 
> change_bool -> change_sebool
> show_bools -> show_sebools
> toggle_bool -> toggle_sebool
> 

If they are going to be changed they should probably also be changed to 
match the get/set convention used by most other selinux apps.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
