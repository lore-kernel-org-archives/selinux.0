Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2LJcvDo009073
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2005 14:38:57 -0500 (EST)
Subject: Re: latest diff
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <423BCC68.3090003@redhat.com>
References: <423BCC68.3090003@redhat.com>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 14:40:40 -0500
Message-Id: <1111434040.3178.20.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sat, 2005-03-19 at 01:53 -0500, Daniel J Walsh wrote:
> Several Ivan Cleanups of x_client_macro, tvtime,  mozilla, mplayer
> 
> Some cleanup of the dovecot policy, adding keys
> 
> I think we can remove the hostname policy, it adds little value.  I 
> added don't audit sys_admin to dhcpc
> which is triggered by hostname being run by dhcp.  Code seems to work 
> without allowing this privs.  I
> think it would work fine without hostname policy.  I think we could 
> probably get rid of consoletype also.
> 
> Moved arpwatch out of mta.te
> 
> Add syslogng support to syslog.te
> 
> Dan

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
