Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JNvAXf009341
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 18:57:10 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JNv6h0015890
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 23:57:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: dropping pppd_script_exec_t
Date: Fri, 20 Jan 2006 10:56:55 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1137083967.29815.205.camel@sgc.columbia.tresys.com> <200601200039.38070.russell@coker.com.au> <1137685313.29815.374.camel@sgc.columbia.tresys.com>
In-Reply-To: <1137685313.29815.374.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601201057.02949.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 20 January 2006 02:41, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> > The only problem is that escape from the pppd_t domain is possible via
> > any of the initrc_exec_t scripts (of which there are many) instead of
> > merely the pppd_script_exec_t (of which there will be few if any).
>
> Following this logic, it would be better to make a new domain that can
> do only the few network configuration things that pppd scripts need to
> do.  I think this is a better idea, then you can't "escape" to the
> highly privileged initrc_t at all.

The pppd_script_exec_t type is not just for "network configuration things".  
It's commonly used for starting/reconfiguring bind, mail servers, squid, and 
other daemons.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
