Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FMLOL9011959
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 17:21:25 -0500 (EST)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FMKEEP019602
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 22:20:14 GMT
Message-ID: <421275E0.9060509@trustedcs.com>
Date: Tue, 15 Feb 2005 16:21:20 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
References: <20050215213455.GF26294@lkcl.net>
In-Reply-To: <20050215213455.GF26294@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:
> stephen,
> 
> i assume it _is_ necessary to perform dynamic auto transitions?
> 
> such that i can track to alternative contexts, yes?
> 

Could you explain what you mean by "dynamic auto transitions"?  An auto 
transition is a policy defined transition upon exec.  The dynamic transitions 
(setcon) are done programatically.

> e.g. i am running in sshd_privsep_t [because on a fork(),
> i deliberately called setcon() to set it that way]
> 
> and i now want to be a user-related context, so i do this:
> 
> 	get_default_context(pw->pw_name,NULL,&scontext)
> 	setcon(scontext);
> 
> and i set up a dynamic_auto_trans(sshd_privsep_t,
>                                   sshd_exec_t,
> 				  sshd_privsep_user_t)
> 
> ... hang on, that doesn't look right.  surely there should be
> four arguments:
> 
> 	* domain you were in before the setcon
> 	* domain the setcon asked to be in
> 	* executable_t
> 	* domain you want to be in afterwards
> 
> so it'd be:
> 
> 	dynamic_auto_trans(sshd_privsep_t, /* where we were */
> 		   user_t,               /* from get_default_context() */
> 		  sshd_exec_t,          /* from the sshd binary */
> 		  sshd_privsep_user_t) /* what we _really_ want to be */
> 
> 
> burblburbl... *gloop* drowning in not-much-understanding...
> 
> l.
> 

For the above call to setcon to be successful, you will need the following 
policy rules where CURRENT_T is the current process domain and NEW_T is the 
domain that you are trying to transition to:

1) allow CURRENT_T self:process setcurrent;
2) allow CURRENT_T NEW_T:process dyntransition;

The first is necessary for the process to be able to use setcon.  The second is 
necessary for a dynamic transition to take place from CURRENT_T to NEW_T.  Those 
two will allow the transition to happen.  The executable type has no bearing on 
dynamic transitions because there is no exec taking place.  Remember that the 
transition will take place in the same process state - the new domain should 
most likely be able to access at least some of the resources (such as tty) of 
the previous domain.

Hope this helps a little...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
