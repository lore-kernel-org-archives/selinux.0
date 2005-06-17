Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5H23IgA005934
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 22:03:18 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5H1s6I8000642
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 01:54:06 GMT
Subject: Re: mail_client_macros.te
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200506171132.07632.russell@coker.com.au>
References: <200506170827.59180.russell@coker.com.au>
	 <1118963954.19768.2.camel@localhost.localdomain>
	 <200506171132.07632.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 21:56:01 -0400
Message-Id: <1118973361.21694.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-17 at 11:32 +1000, Russell Coker wrote:
> On Friday 17 June 2005 09:19, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > On Fri, 2005-06-17 at 08:27 +1000, Russell Coker wrote:
> > > The attached patch is needed to compile a policy without innd.te.
> >
> > I don't see why the innd port is dependent on the innd policy.
> 
> As long as the type is defined in innd.te it is.  The policy won't compile 
> without innd.te included.
> 
> The other option is to move the type to types/network.te.
> 
> Do you think we should change the policy to move all port type definitions to 
> types/network.te and have all ports labeled unconditionally?

I think so... at least most of them.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
