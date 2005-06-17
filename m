Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5H1ewgA005846
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 21:40:59 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5H1ViI8029170
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 01:31:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: mail_client_macros.te
Date: Fri, 17 Jun 2005 11:32:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <200506170827.59180.russell@coker.com.au> <1118963954.19768.2.camel@localhost.localdomain>
In-Reply-To: <1118963954.19768.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506171132.07632.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 17 June 2005 09:19, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> On Fri, 2005-06-17 at 08:27 +1000, Russell Coker wrote:
> > The attached patch is needed to compile a policy without innd.te.
>
> I don't see why the innd port is dependent on the innd policy.

As long as the type is defined in innd.te it is.  The policy won't compile 
without innd.te included.

The other option is to move the type to types/network.te.

Do you think we should change the policy to move all port type definitions to 
types/network.te and have all ports labeled unconditionally?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
