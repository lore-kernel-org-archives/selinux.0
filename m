Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3JrKRb023888
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 14:53:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB3JrJRV008020
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 19:53:19 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id hB3JrDta007987 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 19:53:18 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 38DAF1701DF
	for <selinux@tycho.nsa.gov>; Wed,  3 Dec 2003 21:03:56 +0100 (CET)
Date: Wed, 3 Dec 2003 20:56:04 +0100
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: Debian Servers
Message-ID: <20031203195604.GC3442@hydra.joerghoh.de>
References: <EE5290A8F55F0C4B943C5940B6D73C8B442483@pusmde04.mt.pweh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE5290A8F55F0C4B943C5940B6D73C8B442483@pusmde04.mt.pweh.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 03, 2003 at 02:01:28PM -0500, Pisupati, Ajay wrote:
> Hi,
> 	
> This is a general question for anyone who is interested in answering me.  I
> was reading the whole report that the Debian security team put out yesterday
> about how their servers were compromised.  
> Has anyone else read this?
> If so, here's my question:
> If these servers were running SELinux, how far would the cracker have
> gotten? 

He could exploit the kernel; if you have direct write access to kernel
structures you can do everything. 

> reason I ask is because he took advantage of an overflow condition in the
> Kernel itself and not some application running outside it.

In this case selinux can't help. Against direct kernel exploits you can
only fix the kernel.

Joerg

-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
