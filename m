Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA03611
	for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2002 06:17:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBUBHiI25319
	for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2002 11:17:44 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
        by jazzband.ncsc.mil  with ESMTP id gBUBHff25315 for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2002 11:17:41 GMT
Date: Mon, 30 Dec 2002 06:17:29 -0500
From: forrest whitcher <fw@fwsystems.com>
To: Ben Ritter <benritter@earthlink.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: Mandrake and Slackware Distros
Message-Id: <20021230061729.16f6d5fa.fw@fwsystems.com>
In-Reply-To: <CF725BE6-1A0C-11D7-9B43-003065AE1370@earthlink.net>
References: <CF725BE6-1A0C-11D7-9B43-003065AE1370@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I've been testing / using the selinux kernel on slackware-current (running 
in a VMware vm) with good results for 3 months now, and have also now 
installed lsm/selinux on a laptop.

I'll be installing a new server soon and will run on either slack or rh.
w/ selinux.

I haven't had time to put together my notes of what needs to be done on
slack. certainly you need to build / install PAM, if kerberos isn't 
installed then the ssh build needs to be patched and I think there was a 
problem with incude header files involving ncurses and a few other minor
issues, mostly predictable due to layout problems.

I've tried on more experimental linuxes and had very poor results however.

forrest

On Fri, 27 Dec 2002 18:33:55 -0800 (unchecked - local sync NTPstrat4)
Ben Ritter <benritter@earthlink.net> did inscribe thusly:

> Hey Group,
> I'm kinda new here, how secure are the current distributions of 
> Mandrake and Slackware linux?
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
