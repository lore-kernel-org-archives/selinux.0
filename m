Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FGJ9I4019180
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:19:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FGInl5014493
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 16:18:49 GMT
Received: from MOZART.PatioEnclosuresInc.com (mail.patioenclosuresinc.com [206.183.7.174])
	by jazzswing.ncsc.mil  with ESMTP id h4FGIjNc014490
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 16:18:47 GMT
Message-ID: <B4E788FBFCD6844F96A017F337797AE13B40A5@mozart.patioenclosuresinc.com>
From: "Rottura, Steven" <SRottura@patioenclosuresinc.com>
To: "'Dean Anderson'" <dean@av8.com>,
   Douglas Phillipson
	 <phillipd@oem.doe.gov>
Cc: selinux@tycho.nsa.gov
Subject: RE: Has anyone had or seen a SELinux system approved for classifi
	ed use?
Date: Thu, 15 May 2003 12:14:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Check out dod orange book re; 

http://www.radium.ncsc.mil/tpep/library/rainbow/5200.28-STD.html

&al

http://www.radium.ncsc.mil/tpep/library/rainbow/

-----Original Message-----
From: Dean Anderson [mailto:dean@av8.com]
Sent: Thursday, May 15, 2003 9:51 AM
To: Douglas Phillipson
Cc: selinux@tycho.nsa.gov
Subject: Re: Has anyone had or seen a SELinux system approved for
classified use?


Its been awhile, but when I was at OSF back in the late 80s, OSF/1 was
developed to be B1 certified. C2 only requires that physical access to the
"console" still require a password to boot, and that the case be lockable
to exclude undetected disassembly. On a PC, this is handled by the BIOS,
and most BIOS's handle this now.  Sun and most workstation vendors also
can protect the boot rom with a password.  Most PC and workstation
enclosures also have locks.  You can get a copy of the DOD orange book to
look up other requirements, but I think that was pretty much it.

Prior to working at OSF, I worked at Draper Labs, which handled classified
computing. This was still in the mainframe era, but at the early part of
the PC era. Prior to a classified computing run, the Mainframe was
isolated from the rest of the lab via scheduled downtime. I think the
isolation was physical disconnection of terminal controllers and network
controllers, but I'm not sure. I didn't work in that part of the computer
center.  Classified PC computing was done in secured labs, where the PC
had no outside connection, and personnel in the labs were cleared.  C2
security essentially just attempts to detect and deter some kinds of
inappropriate behavior by cleared personnel.

Linux is not a terribly secure operating system.  I don't present myself
as an expert, but I think it would be inadvisable to rely on linux to keep
any data secure in a multiuser classified/non-classified environment.
Perhaps the result of the SELinux project might be a B1 or B2
certification**, but its clearly not there yet.

**If I recall, B1 requires that OS privileges be split into different
roles, so that no one person can compromise the system undetected, and B2
requires mandatory access control. There are other requirements and
differences that I don't rememeber. Also as I recall, the pentagon kept
multics around for so long because it was the only certified B2 secure
system.  I'm not sure the multics system was replaced with another B2
system, or if they just set up completely separate classified and
unclassified networks, and partitioned classified networks accordingly.

		--Dean

On Wed, 14 May 2003, Douglas Phillipson wrote:

> This may be the wrong forum for this question and I apologize if thats
> the case.  I was wondering if anyone has or knows of any Linux
> systems/networks/OS versions that have been approved for processing
> classified data?  I work for the Dept Of Energy and am looking for a
> test case to model a security plan on, possibly using SELinux.
>
> I am also looking for "C2" software for Linux if anyone has seen it?
>
> Regards
>
> Doug Phillipson
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
