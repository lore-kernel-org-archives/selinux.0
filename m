Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9F0KMWt022561
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:20:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9F0KLmR008033
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:20:21 GMT
Received: from remt23.cluster1.charter.net (remt23.cluster1.charter.net [209.225.8.33])
        by jazzband.ncsc.mil  with ESMTP id h9F0KLjp008030 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:20:21 GMT
Received: from [68.116.1.217] (HELO eng21)
  by remt23.cluster1.charter.net (CommuniGate Pro SMTP 4.0.6)
  with ESMTP id 27154218 for selinux@tycho.nsa.gov; Tue, 14 Oct 2003 20:20:20 -0400
From: "Robert Potter" <robertp72@charter.net>
To: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: trusted vs untrusted packages
Date: Tue, 14 Oct 2003 17:20:44 -0700
Message-ID: <000001c392b2$2e780f40$d9017444@eng21>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3F8C873B.30703@diyab.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Calls to mind varying degrees of trust, which could be useful technology if
implemented in an AI update scheme.

Rob

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Diyab
Sent: Tuesday, October 14, 2003 4:31 PM
To: James Morris
Cc: Russell Coker; SE Linux
Subject: Re: trusted vs untrusted packages


James Morris wrote:
> On Tue, 14 Oct 2003, Russell Coker wrote:
> 
> 
>>Now this raises some interesting issues.  If a signed package has a 
>>program
>>which relies on some other program (and has a dependency), what happens if

>>the dependency is satisfied by an unsigned package?  Installing the
unsigned 
>>package may not result in the system being fully functional (execution of
the 
>>file in question may be denied).
> 
> 
> This should be like enforcing vs. non-enforcing -- you either want all 
> of your packages signed (and the above would fail) or not (just 
> generate a warning).
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
This message was distributed to subscribers of the selinux mailing list. If
you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
