Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T3XZU2024240
	for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 23:33:35 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T3VwU8001019
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 03:32:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Graffam <michael.graffam@gmail.com>
Subject: Re: New to SELinux -- any suggestions?
Date: Sun, 29 Oct 2006 13:31:59 +1000
Cc: selinux@tycho.nsa.gov
References: <1162086080.2566.16.camel@endless>
In-Reply-To: <1162086080.2566.16.camel@endless>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610291432.01272.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 29 October 2006 12:41, Michael Graffam <michael.graffam@gmail.com> 
wrote:
> chcon -t uncontained_execmem_exec_t /usr/bin/sbcl
> (and /usr/local/bin/lisp)

Incidentally why are you running it from /usr/local/bin?  Why don't you use an 
RPM package of it?  If there is no RPM available have you considered building 
your own and submitting it to Extras?

> After fixing my problem, I wanted to demonstrate the behavior to a
> friend of mine, and found that I didn't have the foggiest idea of how to
> actually use chcon :) .. I couldn't remove the indicated permission from
> my bins.

The problem here is your idea of "removing the permission".  Chcon does not 
add or remove permissions, it merely changes the labels of files.  What the 
label means is determined by the policy.

So if you want to change a file back to it's default context you can 
use "restorecon", in this case "restorecon -F -R -v /usr/local /usr/bin" 
should do what you want.

Another option is to know what the original context was (maybe by examining 
the file with "ls -Z" before changing it in the first place).  In this case I 
know that the bin directories have type bin_t, so the following would work:
chcon -t bin_t /usr/bin/sbcl /usr/local/bin/lisp

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
