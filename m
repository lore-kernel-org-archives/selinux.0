Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ENVAWt022347
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 19:31:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9ENV9mR006317
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 23:31:09 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id h9ENV8jp006314 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 23:31:08 GMT
Message-ID: <3F8C873B.30703@diyab.net>
Date: Tue, 14 Oct 2003 19:31:07 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: trusted vs untrusted packages
References: <Xine.LNX.4.44.0310140805090.1093-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0310140805090.1093-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 14 Oct 2003, Russell Coker wrote:
> 
> 
>>Now this raises some interesting issues.  If a signed package has a program 
>>which relies on some other program (and has a dependency), what happens if 
>>the dependency is satisfied by an unsigned package?  Installing the unsigned 
>>package may not result in the system being fully functional (execution of the 
>>file in question may be denied).
> 
> 
> This should be like enforcing vs. non-enforcing -- you either want all of
> your packages signed (and the above would fail) or not (just generate a
> warning).
> 
> 
> - James

How about trust based on the package requiring said untrusted or 
temporarily untrusted package.  For example, you have package abc signed 
by a trusted source.  The package contents have been verified as 
legitimate through something like the package signature. A requirement 
made by the verified abc package says you need package xyz.  The abc 
package also gives you the option to install a public key for the 
required xyz package, which is trusted by the abc package.  Therefore as 
long as package xyz passes the basic signature/validity check then not 
only are the contents valid but they are trusted by someone you trust.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
