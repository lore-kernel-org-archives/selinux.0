Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2GYLMk032484
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 11:34:21 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kA2GWfFI019550
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 16:32:42 GMT
Subject: Re: MLS + MCS?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <454A134D.5060902@us.ibm.com>
References: <454A134D.5060902@us.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:35:13 -0500
Message-Id: <1162485313.18181.9.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 09:48 -0600, Michael C Thompson wrote:
> While writing some policy, I came across a situation that was causing 
> the policy I was writing to be constructed in an invalid fashion. What 
> was happening was this:
> 
> Using an old Makefile, my $(TYPE) was being generated as 
> 'strict-mls-mcs', which was causing the support template 'gen_context' 
> to get completely confused.
> 
> The macro is defined thusly:
[cut]
> I'm wondering, how does this make sense? I'm unclear as to how having 
> both mls_sensitivity and [mcs_catergories] defined in this way has meaning.
> 
> Because of having both '-mls' and '-mcs' in my $(TYPE), the invalid 
> policy I was compiling ended up looking like this:
> user:role:type:$2:s0:$3
> 
> It would seem to me that MLS and MCS are mutually exclusive, at least in 
> this macro.

Yes, they are mutually exclusive.  Sounds like the Makefile that redhat
has is making a mistake on setting TYPE; it has to figure out more than
the upstream refpolicy Makefiles need to because of the
redhat /usr/share/selinux/*/devel setup.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
