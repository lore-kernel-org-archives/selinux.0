Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4FB9rgA012789
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 07:09:53 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4FB6UsN008211
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 11:06:30 GMT
Date: Sun, 15 May 2005 12:16:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: ls -Z on non-SE machine
Message-ID: <20050515111601.GF16326@lkcl.net>
References: <200505151921.23171.russell@coker.com.au> <20050515102704.GA16326@lkcl.net> <1116154619.7833.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1116154619.7833.2.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 15, 2005 at 06:56:59AM -0400, Ivan Gyurdiev wrote:
> On Sun, 2005-05-15 at 11:27 +0100, Luke Kenneth Casson Leighton wrote:
> > how about just silently ignoring the -Z option if selinux is
> > detected to not be enabled?
> 
> I believe that's what it does right now, and Russell's arguing against
> that behavior - he's saying you should be able to view the contexts,
> whether or not SELinux is running (unless I am misunderstanding).
 
 no, it doesn't.  an error is generated saying that the "-Z" argument is
 not understood.

 the resultant error (non-zero exit code) causes, for example,
 initialisation scripts to fail.

 the behaviour is also different: an error code is printed out on
 stderr.

 that's _not_ silent behaviour :)

 yes, i am running my laptop with debian / selinux disabled, with
 the se-aware coreutils package still installed on it.

 every time i boot up, i get a "ls -Z" error in one of the key
 initialisation scripts.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
