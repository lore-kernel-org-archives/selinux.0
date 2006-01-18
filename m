Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0IEP0Xf018032
	for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2006 09:25:00 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0IEOtnO013182
	for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2006 14:24:57 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43CD749E.4000101@redhat.com>
References: <43CD749E.4000101@redhat.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 09:26:17 -0500
Message-Id: <1137594377.29815.310.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-17 at 17:50 -0500, Daniel J Walsh wrote:

No attached patch?

> Is this done some other way, that I am missing?
> 
> +    domain_auto_trans(run_init_t,initrc_exec_t,initrc_t)

init_domtrans_script(run_init_t).  Upon closer inspection, run_init
seems to be missing the constraint exemptions for changing the identity
and role.  I'll fix that.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
