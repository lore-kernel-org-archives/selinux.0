Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l34AceeZ002320
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 06:38:41 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l34AcYkm003299
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 10:38:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: runcon problems
Date: Wed, 4 Apr 2007 11:38:41 +1100
Cc: Yong Lee <ylee@eqo.com>, selinux@tycho.nsa.gov
References: <012201c77006$615c44a0$aa5a0a0a@yonglaptop> <46126A3E.2080909@redhat.com>
In-Reply-To: <46126A3E.2080909@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200704041038.46253.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 04 April 2007 00:52, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Confined apps can not use the runcon process. You have two choices.

I have to be pedantic here.

Confined apps can use runcon if their policy permits them to do so.  An 
example of an application that is permitted to spawn children in a different 
context is crond.  Currently it's not supported for cgi-bin scripts, but a 
policy module could allow this.

Writing policy to allow a cgi-bin script to run another program in a different 
domain may be useful on occasion.  It's easier to have an automatic 
transition as you suggest, but calling runcon from a cgi-bin script is not 
necessarily a bad idea.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
