Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBK1ARIi012204
	for <selinux@tycho.nsa.gov>; Sun, 19 Dec 2004 20:10:27 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBK1ASKh005414
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 01:10:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@redhat.com>
Subject: Re: [patch] selinux_capget()
Date: Mon, 20 Dec 2004 12:10:20 +1100
Cc: Casey Schaufler <casey@schaufler-ca.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412201210.25544.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 14 December 2004 17:09, James Morris <jmorris@redhat.com> wrote:
> How does the application determine the real effective set?
> (confusing enough terms ? :-)
>
> Surely it is a reasonable thing to expect to be able to do.  I'm not sure
> that your example is valid here as euid==0 doesn't mean anything in
> SELinux (if it did, the application could check that first and infer that
> it has all capabilities).

If program A calls capget() and determines that it does not have a certain 
capability then it does not need to drop that capability before executing 
program B which should not have it.

However if executing program B causes a domain transition to a domain that is 
permitted the capability in question then it might suddenly acquire access to 
a capability that program A thought was unavailable.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
