Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7J0vALC029782
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 20:57:13 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7J0utKr018992
	for <selinux@tycho.nsa.gov>; Sat, 19 Aug 2006 00:56:57 GMT
Subject: Re: refpoliy issues
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1155931146.14126.39.camel@sgc.columbia.tresys.com>
References: <1155863972.7443.36.camel@wintermute.xmldesign.de>
	 <1155910539.14126.17.camel@sgc.columbia.tresys.com>
	 <1155916251.14563.5.camel@wintermute.xmldesign.de>
	 <1155931146.14126.39.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Sat, 19 Aug 2006 02:48:04 +0200
Message-Id: <1155948484.14563.9.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Christopher,
> > How about /dev/*
> > sxid by nature tries to getattr all files there.
> 
> Still more specific.  The typically the only files in /dev are
> in /dev/.udev.  Or do you mean the device nodes and character nodes?

"In Unix, everything is a file".
Yes, I'm referring to the device and character nodes.
Heck, I'm not an sxid expert. In fact I havn't even _read_ an sxid
report yet.
It just sounded like a useful tool to me, and it gave me around 1 MB of
audit errors by doing getattr on /dev/*
If there are "real" files in there, it will getattr them, too. I bet it
getattrs /dev/MAKEDEV, too, and /dev/.udev
Its supposed to show you mysterious new device nodes being created, too!

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   It's not denial. I'm just selective about the reality I accept.   //\
       "Wissen ist Macht" - wenn man das richtige daraus macht.      V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
