Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAR27gRb022766
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 21:07:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAR277p5003137
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 02:07:07 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAR275t0003134
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 02:07:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?utf-8?q?An=C3=ADsio=20Monteiro?= <monteiro@ipen.br>
Subject: Re: Type attributes
Date: Thu, 27 Nov 2003 13:07:08 +1100
Cc: selinux <selinux@tycho.nsa.gov>
References: <3FC4ADF3.2050509@ipen.br> <1069857041.30315.72.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1069857041.30315.72.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200311271307.08680.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Nov 2003 01:30, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> Answer:  Yes.  At one time, type attribute names were implicitly
> declared upon their first use in a type declaration, but explicit
> declarations were added and required to allow the compiler to catch
> mistakes.  Type attribute names are typically declared in attrib.te.

Currently the published policy only has them declared in attrib.te.  I 
strongly recommend that this practise be continued.

As Stephen explains below a defined attribute does not have to be used.  One 
thing he did not mention is that a defined attribute which is not used has no 
affect on the policy binary (try adding some attributes that are not assigned 
to any types and you will notice that the md5sum of the compiled policy does 
not change).

So there is no cost to defining extra attributes.

> etc).  Also, you may end up violation an assertion if you fail to use
> the attribute, as assertions are often based on attributes.

Recently I have been adding new assertions to more strictly check these 
things.  So a policy which creates a process type without the "domain" 
attribute will not compile.  These assertions unfortunately significantly 
increase the time taken to compile the policy, however there are only a small 
number of people who do thousands of compiles of policy, but a large number 
of people who might be expected to make such mistakes so the net result is 
positive.

Also I found a few policy mistakes that I had made when I added these 
rules.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
