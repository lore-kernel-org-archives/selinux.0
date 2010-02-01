Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11KaJQJ016952
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 15:36:19 -0500
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o11KaMQt013269
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 20:36:23 GMT
Subject: Re: how to trace an avc denial
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <20100130213222.GO1639@myhost.felk.cvut.cz>
References: <1264873435.12042.15.camel@localhost>
	 <20100130213222.GO1639@myhost.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 21:36:14 +0100
Message-ID: <1265056574.4834.6.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sa, 2010-01-30 at 22:32 +0100, Michal Svoboda wrote:
[...]
> strace/ltrace should almost universally help, though sometimes you need
> extra privileges to maintain a ptrace() over process tree. When you're
> not starting from shell, strace the 'launcher' program, ie. the one that
> acts on the menu entry and/or hotkey you use to run it.
> 
> If the trace itself does not make the cause evident, it should at least
> help you narrow down the relevant parts of source code.

Yeah, I gave strace another shot and this time I got what I needed:

4513  getppid()                         = 1
4513  readlink("/proc/1/exe", 0xbf824ddc, 512) = -1 EACCES (Permission
denied)

A grep after getppid in the sources of pidgin showed me the line of
interest ;-)

Thanks Michal and Stephen for your suggestions.

cheers,
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
