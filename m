Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25643
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 15:08:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA19705
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 19:07:08 GMT
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
        by jazzband.ncsc.mil  with SMTP id TAA19701 for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 19:07:08 GMT
Date: Mon, 20 May 2002 21:07:54 +0200 (MEST)
From: Ian Sollars <ian.sollars@gmx.net>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Policy creation RFC
Message-ID: <4934.1021921674@www51.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there.

I've been lurking on the list for a while. One of the things that's
come up a couple of times is the need for some way to make creating
and editing policies easier than it is at present.

I'd be interested in hearing if anyone has ideas about what this
would look like, or comments on what sort of tool could make policy
creation easier. There was a mention of a "meta policy configuration
description" language (I think) here:

http://marc.theaimsgroup.com/?l=selinux&m=101713295918487

Some comments on policy creation here:

http://marc.theaimsgroup.com/?l=selinux&m=101426994210338

In addition to that, I have a couple of questions.

Firstly, is there any need for something allowing policy creation at
a more abstract level? At what level or levels should a hypothetical
application operate at?

For example, a point-and-click GUI is probably overkill considering
the likely user base of selinux - i.e. security experts, sysadmins,
and hobbyists.

Secondly, assuming some sort of tool can be written, how should it
behave in relation to the use of the m4 macro language?

On one hand, reading and writing to all.te is simpler than developing
yacc (or equivalent) files for parsing m4, and yet there is the
question of how human-readable a resulting policy would be. all.te is
clearly not the preferred place at which to write policies using a
text editor...

Comments appreciated.

Ian

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
