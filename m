Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j137E653028374
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 02:14:06 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j137E1f1022633
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 07:14:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Advice on bringing up SE Linux
Date: Thu, 3 Feb 2005 18:13:30 +1100
Cc: "Villalovos, John L" <john.l.villalovos@intel.com>, selinux@tycho.nsa.gov
References: <60C14C611F1DDD4198D53F2F43D8CA3B035B5359@orsmsx410> <1107284400.26936.212.camel@moss-spartans.epoch.ncsc.mil> <1107285883.26936.216.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107285883.26936.216.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200502031813.33454.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 02 February 2005 06:24, Stephen Smalley <sds@epoch.ncsc.mil> 
wrote:
> On Tue, 2005-02-01 at 14:00, Stephen Smalley wrote:
> > Any output in /var/log/messages from the attempt to write the policy to
> > /selinux/load?  Any difference if you run load_policy on the binary
> > policy instead of directly cat'ing it?
>
> Actually, cat is quite likely to fail, as it likely tries to read and
> write the file in chunks, whereas the kernel wants the entire policy
> pushed in a single transaction.  load_policy is what you want.

In fact cat is almost guaranteed to fail.  cat from coreutils will stat the 
read and write files to check the IO block size.  On 2.6.10 /selinux/load 
reports a 4096 byte IO block size which should cause cat to fail.  Maybe if 
the kernel code was modified to return an insanely large value (larger than 
we expect a policy to be) then cat would work.  I am not sure that this is 
desirable though.

Using dd with a block size larger than the policy size should work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
