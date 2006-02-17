Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HFjJIT022485
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 10:45:19 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HFhk1d022926
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 15:43:46 GMT
Message-ID: <43F5EE32.5080101@cornell.edu>
Date: Fri, 17 Feb 2006 10:39:30 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
CC: Chris PeBenito <pebenito@gentoo.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net> <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org> <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org> <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>
In-Reply-To: <43F5EB83.30402@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> # cat /etc/selinux/test-nomcs/modules/active/seusers.final
> root:root:
> __default__:user_u:
>
Ok, let's see... that semicolon shouldn't be there at the end.
It causes the parser to look for an mls range.
This is parsed as:
user = root, seuser = root, mls_range = "__default__:user_u:"

That explains the output out of semanage, which doesn't make any sense 
otherwise.
Not sure why the end colon of the range is removed, but it seems 
plausible during translation and all that.
======================
So, your seuser has an mls range, which causes a crash, because 
libsemanage doesn't handle that case very well.
I will patch the library to prevent that crash, but for the moment I 
suggest you get rid of the end colon.
=======================
As far as "s0" is concerned - I have no idea where that's coming from - 
did you possibly give me a trace that doesn't match those files (you 
said you'd seen it before, not sure if you pasted old or new trace).











--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
