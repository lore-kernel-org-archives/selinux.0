Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB4CGVRb026988
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 07:16:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB4CFplU013192
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 12:15:51 GMT
Received: from mail3.utc.com (mail3.utc.com [192.249.46.81])
	by jazzswing.ncsc.mil  with ESMTP id hB4CFpSX013189
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 12:15:51 GMT
Received: (from uucp@localhost)
	by mail3.utc.com (8.10.0/8.10.0) id hB4CGT702622
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 07:16:29 -0500 (EST)
Received: from ehposrv5.eh.pweh.com (ehposrv5.eh.pweh.com [191.29.78.93])
	by uusnwa0p.utc.com (Switch-2.2.8/Switch-2.2.8) with ESMTP id hB4CGPe13807
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 07:16:25 -0500 (EST)
Message-ID: <EE5290A8F55F0C4B943C5940B6D73C8B44248A@pusmde04.mt.pweh.com>
From: "Pisupati, Ajay" <ajay.pisupati@pw.utc.com>
To: selinux@tycho.nsa.gov
Subject: RE: Debian Servers
Date: Thu, 4 Dec 2003 07:16:36 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you Joerg.  That's pretty much what I figured.  just thought I would
confirm it.
ajay

-----Original Message-----
From: Joerg Hoh [mailto:joerg@devone.org]
Sent: Wednesday, December 03, 2003 2:56 PM
To: selinux@tycho.nsa.gov
Subject: Re: Debian Servers


On Wed, Dec 03, 2003 at 02:01:28PM -0500, Pisupati, Ajay wrote:
> Hi,
> 	
> This is a general question for anyone who is interested in answering me.
I
> was reading the whole report that the Debian security team put out
yesterday
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
....Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
