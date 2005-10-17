Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9H03sNs023529
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 20:03:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9H01XdD003253
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 00:01:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: range transitions in MCS
Date: Mon, 17 Oct 2005 10:01:03 +1000
References: <200510152033.03582.russell@coker.com.au>
In-Reply-To: <200510152033.03582.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510171001.11124.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 October 2005 20:32, Russell Coker <russell@coker.com.au> wrote:
> Currently in the MCS policy in rawhide restarting a daemon changes it's MLS
> context from "s0" to "s0:c0.c255".  This is obviously not what we want.
>
> I suggest the attached patch to fix this.
>
> The daemon policies cups.te, udev.te, and xdm.te need to be modified to
> include this attribute.

Based on Joshua's message of subject "range_transition inside a conditional" I 
have come to believe that the above is the wrong solution (it works for 
strict but fails on targeted).

Adding the following to initrc.te seems to be a better solution to the 
problem.

range_transition sysadm_t initrc_exec_t s0;


PS  Thanks for the fast response Joshua, this is for the tutorial I'm running 
in <24 hours...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
