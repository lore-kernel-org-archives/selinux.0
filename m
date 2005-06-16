Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GNQVgA005475
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 19:26:31 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GNHKI8022482
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 23:17:20 GMT
Subject: Re: mail_client_macros.te
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200506170827.59180.russell@coker.com.au>
References: <200506170827.59180.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 19:19:13 -0400
Message-Id: <1118963954.19768.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-17 at 08:27 +1000, Russell Coker wrote:
> The attached patch is needed to compile a policy without innd.te.

I don't see why the innd port is dependent on the innd policy.

The client is usually on a different machine than the server.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
