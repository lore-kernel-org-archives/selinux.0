Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j31KSRDo015114
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 15:28:27 -0500 (EST)
Subject: Re: Policy Patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <42498685.8000109@redhat.com>
References: <41E57081.4090500@redhat.com>
	 <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
	 <42498685.8000109@redhat.com>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 15:28:10 -0500
Message-Id: <1112387290.9437.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2005-03-29 at 11:47 -0500, Daniel J Walsh wrote:
> Major cleanup of Makefile.  Probably still needs some sanity checks to 
> it.  Added better echo messages, made sure
> customizable file gets replaced on make load.
> 
> Added policy ssh_keysign_exec_t for /usr/libexec/openssh/ssh-keysign
> 
> Better handling of syslog-ng
> 
> Whole bunch of changes from Ivan, for desktop apps.
> 
> Allow named and nscd to write logs to /var/log
> 
> Lots of name_connect fixes.
> 
> New bool for squid to connect to any port or just http ports.


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
