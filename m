Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04DWfIi023856
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 08:32:41 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04DWfA9026914
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 13:32:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: [patch] types.fc
Date: Wed, 5 Jan 2005 00:32:26 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20050104025950.GA5321@yggdrasil.localdomain>
In-Reply-To: <20050104025950.GA5321@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501050032.29370.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 January 2005 13:59, Greg Norris <haphazard@kc.rr.com> wrote:
> The attached patch against types.fc is needed by Debian, which currently
> supports only a single policy type.  At present "make relabel" mislabels
> the binary policy file, which as you can probably imagine is somewhat
> inconvenient. ;-)  The patch was generated against current CVS.

You also need the same for the three lines that follow.  I posted a patch at 
about the same time as your message which made the appropriate change.

But I have been considering just moving to the locations that are used in 
Fedora.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
