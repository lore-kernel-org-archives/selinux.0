Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FDjWI4026184
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 09:45:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3FDfjOv022928
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 13:41:45 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h3FDfgY1022925
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 13:41:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: strange errors
Date: Tue, 15 Apr 2003 23:45:32 +1000
References: <CB4A800B69051C4986485EBBC070C69952B950@csoc-mail-hou.csoconline.com>
In-Reply-To: <CB4A800B69051C4986485EBBC070C69952B950@csoc-mail-hou.csoconline.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304152345.32626.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Apr 2003 23:18, Westerman, Mark wrote:
> I have run into problems like this before.
> What fixed it for me was
> removing all ...security for all mounted partitions and
> performing a make reset (not relabel)
>
> Did you try that ?
> Tring to see if it was a similar problem

I haven't tried that.  I need that machine to do some serious compiles so I 
couldn't take the time to investigate it fully.

However from your report I conclude that there isn't just something strange 
with my system, but maybe a bug in the PSID handling in SE Linux.

Hopefully Steve could make some suggestions on what might be the cause and 
which tests could usefully be done to gather more information.  In the mean 
time I'll try not to destroy any more evidence.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
