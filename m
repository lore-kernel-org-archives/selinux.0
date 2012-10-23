Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9NKnFp6023117
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 16:49:15 -0400
Received: by mail-wg0-f49.google.com with SMTP id gg4so2532826wgb.30
        for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 13:49:08 -0700 (PDT)
Message-ID: <1351025344.2774.13.camel@d30.localdomain>
Subject: Re: Question about policy module error message
From: Dominick Grift <dominick.grift@gmail.com>
To: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 23 Oct 2012 22:49:04 +0200
In-Reply-To: <CCAC7590.2211%thomas.moyer@ll.mit.edu>
References: <CCAC7590.2211%thomas.moyer@ll.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Tue, 2012-10-23 at 16:30 -0400, Moyer, Thomas - 0668 - MITLL wrote:
> So it turns out that the name I used it didn't like and the second name I
> used (ui-interface) is also didn't like.
> 
> When I tried uiInterface, things started working again. I don't know what
> the difference is, but maybe someone can enlighten me as to why the
> SELinux policy generation tools don't like things with hyphens in the name?
> 
> -Tom
> 

I suspect that it chokes on "interface". The hyphen might make
ui-interface seem like ui and interface to it or so

interface is used in the m4 macro's (it is a part of what makes selinux
policy modular):

> ##############################
> #
> # In the future interfaces should be in loadable modules
> #
> # interface(name,rules)
> #
> define(`interface',` dnl
> 	ifdef(`$1',`refpolicyerr(`duplicate definition of $1(). Original definition on '$1.) define(`__if_error')',`define(`$1',__line__)') dnl
> 	`define(`$1',` dnl
> 	pushdef(`policy_call_depth',incr(policy_call_depth)) dnl
> 	policy_m4_comment(policy_call_depth,begin `$1'(dollarsstar)) dnl
> 	$2
> 	popdef(`policy_call_depth') dnl
> 	policy_m4_comment(policy_call_depth,end `$1'(dollarsstar)) dnl
> 	'')
> ')
> 

So as long as you avoid keywords like (-)?interface(-)?, (-)?template(-)? (and maybe some others) it may work



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
