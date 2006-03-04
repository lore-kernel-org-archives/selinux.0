Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k240vnX2020292
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 19:57:49 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k240uH8d006950
	for <selinux@tycho.nsa.gov>; Sat, 4 Mar 2006 00:56:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 714E2C4C084
	for <selinux@tycho.nsa.gov>; Sat,  4 Mar 2006 01:57:47 +0100 (CET)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 01683-04 for <selinux@tycho.nsa.gov>;
	Sat, 4 Mar 2006 01:57:46 +0100 (CET)
Received: from wintermute.xmldesign.de (p549A0455.dip0.t-ipconnect.de [84.154.4.85])
	by legolas.drinsama.de (Postfix) with ESMTP id 6FFDDC4C083
	for <selinux@tycho.nsa.gov>; Sat,  4 Mar 2006 01:57:46 +0100 (CET)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id BE0BD23439D
	for <selinux@tycho.nsa.gov>; Sat,  4 Mar 2006 01:57:49 +0100 (CET)
Subject: Re: Refpolicy: Small fix to make refpolicy compile with make from
	CVS
From: Erich Schubert <erich@debian.org>
To: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060221134958.GB7338@thorium.jmh.mhn.de>
References: <20060221134958.GB7338@thorium.jmh.mhn.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 04 Mar 2006 01:57:49 +0100
Message-Id: <1141433869.18820.52.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello SELinux list,
> With the make shipped with Debian and Ubuntu (and also the current CVS
> version) it is impossible to build the reference policy because make
> always complains about "make: Circular tmp/all_te_files.conf <-
> corenetwork.te dependency dropped." and produces incorrect output.

Note that with make 3.81.rc1 this sometimes even causes a segfault in
make.
Some more details in
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=354673
It looks very much like a make bug to me, a downgrade of make to 3.80
resolves these build issues. The proposed workaround by Thomas no longer
helped suddenly.
(It did help some time, but it seems there are quantity effects
involved, and by adding new modules, the error came back again... so
maybe the .SECONDARY target was just a success by chance...)

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   To understand recursion you first need to understand recursion.   //\
   Freund in der Not will nicht viel heißen; hilfreich möchte sich   V_/_
    mancher erweisen. Aber die neidlos dein Glück dir gönnen, die
        darfst du wahrlich Freunde nennen. --- Paul von Heyse



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
