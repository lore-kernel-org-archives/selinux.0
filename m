Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2ODsqx6002216
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 08:54:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2ODspR1007738
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 13:54:51 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
        by jazzband.ncsc.mil  with ESMTP id h2ODsoj9007735 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 13:54:50 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.5/Switch-2.2.5) with SMTP id h2ODhHd01220
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 07:43:17 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: setfiles.c minor change
Date: Mon, 24 Mar 2003 07:57:06 -0600
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14CF7@md-exchange1.na.nai.com>
From: <Kelly_Djahandari@nai.com>
To: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This change has been made to setfiles.c on sourceforge. Thanks Russell.

Kelly Djahandari
Network Associates Laboratories

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> Sent: Sunday, March 23, 2003 11:38 PM
> To: SE Linux
> Subject: setfiles.c minor change
> 
> 
> Could this:
> #include <limits.h>
> Be changed to this:
> #include <linux/limits.h>
> 
> Such a change makes it build on a cross-compile for ARM and 
> seems to have no 
> deficiency for a regular compile (it's only used for FILE_MAX anyway).
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced 
> Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
