Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2RIT5x6025410
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 13:29:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2RISkRX009195
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 18:29:04 GMT
Received: from RelayDAL.nai.com (relaydal.nai.com [205.227.136.197])
        by jazzband.ncsc.mil  with ESMTP id h2RINlj9008983 for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 18:23:48 GMT
Received: from txwsout1.nai.com (txwsout1.na.nai.com [161.69.216.92])
	by RelayDAL.nai.com (Switch-2.2.5/Switch-2.2.5) with SMTP id h2RILSN24560
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 12:21:29 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: policy patches
Date: Thu, 27 Mar 2003 12:25:57 -0600
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14D05@md-exchange1.na.nai.com>
From: <Kelly_Djahandari@nai.com>
To: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated the policy files on sourceforge with the "file_type" patch and most of the "general" patch. We are still looking at the "readable" patch. Thanks Russell for the patches.

Kelly Djahandari
Network Associates Laboratories

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> Sent: Saturday, March 22, 2003 5:53 PM
> To: SE Linux
> Subject: policy patches
> 
> 
> I've attached a patch to use readable_t for the timezone 
> files.  It's a bit of 
> an experimental patch, perhaps we should have a timezone_t instead.
> 
> I've attached a patch to make some file_type_auto_trans rules 
> specific to the 
> classes that they need to create.  This removes some access 
> that isn't 
> needed.  I think that this should be included in the CVS.
> 
> The file "general" contains a patch for the global macros, 
> and a patch for the 
> X server policy to tighten it down a lot.  This is also good 
> for the CVS 
> IMHO.
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
