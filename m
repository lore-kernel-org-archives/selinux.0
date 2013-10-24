Message-ID: <1382645796.3041.159.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Thu, 24 Oct 2013 22:16:36 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

Now that we can specify contraints in "loadable modules" i noticed that
i can alter the behavior of existing constraints in the sense that they
can be overridden

take for example this instance

in the domain module ( which i consider "base" ) i have this constraint:

> (constrain (process (transition dyntransition noatsecure siginh rlimitinh))
>            (or (or (or (eq u1 u2) (and (eq t1
>            can_change_process_identity) (eq t2 process_user_target)))
>            (and (eq t1 can_system_change) (eq u2 system_u)))
>            (eq t1 process_uncond_exempt)))
> 

This seems to work fine. however if i now want to extent this from a loadable
module. for example the cron module:

> (constrain (process (transition dyntransition noatsecure siginh rlimitinh))
>            (or (eq u1 u2) (and (eq t1 cron_source_domain) (or
>            (eq t2 cron_job_domain) (eq u2 system_u)))))


Then the former "base" constraint no longer works. Its not getting extended
but rather a new one gets added and now the first one fails because the second on
is not met

it would have been nice if cilc merged the two into a single constraint instead

In practice its not a big deal because the source policy is probably on the system
anyways so might as well put it in the domain module

But it would have been nice if i could put it in the module where it belongs so that when
i choose to disable the module, the module related constraint rules disappear as well

Is this a right assumption or are my constraints just wrong?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
