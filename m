Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1G3bjL9013349
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 22:37:46 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1G3Y9w0022693
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 03:34:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Best way to label a filesystem for another system
Date: Wed, 16 Feb 2005 14:36:02 +1100
Cc: "Villalovos, John L" <john.l.villalovos@intel.com>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <60C14C611F1DDD4198D53F2F43D8CA3B036A31B3@orsmsx410> <1107816234.11907.115.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107816234.11907.115.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200502161436.06019.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 08 February 2005 09:43, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> 2) Retain SELinux on the host development system, but change its policy
> such that all of the desired file contexts for the embedded system are
> legal in its policy.  The simplest way to do this is to use the same
> policy.  An alternative is to just to add stub type definitions for all

Using the same policy for a workstation and a PDA is not practical.  A policy 
that works well for a workstation will be too large for the RAM of a PDA.

A targeted policy might work on a workstation and a PDA, but there's not much 
point.  PDAs have almost no daemons so a policy that only affects daemons 
will do little good.

Probably the easiest thing to do would be to write a little Perl program to 
read through two policy.conf files and list all user identities and type 
declarations with the file_type attribute that are in one policy but not 
another.  The result could be put in domains/misc/custom.te on the 
workstation to allow labelling for the PDA image.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
