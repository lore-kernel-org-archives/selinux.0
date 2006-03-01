Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k21M0iaL026389
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 17:00:44 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k21LxD1o004961
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 21:59:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 2F543C4C084
	for <selinux@tycho.nsa.gov>; Wed,  1 Mar 2006 23:00:42 +0100 (CET)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 16812-01 for <selinux@tycho.nsa.gov>;
	Wed, 1 Mar 2006 23:00:40 +0100 (CET)
Received: from wintermute.xmldesign.de (p549A4023.dip0.t-ipconnect.de [84.154.64.35])
	by legolas.drinsama.de (Postfix) with ESMTP id BA570C4C083
	for <selinux@tycho.nsa.gov>; Wed,  1 Mar 2006 23:00:40 +0100 (CET)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id C729123439F
	for <selinux@tycho.nsa.gov>; Wed,  1 Mar 2006 23:00:42 +0100 (CET)
Subject: Re: FYI SELinux/AppArmor press
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>
References: <43FF7418.90205@redhat.com>
	 <1141138934.29803.2.camel@wintermute.xmldesign.de>
	 <1141183226.8475.22.camel@localhost.localdomain>
	 <1141222338.2834.33.camel@wintermute.xmldesign.de>
	 <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 23:00:41 +0100
Message-Id: <1141250441.2834.62.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Benjy,
> How do these new IDEs that Tresys put out in the last week or so fit
> into the picture?  Haven't used them, but they appear to be the start
> of a higher-level approach to developing policy and perhaps more
> intuitive.  I'm talking about SLIDE (SELinux policy IDE) and the CDS
> framework IDE tool. 

They replace vim, if you are developing your policy on a system with
eclipse installed...

SLIDE IMHO does not address the issues with the policy language, but it
just tries to make it a little bit less painful, by basically giving you
tab completion, reference (like the website did) and a couple of
templates (like policygentool did). So it likely is a nice tool for
people who _already_ know how to write policy by heart.

Have a look for example at
http://selinux-ide.sourceforge.net/images/screenshots/completion.png
well, it's nice syntax highlighting, and you have a dropdown to select
the macros. But that doesn't really help you finding the appropriate
macros, or explain what ever "generic files in library directories"
might be. Or help you finding out whether you might need it.
There are approximately 1600 interfaces, not counting the generated
network port and interface macros. Even given the hierarchy represented
by {admin,services,...} and convetions like files_ etc. names this is
probably more than most people can handle.

I can't say much about CDS: the website gives so few details, you can
barely tell what it is _meant_ to be, not to say what it's capable of. I
just don't have the time to download the sourcecode and try it. The
screenshot appears pretty at first sight, but there is nothing on it how
this interfaces with other parts of the system and other services -
which is exactly where it gets messy and complicated... Stuff like
allowing DNS usage, access to locales. Using the perl interpreter, or
python. Reading /etc/resolv.conf. Some of this has matching interfaces
already, some has not.
I guess you could even autodetect some of these things. A smart
policygen tool should be able to detect whether it needs
perl/python/java/mono, maybe locales, maybe you could just grep for
"ifconfig" in the binary, too...

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
      To be trusted is a greater complement than to be loved.       //\
   Mathematik: Das Alphabet, mit dessen Hilfe Gott das Universum    V_/_
                beschrieben hat. --- Galileo Galilei


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
