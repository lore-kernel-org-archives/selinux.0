Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NFilHa026121
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 11:44:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6NFikDW015692
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 15:44:46 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6NFiieN015679 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 15:44:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Subject: Re: Linuxfromscratch.org
Date: Wed, 23 Jul 2003 11:44:38 -0400
Cc: <selinux@tycho.nsa.gov>
References: <200307221606.42540.russell@coker.com.au> <5.1.1.6.2.20030723080629.0a198680@Shire>
In-Reply-To: <5.1.1.6.2.20030723080629.0a198680@Shire>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307231144.38947.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Jul 2003 11:09, Carsten P. Gehrke wrote:
> Is this true of the GNU C compiler suite as well?  And if so, would it not
> be possible to remove it from the compiler?  How does it work?  Does it
> look at the code, or is anything called login.c susceptible?  Why has this
> not been removed in the open-source code?  How can I check to see if this
> backdoor exists?

This is not in the current GCC builds, if it ever was.

There are a variety of stories concerning this, some say that it was just 
commented code to illustrate a point, some say that it was in there with full 
nasty capabilities but was removed years ago (>10 years).

There is no need to worry about this particular exploit right now, but there 
are issues with the potential for creating others of the same type.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
