Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k43DTaad028207
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 09:29:36 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k43DTY80013027
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 13:29:35 GMT
Date: Wed, 3 May 2006 09:29:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Russell Coker <russell@coker.com.au>
cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Making MCS mandatory
In-Reply-To: <200605032230.30757.russell@coker.com.au>
Message-ID: <Pine.LNX.4.64.0605030928460.16976@d.namei>
References: <200605032230.30757.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 May 2006, Russell Coker wrote:

> I have implemented a change to the MCS policy to make it mandatory.  So far in 
> my own tests it does what it is supposed to do.  I would like to get some 
> feedback from people on this list before putting it in to rawhide, it's the 
> most significant change to MCS since it's inception...

It seems ok, but I don't understand the requirements for the change.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
