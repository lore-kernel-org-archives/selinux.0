Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12303
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 11:04:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA02927
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 16:01:21 GMT
From: Kelly_Djahandari@nai.com
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
	by jazzswing.ncsc.mil  with ESMTP id QAA02908
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 16:01:17 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.4/Switch-2.2.4) with SMTP id h1DFrC226555
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 09:53:12 -0600 (CST)
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14C5E@md-exchange1.na.nai.com>
To: selinux@tycho.nsa.gov, carstengrohmann@gmx.de, russell@coker.com.au
Subject: RE: regular expressions
Date: Thu, 13 Feb 2003 08:07:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated sourceforge with the regular expressions patch from Carsten
Grohmann and Russell Coker. Thanks Carsten and Russell for the patch.

Kelly Djahandari
Network Associates Laboratories

> -----Original Message-----
> Date: Mon, 20 Jan 2003 01:28:20 +0100
> From: Russell Coker <russell@coker.com.au>
> To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux 
> <SELinux@tycho.nsa.gov>
> Cc: mark.westerman@westcam.com
> Subject: Re: regular expressions
> 
> On Sun, 19 Jan 2003 18:29, Carsten Grohmann wrote:
> > a few fc-files used the regexp [^/]* to label exact one 
> file system entry.
> > I think sometimes it is better to use [^/]+ to mark one 
> entry instead of
> > "zero and more".
> 
> You are right.  Those regex's should be made more strict to avoid the
> potential for future conflicts or mis-interpretations.
> 
> > An good example is the entry for the .ssh directory 
> /home/[^/]*/.ssh(/.*)?
> > matched the user specific ssh directories but also /home/.ssh.
> > This time I don't see no way to use this to compromise the 
> system, but I'm
> > in two minds as to whether it is potential unsecure or not.
> 
> It is not insecure (IMHO) as the only person who can create 
> subdirectories of
> /home is also the only person who can relabel such files, and 
> /home/.ssh
> should not have any special meaning unless something is very broken.
> 
> But it's good to fix it anyway.
> 
> > The attached patch change it. I also change some /home 
> resp. /root entries
> > in this way too.
> 
> I've applied this to my tree, and in addition I changed the 
> preceeding two
> lines in types.fc in a similar fashion.  I have put an 
> archive of my tree on
> http://www.coker.com.au/selinux/policy.tgz and I've attached 
> the patch that
> I'm using for this regex change (note that it has several 
> things not in
> Carsten's patch).
> 
> > I don't  now enouph about the directory structure of 
> dpkg.fc so I don't
> > change it. Could anybody do it?
> 
> I'll do it.  Also Mark, I couldn't work out what you were 
> trying to do with
> vmware and the "\v" parts, could you please take a look at it?
> 
> Also perhaps every instance of "(/.*)?" should be changed to "(/.+)?"?
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
