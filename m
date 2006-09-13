Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DJGIw3007204
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 15:16:18 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DJFpPt003250
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 19:15:52 GMT
Subject: Re: Moving xconsole from xserver to logging policy
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1158167487.26420.75.camel@sgc.columbia.tresys.com>
References: <1158162208.1594.37.camel@wintermute.xmldesign.de>
	 <1158164561.26420.72.camel@sgc.columbia.tresys.com>
	 <1158166443.1594.51.camel@wintermute.xmldesign.de>
	 <1158167487.26420.75.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 21:16:12 +0200
Message-Id: <1158174972.1594.61.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Christopher,
> I've seen it used for redirecting the stdout/err of programs started by
> the window manager.  I think you can do that instead of
> ~/.xsession-errors.

Not in strict, I guess... and you don't need a pipe in /dev for that,
nor do you need to run xconsole to access /dev/xconsole. Just run
xconsole -file ~/.xconsole and you won't need any extra information for
that...
So that use is actually an abuse of /dev/xconsole IMHO.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Nothing prevents happiness like the memory of happiness. --- A. Gide //\
     Mathematik: Das Alphabet, mit dessen Hilfe Gott das Universum    V_/_
                 beschrieben hat. --- Galileo Galilei


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
