Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24618
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 14:48:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA04711
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 18:46:41 GMT
Received: from mx.nas-smoothtransition.com ([66.95.157.149])
        by jazzband.ncsc.mil  with ESMTP id SAA04707 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 18:46:40 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'David Caplan'" <dac@tresys.com>
Subject: RE: checkpolicy and login names [patch]
Date: Thu, 26 Sep 2002 14:49:12 -0400
Message-ID: <006a01c2658d$6b0b6c20$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <006901c26589$9cb35ac0$6600a8c0@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, correct patch is attached.  The cexpr_prim stuff is a little tricky;
hopefully I got it right in this patch!  Frank

> -----Original Message-----
> From: Frank Mayer [mailto:mayerf@tresys.com] 
> Sent: Thursday, September 26, 2002 2:22 PM
> To: 'Frank Mayer'; selinux@tycho.nsa.gov
> Cc: 'David Caplan'
> Subject: RE: checkpolicy and login names [patch]
> 
> 
> > Attached is a patch to checkpolicy that expands the syntax of
> > user names to include "." and "-" characters.  User names are 
> > now a distinct syntax (actually a superset) from other 
> > identifiers.  One should be able to add more character to 
> > what's allowed in user names without impacting other 
> > identifiers.  Frank
> 
> I just noticed a small error in the patch that doesn't have a 
> simple fix; please ignore the patch until I can fix it.  Sorry Frank 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
