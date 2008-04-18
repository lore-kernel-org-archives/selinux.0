Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3ICmpNM001261
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 08:48:51 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3ICmo2w013566
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 12:48:50 GMT
Subject: Re: refpolicy: loadable_module.spt improvement?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080418090020.GA19371@bobek.pm.i.cz>
References: <20080418090020.GA19371@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 18 Apr 2008 08:47:08 -0400
Message-Id: <1208522828.1548.47.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-04-18 at 11:00 +0200, Václav Ovsík wrote:
> Hi,
> while looking into the policy/support/loadable_module.spt I could not
> catch handling of the policy_call_depth in the template and the
> interface macro.
[...]
> The policy_call_depth is incremented using temporal policy_temp
> - I don't know why. The new definition is pushed into the m4 stack, ok.
> On the leaving side of macro is the original value not popped from the
> stack, but new decremented value is pushed into the stack. So stack of
> the policy_call_depth definitions is growing up.
> 
> I prepared fix for this - it is attached. The policy is generated faster
> by at least 5% with this (intermediate files are smaller and less work
> for m4 and less memory footprint of m4 I hope).

Good catch.  Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
