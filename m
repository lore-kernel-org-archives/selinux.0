Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB59X1Rb003536
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 04:33:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB59WKlU029125
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 09:32:21 GMT
Received: from hotmail.com (bay1-dav46.bay1.hotmail.com [65.54.244.18])
	by jazzswing.ncsc.mil  with ESMTP id hB59WKSX029122
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 09:32:20 GMT
From: "Stephen" <mridion@hotmail.com>
To: <selinux@tycho.nsa.gov>
References: <EE5290A8F55F0C4B943C5940B6D73C8B442483@pusmde04.mt.pweh.com> <20031203195604.GC3442@hydra.joerghoh.de>
Subject: Re: Debian Servers
Date: Fri, 5 Dec 2003 20:21:46 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <BAY1-DAV46Zim80P5hl00003221@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Wouldn't you be able to restrict execute access to unconfigured files and
therefore the attacker couldnt launch the exploit code in the first place?

----- Original Message ----- 
From: "Joerg Hoh" <joerg@devone.org>
To: <selinux@tycho.nsa.gov>
Sent: Thursday, December 04, 2003 6:56 AM
Subject: Re: Debian Servers


> On Wed, Dec 03, 2003 at 02:01:28PM -0500, Pisupati, Ajay wrote:
> > Hi,
> >
> > This is a general question for anyone who is interested in answering me.
I
> > was reading the whole report that the Debian security team put out
yesterday
> > about how their servers were compromised.
> > Has anyone else read this?
> > If so, here's my question:
> > If these servers were running SELinux, how far would the cracker have
> > gotten?
>
> He could exploit the kernel; if you have direct write access to kernel
> structures you can do everything.
>
> > reason I ask is because he took advantage of an overflow condition in
the
> > Kernel itself and not some application running outside it.
>
> In this case selinux can't help. Against direct kernel exploits you can
> only fix the kernel.
>
> Joerg
>
> -- 
> ...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
> man updated, mplayer hat mit Sicherheit dependencies drauf.
>   Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
