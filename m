Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1OJBlDo008625
	for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2005 14:11:47 -0500 (EST)
Subject: Re: [Fwd: New policy patch]
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <42152431.5010605@redhat.com>
References: <41E57081.4090500@redhat.com>
	 <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
	 <42152431.5010605@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 14:10:45 -0500
Message-Id: <1109272245.10685.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.
On Thu, 2005-02-17 at 18:09 -0500, Daniel J Walsh wrote:
> Ivan did a few more cleanups in x_client_macros and access_terminals.
>     Added a couple of ioctls back in.
> 
> Had to add back in a dontaudit for net_admin on cups.
> 
> Allow dovecot to search certs dir
> 
> Fixes for allow squirrelmail to spell check
> 
> Privoxy needs to run as a client as well as a server
> 
> 
> plain text document attachment (policy-20050217.patch)

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
