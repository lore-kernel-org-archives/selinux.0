Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12103
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 10:50:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1DFoqI03316
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 15:50:52 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
        by jazzband.ncsc.mil  with ESMTP id h1DFopf03312 for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 15:50:51 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.4/Switch-2.2.4) with SMTP id h1DFdi222592
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 09:39:44 -0600 (CST)
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14C5B@md-exchange1.na.nai.com>
From: Kelly_Djahandari@nai.com
To: selinux@tycho.nsa.gov, mayerf@tresys.com
Subject: RE: patch to sepcut tool
Date: Thu, 13 Feb 2003 07:53:53 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated sourceforge with Frank Mayer's sepcut tool patch. Frank, Thanks
for the patch.

Kelly Djahandari
Network Associates Laboratories

> -----Original Message-----
> From: Frank Mayer [mailto:mayerf@tresys.com]
> Sent: Wednesday, January 22, 2003 3:07 PM
> To: selinux@tycho.nsa.gov
> Subject: patch to sepcut tool
> 
> 
> Attached is a patched to setools v0.6.1 which was included in last
> week's selinux distribution.  This patch fixes a file handling bug in
> sepcut (a basic policy browser/editor).  This patch will also 
> be posted
> on www.tresys.com/selinux for those of you who downloads setools from
> there.  
> 
> To apply, copy the patch to selinux/tools, cd there, and do 
> 'patch -p1 <
> sepcut.patch' 
> 
> Frank
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
