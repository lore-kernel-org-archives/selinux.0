Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12199
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 10:59:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1DFwxI03962
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 15:58:59 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
        by jazzband.ncsc.mil  with ESMTP id h1DFwvf03958 for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 15:58:58 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.4/Switch-2.2.4) with SMTP id h1DFlp224683
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 09:47:51 -0600 (CST)
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14C5D@md-exchange1.na.nai.com>
From: Kelly_Djahandari@nai.com
To: selinux@tycho.nsa.gov, russell@coker.com.au
Subject: RE: patch for new domains
Date: Thu, 13 Feb 2003 08:01:55 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated sourceforge with Russell Coker's new domains patch. Thanks
Russell for the patch.

Kelly Djahandari
Network Associates Laboratories

> ------ Original message ------
> Date: Mon, 20 Jan 2003 01:22:48 +0100
> From: Russell Coker <russell@coker.com.au>
> To: SELinux <SELinux@tycho.nsa.gov>
> Subject: Re: patch for new domains
> 
> On Mon, 20 Jan 2003 01:21, Russell Coker wrote:
> > I've attached a patch with policy for Perdition, nessus, 
> nsd, and UML.
> > Also it has a new file auth-net.te with the policy for doing network
> > authentication (LDAP etc).
> 
> The attached patch is also needed for UML.
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced 
> Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
