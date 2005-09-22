Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8M9eFNs017807
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 05:40:15 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8M9ZjUn023079
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 09:35:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Lee Lowder <friedbob@sbcglobal.net>
Subject: Re: Getting started with SELinux and Slackware
Date: Thu, 22 Sep 2005 19:34:58 +1000
Cc: selinux@tycho.nsa.gov
References: <43325C75.3060405@sbcglobal.net>
In-Reply-To: <43325C75.3060405@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509221935.06357.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 22 September 2005 17:25, Lee Lowder <friedbob@sbcglobal.net> 
wrote:
> I don't mind installing it all myself, but I am not sure where to start.
>   I do know I will need PAM, as Slackware does not include it by default.

If Slackware doesn't include PAM then it will be quite a lot of work to add 
PAM support to all necessary applications.

It would probably be easier to modify the policy to remove *_chkpwd_t and 
grant every daemon that needs to verify a password read access to 
shadow_t:file.

Why do you want to work on Slackware?  It seems to be a regular occurrance 
that someone starts work on Slackware SE Linux support, their work doesn't 
get merged into the Slackware distribution, and then it gets discarded.

While Debian SE Linux support isn't in the greatest shape at the moment the 
changes are getting merged into the main packages so any work you do won't 
get wasted.

Of course you could just use Fedora and have it all work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
