Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA29563
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 18:10:00 -0500 (EST)
From: jeffrey.denton@hua.army.mil
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA13904
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 23:09:26 GMT
Received: from atzs-imc-n1.army.mil ([138.27.99.12])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA13892
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 23:09:25 GMT
Message-ID: <CC720C381CD5D411A4860008C7A47EEB747326@HUADOIMC2I>
To: selinux@tycho.nsa.gov
Subject: RE: [selinux] subject prefix?
Date: Thu, 4 Jan 2001 15:53:30 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Pine can filter messages and move them to a new folder.  Main Menu -> Setup
-> Rules -> Filter -> Add, and then filter on the sender
"owner-selinux@tycho.nsa.gov".
--
dd if=/dev/random bs=1024 count=10 | \
mail -s "Green Cow" spook@nsa.gov

> -----Original Message-----
> From: Magosányi Árpád [mailto:mag@bunuel.tii.matav.hu]
> Sent: Sunday, December 31, 2000 6:30 AM
> To: selinux@tycho.nsa.gov
> Subject: Re: [selinux] subject prefix?
> 
> 
> A levelezõm azt hiszi, hogy Marc Heuse a következõeket írta:
> > 
> > sorry for an administrivia question:
> > 
> > would it be possible to add a sbject like "[SeLinux] " in 
> front of every
> > subject by the mailinglist software? I guess all people 
> here are on many
> > mailinglists and not all of them use procmail etc. to 
> automatically move
> > mails to folders so this would make threading and the 
> general mailbox
> > overview better.
> > 
> 
> my .procmailrc reads:
> 
> :0 cf
> * ^Sender:.*owner-selinux@tycho.nsa.gov
> |sed 's/^Subject:\(.*\)/Subject: [selinux]\1/'
> 
> -- 
> GNU GPL: csak tiszta forrásból
> You have received this message because you are subscribed to 
> the selinux list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
