Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76E6PrT012195
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:06:25 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76E6OO0022849
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:06:24 GMT
Subject: RE: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1091800968.8590.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 10:02:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 14:53, Stephen Smalley wrote:
> As a minor issue, we should also reconsider the names of the boolean
> utilities, as they are too generic and could easily conflict in the
> future with other non-SELinux programs.  Also, Chris PeBenito posted a
> toggle_bool utility a while back that would likely be useful to add.

change_bool -> change_sebool
show_bools -> show_sebools
toggle_bool -> toggle_sebool

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
