Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9FIm1ct031347
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2008 14:48:01 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m9FIkhNW015976
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2008 18:46:43 GMT
Subject: Re: Use of optional_policy in templates (compiler bug or feature?)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com>
References: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 14:46:51 -0400
Message-Id: <1224096411.21012.46.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-15 at 11:02 -0500, Joe Nall wrote:
> Is it legitimate to define a type within an optional_policy within a  
> template?

Yes.

> I ask because there are a number of compile issues with policy that  
> look like:
> 
> template(`wm_domain_template',`
> ...
>          optional_policy(`
>                  dbus_system_bus_client_template($1_wm,$1_wm_t)
> # does not compile
> #               dbus_user_bus_client_template($1,$1_wm,$1_wm_t)
>          ')
> ...
> ')

I can't reproduce this by just adding it to a random module; there are
likely more factors that just the above template calls.

> Looking at the checkmodule source, it looks like type declarations  
> declared within optionals are popped off the symbol stack in  
> end_optional but left in the symbol table. These symbols later fail an  
> is_id_in_scope test and generate an 'duplicate declaration of type/ 
> attribute'.
> 
> I think this is related to:
> http://oss.tresys.com/projects/refpolicy/ticket/43
> 
> and earlier complaints about this behavior in the X policy from Dan  
> and Eamon in June/July.
> http://www.nsa.gov/SeLinux/list-archive/0806/thread_body18.cfm
> 
> I'm running libsepol-2.0.33 which has the fix in the above thread.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
