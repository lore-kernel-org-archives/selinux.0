Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3P3oGI4012455
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 23:50:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3P3oF7R016527
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2003 03:50:15 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3P3oCKP016524 for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2003 03:50:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Robert Bihlmeyer <robbe@orcus.priv.at>, selinux@tycho.nsa.gov
Subject: Re: role orthogonality
Date: Fri, 25 Apr 2003 13:50:00 +1000
References: <87ist9eem5.fsf@orcus.priv.at>
In-Reply-To: <87ist9eem5.fsf@orcus.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304251350.00754.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Apr 2003 18:51, Robert Bihlmeyer wrote:
> This is supposed to mean that foo_t and foo_files_t exist seperately
> for every role, while there is only one foo_etc_t. Or you can think of
> foo_t and foo_files_t having "hard" boundaries between roles.

Probably the best way to do that would be in an object-oriented manner.  You 
could have a security "class" which defines local types.  Then the User class 
would be instantiated for user_t and sysadm_t.

You could implement this as a policy pre-processor which outputs code with 
name mangling that the checkpolicy tool can accept, in a similar manner to 
the C-front implementation of C++.

Things of a similar nature have been suggested before and the NSA people 
haven't seemed to like any of them.  But that doesn't prevent you from doing 
whatever you want.

Although I think that there's much less call for such things now than there 
used to be.  I think I've solved a lot of the annoying policy issues with M4 
macros, and I will probably improve it even more in the next few months.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
