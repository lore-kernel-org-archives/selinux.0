Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25899
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 15:50:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA21847
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 19:48:50 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id TAA21843 for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 19:48:45 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524384@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Ian Sollars'" <ian.sollars@gmx.net>, selinux@tycho.nsa.gov
Subject: RE: Policy creation RFC
Date: Mon, 20 May 2002 14:50:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

on Monday, May 20, 2002 2:08 PM, Ian Sollars wrote:
> 
> I've been lurking on the list for a while. One of the things that's
> come up a couple of times is the need for some way to make creating
> and editing policies easier than it is at present.
> 
> For example, a point-and-click GUI is probably overkill considering
> the likely user base of selinux - i.e. security experts, sysadmins,
> and hobbyists.

I have been using creating rule for SELinux since about the start of 
the SELinux release. I truly would not mind a GUI. One of the critical
area that is needed is a Policy Management System. A way for people to
create and distribute policies better. I post a perl script that was
a start to see if it would draw any insterest in the list. It did not.
I would like very much to be able to insert a policy into the system
using just one file. 



> Secondly, assuming some sort of tool can be written, how should it
> behave in relation to the use of the m4 macro language?
> 
> On one hand, reading and writing to all.te is simpler than developing
> yacc (or equivalent) files for parsing m4, and yet there is the
> question of how human-readable a resulting policy would be. all.te is
> clearly not the preferred place at which to write policies using a
> text editor...
> 
Use the m4. Once you start using the all.te then you are not longer
able the use the m4 system, the m4 system will overwrite the all.te.



> Comments appreciated.
> 
> Ian
> 
> -- 
> GMX - Die Kommunikationsplattform im Internet.
> http://www.gmx.net
> 
> 
> --
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
