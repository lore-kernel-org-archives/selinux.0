Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9O7Jnam005281
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 03:19:49 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9O7J3on028815
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 07:19:04 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 5CD661D32A2
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 09:19:50 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 305C7598F
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 07:19:50 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02340-04 for <selinux@tycho.nsa.gov>;
 Tue, 24 Oct 2006 09:19:49 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id B860658B0
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 09:19:49 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: vserver and vprocunhide
Date: Tue, 24 Oct 2006 09:19:46 +0200
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de> <1161625986.3316.108.camel@moss-spartans.epoch.ncsc.mil> <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
In-Reply-To: <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
MIME-Version: 1.0
Message-Id: <200610240919.46906.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Is the process running as
> > root? 
>
> After execute "ps aux | grep bus" I see the next:
>
> dbus     21879  0.0  0.3 10508  768 ?        Ssl  Oct23   0:00
> dbus-daemon-1 --system
>
> so it is not running within a vserver, has its own process;
> And appear dbus instead of root, must be root?

I forgot to write -Z (--context), after "ps auxZ | grep bus", I see this:

root:system_r:dbusd_t           dbus     21879  0.0  0.3 10508  968 ?        
Ssl  Oct23   0:00 dbus-daemon-1 --system

So runs as root.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
