Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06BkhIi008027
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 06:46:43 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06BkioP007091
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 11:46:45 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D7F6261B01
	for <selinux@tycho.nsa.gov>; Thu,  6 Jan 2005 22:46:44 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04894-08 for <selinux@tycho.nsa.gov>;
	Thu, 6 Jan 2005 22:46:44 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 84A9B61B00
	for <selinux@tycho.nsa.gov>; Thu,  6 Jan 2005 22:46:44 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [patch] screen_macros.te
Date: Thu, 6 Jan 2005 22:46:39 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20050104230149.GA10317@yggdrasil.localdomain> <20050104233401.GA11885@yggdrasil.localdomain> <41DBE9F1.50303@redhat.com>
In-Reply-To: <41DBE9F1.50303@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501062246.42763.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 06 January 2005 00:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
> I would like to add a new file type cert_t for ssl cert files, since
> these are defaulted to usr_t right now.
> Shouldn't these be protected at a higher level?

Are you talking about protecting the integrity or the secrecy of data in such 
files?

If integrity then anything which can write to usr_t can break the system 
anyway.  If secrecy then nothing in an rpm is secret anyway.

If there are certificates that have any secret data then they should be 
somewhere other than under /usr.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
