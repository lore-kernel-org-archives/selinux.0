Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JDfLXf002121
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 08:41:21 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JDeAgR018480
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 13:40:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: dropping pppd_script_exec_t
Date: Fri, 20 Jan 2006 00:39:31 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1137083967.29815.205.camel@sgc.columbia.tresys.com>
In-Reply-To: <1137083967.29815.205.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601200039.38070.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 13 January 2006 03:39, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> In the ppp module there is a type pppd_script_exec_t and its only used
> in one rule:
>
> domain_auto_trans(pppd_t, pppd_script_exec_t, initrc_t)
>
> Looking at the actual scripts, they seem similar to regular init scripts
> for configuring network devices.  Since the scripts transition to
> initrc_t already, it seems like they should instead be labeled
> initrc_exec_t and the regular interface call for transitioning to initrc
> can be used.  Then pppd_script_exec_t would be dropped (made an alias of
> initrc_exec_t for compatibility).  Is there any problem with doing this?

The only problem is that escape from the pppd_t domain is possible via any of 
the initrc_exec_t scripts (of which there are many) instead of merely the 
pppd_script_exec_t (of which there will be few if any).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
