Subject: Re: Trouble with setexeccon/setcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <4465bac8.7f1514c3.12f8.57e6@mx.gmail.com>
References: <4465bac8.7f1514c3.12f8.57e6@mx.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 15 May 2006 08:19:35 -0400
Message-Id: <1147695575.14426.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-05-13 at 12:53 +0200, Mario Fanelli wrote:

> I think that there is a problem with setcon/setexecon …. 

Please disable HTML mail in your mail client.

> Perhaps now I try to write a wrapper program that execute the command
> “runcon –t dummy_change_context_t  /path/of/suphp”..the program only
> use an enviroment variable “SUPHP_SELINUX_DOMAIN” and call execve()
> with same environment, but the result doesn’t change

I'm not certain as to what you mean by the above statement.  Does it
fail?   Does running that same command by hand succeed?  What is the
output?  What is logged in /var/log/messages
or /var/log/audit/audit.log?

> Now I have written a policy for suPhp with a domain_auto_trans macro…
> when apache executes suphp, the context changes…but if I use a
> domain_trans and a setcon in suPhp, I obtain an error and I don’t find
> any error message in /var/log/messages…I’m using a targetd policy and
> I put apache2 in unconfined_t domain…

Point of clarification:  domain_trans is for authorizing transitions via
execve.  It does not authorize a dynamic context transition.  So if you
want to transition upon execve (as in runcon), then you want to use
setexeccon() prior to the execve, and you need to allow process setexec
permission as well as the domain transition (in the example policy, this
is done by the can_setexec() macro).  If you want to transition within
the current process without performing an execve via setcon(), then you
need to separately allow process dyntransition permission.

Did you also check for a /var/log/audit/audit.log?  That is where
messages are logged if running auditd (as in FC4).

> Where can I find the runcon/newrole source code?

runcon is part of coreutils, so it would be in the coreutils SRPM, or
you can just grab coreutils-selinux.patch.

newrole is part of policycoreutils, so you can grab that SRPM or
upstream tar ball. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
