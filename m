Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NDEVrT008835
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 09:14:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NDERUk015672
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 13:14:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: patch: clean up vmware
Date: Thu, 23 Sep 2004 23:14:25 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040917224956.GA2517@jmh.mhn.de>
In-Reply-To: <20040917224956.GA2517@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xwsUBWSOD6CQjO5"
Message-Id: <200409232314.25355.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_xwsUBWSOD6CQjO5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 18 Sep 2004 08:49, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> After reading through the messy vmware policy I decided to clean it up a
> little. Result is below.

The changes are so great that patches don't work well.  I've made a few 
modifications to your policy and attached an archive of it.

I think that defining vmware_t is a bad idea.  I think that we want 
system_vmware_t to be used for vmware sessions launched by the server and 
have the same base macro used as for user_vmware_t.

Your work is good and is a significant enough improvement to be worth merging 
now.  But we need to go further to get the full functionality.

Also please keep in mind that some people may want to have multiple VMware 
sessions isolated from each other which are launched from the same user role.  
Maybe having two parameters to the vmware_domain() macro is the correct thing 
to do, one to specify the source role and one part of the name for the target 
domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_xwsUBWSOD6CQjO5
Content-Type: application/x-tgz;
  name="vmware.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="vmware.tgz"

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
UKBAgQIFChQoUKBA/zv0HyPdV+0AUAAA

--Boundary-00=_xwsUBWSOD6CQjO5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
