Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA14265
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 14:09:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA14525
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 19:06:42 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-156.nas-smoothtransition.com [66.95.157.156] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA14521
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 19:06:42 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: <Kelly_Djahandari@nai.com>, <selinux@tycho.nsa.gov>
Subject: RE: patch to sepcut tool
Date: Thu, 13 Feb 2003 12:15:08 -0500
Message-ID: <006001c2d383$8213afe0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <8894CA1F87A5D411BD24009027EE783801C14C5B@md-exchange1.na.nai.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was just asking Steve when the next release is expected (he says
sometime later this month); please let us know in advanced.  We're have
quite a bit of enhancements to our setools and I want to ensure I give
you a new patch before the next release.  Frank

> -----Original Message-----
> From: Kelly_Djahandari@NAI.com [mailto:Kelly_Djahandari@NAI.com]
> Sent: Thursday, February 13, 2003 10:54 AM
> To: selinux@tycho.nsa.gov; mayerf@tresys.com
> Subject: RE: patch to sepcut tool
> 
> I've updated sourceforge with Frank Mayer's sepcut tool patch. Frank,
Thanks
> for the patch.
> 
> Kelly Djahandari
> Network Associates Laboratories
> 
> > -----Original Message-----
> > From: Frank Mayer [mailto:mayerf@tresys.com]
> > Sent: Wednesday, January 22, 2003 3:07 PM
> > To: selinux@tycho.nsa.gov
> > Subject: patch to sepcut tool
> >
> >
> > Attached is a patched to setools v0.6.1 which was included in last
> > week's selinux distribution.  This patch fixes a file handling bug
in
> > sepcut (a basic policy browser/editor).  This patch will also
> > be posted
> > on www.tresys.com/selinux for those of you who downloads setools
from
> > there.
> >
> > To apply, copy the patch to selinux/tools, cd there, and do
> > 'patch -p1 <
> > sepcut.patch'
> >
> > Frank
> >


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
