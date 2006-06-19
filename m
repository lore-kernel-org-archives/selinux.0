Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5JEgveR011713
	for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2006 10:42:57 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k5JEguxb021333
	for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2006 14:42:56 GMT
Subject: Re: moving modules into base
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200606181333.36369.russell@coker.com.au>
References: <200606181333.36369.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 10:45:20 -0400
Message-Id: <1150728321.18657.104.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-06-18 at 13:33 +1000, Russell Coker wrote:
> Due to problems with modules I want to compile a policy with amavis and clamav 
> in base.pp.
> 
> I built the rpms but get the following when trying to install them:
> 
> libsepol.scope_copy_callback: amavis: Duplicate declaration in module: 
> type/attribute amavis_var_log_t
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!
> 
> I then built a module with just clamav in base.pp and got the following:
> 
> libsepol.scope_copy_callback: clamav: Duplicate declaration in module: 
> type/attribute clamd_var_lib_t
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!

Can you send a copy of the modules.conf?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
