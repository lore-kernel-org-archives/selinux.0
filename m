From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: mike@theptrgroup.com
Subject: Re: Starting applications from initrc in a user's context?
Date: Tue, 4 Jan 2005 21:03:12 +1100
Cc: SElinux <SELinux@tycho.nsa.gov>
References: <41CAE132.3020504@theptrgroup.com>
In-Reply-To: <41CAE132.3020504@theptrgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501042103.15885.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 24 December 2004 02:16, Mike Anderson <mike@theptrgroup.com> wrote:
>   I'm trying to run a series of applications from the init scripts that
> I want to run in separate user contexts. Four separate init scripts all
> run from a master script that runs the user code only if tripwire says
> that the file system is kosher.  The actual launching of the four
> separate scripts is working well.  However, I'm trying to use the runcon
> command to run the applications in the separate user contexts and  I'm
> getting a transition error from the initrc domain to the user domain.
> I've added the
>
> allow initrc_t user1_t:process { transition };

Use:
domain_trans(initrc_t, shell_exec_t, user1_t)

Also you need to either allow domain user1_t to run in role system_r or allow 
a role transition from system_r to user1_r by initrc_t.

Allowing the domain user1_t in role system_r is done by:
role system_r types user1_t;

Allowing the role to be changed requires adding privrole to the attributes of 
domain initrc_t.  In that case either the identity system_u must be permitted 
to have the role user1_r or initrc_t also needs the privuser attribute so it 
can launch a process with a different identity.

> What am I missing?  Or, is there a better way of running the four
> applications in their respective user domains from the init scripts?

Maybe have cron launch them.  Cron has all privs needed to launch processes on 
behalf of users.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
