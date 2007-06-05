Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55FO1Qx003320
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 11:24:01 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l55FO0x1010648
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 15:24:00 GMT
Subject: Re: upgrading to modular policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <466578C5.9070602@nagafix.co.uk>
References: <466578C5.9070602@nagafix.co.uk>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 11:22:44 -0400
Message-Id: <1181056964.6578.7.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 15:52 +0100, Antoine Martin wrote:
> I am finally getting around to upgrading some custom modules to the
> modular policy and I have encountered a few issues:
> * How do I find the new equivalent for macros which have been renamed?
> ie: file_type_auto_trans, domain_auto_trans, append_logdir_domain,
> general_domain_access, etc...

You can look at this:

http://oss.tresys.com/projects/refpolicy/browser/docs/macro_conversion_guide

It hasn't been updated in 10 months, so its probably a little out of
date, but it should get you started.

> * trying to load one of the modules gives:
> libsepol.permission_copy_callback: Module local depends on permission
> dccp_recv in class node, not satisfied
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!

It means the headers you are compiling against are newer than the base
policy you have installed.  The dccp_recv permission does not exist in
the base policy, but it exists, according to the headers.  You probably
just need to recompile your base module to include these new perms.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
