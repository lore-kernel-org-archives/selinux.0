Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA24096
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 18:37:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA11734
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 23:37:09 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA11730
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 23:37:08 GMT
From: "LA Walsh" <law@sgi.com>
To: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Date: Fri, 12 Jan 2001 15:36:08 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHKEBFCKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200101122302.RAA01350@tomcat.admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

>
> Not unless every possible process suddenly becomes the
> "transition program".
> The key here is that the user could just be running "more". If the user
> has no restrictions, then it works. Once the user HAS done more on the
> file, then restrictions may be imposed on the next file (depending on the
> conflict).
---
	True -- what you are talking about is 'floating' labels', where
as in 'POSIX' Information labels.  In a conforming implementation a subject
with label "inf1" that reads an object that has "inf2" gets relabeled
with the output of "float(inf1,inf2) and any written object gets the label
of the process.

	Using the output of the information labels to automatically
modify or add to 'mac_labels', would be an implementation-detail not
covered by the POSIX spec.

	Can have unintended consequences if someone who has read 'defense-A'
"su's" to root and writes /etc/passwd.  But you get the idea -- a lawyer
on "A" couldn't be a sysadmin.  The configuration would be an implementation
detail, but seems "doable".

>
> There is no need to run a special program before gaining access. No
> intervention by the security manager other than defining the
> conflict matrix
> in the first place.
---
	Right.  The 'information label' part of the posix spec was defined
to keep track of information flow.

>
> A practical chinese wall has more complications too. A conflict is usually
> specified in a contract ("propriatary information not to be divulged for
> 5 years" type of thing). This means that the conflict exists, but only
> for the time interval since it was last imposed (most likely based on the
> modification date of the file?). After the time interval, the conflict
> is resolved, and the restriction removed. Even if the file is destroyed,
> the conflict still remains.
>
> Existing lattice models have no structure to handle time, they all expect
> the state to last forever.
---
	A pure chinese wall model doesn't have the notion of time either.

> This would help with the automatic downgrading
> of sensitive data, if the data could be labled with time as well as
> compartment/level ("not for release until after xxx hours...). These
> transitions currently require intervention by the security administrator,
> and the author (if available - he may have died... now the data may never
> get downgraded).
----
	Well that may be the point.  Different requirements.  Most governments
would probably avoid systems that automatically declassified material
w/o human intervention at the time of the declassification.  The original
author cannot know how long the information should remain restricted --
especially if the time interval is after the author's death.  The author
may not be authorized to declassify their data in the future as well as
the present.


>
> The "transitions" file has no means of detecting when enforcement must
> take place. It has to be applied manually, and can't be done automatically
> since the security monitor for lattice structured systems cannot interpret
> it.
----
	Either the file is has a 'fixed' MAC label, or you can allow part
of the MAC label to float àla information labels.  The difference is whether
or not the user is "warned" and has to explicity change state or if they
are just automatically reclassified.  Personally, I think of the former
as more 'useful'.  I'd like to know that I'm entering down a one-way path
before I've done so.


> I would also imagine that they may be slower for really complex structures
> too... perhaps we are seeing an analogue to the CISC/RISC cpu
> archetectures
> from 10 years ago? Both were right, and both were wrong (and
> depended on the
> application....)
----
	Probably a very valid point.
-l


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
