Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88DP6rT003317
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 09:25:07 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88DOvfe016489
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 13:25:06 GMT
Received: from mm-ismta3.bizmailsrvcs.net ([192.168.133.28])
          by oe-im1.bizmailsrvcs.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with ESMTP
          id <20040908132458.HNNL10836.oe-im1.bizmailsrvcs.net@mm-ismta3.bizmailsrvcs.net>
          for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 08:24:58 -0500
Received: from ICEMAN ([151.196.62.58]) by mm-ismta3.bizmailsrvcs.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with ESMTP
          id <20040908132458.SOHZ1729.mm-ismta3.bizmailsrvcs.net@ICEMAN>
          for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 08:24:58 -0500
Reply-To: <don.patterson@tresys.com>
From: "Don Patterson" <don.patterson@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Users writting to home directory
Date: Wed, 8 Sep 2004 09:24:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <20040908132458.SOHZ1729.mm-ismta3.bizmailsrvcs.net@ICEMAN>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> ----- Original Message -----
> From: "James R. Marcus" <jmarcus@mvalent.net>
> To: "Stephen Smalley" <sds@epoch.ncsc.mil>
> Cc: <selinux@tycho.nsa.gov>
> Sent: Tuesday, August 24, 2004 2:14 PM
> Subject: RE: Users writting to home directory
> 
> 
> > Okay I tried just creating a user under home.  While in permissive 
> > mode they can login to the ftp server and upload and download.
> > However when I turn on enforced mode they get this message:
> >
> > C:\Documents and Settings\jmarcus\Desktop>ftp ftp Connected to 
> > ftp.mvalent.local.
> > 220 Welcome to mValent, Inc. FTP service.
> > User (ftp.mvalent.local:(none)): jmarcus7
> > 331 Please specify the password.
> > Password:
> > 500 OOPS: cannot change directory:/home/jmarcus7 500 OOPS: child 
> > died Connection closed by remote host.
> >
> > C:\Documents and Settings\jmarcus\Desktop>
> >
> > ftp policy # seuseradd -g users -d /home/jmarcus7 -m -s /bin/bash -c 
> > "James R. Marcus" jmarcus7 loading new policy...
> >
> > Error relabeling users home directory files: User is not defined in 
> > the policy.
> >
> 
In case anyone sees a similar problem, this bug was fixed in setools 1.4.x.
To upgrade use the commands:

Fedora - 'yum update setools'
Gentoo - 'emerge setools'

Don Patterson
Tresys Technology
www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
