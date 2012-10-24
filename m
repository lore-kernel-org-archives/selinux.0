Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9OG6j6O001579
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2012 12:06:45 -0400
Message-ID: <508811E8.4090704@tresys.com>
Date: Wed, 24 Oct 2012 12:06:00 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Question about policy module error message
References: <CCAC7590.2211%thomas.moyer@ll.mit.edu> <1351025344.2774.13.camel@d30.localdomain>
In-Reply-To: <1351025344.2774.13.camel@d30.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/23/12 16:49, Dominick Grift wrote:
> 
> 
> On Tue, 2012-10-23 at 16:30 -0400, Moyer, Thomas - 0668 - MITLL wrote:
>> So it turns out that the name I used it didn't like and the second name I
>> used (ui-interface) is also didn't like.
>>
>> When I tried uiInterface, things started working again. I don't know what
>> the difference is, but maybe someone can enlighten me as to why the
>> SELinux policy generation tools don't like things with hyphens in the name?
>>
>> -Tom
>>
> 
> I suspect that it chokes on "interface". The hyphen might make
> ui-interface seem like ui and interface to it or so
> 
> interface is used in the m4 macro's (it is a part of what makes selinux
> policy modular):
> 
>> ##############################
>> #
>> # In the future interfaces should be in loadable modules
>> #
>> # interface(name,rules)
>> #
>> define(`interface',` dnl
>> 	ifdef(`$1',`refpolicyerr(`duplicate definition of $1(). Original definition on '$1.) define(`__if_error')',`define(`$1',__line__)') dnl
>> 	`define(`$1',` dnl
>> 	pushdef(`policy_call_depth',incr(policy_call_depth)) dnl
>> 	policy_m4_comment(policy_call_depth,begin `$1'(dollarsstar)) dnl
>> 	$2
>> 	popdef(`policy_call_depth') dnl
>> 	policy_m4_comment(policy_call_depth,end `$1'(dollarsstar)) dnl
>> 	'')
>> ')
>>
> 
> So as long as you avoid keywords like (-)?interface(-)?, (-)?template(-)? (and maybe some others) it may work

I'll see what I can do to fix this situation.  I think we should be able to adjust the refpolicy infrastructure to not have these keyword problems since the only macro we really need for processing .fc files is gen_context().

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
