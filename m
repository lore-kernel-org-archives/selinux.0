Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JFvJL2031625
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 11:57:19 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JFvI3K019306
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 15:57:18 GMT
Subject: Re: New policy for consolekit.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E5A6C9.40107@redhat.com>
References: <45E5A6C9.40107@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 15:57:49 +0000
Message-Id: <1174319870.29664.60.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 10:59 -0500, Daniel J Walsh wrote:
> This is a new policy for the User Switching capability coming in gnome.
> 
> consolekit is a daemon that communicates with xdm_t and hal through dbus 
> to change the
> ownership/access on certain devices when the login session changes from 
> one user to another.

I'm going to merge this with some organization fixes, but can you
doublecheck to see if this works with term_dontaudit_use_console()
instead of allowing the console access?  This goes back to if it will
work with denying init_t:fd use.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
