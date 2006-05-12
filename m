Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CCaMJj006363
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 08:36:23 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CCaK1i020843
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 12:36:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Janak Desai <janak@us.ibm.com>
Subject: Re: [Fwd: [PATCH 1/1] mount: shared-subtree support for mount]
Date: Fri, 12 May 2006 22:36:23 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <4460A6DA.1040407@us.ibm.com>
In-Reply-To: <4460A6DA.1040407@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605122236.27664.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 May 2006 00:27, Janak Desai <janak@us.ibm.com> wrote:
> As per Russell's request, I am posting this patch here as well, so
> broader selinux
> community can also play with the shared tree feature.

Thanks for that.

I just built mount with that patch and tried it out but it doesn't seem to 
work.  I run the following command from root login:
mount --make-private --bind /tmp/tmp.inst-user-user /tmp

Then when I inspect /tmp from other sessions it seems that the change is 
global.

Does the rawhide kernel 2.6.16-1.2196_FC6 lack support for this or did I get 
the command-line wrong?

Also from the documentation it seems that such a private mount does all we 
need without any need to call unshare().  Is my understanding of this 
correct?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
