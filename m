Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76FVKrT012875
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 11:31:20 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76FVJO0026133
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 15:31:19 GMT
Subject: Re: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   Russell Coker <russell@coker.com.au>, selinux-dev@tresys.com
In-Reply-To: <411397C9.2010606@redhat.com>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091800968.8590.39.camel@moss-spartans.epoch.ncsc.mil>
	 <411393AB.6020305@tresys.com>
	 <1091802482.8590.62.camel@moss-spartans.epoch.ncsc.mil>
	 <411397C9.2010606@redhat.com>
Content-Type: text/plain
Message-Id: <1091806214.8590.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 11:30:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-06 at 10:38, Daniel J Walsh wrote:
> show_bools should be getsebool -a.

Ok, committed.

show_bools -> getsebool -a or getsebool boolean...
change_bool -> setsebool
toggle_bool -> togglesebool

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
