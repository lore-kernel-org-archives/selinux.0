Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1HJdrJ1030967
	for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2010 14:39:53 -0500
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1HJddpS029595
	for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2010 19:39:39 GMT
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o1HJfe8Z025767
	for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2010 13:41:40 -0600
From: Alan Rouse <alan.rouse@ericsson.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 14:39:50 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A780236@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oops.

I'm a bit confused though.  What are the scenarios that trigger an autorelabel?  I've not had any luck with the -autorelabel kernel boot parameter, nor with the /.autorelabel flag file.  OTOH sometimes when I reboot it (apparently) decides to autorelabel.

> Ok, so all of your processes are still running in kernel_t, and all of your files are 
> labeled file_t.  You need to label your filesystems and reboot.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
