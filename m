Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA24015
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 18:02:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA24957
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 23:00:51 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA24952
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 23:00:51 GMT
Date: Fri, 12 Jan 2001 17:02:13 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101122302.RAA01350@tomcat.admin.navo.hpc.mil>
To: law@sgi.com, "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>,
        "Stephen Smalley" <sds@tislabs.com>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

---------  Received message begins Here  ---------

> 
> 
> > That is true for some security policies, not for others. POSIX is/was
> > based on the TSEC description, which is a very black/white model. It
> > does not support a more complex model such as a chinese wall structure.
> ---
> 	No?  User1 wants to access the Firm-A defense file.  Runs a transition
> program that adds Firm-A to the user's mac-label division list.  Now any
> files or users that are working on Firm-B defense files (which have gone
> through the same transition to mac-label w/division "firm-b" added) are 
> inaccessible to the User1.  User1 is now permanently banned from firm-b
> files by having transitioned into a user with 'firm-a' access.
>
> 	Seems like that implements perfectly a chinese wall /conflict of
> interest model.  

Not unless every possible process suddenly becomes the "transition program".
The key here is that the user could just be running "more". If the user
has no restrictions, then it works. Once the user HAS done more on the
file, then restrictions may be imposed on the next file (depending on the
conflict). 

There is no need to run a special program before gaining access. No
intervention by the security manager other than defining the conflict matrix
in the first place.

A practical chinese wall has more complications too. A conflict is usually
specified in a contract ("propriatary information not to be divulged for
5 years" type of thing). This means that the conflict exists, but only
for the time interval since it was last imposed (most likely based on the
modification date of the file?). After the time interval, the conflict
is resolved, and the restriction removed. Even if the file is destroyed,
the conflict still remains.

Existing lattice models have no structure to handle time, they all expect
the state to last forever. This would help with the automatic downgrading
of sensitive data, if the data could be labled with time as well as
compartment/level ("not for release until after xxx hours...). These
transitions currently require intervention by the security administrator,
and the author (if available - he may have died... now the data may never
get downgraded).

> 	To my mind MAC+capabilities + a transitions config file = "domain
> or type enforcement".  I see the transitions file as being fairly easy to
> maintain.  	
> 
> 	MAC and capabilities are basic building blocks from which you can
> build other security models.
> 
> 	I'm told you can build MAC and capabilities from DTE with 
> sufficient rules, and perhaps that is so, but it seems that set of rules
> would be considerably more complex than a "transitions" file with which
> to implement DTE or Chinese Wall.

The "transitions" file has no means of detecting when enforcement must
take place. It has to be applied manually, and can't be done automatically
since the security monitor for lattice structured systems cannot interpret
it.

I grant that a DTE rule set may be more complex to define a lattice, but
the intent appears to be to provide initial definitions, and explore more
flexible definitions.

I would also imagine that they may be slower for really complex structures
too... perhaps we are seeing an analogue to the CISC/RISC cpu archetectures
from 10 years ago? Both were right, and both were wrong (and depended on the
application....)

Right now, I don't fully understand the difference in implementation, other
than the security monitor itself. It appears that the DTE can define how
the bits are interpreted. Lattice models tend to have a fixed definition of
the bits, limiting redefinition. I don't yet know if there is still a limit
on the number of bits, but perhaps that is more flexible too. 32 (or even
64) bits has always seemed too limiting. It certainly should be less
restrictive on the algorithm implemented for evaluation.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
