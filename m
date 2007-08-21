Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LIuvIi016324
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 14:56:57 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LIuuYx020277
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 18:56:57 GMT
Subject: Re: [refpolicy] debian changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <0485FDE6-7668-4C52-B2FA-ED14C9748F11@sf-net.com>
References: <0485FDE6-7668-4C52-B2FA-ED14C9748F11@sf-net.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 14:56:04 -0400
Message-Id: <1187722564.13874.40.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-08-11 at 05:27 -0400, Stefan Schulze Frielinghaus wrote:
> Under Debian the file /etc/motd is only a symlink to /var/run/motd 
> which is labelled as var_run_t. OpenSSH etc. needs to read this file. 
> Attached is a patch which labels this file under Debian correctly.

Merged.

> Also ssh generates an avc message:
> 
> dmesg | audit2allow
> allow sshd_t var_lib_t:dir search;
> 
> But everything works fine in enforcement mode. So my question is 
> should we dontaudit this one or should we allow it (it's only a 
> search permission on var_lib_t which shouldn't be to dangerous). This 
> regards to Debian too.

If being denied doesn't affect it negatively, then might as well
dontaudit it.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
