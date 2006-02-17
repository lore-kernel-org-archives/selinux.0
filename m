Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HFOGH1021626
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 10:24:16 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HFLG1d020328
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 15:21:16 GMT
Message-ID: <43F5E97B.8060102@cornell.edu>
Date: Fri, 17 Feb 2006 10:19:23 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
CC: Chris PeBenito <pebenito@gentoo.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net> <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org> <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>
In-Reply-To: <43F5E74C.7050904@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> what info? it isn't hard to reproduce.
Contents of: users.local, seusers, and seusers.final

I guess this function is exactly the place that should reject a seuser 
with mls fields (or ignore them) based on whether mls is enabled in the 
policy - I can export the mls flag from libsepol, and check that (at 
this point we have a policydb, validation occurs after everything is 
merged).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
