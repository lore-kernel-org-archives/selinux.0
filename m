Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03FjsXf019768
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 10:45:54 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03Fjoah029444
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 15:45:51 GMT
Subject: Re: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20051215222809.GA17384@sergelap.austin.ibm.com>
References: <1133973607.8185.10.camel@sgc.columbia.tresys.com>
	 <20051215222809.GA17384@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 10:48:51 -0500
Message-Id: <1136303331.29815.22.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-15 at 16:28 -0600, Serge E. Hallyn wrote:
> Hmm, I'm trying to compile this as a modular policy.  I've selected
> "nis = off" in my modules.conf.  But I get
> 
> 	policy/modules/admin/netutils.te:88:ERROR 'syntax error' at token
> 	'nis_use_ypbind' on line 33005:
> 	#line 88
> 		nis_use_ypbind(netutils_t)
> 
> when I try 'make load'.

Looks like the interfaces for disabled modules are not being expanded
properly.  After a quick glance, the disabled modules are not being
included in the ALL_MODULES variable in the Rules.modular, so fixing it
should be fairly straightforward.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
