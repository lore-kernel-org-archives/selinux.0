Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4FB0TgA012744
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 07:00:29 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4FAvJiA007500
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 10:57:19 GMT
Subject: Re: ls -Z on non-SE machine
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050515102704.GA16326@lkcl.net>
References: <200505151921.23171.russell@coker.com.au>
	 <20050515102704.GA16326@lkcl.net>
Content-Type: text/plain
Date: Sun, 15 May 2005 06:56:59 -0400
Message-Id: <1116154619.7833.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-05-15 at 11:27 +0100, Luke Kenneth Casson Leighton wrote:
> how about just silently ignoring the -Z option if selinux is
> detected to not be enabled?

I believe that's what it does right now, and Russell's arguing against
that behavior - he's saying you should be able to view the contexts,
whether or not SELinux is running (unless I am misunderstanding).

> > I believe that the best thing to do is to have ls not be linked against 
> > libselinux and instead just call the XATTR api for reading the file contexts.  
> > Ideally I think that such functionality should be enabled unconditionally 


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
