Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75F5CRX025196
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 11:05:12 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m75F550u009546
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 15:05:05 GMT
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 05 Aug 2008 17:05:10 +0200
From: "Dennis Wronka" <linuxweb@gmx.net>
In-Reply-To: <1217947735.2994.88.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <20080805150510.243300@gmx.net>
MIME-Version: 1.0
References: <200808052155.18105.linuxweb@gmx.net>	
 <cadfc0e40808050717j6a042fedle997df133400456@mail.gmail.com>	
 <200808052232.03624.linuxweb@gmx.net>
 <1217947735.2994.88.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: Question about newrole
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


-------- Original-Nachricht --------
> Datum: Tue, 05 Aug 2008 10:48:55 -0400
> Von: Stephen Smalley <sds@tycho.nsa.gov>
> An: Dennis Wronka <linuxweb@gmx.net>
> CC: Xavier Toth <txtoth@gmail.com>, SELinux Mailing List <selinux@tycho.nsa.gov>
> Betreff: Re: Question about newrole

> 
> On Tue, 2008-08-05 at 22:32 +0800, Dennis Wronka wrote:
> > Thanks.
> > That seems to help quite a bit.
> > I now get some messages. For example it seems that newrole wants to 
> > read /etc/shadow directly.
> > Will check those messages and play around with the policy.
> 
> The way it works is that pam_unix attempts to open /etc/shadow directly
> for reading, and if it fails, it falls back to running unix_chkpwd to
> perform the password check.  SELinux policy prohibits most programs from
> directly reading /etc/shadow, including even ones that run as root, and
> forces them to go through unix_chkpwd instead, in order to limit the set
> of processes that have full read access to the shadow password file.
> 
> The logic to try to open /etc/shadow and fall back to unix_chkpwd
> already existed before SELinux in order to support non-root processes
> re-authenticating the current user.  What changed with SELinux was that
> it could also happen for root processes.
> 
> The current policy dontaudit's the attempt to directly read /etc/shadow
> to avoid noise.  When you did semodule -DB, you turned on that auditing.
> But those denials are what is expected, and allowing them will mean
> giving newrole direct read access to /etc/shadow (although that will
> only work if running as root, of course, as otherwise it has to use a
> suid helper like unix_chkpwd anyway).
> 
> Does newrole work for you as a non-root user?
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

Also running newrole as regular user (running as staff_u:staff_r:staff_t, trying to transition to sysadm_r) gets me the same message, just with dennis as username.

I also tried setting unix_chkpwd set-uid root already, but even that didn't help.

I'll turn on the audit-messages again and see if there's anything that maybe shows that unix_chkpwd is not allowed to read shadow.
-- 
GMX Kostenlose Spiele: Einfach online spielen und Spaﬂ haben mit Pastry Passion!
http://games.entertainment.gmx.net/de/entertainment/games/free/puzzle/6169196

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
