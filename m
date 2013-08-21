Message-ID: <1377071660.21409.15.camel@d30>
Subject: Re: Programmatic domain change to unprivileged role
From: Dominick Grift <dominick.grift@gmail.com>
To: Dan Pou <danielp@sgi.com>
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
Date: Wed, 21 Aug 2013 09:54:20 +0200
In-Reply-To: <20130820200546.GL28332@localhost>
References: <20130805190732.GT18909@localhost>
	 <52015950.9010906@tycho.nsa.gov> <20130806203751.GA14875@localhost>
	 <52023D7D.7040409@tycho.nsa.gov> <52024071.4000206@tycho.nsa.gov>
	 <20130808195857.GB23152@localhost> <5204E5C5.1050802@tycho.nsa.gov>
	 <20130820200546.GL28332@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2013-08-20 at 15:05 -0500, Dan Pou wrote:
< snip >
> 
> I addeded the system_r:my_daemon_t:s0 user_r:user_t:s0 role transition
> to /etc/selinux/mls/contexts/default_contexts.
> This got me to actually writing user_u:user_r:user_t:s0 for setexeccon,
> but I am still failing.  It looks like it is failing in the
> selinux_trans_to_raw_context.  I was thinking this was an issue with
> declaring the transition.
> What steps do I need to setup a role_transition and/or type_transistion?
> 
> I tried adding the following to no avail:
> type_transition my_daemon_t non_security_file_type:process user_t;
> Do I need more type_transitions, or addition role_transition
> declarations (aside from /etc/selinux/mls/contexts/default_context)?

Some things ( but i am not sure ):

The target role needs to be associated to the identity (probably already
done)
The target role needs to be associated to the target domain (probably
already done)
The source role needs to be allowed to manually change to the target
role (probably already done)

The source domain needs various permissions to change identity, role,
and set mls range (policy constraints: mlsprocsetsl
can_change_process_identity can_change_process_role )
The target security level must be within range of the selinux identity
associated level, range)

You probably need to specify the entrypoint to the target domain
You probably need to allow the actual transition permission from source
domain to target domain (allow my_daemon_t user_t:process transition)

As far as i know, the function calculates if what you specified is valid
first

I do not think you need a automatic role transition rule (it changes
manually instead i believe)

So you have to make sure those prerequisites are dealt with

I might be overlooking things and i might be totally wrong

> 
> Other info:
> The daemon (without SELinux) just sets the euid/egid to match the user
> requesting the job. So I inserted calls to
> getseuserbyname
> get_default_context_with_rolelevel or get_default_context_with_level
> then setexeccon
> the returned context before execve'ing.
> 
> Thanks
> -Dan
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
