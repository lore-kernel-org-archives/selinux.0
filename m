Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1EAcXZ025989
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 09:10:38 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1E9ECE028117
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 14:09:17 GMT
Message-ID: <36282A1733C57546BE392885C06185924D9033@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Frank Mayer <mayerf@tresys.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
Subject: RE: dynamic context transitions
Date: Mon, 1 Nov 2004 09:11:00 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> On Sun, 2004-10-31 at 17:47, Frank Mayer wrote:
> > > 	The MLS model is another reason for this functionality. We have
> > > chosen to create MLS policy overrides using a new SELinux MLS
> > > capability class. 
> > 
> > I have not thought greatly about this choice, but I wonder 
> if it was wise to
> > make the MLS mechanism dependent on the capability 
> mechanism.  Orthogonal
> > mechanisms would seem smarter.  
> 
> Point of clarification:  These MLS capabilities only exist as TE
> abstractions, not as part of the Linux capabilities logic, 
> IIUC.  Using
> TE to control MLS privileges is desirable.
> 

This is correct. We believe the the existing capabilities logic shouldn't be
extended and thus added a new TE class for MLS override logic.  These "MLS
capabilities" only affect MLS policy decisions.  In our desired
implementation, SELinux would abritrate all capability decisions and
obsolete the capability module.

> > Ah and here we have the beginning of the slippery slope.  
> This might be easy in
> > terms of lines of code, but the conceptual complexity of 
> what you describe above
> > scares me.  I still wonder why we have to change TE to 
> support a MLS convention.
> > I'd much rather you did not make these mechanisms dependent 
> on each other.  
> 
> TE was originally developed to fill in the gaps of MLS, including
> privilege management for trusted subjects.  Using TE to control MLS
> privileges is a good thing.  Whether or not privilege bracketing is a
> good thing is more open to debate, although it is clearly 
> entrenched in
> applications today, and not just MLS applications; the prior requests
> for such a feature have been to support traditional Unix applications
> that presently use seteuid/setfsuid.
> 

IMHO the combination of MLS and TE is next step in increasing the security
of solutions.  Existing MLS applications and systems have weaknesses. Using
TE to model a complex MLS scenario is not a good idea.  The combination of
the two technologies create the strongest foundation. 

-Chad

____________________________
Chad Hanson
Senior Secure Systems Engineer

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

www.TrustedCS.com

V:  217.384.0028  ext.12
F:  217.384.0288

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
